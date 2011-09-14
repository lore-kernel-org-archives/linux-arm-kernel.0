From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 Sep 2011 14:45:33 -0700
Subject: [PATCH v15 06/12] OMAP: dmtimer: switch-over to platform
	device driver
In-Reply-To: <1315516098-29761-7-git-send-email-tarun.kanti@ti.com>
References: <1315516098-29761-1-git-send-email-tarun.kanti@ti.com>
	<1315516098-29761-7-git-send-email-tarun.kanti@ti.com>
Message-ID: <20110914214533.GA30941@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [110908 13:36]:
> Register timer devices by going through hwmod database using
> hwmod API. The driver probes each of the registered devices.
> Functionality which are already performed by hwmod framework
> are removed from timer code. New set of timers present on
> OMAP4 are now supported.

Adding the support for the different offsets on some omap4
timers should be a separate patch.

Also, as we don't need the support for different register offsets
for the first two omap4 timers, please rather implement support
for the new timers and the timeouts directly in plat-omap/dmtimer.c.

That way we can still keep the minimal timer support simple
for clocksource and clockevent. Of course this means that we'll
be only supporting the first two timers as system timers on
omap4, but that's fine.
 
>  static inline u32 __omap_dm_timer_read(void __iomem *base, u32 reg,
> -						int posted)
> +						int posted, u8 func_offset)
>  {
>  	if (posted)
> -		while (__raw_readl(base + (OMAP_TIMER_WRITE_PEND_REG & 0xff))
> +		while (__raw_readl(base +
> +			((OMAP_TIMER_WRITE_PEND_REG + func_offset) & 0xff))
>  				& (reg >> WPSHIFT))
>  			cpu_relax();
>  
> @@ -264,10 +263,11 @@ static inline u32 __omap_dm_timer_read(void __iomem *base, u32 reg,
>  }
>  
>  static inline void __omap_dm_timer_write(void __iomem *base, u32 reg, u32 val,
> -						int posted)
> +						int posted, u8 func_offset)
>  {
>  	if (posted)
> -		while (__raw_readl(base + (OMAP_TIMER_WRITE_PEND_REG & 0xff))
> +		while (__raw_readl(base +
> +			((OMAP_TIMER_WRITE_PEND_REG + func_offset) & 0xff))
>  				& (reg >> WPSHIFT))
>  			cpu_relax();

Otherwise our inline functions just get too messed up with these func_offset
hacks. These need to be minimal as they're being called contantly for the
system timers. We can still recycle the inline functions if we pass the
correct WRITE_PEND_REG to them instead of the func_offset.

Regards,

Tony 
