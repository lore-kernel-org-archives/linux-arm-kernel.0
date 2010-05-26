From: viresh.kumar@st.com (Viresh KUMAR)
Date: Wed, 26 May 2010 14:00:15 +0530
Subject: Should we pass amba device peripheral id with device structure
	or	not?
In-Reply-To: <AANLkTimIDuNPo0t-GNIODjz-rpMvlEYqmUq7PbilxIhv@mail.gmail.com>
References: <4BECF57A.4050802@st.com>
	<AANLkTimIDuNPo0t-GNIODjz-rpMvlEYqmUq7PbilxIhv@mail.gmail.com>
Message-ID: <4BFCDC17.1010700@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/25/2010 1:44 AM, Linus Walleij wrote:
> 2010/5/14 Viresh KUMAR <viresh.kumar@st.com>:
> 
>> amba_device_register function reads and updates peripheral id from hardware
>> registers, whenever we register any amba device. If clock to device is disabled,
>> then amba_device_register will not be able to read and update this value.
>>
>> Thus device registration will fail.
>> (...)
> 
> In the U300 arch/arm/mach-u300/clock.c we have this code:
> 
> /*
>  * These are the clocks for cells registered as primecell drivers
>  * on the AMBA bus. These must be on during AMBA device registration
>  * since the bus probe will attempt to read magic configuration
>  * registers for these devices. If they are deactivated these probes
>  * will fail.
>  *
>  *
>  * Please note that on emif, both RAM and NAND is connected in dual
>  * RAM phones. On single RAM phones, ram is on semi and NAND on emif.
>  *
>  */
> void u300_clock_primecells(void)
> {
>         clk_enable(&intcon_clk);
>         clk_enable(&uart_clk);
> #ifdef CONFIG_MACH_U300_BS335
>         clk_enable(&uart1_clk);
> #endif
>         clk_enable(&spi_clk);
> 
>         clk_enable(&mmcsd_clk);
> 
> }
> EXPORT_SYMBOL(u300_clock_primecells);
> 
> void u300_unclock_primecells(void)
> {
> 
>         clk_disable(&intcon_clk);
>         clk_disable(&uart_clk);
> #ifdef CONFIG_MACH_U300_BS335
>         clk_disable(&uart1_clk);
> #endif
>         clk_disable(&spi_clk);
>         clk_disable(&mmcsd_clk);
> 
> }
> EXPORT_SYMBOL(u300_unclock_primecells);
> 
> 
> When we add the primecells we have this piece:
> 
>         /* Register the AMBA devices in the AMBA bus abstraction layer */
>         u300_clock_primecells();
>         for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
>                 struct amba_device *d = amba_devs[i];
>                 amba_device_register(d, &iomem_resource);
>         }
>         u300_unclock_primecells();
> 
> This way the reference counter is still zero and the clocks are off
> when the drivers probe, so they need to enable their own clocks
> at the latter stage.
> 
> It's a bit brutal but it works. (And yes, we shouldn't be exporting the
> symbols, no point, will fix it someday.) However it messes with the
> internals of your clock implementation indeed.
> 
> One more elegant way would be to pass the master clock along
> in struct amba_device like we do with IRQs, so the probe code in
> drivers/amba/bus.c know how to clock the device before attempting
> to read the PrimeCell IDs. I don't know if that's particularly elegant
> though.
> 

Thanks Linus,

I will check which one will be more suitable for us.

viresh.
