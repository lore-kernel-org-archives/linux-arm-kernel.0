From: will.deacon@arm.com (Will Deacon)
Date: Mon, 5 Jun 2017 11:46:20 +0100
Subject: Small issue with 3fde2999fac5 "arm64: cpufeature: Don't dump
 useless backtrace on CPU_OUT_OF_SPEC"
In-Reply-To: <e9f35f1c-fe40-2c08-f47b-e4275b6cbcaf@gmail.com>
References: <7f8ade0a-c4ab-3e2e-d21e-8eab4df07cac@gmail.com>
 <20170605084840.GB4650@leverpostej>
 <8ff72bb8-d8be-e691-c939-5f7d73f5e3d9@gmail.com>
 <20170605092438.GE4650@leverpostej>
 <e9f35f1c-fe40-2c08-f47b-e4275b6cbcaf@gmail.com>
Message-ID: <20170605104620.GC21944@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 05, 2017 at 11:37:35AM +0200, Heiner Kallweit wrote:
> Am 05.06.2017 um 11:24 schrieb Mark Rutland:
> > On Mon, Jun 05, 2017 at 11:20:53AM +0200, Heiner Kallweit wrote:
> >> Am 05.06.2017 um 10:48 schrieb Mark Rutland:
> >>> Hi,
> >>>
> >>> On Sun, Jun 04, 2017 at 02:53:36PM +0200, Heiner Kallweit wrote:
> >>>> The warning is printed unconditionally. An "if (taint)" seems to be
> >>>> missing.
> >>>
> >>> I'm not sure I follow. We're using pr_warn_once(), which should only
> >>> print the message once, regardless of how many times it is called.
> >>>
> >> Before we had WARN_TAINT_ONCE(taint, ..), so the warning is
> >> triggered by taint != 0.
> >> Now the warning is printed (just once but) even if taint == 0.
> > 
> > Ah, I see.
> > 
> > Thanks for the report; I'll put together a fix shortly.
> > 
> > Do you mind if I add:
> > 
> > Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
> > 
> Fine with me.

I'm about to apply the patch below.

Will

--->8

>From 8dd0ee651d8aefdc2d8ae0fcc9c68dfc943c9e4c Mon Sep 17 00:00:00 2001
From: Will Deacon <will.deacon@arm.com>
Date: Mon, 5 Jun 2017 11:40:23 +0100
Subject: [PATCH] arm64: cpufeature: Fix CPU_OUT_OF_SPEC taint for uniform
 systems

Commit 3fde2999fac5 ("arm64: cpufeature: Don't dump useless backtrace on
CPU_OUT_OF_SPEC") changed the cpufeature detection code to use add_taint
instead of WARN_TAINT_ONCE when detecting a heterogeneous system with
mismatched feature support. Unfortunately, this resulted in all systems
getting the taint, regardless of any feature mismatch.

This patch fixes the problem by conditionalising the taint on detecting
a feature mismatch.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 22f554320581..55d5c72a507d 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -639,8 +639,10 @@ void update_cpu_features(int cpu,
 	 * Mismatched CPU features are a recipe for disaster. Don't even
 	 * pretend to support them.
 	 */
-	pr_warn_once("Unsupported CPU feature variation detected.\n");
-	add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+	if (taint) {
+		pr_warn_once("Unsupported CPU feature variation detected.\n");
+		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+	}
 }
 
 u64 read_sanitised_ftr_reg(u32 id)
-- 
2.1.4
