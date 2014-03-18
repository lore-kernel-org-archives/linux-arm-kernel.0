From: sebastian.capella@linaro.org (Sebastian Capella)
Date: Tue, 18 Mar 2014 14:40:56 -0700
Subject: [PATCH v9 0/2] hibernation support on ARM
Message-ID: <1395178858-27343-1-git-send-email-sebastian.capella@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Cc: Russ Dill <Russ.Dill@ti.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Stephen Warren <swarren@nvidia.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Nicolas Pitre <nico@linaro.org>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Jonathan Austin <jonathan.austin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Uwe Kleine-K?nig" <u.kleine-koenig@pengutronix.de>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Laura Abbott <lauraa@codeaurora.org>
Cc: Jiang Liu <liuj97@gmail.com>
Cc: Sricharan R <r.sricharan@ti.com>
Cc: Victor Kamensky <victor.kamensky@linaro.org>
Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Robin Holt <robin.m.holt@gmail.com>
Cc: Konstantin Khlebnikov <k.khlebnikov@samsung.com>
Cc: Steven Capper <steve.capper@linaro.org>
Cc: Tejun Heo <tj@kernel.org>


Patches adding support for hibernation on ARM
 - ARM hibernation / suspend-to-disk
 - Change soft_restart to use non-tracing raw_local_irq_disable

Patches based on v3.14-rc7 tag, verified hibernation on beaglebone black on a
branch based on 3.13 merged with initial omap support from Russ Dill which
can be found here (includes v1 patchset):
http://git.linaro.org/git-ro/people/sebastian.capella/linux.git hibernation_3.13_russMerge

[PATCH v9 1/2] ARM: avoid tracers in soft_restart
 arch/arm/kernel/process.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

 Use raw_local_irq_disable in place of local_irq_disable to avoid
 infinite abort recursion while tracing. (unchanged since v3)

[PATCH v9 2/2] ARM hibernation / suspend-to-disk
 arch/arm/Kconfig              |    5 ++
 arch/arm/include/asm/memory.h |    1 +
 arch/arm/kernel/Makefile      |    1 +
 arch/arm/kernel/hibernate.c   |  107 +++++++++++++++++++++++++++++++++++++++++
 include/linux/suspend.h       |    2 +
 5 files changed, 116 insertions(+)

 Adds support for ARM based hibernation


Additional notes:
-----------------

There are two checkpatch warnings added by this patch.  These follow
behavior in existing hibernation implementations on other platforms.


    WARNING: externs should be avoided in .c files
    #131: FILE: arch/arm/kernel/hibernate.c:25:
    +extern const void __nosave_begin, __nosave_end;

  This extern is picking up the linker nosave region definitions, only
  used in hibernate.  Follows same extern line used mips, powerpc, s390,
  sh, sparc, x86 & unicore32

    WARNING: externs should be avoided in .c files
    #209: FILE: arch/arm/kernel/hibernate.c:103:
    +	extern void call_with_stack(void (*fn)(void *), void *arg, void *sp);

  This extern is used in the arch/arm/ in hibernate, process and bL_switcher


Changes in v9:
--------------
* replace pfn calculationwith virt_to_pfn
* automatically allow ARCH_HIBERNATION_POSSIBLE if SUSPEND permitted
* move handling of ARCH config flag to arch/arm/Kconfig

Changes in v8:
--------------
* remove definition and use of __pa_symbol

Changes in v7:
--------------
* remove use of RELOC_HIDE macro
* remove unused #includes
* fixup comment for arch_restore_image
* ensure alignment of resume stack on 8 byte boundary

Changes in v6:
--------------
* Simplify static variable names

Changes in v5:
--------------
* Fixed checkpatch warning on trailing whitespace

Changes in v4:
--------------
* updated comment for soft_restart with review feedback
* dropped freeze_processes patch which was queued separately 
  to 3.14 by Rafael Wysocki:
  https://lkml.org/lkml/2014/2/25/683

Changes in v3:
--------------
* added comment to use of soft_restart
* drop irq disable soft_restart patch
* add patch to avoid tracers in soft_restart by using raw_local_irq_*

Changes in v2:
--------------
* Removed unneeded flush_thread, use of __naked and cpu_init.
* dropped Cyril Chemparathy <cyril@ti.com> from Cc: list as 
  emails are bouncing.

Thanks,

Sebastian Capella
