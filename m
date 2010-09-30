From: charu@ti.com (Varadarajan, Charulatha)
Date: Thu, 30 Sep 2010 21:25:26 +0530
Subject: [PATCH] OMAP2PLUS: WDT: Fix: Disable WDT after reset during init
In-Reply-To: <20100930150713.GG3117@atomide.com>
References: <1285834270-32766-1-git-send-email-charu@ti.com>
	<4CA45341.3080300@ti.com> <87vd5njpyq.fsf@deeprootsystems.com>
	<4CA49ADE.6080202@ti.com>,<20100930150713.GG3117@atomide.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030CCF813E@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony/ Benoit,

> >
> > I think that disabling it should be done only if the CONFIG_OMAP_WDT
> > is not set.
> 
> How about disabling is done always unless CONFIG_WATCHDOG_NOWAYOUT
> is set? 

As given in the patch description, this patch does a disable of watchdog
timer, during init, to avoid the system rebooting that happens due to
enabling of watchdog timer after a reset of the module (during hwmod init).

According to the default WDT registers values, the system reboot would
happen in ~10s if watchdog is enabled with default values. Hence, after
a WDT module reset during init, the watchdog has to be disabled within 10s
otherwise the system will keep rebooting.

Hence irrespective of CONFIG_WATCHDOG_NOWAYOUT/ CONFIG_OMAP_WDT,
the watchdog timer needs to be disabled after a WDT reset has happened.

Later on, the watchdog timer probe would be called (if CONFIG_OMAP_WDT
is defined) which takes care of doing the regular the watchdog timer
settings. After this, normal operations like open, close, ioctl operations
are supported (if CONFIG_OMAP_WDT is defined).
Based on CONFIG_WATCHDOG_NOWAYOUT definition, disabling the watchdog
may/may not be supported. 

Hence omap2_disable_wdt() introduced in this patch is not going to affect
the watchdog operations in anyway execpt that it is fixing the reboot issue
observed due to a watchdog timer reset. And this has to be done irrespective
of any OMAP watchdog timer related flags.

I guess, omap_wdt_disable() call during the WDT probe might be due to
similar reasons.

> That way product kernels can set CONFIG_WATCHDOG_NOWAYOUT
> and for the rest of us we can let fsck run the standard Linux way.
> 
> Tony
