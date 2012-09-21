From: horms@verge.net.au (Simon Horman)
Date: Fri, 21 Sep 2012 10:04:04 +0900
Subject: [PATCH 1/2] arm: Add ARM ERRATA 775420 workaround
In-Reply-To: <CAHkRjk6vbM8f=bK_GkgpDmnYh-UU_M3T9TeOj6Ti7UZB-5U2cg@mail.gmail.com>
References: <1347434097-7924-1-git-send-email-horms@verge.net.au>
 <1347434097-7924-2-git-send-email-horms@verge.net.au>
 <CAHkRjk6vbM8f=bK_GkgpDmnYh-UU_M3T9TeOj6Ti7UZB-5U2cg@mail.gmail.com>
Message-ID: <20120921010404.GJ21660@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2012 at 10:58:53AM +0100, Catalin Marinas wrote:
> On 12 September 2012 08:14, Simon Horman <horms@verge.net.au> wrote:
> > +config ARM_ERRATA_775420
> > +       bool "ARM errata: A data cache maintenance operation which aborts, might lead to deadlock"
> > +       depends on CPU_V7
> > +       help
> > +         This option enables the workaround for the 775420 Cortex-A9 (r2p2,
> > +         r2p6,r2p8,r2p10,r3p0) erratum. In case a date cache maintenance
> > +         operation aborts with MMU exception, it might cause the processor
> > +         deadlock. This workaround puts DSB before executing ISB at the
> > +         beginning of the abort exception handler.
> > +
> >  endmenu
> 
> The only case where we can get an abort on cache maintenance is
> v7_coherent_user_range(). I don't think we have any ISB on the
> exception handling path for this function, so we could just add the
> DSB there:

I think that an advantage of Abe-san's implementation is that
it might to be a bit more robust. But your proposal is certainly
much cleaner and for that reason I agree it is a good option.

I've updated the patch, but since the code is now all yours
I'm unsure if the author should be changed or not.

----------------------------------------------------------------
From: Kouei Abe <kouei.abe.cp@rms.renesas.com>

arm: Add ARM ERRATA 775420 workaround

Workaround for the 775420 Cortex-A9 (r2p2, r2p6,r2p8,r2p10,r3p0) erratum.
In case a date cache maintenance operation aborts with MMU exception, it
might cause the processor to deadlock. This workaround puts DSB before
executing ISB if an abort may occur on cache maintenance.

Based on work by Kouei Abe and feedback from Catalin Marinas.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Kouei Abe <kouei.abe.cp@rms.renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>

---

v2
* Add some details to changelog entry
* Alternate implementation suggested by Catalin Marinas
  - Add the dsb directly to v7_coherent_user_range() rather
    than the exception handler
---
 arch/arm/Kconfig       |   10 ++++++++++
 arch/arm/mm/cache-v7.S |    3 +++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2f88d8d..48c19d4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1413,6 +1413,16 @@ config PL310_ERRATA_769419
 	  on systems with an outer cache, the store buffer is drained
 	  explicitly.
 
+config ARM_ERRATA_775420
+       bool "ARM errata: A data cache maintenance operation which aborts, might lead to deadlock"
+       depends on CPU_V7
+       help
+	 This option enables the workaround for the 775420 Cortex-A9 (r2p2,
+	 r2p6,r2p8,r2p10,r3p0) erratum. In case a date cache maintenance
+	 operation aborts with MMU exception, it might cause the processor
+	 to deadlock. This workaround puts DSB before executing ISB if
+	 an abort may occur on cache maintenance.
+
 endmenu
 
 source "arch/arm/common/Kconfig"
diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index 39e3fb3..3b17227 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -211,6 +211,9 @@ ENTRY(v7_coherent_user_range)
  * isn't mapped, fail with -EFAULT.
  */
 9001:
+#ifdef CONFIG_ARM_ERRATA_775420
+	dsb
+#endif
 	mov	r0, #-EFAULT
 	mov	pc, lr
  UNWIND(.fnend		)
-- 
1.7.10.4
