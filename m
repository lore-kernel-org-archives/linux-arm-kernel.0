From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 17 Mar 2014 17:54:42 -0400 (EDT)
Subject: PL310 errata workarounds
In-Reply-To: <20140317211455.GM21483@n2100.arm.linux.org.uk>
References: <20140314144835.GP21483@n2100.arm.linux.org.uk>
 <20140314150110.GQ21483@n2100.arm.linux.org.uk>
 <CAL_JsqLuNz4EzGaQdb5eFSX5ip-spcDTFsNaFN094=XB_iPV3g@mail.gmail.com>
 <20140316115207.GW21483@n2100.arm.linux.org.uk>
 <CAL_Jsq+9Dm9S6rhQAt_umOM6T_x21O=Y_PPg0QyCH1zR_=yWoA@mail.gmail.com>
 <20140317153738.GB21483@n2100.arm.linux.org.uk>
 <20140317172943.GI24070@arm.com>
 <20140317194440.GG21483@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1403171651440.1291@knanqh.ubzr>
 <20140317211455.GM21483@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.11.1403171738270.1291@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 17 Mar 2014, Russell King - ARM Linux wrote:

> On Mon, Mar 17, 2014 at 05:09:46PM -0400, Nicolas Pitre wrote:
> > L2 is normally a per cluster resource.  It is flushed by the last man 
> > standing when no other CPUs might contend for the L2 controller.  And if 
> > the outer cache is shared by multiple clusters then some additional 
> > handling (such as "last cluster standing") would need to be implemented.
> > 
> > Clearly this outer_cache_flush() call is just a hint if someone were to 
> > copy that file to write their own backend.  If it is causing problems 
> > then it should just be removed altogether.  No platforms with MCPM that 
> > I know of have an actual outer cache at the moment.  And certainly not 
> > the platform where dcscb.c is used.
> 
> This sounds to me like an invitation to kill it :)  Killing it off
> would be good, though maybe a comment should be left behind at this
> site?
> 
> As you're the most familiar with this code, I'd prefer to commit a
> patch from you rather than just deleting the reference myself.

OK, what about the following:

----- >8
Subject: ARM: dcscb.c: remove actual call to outer_flush_all()

Strictly speaking this call is a no-op on the platform where dcscb.c is 
used since it only has architected caches.  The call was there as a hint 
to people who would be inspired by this code to write their own backend 
but the hint might not always be correct.

For example, if a PL310 were to be used this wouldn't be safe to call 
the regular outer_flush_all() anyway as it makes use of atomic 
instructions for locking which cannot be assumed to still be operational 
after v7_exit_coherency_flush() has returned.  Given no other CPUs (in 
the cluster) should be running at that point then standard concurrency 
concerns wouldn't apply.

So let's simply kill this call for now and enhance the existing comment.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
diff --git a/arch/arm/mach-vexpress/dcscb.c b/arch/arm/mach-vexpress/dcscb.c
index 14d4996887..e717515999 100644
--- a/arch/arm/mach-vexpress/dcscb.c
+++ b/arch/arm/mach-vexpress/dcscb.c
@@ -137,11 +137,10 @@ static void dcscb_power_down(void)
 		v7_exit_coherency_flush(all);
 
 		/*
-		 * This is a harmless no-op.  On platforms with a real
-		 * outer cache this might either be needed or not,
-		 * depending on where the outer cache sits.
+		 * A full outer cache flush could be needed at this point
+		 * on platforms with a real outer cache. This might either
+		 * be needed or not depending on where the outer cache sits.
 		 */
-		outer_flush_all();
 
 		/*
 		 * Disable cluster-level coherency by masking
