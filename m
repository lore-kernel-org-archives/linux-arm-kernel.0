From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Mon, 16 Jan 2012 09:16:22 +0000
Subject: omap clocksource timer selection: dmtimer OR 32K-Sync timer
In-Reply-To: <20120113165003.GJ15299@atomide.com>
References: <79CD15C6BA57404B839C016229A409A8317A4E2E@DBDE01.ent.ti.com>
 <CAMQu2gxYQOHX8n2RLfkLBw5hQMdvH389DfrguLtzpLcpmqBQMA@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A8317A4FD9@DBDE01.ent.ti.com>
 <CAMQu2gxkBV87YQE7SPmLXh0RZBR+SNHzHE5H-PVjuef+1UZp8Q@mail.gmail.com>
 <20120113165003.GJ15299@atomide.com>
Message-ID: <79CD15C6BA57404B839C016229A409A8317A6A9D@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2012 at 22:20:03, Tony Lindgren wrote:
> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [120113 06:08]:
> > On Fri, Jan 13, 2012 at 2:42 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wrote:
> > > On Fri, Jan 13, 2012 at 18:19:24, Shilimkar, Santosh wrote:
> > >> > ? ...
> > >> > ? };
> > >> >
> > >> > ? We need to have similar entries in all devices where 32K timer is present.
> > >> >
> > >> > 2) OR simply add another cpu_is_am33xx() and then fall back to dmtimer?
> > >> > ? Just to prove this, everything works here, I modified the code for this
> > >> > ? and tested it on both AM335x EVM and AM37xEVM and it works fine for me.
> > >> >
> > >> >
> > >> > Any comments?? OR Better approach? OR anything which I am missing here?
> 
> Why don't you just add a new entry to mach-omap2/timer.c using the OMAP_SYS_TIMER
> macro?
> 
Tony,

The entry is already present in mach-olmap2/timer.c

OMAP_SYS_TIMER_INIT(3_am33xx, 1, OMAP4_MPU_SOURCE, 2, OMAP4_MPU_SOURCE)
OMAP_SYS_TIMER(3_am33xx)


The issue is not related to this, more with respect to compile time 
Code -

#ifdef CONFIG_OMAP_32K_TIMER
static void __init omap2_gp_clocksource_init(int unused, const char *dummy)
{
	32K TIMER code
}
#else
static void __init omap2_gp_clocksource_init(int unused, const char *dummy)
{
	DMTIMER code
}
#endif

Omap2plus_defconfig enabled option "CONFIG_OMAP_32K_TIMER", so from
Multi-omap point of view it will break AM335x.

Thanks,
Vaibhav

> See for example the omap3_secure timer set up. That should allow
> specifying the clock source already.
> 
> Regards,
> 
> Tony
> 
