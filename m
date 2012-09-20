From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 20 Sep 2012 16:59:33 +0000 (UTC)
Subject: [PATCH V3 6/8] ARM: OMAP4: Route PMU IRQs to CTI IRQs
In-Reply-To: <1347290626-21164-7-git-send-email-jon-hunter@ti.com>
References: <1347290626-21164-1-git-send-email-jon-hunter@ti.com>
 <1347290626-21164-7-git-send-email-jon-hunter@ti.com>
Message-ID: <alpine.DEB.2.00.1209201655060.12583@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Mon, 10 Sep 2012, Jon Hunter wrote:

> From: Ming Lei <ming.lei@canonical.com>
> 
> For OMAP4430 there are no dedicate PMU interrupts, however, PMU events can be
> routed to via the CTI IRQs. This allows tools such as PERF and OPROFILE to work
> on OMAP4430.
> 
> The idea is from Woodruff Richard in the disscussion about "Oprofile on
> Pandaboard / Omap4" on pandaboard at googlegroups.com.
> 
> Ming's original patch was called "arm: omap4: support pmu" [1] and has been
> renamed and modified by Jon Hunter. There main differences from the original
> patch are ...
> 
> 1. Instead of only configuring the CTI interrupt once during boot, the
>    interrupts are configured everytime the the PMU is used. The reason for this
>    is because during power transitions the CTI logic state will be lost and so
>    we will need to configure the interrupts everytime they are used. This is
>    accomplished by using the PM runtime callbacks which will be called whenever
>    the PMU is used.
> 2. Assign the PMU events to different cross triggering channels. This prevents
>    a single PMU event generating interrupts to both CPUs and hence can cause
>    spurious interrupts to occur. Reported by Ming [2].
> 
> [1] http://marc.info/?l=linux-arm-kernel&m=132227620816504&w=2
> [2] http://permalink.gmane.org/gmane.linux.linaro.devel/10532

Spent some time with this one here.  At this point I don't think I can 
queue it.  It's got hardcoded IRQ numbers and address information for the 
CTI, and mixes the CTI and PMU programming.  A few months ago we might 
have gotten away with this, but now it seems best to do this one cleanly.
Probably the CTI control should be moved off into mach-omap2/omap4-cti.c 
or somewhere into drivers/ if possible.  So let's revisit this for 3.8.


- Paul
