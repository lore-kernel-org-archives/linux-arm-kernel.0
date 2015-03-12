From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Thu, 12 Mar 2015 13:39:15 +0000
Subject: [PATCH 4.0-rc2 v18 0/6] irq/arm: Implement
 arch_trigger_all_cpu_backtrace
In-Reply-To: <1422022952-31552-1-git-send-email-daniel.thompson@linaro.org>
References: <1422022952-31552-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1426167561-25963-1-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason/Thomas:
  Any chance of taking the first five of these patches via the irqchip
  route? The x86 patch has an ack from Ingo, printk has no explicit
  maintainer and I've done plenty of bisectability tests on the patchset.

This patchset modifies the GIC driver to allow it, on supported
platforms, to route IPI interrupts to FIQ. It then uses this
feature to implement arch_trigger_all_cpu_backtrace for arm.
In order to neatly bring in the changes for the arm we also rearrange
some of the existing x86 NMI code to make it architecture neutral.

The patchset http://thread.gmane.org/gmane.linux.kernel/1897765 , which
makes sched_clock() NMI/FIQ-safe, should be treated as a prerequisite
for the sixth and final patch in the series (which enables the feature
on ARM).  Although sched_clock() is not called directly by any of the
code that runs from a FIQ handler it is possible for sched_clock() to be
called indirectly when the function tracer is enabled.

The patches have been runtime tested on two systems capable of
supporting FIQ (Freescale i.MX6 and STiH416) and two that do not
(vexpress-a9 and Qualcomm Snapdragon 600), the changes to the x86
logic were tested on qemu and all patches have been compile tested
on x86, arm and arm64.

Note: On platforms not capable of supporting FIQ, the IPI to generate a
      backtrace will fall back to using IRQ for propagation instead.
      The backtrace logic contains a timeout to we will not permanently
      wedge the requesting CPU if other CPUs are not responsive.

v18:

* Move printk_nmi_ functions out of printk.c and into their own
  file, nmi_callback.c (Joe Perches/Steven Rostedt).

* Rename printk_nmi_ functions so their name matches their new home
  (Joe Perches)

v17:

* Rename bl_migration_lock/unlock to gic_migration_lock/unlock
  (Nicolas Pitre).

v16:

* Significant clean up of the printk patches (Thomas Gleixner).
  Replacing macros with real functions, CONFIG_ARCH_WANT_NMI_PRINTK
  -> CONFIG_PRINTK_NMI, prefixing global functions with printk_nmi,
  removing pointless exports, removing cpu_mask from the interfaces,
  removal of just-in-time initialization of trace buffers, prevented
  call sites having to save state, rolled up variable declarations
  into single lines.

* Dropped the sched_clock() patches from *this* patchset and managed
  them separately (http://thread.gmane.org/gmane.linux.kernel/1879261 ).
  The cross-dependancies between the patches are minimal; the backtrace
  code only calls sched_clock() if we are ftracing and backtracing is
  normally only triggered to report information about about a broken
  system (although users can type SysRq-l for amusement, most use it
  to find out why the system it dead).

* Squashed together the final two patches. Essentially these duplicated
  the x86 code and slavishly avoided changing it before, in the next
  patch, fixing it to work better on ARM. It seems better that the code
  just works first time!

v15:

* Added a patch to make sched_clock safe to call from NMI (Stephen
  Boyd). Note that sched_clock() is not called by the NMI handlers that
  have been added for the arm but it could be called if tools such as
  ftrace are deployed.

* Fixed some warnings picked up during bisectability testing.

v14:

* Moved a nmi_vprintk() and friends from arch/x86/kernel/apic/hw_nmi.c
  to printk.c (Steven Rostedt)

v13:

* Updated the code to print the backtrace to replicate Steven Rostedt's
  x86 work to make SysRq-l safe. This is pretty much a total rewrite of
  patches 4 and 5.

v12:

* Squash first two patches into a single one and re-describe
  (Thomas Gleixner).

* Improve description of "irqchip: gic: Make gic_raise_softirq FIQ-safe"
  (Thomas Gleixner).

v11:

* Optimized gic_raise_softirq() by replacing a register read with
  a memory read (Jason Cooper).

v10:

* Add a further patch to optimize away some of the locking on systems
  where CONFIG_BL_SWITCHER is not set (Marc Zyngier). Compiles OK with
  exynos_defconfig (which is the only defconfig to set this option).

* Whitespace fixes in patch 4. That patch previously used spaces for
  alignment of new constants but the rest of the file used tabs.

v9:

* Improved documentation and structure of initial patch (now initial
  two patches) to make gic_raise_softirq() safe to call from FIQ
  (Thomas Gleixner).

* Avoid masking interrupts during gic_raise_softirq(). The use of the
  read lock makes this redundant (because we can safely re-enter the
  function).

v8:

* Fixed build on arm64 causes by a spurious include file in irq-gic.c.

v7-2 (accidentally released twice with same number):

* Fixed boot regression on vexpress-a9 (reported by Russell King).

* Rebased on v3.18-rc3; removed one patch from set that is already
  included in mainline.

* Dropped arm64/fiq.h patch from the set (still useful but not related
  to issuing backtraces).

v7:

* Re-arranged code within the patch series to fix a regression
  introduced midway through the series and corrected by a later patch
  (testing by Olof's autobuilder). Tested offending patch in isolation
  using defconfig identified by the autobuilder.

v6:

* Renamed svc_entry's call_trace argument to just trace (example code
  from Russell King).

* Fixed mismatched ENDPROC() in __fiq_abt (example code from Russell
  King).

* Modified usr_entry to optional avoid calling into the trace code and
  used this in FIQ entry from usr path. Modified corresponding exit code
  to avoid calling into trace code and the scheduler (example code from
  Russell King).

* Ensured the default FIQ register state is restored when the default
  FIQ handler is reinstalled (example code from Russell King).

* Renamed no_fiq_insn to dfl_fiq_insn to reflect the effect of adopting
  a default FIQ handler.

* Re-instated fiq_safe_migration_lock and associated logic in
  gic_raise_softirq(). gic_raise_softirq() is called by wake_up_klogd()
  in the console unlock logic.

v5:

* Rebased on 3.17-rc4.

* Removed a spurious line from the final "glue it together" patch
  that broke the build.

v4:

* Replaced push/pop with stmfd/ldmfd respectively (review of Nicolas
  Pitre).

* Really fix bad pt_regs pointer generation in __fiq_abt.

* Remove fiq_safe_migration_lock and associated logic in
  gic_raise_softirq() (review of Russell King)

* Restructured to introduce the default FIQ handler first, before the
  new features (review of Russell King).

v3:

* Removed redundant header guards from arch/arm64/include/asm/fiq.h
  (review of Catalin Marinas).

* Moved svc_exit_via_fiq macro to entry-header.S (review of Nicolas
  Pitre).

v2:

* Restructured to sit nicely on a similar FYI patchset from Russell
  King. It now effectively replaces the work in progress final patch
  with something much more complete.

* Implemented (and tested) a Thumb-2 implementation of svc_exit_via_fiq
  (review of Nicolas Pitre)

* Dropped the GIC group 0 workaround patch. The issue of FIQ interrupts
  being acknowledged by the IRQ handler does still exist but should be
  harmless because the IRQ handler will still wind up calling
  ipi_cpu_backtrace().

* Removed any dependency on CONFIG_FIQ; all cpu backtrace effectively
  becomes a platform feature (although the use of non-maskable
  interrupts to implement it is best effort rather than guaranteed).

* Better comments highlighting usage of RAZ/WI registers (and parts of
  registers) in the GIC code.

Changes *before* v1:

* This patchset is a hugely cut-down successor to "[PATCH v11 00/19]
  arm: KGDB NMI/FIQ support". Thanks to Thomas Gleixner for suggesting
  the new structure. For historic details see:
        https://lkml.org/lkml/2014/9/2/227

* Fix bug in __fiq_abt (no longer passes a bad struct pt_regs value).
  In fixing this we also remove the useless indirection previously
  found in the fiq_handler macro.

* Make default fiq handler "always on" by migrating from fiq.c to
  traps.c and replace do_unexp_fiq with the new handler (review
  of Russell King).

* Add arm64 version of fiq.h (review of Russell King)

* Removed conditional branching and code from irq-gic.c, this is
  replaced by much simpler code that relies on the GIC specification's
  heavy use of read-as-zero/write-ignored (review of Russell King)


Daniel Thompson (6):
  irqchip: gic: Optimize locking in gic_raise_softirq
  irqchip: gic: Make gic_raise_softirq FIQ-safe
  irqchip: gic: Introduce plumbing for IPI FIQ
  printk: Simple implementation for NMI backtracing
  x86/nmi: Use common printk functions
  ARM: Add support for on-demand backtrace of other CPUs

 arch/arm/Kconfig                |   1 +
 arch/arm/include/asm/hardirq.h  |   2 +-
 arch/arm/include/asm/irq.h      |   5 +
 arch/arm/include/asm/smp.h      |   3 +
 arch/arm/kernel/smp.c           |  81 ++++++++++++++++
 arch/arm/kernel/traps.c         |   8 +-
 arch/x86/Kconfig                |   1 +
 arch/x86/kernel/apic/hw_nmi.c   | 101 ++------------------
 drivers/irqchip/irq-gic.c       | 203 +++++++++++++++++++++++++++++++++++++---
 include/linux/irqchip/arm-gic.h |   8 ++
 include/linux/printk.h          |  20 ++++
 init/Kconfig                    |   3 +
 kernel/printk/Makefile          |   1 +
 kernel/printk/nmi_backtrace.c   | 148 +++++++++++++++++++++++++++++
 14 files changed, 474 insertions(+), 111 deletions(-)
 create mode 100644 kernel/printk/nmi_backtrace.c

--
2.1.0
