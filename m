From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Mon, 19 Mar 2012 11:11:14 +0000
Subject: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to check
 presence of 32k timer
In-Reply-To: <CACVXFVOqmC0OhT-Dim8dL9pWnmGwO2-Awc4V2Jziyf7DHQdYcQ@mail.gmail.com>
References: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>
 <1326983304-14619-2-git-send-email-hvaibhav@ti.com>	<87mx9ej8fp.fsf@ti.com>
 <CACVXFVOqmC0OhT-Dim8dL9pWnmGwO2-Awc4V2Jziyf7DHQdYcQ@mail.gmail.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83181EF3F@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2012 at 17:07:16, Ming Lei wrote:
> Hi,
> 
> On Tue, Jan 24, 2012 at 7:38 AM, Kevin Hilman <khilman@ti.com> wrote:
> > Vaibhav Hiremath <hvaibhav@ti.com> writes:
> >
> >> OMAP device has 32k-sync timer which is currently used as a
> >> clocksource in the kernel (omap2plus_defconfig).
> >> The current implementation uses compile time selection between
> >> gp-timer and 32k-sync timer, which breaks multi-omap build for
> >> the devices like AM33xx, where 32k-sync timer is not available.
> >>
> >> So use hwmod database lookup mechanism, through which at run-time
> >> we can identify availability of 32k-sync timer on the device,
> >> else fall back to gp-timer.
> >
> > With the runtime detection & fallback, I suggest also removing the
> > Kconfig choice between the two as well.
> 
> IMO, under some situations, gp timer clocksource has high precision
> and is very useful, so hope the Kconfig choice can be kept, or using
> kernel parameter way,  and the patch need to be changed to support the
> selection.
> 
> 

I think you made very good point here. With the above patch, we are almost missing the capability of registering dmtimer as a clocksource for OMAP.
It will always use 32k-counter, and never fall back to dmtimer.

Then the only options we have here is,

1) Register both the timers, 32k-counter and dmtimer for clocksource; let
   Kernel pick up best rating clocksource out of these two.

   In case of OMAP1/2/3/4, kernel will use dmtimer, since it has better 
   Rating. User can choose the 32k-counter clocksource via bootargs.

   Impact: without bootargs for clocksource selection, kernel will choose 
     dmtimer, impacting loss of time during suspend/resume.


2) Let the current code be as is, means, the clocksource registration will 
   Happened based on "#ifdef CONFIG_OMAP_32K_TIMER" and this option 
   selection will be Controlled by Kconfig rules.


Based on this conclusion, 1st patch of this series needs some changes.
But Irrespective of this, we still need 2 patches from this series,

[PATCH 2/3] ARM: OMAP2+: hwmod data: Add 32k-sync timer data to hwmod database
[PATCH 3/3] ARM: OMAP2/3: Add idle_st bits for ST_32KSYNC timer to prcm-common header


Thanks,
Vaibhav

> thanks,
> -- 
> Ming Lei
> 
