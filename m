From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Apr 2013 12:00:32 +0100
Subject: [PATCH] ARM: Samsung: Select ARM_CPU_SUSPEND when required
In-Reply-To: <51629B96.9050504@samsung.com>
References: <1365366442-16025-1-git-send-email-s.nawrocki@samsung.com>
 <2cd601ce343f$7d6aac50$784004f0$%kim@samsung.com>
 <51629B96.9050504@samsung.com>
Message-ID: <20130408110032.GK17995@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 08, 2013 at 12:27:34PM +0200, Sylwester Nawrocki wrote:
> On 04/08/2013 11:57 AM, Kukjin Kim wrote:
> Yes, this looks better. However after posting this patch I noticed linker
> errors in some builds due to undefined cpu_arm920_do_suspend,
> cpu_arm920_do_resume routines.
> 
> It seems it is because various cpu_*_do_suspend routines are selected by
> CONFIG_PM_SLEEP.  And the PM code in arch/arm/mach-s3c24xx, arch/arm/mach-
> s3c64xx is selected by CONFIG_PM.
> 
> $ git grep -1 "ENTRY(cpu_.*_do_suspend"
> arch/arm/mm/proc-arm920.S-#ifdef CONFIG_PM_SLEEP
> arch/arm/mm/proc-arm920.S:ENTRY(cpu_arm920_do_suspend)
> arch/arm/mm/proc-arm920.S-      stmfd   sp!, {r4 - r6, lr}
> --
> arch/arm/mm/proc-arm926.S-#ifdef CONFIG_PM_SLEEP
> arch/arm/mm/proc-arm926.S:ENTRY(cpu_arm926_do_suspend)
> arch/arm/mm/proc-arm926.S-      stmfd   sp!, {r4 - r6, lr}
> --
> arch/arm/mm/proc-mohawk.S-#ifdef CONFIG_PM_SLEEP
> arch/arm/mm/proc-mohawk.S:ENTRY(cpu_mohawk_do_suspend)
> arch/arm/mm/proc-mohawk.S-      stmfd   sp!, {r4 - r9, lr}
> --
> arch/arm/mm/proc-sa1100.S-#ifdef CONFIG_PM_SLEEP
> arch/arm/mm/proc-sa1100.S:ENTRY(cpu_sa1100_do_suspend)
> arch/arm/mm/proc-sa1100.S-      stmfd   sp!, {r4 - r6, lr}
> --
> arch/arm/mm/proc-v6.S-#ifdef CONFIG_PM_SLEEP
> arch/arm/mm/proc-v6.S:ENTRY(cpu_v6_do_suspend)
> arch/arm/mm/proc-v6.S-  stmfd   sp!, {r4 - r9, lr}
> --
> arch/arm/mm/proc-v7.S-#ifdef CONFIG_ARM_CPU_SUSPEND
> arch/arm/mm/proc-v7.S:ENTRY(cpu_v7_do_suspend)
> arch/arm/mm/proc-v7.S-  stmfd   sp!, {r4 - r10, lr}
> --
> arch/arm/mm/proc-xsc3.S-#ifdef CONFIG_PM_SLEEP
> arch/arm/mm/proc-xsc3.S:ENTRY(cpu_xsc3_do_suspend)
> arch/arm/mm/proc-xsc3.S-        stmfd   sp!, {r4 - r9, lr}
> --
> arch/arm/mm/proc-xscale.S-#ifdef CONFIG_PM_SLEEP
> arch/arm/mm/proc-xscale.S:ENTRY(cpu_xscale_do_suspend)
> arch/arm/mm/proc-xscale.S-      stmfd   sp!, {r4 - r9, lr}
> 
> However I can't reproduce it now :-/ Anyway the $subject patch fixes
> the main issue, which I can easily reproduce here as well. So I'll
> prepare another patch if needed when I get back to this later.

Sigh.  This stuff looks rather screwed up now:

$ grep -B1 'ENTRY.*do_suspend' arch/arm/mm/proc*.S
arch/arm/mm/proc-arm920.S-#ifdef CONFIG_PM_SLEEP
arch/arm/mm/proc-arm920.S:ENTRY(cpu_arm920_do_suspend)
--
arch/arm/mm/proc-arm926.S-#ifdef CONFIG_PM_SLEEP
arch/arm/mm/proc-arm926.S:ENTRY(cpu_arm926_do_suspend)
--
arch/arm/mm/proc-mohawk.S-#ifdef CONFIG_PM_SLEEP
arch/arm/mm/proc-mohawk.S:ENTRY(cpu_mohawk_do_suspend)
--
arch/arm/mm/proc-sa1100.S-#ifdef CONFIG_PM_SLEEP
arch/arm/mm/proc-sa1100.S:ENTRY(cpu_sa1100_do_suspend)
--
arch/arm/mm/proc-v6.S-#ifdef CONFIG_PM_SLEEP
arch/arm/mm/proc-v6.S:ENTRY(cpu_v6_do_suspend)
--
arch/arm/mm/proc-v7.S-#ifdef CONFIG_ARM_CPU_SUSPEND
arch/arm/mm/proc-v7.S:ENTRY(cpu_v7_do_suspend)
--
arch/arm/mm/proc-xsc3.S-#ifdef CONFIG_PM_SLEEP
arch/arm/mm/proc-xsc3.S:ENTRY(cpu_xsc3_do_suspend)
--
arch/arm/mm/proc-xscale.S-#ifdef CONFIG_PM_SLEEP
arch/arm/mm/proc-xscale.S:ENTRY(cpu_xscale_do_suspend)

Now, CONFIG_PM_SLEEP is fine if this stuff only ever gets used when PM_SLEEP
is enabled - that's what it was designed for in the first place.  However,
as we can see from the earlier patches in this thread, the cpu_suspend
stuff is being selected when PM is enabled (which is arguably wrong), and
also in some cases when CPU_IDLE is enabled.

Therefore, making this code depend on ARM_CPU_SUSPEND seems sensible.
However, So, how did proc-v7.S and only that file end up doing something
different?

commit 15e0d9e37c7fe9711b60f47221c394d45553ad8c
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Sat Oct 1 21:09:39 2011 +0200

    ARM: pm: let platforms select cpu_suspend support

    Support for the cpu_suspend functions is only built-in
    when CONFIG_PM_SLEEP is enabled, but omap3/4, exynos4
    and pxa always call cpu_suspend when CONFIG_PM is enabled.

    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

...
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index a30e785..591accd 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -217,7 +217,7 @@ ENDPROC(cpu_v7_set_pte_ext)
 /* Suspend/resume support: derived from arch/arm/mach-s5pv210/sleep.S */
 .globl cpu_v7_suspend_size
 .equ   cpu_v7_suspend_size, 4 * 9
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_ARM_CPU_SUSPEND
 ENTRY(cpu_v7_do_suspend)
...

As far as this commit goes, it looks sane at the time that it was written,
but as soon as we have *any* other selections of ARM_CPU_SUSPEND, the
whole idea becomes extremely fragile - hence the reason for your build
errors.

Moreover, with the above commit, there is _no_ sense what so ever in not
applying the same change to all proc-*.S files, thereby entirely avoiding
this fragility.  I would argue that the original commit should have made
the same change to _all_ proc-*.S files.

Let's do the job properly - hence this is now queued for -rc:

8<===
From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH] ARM: Do 15e0d9e37c (ARM: pm: let platforms select cpu_suspend support) properly

Let's do the changes properly and fix the same problem everywhere, not
just for one case.

Cc: <stable@vger.kernel.org> # kernels containing 15e0d9e37c7fe or equivalent
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/proc-arm920.S |    2 +-
 arch/arm/mm/proc-arm926.S |    2 +-
 arch/arm/mm/proc-mohawk.S |    2 +-
 arch/arm/mm/proc-sa1100.S |    2 +-
 arch/arm/mm/proc-v6.S     |    2 +-
 arch/arm/mm/proc-xsc3.S   |    2 +-
 arch/arm/mm/proc-xscale.S |    2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mm/proc-arm920.S b/arch/arm/mm/proc-arm920.S
index 2c3b942..2556cf1 100644
--- a/arch/arm/mm/proc-arm920.S
+++ b/arch/arm/mm/proc-arm920.S
@@ -387,7 +387,7 @@ ENTRY(cpu_arm920_set_pte_ext)
 /* Suspend/resume support: taken from arch/arm/plat-s3c24xx/sleep.S */
 .globl	cpu_arm920_suspend_size
 .equ	cpu_arm920_suspend_size, 4 * 3
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_ARM_CPU_SUSPEND
 ENTRY(cpu_arm920_do_suspend)
 	stmfd	sp!, {r4 - r6, lr}
 	mrc	p15, 0, r4, c13, c0, 0	@ PID
diff --git a/arch/arm/mm/proc-arm926.S b/arch/arm/mm/proc-arm926.S
index f1803f7..344c8a5 100644
--- a/arch/arm/mm/proc-arm926.S
+++ b/arch/arm/mm/proc-arm926.S
@@ -402,7 +402,7 @@ ENTRY(cpu_arm926_set_pte_ext)
 /* Suspend/resume support: taken from arch/arm/plat-s3c24xx/sleep.S */
 .globl	cpu_arm926_suspend_size
 .equ	cpu_arm926_suspend_size, 4 * 3
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_ARM_CPU_SUSPEND
 ENTRY(cpu_arm926_do_suspend)
 	stmfd	sp!, {r4 - r6, lr}
 	mrc	p15, 0, r4, c13, c0, 0	@ PID
diff --git a/arch/arm/mm/proc-mohawk.S b/arch/arm/mm/proc-mohawk.S
index 82f9cdc..0b60dd3 100644
--- a/arch/arm/mm/proc-mohawk.S
+++ b/arch/arm/mm/proc-mohawk.S
@@ -350,7 +350,7 @@ ENTRY(cpu_mohawk_set_pte_ext)
 
 .globl	cpu_mohawk_suspend_size
 .equ	cpu_mohawk_suspend_size, 4 * 6
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_ARM_CPU_SUSPEND
 ENTRY(cpu_mohawk_do_suspend)
 	stmfd	sp!, {r4 - r9, lr}
 	mrc	p14, 0, r4, c6, c0, 0	@ clock configuration, for turbo mode
diff --git a/arch/arm/mm/proc-sa1100.S b/arch/arm/mm/proc-sa1100.S
index 3aa0da1..d92dfd0 100644
--- a/arch/arm/mm/proc-sa1100.S
+++ b/arch/arm/mm/proc-sa1100.S
@@ -172,7 +172,7 @@ ENTRY(cpu_sa1100_set_pte_ext)
 
 .globl	cpu_sa1100_suspend_size
 .equ	cpu_sa1100_suspend_size, 4 * 3
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_ARM_CPU_SUSPEND
 ENTRY(cpu_sa1100_do_suspend)
 	stmfd	sp!, {r4 - r6, lr}
 	mrc	p15, 0, r4, c3, c0, 0		@ domain ID
diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index bcaaa8d..5c07ee4 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -138,7 +138,7 @@ ENTRY(cpu_v6_set_pte_ext)
 /* Suspend/resume support: taken from arch/arm/mach-s3c64xx/sleep.S */
 .globl	cpu_v6_suspend_size
 .equ	cpu_v6_suspend_size, 4 * 6
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_ARM_CPU_SUSPEND
 ENTRY(cpu_v6_do_suspend)
 	stmfd	sp!, {r4 - r9, lr}
 	mrc	p15, 0, r4, c13, c0, 0	@ FCSE/PID
diff --git a/arch/arm/mm/proc-xsc3.S b/arch/arm/mm/proc-xsc3.S
index eb93d64..e8efd83 100644
--- a/arch/arm/mm/proc-xsc3.S
+++ b/arch/arm/mm/proc-xsc3.S
@@ -413,7 +413,7 @@ ENTRY(cpu_xsc3_set_pte_ext)
 
 .globl	cpu_xsc3_suspend_size
 .equ	cpu_xsc3_suspend_size, 4 * 6
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_ARM_CPU_SUSPEND
 ENTRY(cpu_xsc3_do_suspend)
 	stmfd	sp!, {r4 - r9, lr}
 	mrc	p14, 0, r4, c6, c0, 0	@ clock configuration, for turbo mode
diff --git a/arch/arm/mm/proc-xscale.S b/arch/arm/mm/proc-xscale.S
index 2551036..e766f88 100644
--- a/arch/arm/mm/proc-xscale.S
+++ b/arch/arm/mm/proc-xscale.S
@@ -528,7 +528,7 @@ ENTRY(cpu_xscale_set_pte_ext)
 
 .globl	cpu_xscale_suspend_size
 .equ	cpu_xscale_suspend_size, 4 * 6
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_ARM_CPU_SUSPEND
 ENTRY(cpu_xscale_do_suspend)
 	stmfd	sp!, {r4 - r9, lr}
 	mrc	p14, 0, r4, c6, c0, 0	@ clock configuration, for turbo mode
-- 
1.7.4.4
