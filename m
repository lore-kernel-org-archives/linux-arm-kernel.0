From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 24 Jun 2011 19:13:50 +0400
Subject: [RFC 5/8] remoteproc: add davinci implementation
In-Reply-To: <FFF198FBBF957F4393BA834040FEFFA202D66E@DFLE35.ent.ti.com>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	<1308640714-17961-6-git-send-email-ohad@wizery.com>
	<4E035B78.3080200@mvista.com>
	<FFF198FBBF957F4393BA834040FEFFA202D66E@DFLE35.ent.ti.com>
Message-ID: <4E04A9AE.3030801@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Grosen, Mark wrote:

>>     It should work on DA830 as well,

    So please make it dependent on ARCH_DAVINCI_DA8XX.

>> but not on real DaVinci, so the name is misleading...

> Yes, we debated calling it da8xx, but felt that with minor changes it could
> accomodate the other SoCs in the davinci family.

    I don't think it's a good idea. Using cpu_is_*() is drivers is bad. Using 
#ifdef's is not an option either.

> However, it may be better
> to start with just the da8xx/omapl13x parts and then rename if we add the
> others. 

>> [...]
>>> +
>>> +/*
>>> + * Technical Reference:
>>> + * OMAP-L138 Applications Processor System Reference Guide
>>> + * http://www.ti.com/litv/pdf/sprugm7d
>>> + */
>>> +
>>> +/* local reset bit (0 is asserted) in MDCTL15 register (section
>> 9.6.18) */
>>> +#define LRST		BIT(8)

>>     Perhaps this should be named nLRST or something if the sense is inverted?

> If there is an established naming convention for this, I'll adopt it.

    Looking into my old PSC manual (can't get the recent documentation from TI's 
site right now), the bit is called LRSTz.
    It's worth moving this #define into <mach/psc.h> as well.

>>> +/* register for DSP boot address in SYSCFG0 module (section 11.5.6)
>> */
>>> +#define HOST1CFG	0x44

>>     Worth declaring in <mach/da8xx.h> instead...

> Possibly - since it is only used for the DSP, I thought it would be better
> to keep local to this implementation. I'll adopt whichever approach is the
> convention. 

    Well, the general approach is to keep the #define's where they are used, so 
maybe we should keep this #define here.

>>> +static inline int davinci_rproc_start(struct rproc *rproc, u64
>> bootaddr)
>>> +{
>>> +	struct device *dev = rproc->dev;
>>> +	struct davinci_rproc_pdata *pdata = dev->platform_data;
>>> +	struct davinci_soc_info *soc_info = &davinci_soc_info;
>>> +	void __iomem *psc_base;
>>> +	struct clk *dsp_clk;
>>> +
>>> +	/* hw requires the start (boot) address be on 1KB boundary */
>>> +	if (bootaddr & 0x3ff) {
>>> +		dev_err(dev, "invalid boot address: must be aligned to
>> 1KB\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	dsp_clk = clk_get(dev, pdata->clk_name);

>>     We could match using clkdev functionality, but the clock entry
>> would need to be changed then...

> I followed the existing pattern I saw in other drivers.

    Probably MUSB? We're trying to move away from passing the clock name to thge 
drivers, using match by device instead.

> If there is a new, better way, please point me to an example.

    Look at the da850_clks[] in mach-davinci/da850.c: if the device name is 
specified as a first argument to CLK() macro (instead of clock name the second 
argument), the matching is done by device, so you don't need to specify the 
clock name to clk_get(), passing NULL instead.

>>> +	if (IS_ERR_OR_NULL(dsp_clk)) {
>>> +		dev_err(dev, "clk_get error: %ld\n", PTR_ERR(dsp_clk));
>>> +		return PTR_ERR(dsp_clk);
>>> +	}
>>> +
>>> +	clk_enable(dsp_clk);

>>      This seems rather senseless activity as on DA8xx the DSP core
>> boots the ARM core, so the DSP clock will be already enabled.

> I think it is needed. It's true that the DSP initiates the boot, but then it is
> reset and the clock disabled. See Section 13.2 of

    Hm, didn't know that. Contrarywise, we had to work around the races between 
ARM and DSP cores on accessing locked SYSCFG registers -- in kernel. So I was 
under impression that DSP code continues running some stuff of its own.

> http://focus.ti.com/lit/ug/sprugm7e/sprugm7e.pdf:

> 13.2 DSP Wake Up

> Following deassertion of device reset, the DSP intializes the ARM296 so that
> it can execute the ARM ROM bootloader. Upon successful wake up, the ARM
> places the DSP in a reset and clock gated (SwRstDisable) state that is
> controlled by the LPSC and the SYSCFG modules.

> Besides, the boot loader could have disabled it to save power. The ARM and
> DSP are clocked independently, so I think it's best to use clock management.

    OK, agreed.

>>> +	rproc->priv = dsp_clk;
>>> +
>>> +	psc_base = ioremap(soc_info->psc_bases[0], SZ_4K);
>>> +
>>> +	/* insure local reset is asserted before writing start address */
>>> +	__raw_writel(NEXT_ENABLED, psc_base + MDCTL + 4 *
>> DA8XX_LPSC0_GEM);
>>> +
>>> +	__raw_writel(bootaddr, DA8XX_SYSCFG0_VIRT(HOST1CFG));

>>     DA8XX_SYSCFG0_VIRT() is not supposed to be used outside mach-davinci. The
>> variable it refers is not exported, so driver module won't work.

> Ooops, I clearly did not build this as a module. Suggestion how to fix this?

    Using the normal ioremap() of SYSCFG0 space, I suppose.

> Mark

WBR, Sergei
