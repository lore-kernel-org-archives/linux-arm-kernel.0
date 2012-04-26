From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 26 Apr 2012 13:30:49 -0600 (MDT)
Subject: [PATCH-V5 3/3] ARM: OMAP: Make OMAP clocksource source selection
 using kernel param
In-Reply-To: <79CD15C6BA57404B839C016229A409A83E9FF819@DBDE01.ent.ti.com>
References: <1335362340-14960-1-git-send-email-hvaibhav@ti.com>
 <1335362340-14960-4-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1204260904580.10308@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83E9FF819@DBDE01.ent.ti.com>
Message-ID: <alpine.DEB.2.00.1204261330010.10308@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Apr 2012, Hiremath, Vaibhav wrote:

> On Thu, Apr 26, 2012 at 20:40:34, Paul Walmsley wrote:
> > On Wed, 25 Apr 2012, Vaibhav Hiremath wrote:
> > 
> <snip>
> > > +
> > > +	sync32k_ick = clk_get(NULL, "omap_32ksync_ick");
> > > +	if (!IS_ERR(sync32k_ick))
> > > +		clk_enable(sync32k_ick);
> > 
> > You've added hwmod data for this IP block, which is good.  This will 
> > presumably cause the IP block to be idled on boot.  But you haven't 
> > converted this code to use either the hwmod enable code -- just using 
> > clk_get() isn't enough.  (Better would be to use a driver and the PM 
> > runtime functions, of course, but maybe this runs too early?)
> > 
> > If the 32k sync timer is in OCP force-idle, then that might produce the 
> > hangs you're seeing.
> > 
> 
> I tried disabling all idle related flags in hwmod entry but no change in 
> observation, kernel still hangs.
> 
> I even conformed the register content by connecting debugger, and it is set 
> to No-idle state.

Okay, thanks for testing.  Please do update this patch to use 
omap_hwmod_enable(), etc.; see for example omap_dm_timer_init_one().


- Paul
