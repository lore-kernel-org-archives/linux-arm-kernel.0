From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 23 Aug 2013 07:49:50 -0300
Subject: [PATCH v3 2/3] clocksource: orion: Use atomic access for shared
 registers
In-Reply-To: <20130823103857.GP4600@tarshish>
References: <1377253445-2842-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1377253445-2842-3-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130823103857.GP4600@tarshish>
Message-ID: <20130823104949.GC2389@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 23, 2013 at 01:38:57PM +0300, Baruch Siach wrote:
> Hi Ezequiel,
> 
> On Fri, Aug 23, 2013 at 07:24:04AM -0300, Ezequiel Garcia wrote:
> > Replace the driver-specific thread-safe shared register API
> > by the recently introduced atomic_io_clear_set().
> > 
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> 
> [...]
> 
> > @@ -131,7 +121,9 @@ static void __init orion_timer_init(struct device_node 
> >   *np)
> >  	/* setup timer0 as free-running clocksource */
> >  	writel(~0, timer_base + TIMER0_VAL);
> >  	writel(~0, timer_base + TIMER0_RELOAD);
> > -	orion_timer_ctrl_clrset(0, TIMER0_RELOAD_EN | TIMER0_EN);
> > +	oatomic_io_modify(timer_base + TIMER_CTRL,
> 
> oatomic? Are you sure this code builds?
> 

Argh, no. I wasn't building the proper configuration/tree
and thus this clocksource driver wasn't being used.

Thanks for the catch!
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
