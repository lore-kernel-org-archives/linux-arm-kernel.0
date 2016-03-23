From: david@lechnology.com (David Lechner)
Date: Wed, 23 Mar 2016 12:45:03 -0500
Subject: [PATCH v2 04/11] ARM: davinci: da8xx: add usb phy clocks
In-Reply-To: <56F2CAB8.3090705@ti.com>
References: <1458181615-27782-1-git-send-email-david@lechnology.com>
 <1458181615-27782-5-git-send-email-david@lechnology.com>
 <56F2CAB8.3090705@ti.com>
Message-ID: <56F2D61F.80000@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/23/2016 11:56 AM, Sekhar Nori wrote:
>>
>> +static struct clk usb_ref_clk = {
>> +	.name		= "usb_ref_clk",
>> +	.rate		= 48000000,
>> +	.set_rate	= davinci_simple_set_rate,
>> +};
>
> can we call this usb_refclkin so it matches the TRM name? Also, should
> this node be not be coming through individual board files as the rate
> depends on what is connected to the usb_refclkin pin? Or is the
> expectation that boards will call clk_set_rate() on this clock to the
> correct value? If yes, I think it is misleading to populate the .rate here.

You are right. When I did this, I was looking at USB 1.1 only, which 
MUST be 48MHz. However, this can be used for USB 2.0 which can accept a 
number of rates.

However, even the main reference oscillator in da850.c has the rate hard 
coded in da850.c (DA850_REF_FREQ).

The clock initialization will fail if a clock does not have a parent or 
a rate, so we have to give it a default rate since it is an external 
clock and has no parent. So, I think 48MHz makes sense for a default 
value. Most boards will probably not be using this clock anyway, but 
rather the PLL in the USB 2.0 PHY.


>> +
>> +	pr_info("Waiting for USB 2.0 PHY clock good...\n");
>> +	while (!(readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG))
>> +						& CFGCHIP2_PHYCLKGD))
>> +		cpu_relax();
>
> I guess this is copying some earlier code, but still, it will be nice to
> see a timeout mechanism here, rather than loop endlessly.

Do you have a suggestion on how to do this?

>> +
>> +	/*
>> +	 * Can't use DA8XX_SYSCFG0_VIRT() here since this can be called before
>> +	 * da8xx_syscfg0_base is initialized.
>> +	 */
>> +	cfgchip2 = ioremap(DA8XX_SYSCFG0_BASE + DA8XX_CFGCHIP2_REG, 4);
>
> Again, not sure if this is juts a theoretical possibility. If yes, I
> would rather see you bail out if syscfg0_base is not initialized by the
> time you get here than do an ioremap() again.
>

Will rework clock registration so that this is not necessary.


>> +
>> +static struct clk usb20_phy_clk = {
>> +	.name		= "usb20_phy",
>> +	.parent		= &pll0_aux_clk,
>> +	.clk_enable	= usb20_phy_clk_enable,
>> +	.clk_disable	= usb20_phy_clk_disable,
>> +	.set_parent	= usb20_phy_clk_set_parent,
>> +};
>
> I hope you have checked that all boards in mainline use the AUXCLK as
> the reference USB 2.0 frequency?
>

After sending this patch set, I realized that I missed updating existing 
boards. Will include this in v3.

>> +
>> +static struct clk usb11_phy_clk = {
>> +	.name		= "usb11_phy",
>> +	.parent		= &usb20_phy_clk,
>> +	.set_parent	= usb11_phy_clk_set_parent,
>> +};
>
> Same thing here. I hope all current boards use USB2.0 clk as reference
> for USB 1.1 phy
>

Ditto. Will check on this.


>> +static void usb20_phy_clk_enable(struct clk *clk)
>> +{
>> +	u32 val;
>> +
>> +	val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
>> +
>> +	/*
>> +	 * Turn on the USB 2.0 PHY, but just the PLL, and not OTG. The USB 1.1
>> +	 * host may use the PLL clock without USB 2.0 OTG being used.
>> +	 */
>> +	val &= ~(CFGCHIP2_RESET | CFGCHIP2_PHYPWRDN);
>> +	val |= CFGCHIP2_PHY_PLLON;
>> +
>> +	writel(val, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
>> +
>> +	pr_info("Waiting for USB 2.0 PHY clock good...\n");
>> +	while (!(readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG))
>> +						& CFGCHIP2_PHYCLKGD))
>> +		cpu_relax();
>> +}
>
> Looks like this is pretty much going to be the same code repeated for
> DA850 and DA830. So can we move these to a common file like da8xx-usb.c?
> You can even register these USB clocks from that file by using
> clkdev_add() and clk_register(). This way they can remain to be file local.
>


I knew someone was going to say that. ;-) Thanks for the suggestion of 
clkdev_add() and clk_register(), I had not considered that but it sounds 
like a good idea and will take care of the ioremap problem too.
