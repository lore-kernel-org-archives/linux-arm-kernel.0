From: balbi@ti.com (Felipe Balbi)
Date: Fri, 19 Oct 2012 19:30:27 +0300
Subject: RT throttling and suspend/resume (was Re: [PATCH] i2c: omap:
 revert "i2c: omap: switch to threaded IRQ support")
In-Reply-To: <1350655227.2768.11.camel@twins>
References: <alpine.DEB.2.00.1210150148080.16624@utopia.booyaka.com>
 <CAM=Q2csHTbR4rBe1HNr5-M3sG5wgdCv6dCnGLmNQEwo1gjCSGg@mail.gmail.com>
 <20121016133356.GG21801@arwen.pp.htv.fi>
 <87ipaanljt.fsf_-_@deeprootsystems.com>
 <20121017140002.GI11394@arwen.pp.htv.fi>
 <20121017143534.GJ11394@arwen.pp.htv.fi>
 <87txtsitpt.fsf@deeprootsystems.com>
 <20121018055136.GF11137@arwen.pp.htv.fi>
 <1350655227.2768.11.camel@twins>
Message-ID: <20121019163027.GD1493@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 19, 2012 at 04:00:27PM +0200, Peter Zijlstra wrote:
> On Thu, 2012-10-18 at 08:51 +0300, Felipe Balbi wrote:
> > > So the primary question remains: is RT runtime supposed to include the
> > > time spent suspended?  I suspect not. 
> > 
> > you might be right there, though we need Thomas or Peter to answer :-s 
> 
> re, sorry both tglx and I have been traveling, he still is, I'm trying
> to play catch-up :-)
> 
> Anyway, yeah I'm somewhat surprised the clock is 'running' when the
> machine isn't. From what I could gather, this is !x86 hardware, right?
> 
> x86 explicitly makes sure our clocks are 'stopped' during suspend, see
> commit cd7240c0b900eb6d690ccee088a6c9b46dae815a.
> 
> Can you do something similar for ARM? A quick look at
> arch/arm/kernel/sched_clock.c shows there's already suspend/resume
> hooks, do they do the wrong thing?

if I understand correctly, then below should be enough. I did't test it
though:

diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index 87ba8dd..c9260e6 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -116,7 +116,7 @@ int __init omap_init_clocksource_32k(void __iomem *vbase)
 		return ret;
 	}
 
-	setup_sched_clock(omap_32k_read_sched_clock, 32, 32768);
+	setup_sched_clock_needs_suspend(omap_32k_read_sched_clock, 32, 32768);
 	register_persistent_clock(NULL, omap_read_persistent_clock);
 	pr_info("OMAP clocksource: 32k_counter at 32768 Hz\n");
 

Russell, would you have any comments here ? Should we make sure all ARMs
call setup_sched_clock_needs_suspend() and 'stop' counting during
suspend ?

I will test the above diff tomorrow, unless you have any other (better)
idea on how to deal with the problem.

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121019/df3b447e/attachment.sig>
