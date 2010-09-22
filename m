From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 21 Sep 2010 18:19:40 -0600
Subject: [PATCH 5/5] OMAP: hwmod: improve documentation,
	clean up function names
In-Reply-To: <20100922001834.8621.76144.stgit@twilight.localdomain>
References: <20100922001834.8621.76144.stgit@twilight.localdomain>
Message-ID: <20100922001937.8621.99042.stgit@twilight.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch:

- adds more documentation to the hwmod code

- fixes some documentation typos elsewhere in the file

- changes the _sysc_*() function names to appear in (verb, noun) order,
  to match the rest of the function names.

This patch should not result in any functional change.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |  141 ++++++++++++++++++++++----
 arch/arm/plat-omap/include/plat/omap_hwmod.h |   11 +-
 2 files changed, 123 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 3f3d61a..52f2fb9 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -13,10 +13,102 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  *
- * This code manages "OMAP modules" (on-chip devices) and their
- * integration with Linux device driver and bus code.
- *
- * References:
+ * Introduction
+ * ------------
+ * One way to view an OMAP SoC is as a collection of largely unrelated
+ * IP blocks connected by interconnects.  The IP blocks include
+ * devices such as ARM processors, audio serial interfaces, UARTs,
+ * etc.  Some of these devices, like the DSP, are created by TI;
+ * others, like the SGX, largely originate from external vendors.  In
+ * TI's documentation, on-chip devices are referred to as "OMAP
+ * modules."  Some of these IP blocks are identical across several
+ * OMAP versions.  Others are revised frequently.
+ *
+ * These OMAP modules are tied together by various interconnects.
+ * Most of the address and data flow between modules is via OCP-based
+ * interconnects such as the L3 and L4 buses; but there are other
+ * interconnects that distribute the hardware clock tree, handle idle
+ * and reset signaling, supply power, and connect the modules to
+ * various pads or balls on the OMAP package.
+ *
+ * OMAP hwmod provides a consistent way to describe the on-chip
+ * hardware blocks and their integration into the rest of the chip.
+ * This description can be automatically generated from the TI
+ * hardware database.  OMAP hwmod provides a standard, consistent API
+ * to reset, enable, idle, and disable these hardware blocks.  And
+ * hwmod provides a way for other core code, such as the Linux device
+ * code or the OMAP power management and address space mapping code,
+ * to query the hardware database.
+ *
+ * Using hwmod
+ * -----------
+ * Drivers won't call hwmod functions directly.  That is done by the
+ * omap_device code, and in rare occasions, by custom integration code
+ * in arch/arm/ *omap*.  The omap_device code includes functions to
+ * build a struct platform_device using omap_hwmod data, and that is
+ * currently how hwmod data is communicated to drivers and to the
+ * Linux driver model.  Most drivers will call omap_hwmod functions only
+ * indirectly, via pm_runtime*() functions.
+ *
+ * From a layering perspective, here is where the OMAP hwmod code
+ * fits into the kernel software stack:
+ *
+ *            +-------------------------------+
+ *            |      Device driver code       |
+ *            |      (e.g., drivers/)         |
+ *            +-------------------------------+
+ *            |      Linux driver model       |
+ *            |     (platform_device /        |
+ *            |  platform_driver data/code)   |
+ *            +-------------------------------+
+ *            | OMAP core-driver integration  |
+ *            |(arch/arm/mach-omap2/devices.c)|
+ *            +-------------------------------+
+ *            |      omap_device code         |
+ *            | (../plat-omap/omap_device.c)  |
+ *            +-------------------------------+
+ *   ---->    |    omap_hwmod code/data       |    <-----
+ *            | (../mach-omap2/omap_hwmod*)   |
+ *            +-------------------------------+
+ *            | OMAP clock/PRCM/register fns  |
+ *            | (__raw_{read,write}l, clk*)   |
+ *            +-------------------------------+
+ *
+ * Device drivers should not contain any OMAP-specific code or data in
+ * them.  They should only contain code to operate the IP block that
+ * the driver is responsible for.  This is because these IP blocks can
+ * also appear in other SoCs, either from TI (such as DaVinci) or from
+ * other manufacturers; and drivers should be reusable across other
+ * platforms.
+ *
+ * The OMAP hwmod code also will attempt to reset and idle all on-chip
+ * devices upon boot.  The goal here is for the kernel to be
+ * completely self-reliant and independent from bootloaders.  This is
+ * to ensure a repeatable configuration, both to ensure consistent
+ * runtime behavior, and to make it easier for others to reproduce
+ * bugs.
+ *
+ * OMAP module activity states
+ * ---------------------------
+ * The hwmod code considers modules to be in one of several activity
+ * states.  IP blocks start out in an UNKNOWN state, then once they
+ * are registered via the hwmod code, proceed to the REGISTERED state.
+ * Once their clock names are resolved to clock pointers, the module
+ * enters the CLKS_INITED state; and finally, once the module has been
+ * reset and the integration registers programmed, the INITIALIZED state
+ * is entered.  The hwmod code will then place the module into either
+ * the IDLE state to save power, or in the case of a critical system
+ * module, the ENABLED state.
+ *
+ * OMAP core integration code can then call omap_hwmod*() functions
+ * directly to move the module between the IDLE, ENABLED, and DISABLED
+ * states, as needed.  This is done during both the PM idle loop, and
+ * in the OMAP core integration code's implementation of the PM runtime
+ * functions.
+ *
+ * References
+ * ----------
+ * This is a partial list.
  * - OMAP2420 Multimedia Processor Silicon Revision 2.1.1, 2.2 (SWPU064)
  * - OMAP2430 Multimedia Device POP Silicon Revision 2.1 (SWPU090)
  * - OMAP34xx Multimedia Device Silicon Revision 3.1 (SWPU108)
@@ -654,7 +746,7 @@ static void __iomem *_find_mpu_rt_base(struct omap_hwmod *oh, u8 index)
 }
 
 /**
- * _sysc_enable - try to bring a module out of idle via OCP_SYSCONFIG
+ * _enable_sysc - try to bring a module out of idle via OCP_SYSCONFIG
  * @oh: struct omap_hwmod *
  *
  * If module is marked as SWSUP_SIDLE, force the module out of slave
@@ -662,7 +754,7 @@ static void __iomem *_find_mpu_rt_base(struct omap_hwmod *oh, u8 index)
  * as SWSUP_MSUSPEND, force the module out of master standby;
  * otherwise, configure it for smart-standby.  No return value.
  */
-static void _sysc_enable(struct omap_hwmod *oh)
+static void _enable_sysc(struct omap_hwmod *oh)
 {
 	u8 idlemode, sf;
 	u32 v;
@@ -708,7 +800,7 @@ static void _sysc_enable(struct omap_hwmod *oh)
 }
 
 /**
- * _sysc_idle - try to put a module into idle via OCP_SYSCONFIG
+ * _idle_sysc - try to put a module into idle via OCP_SYSCONFIG
  * @oh: struct omap_hwmod *
  *
  * If module is marked as SWSUP_SIDLE, force the module into slave
@@ -716,7 +808,7 @@ static void _sysc_enable(struct omap_hwmod *oh)
  * as SWSUP_MSUSPEND, force the module into master standby; otherwise,
  * configure it for smart-standby.  No return value.
  */
-static void _sysc_idle(struct omap_hwmod *oh)
+static void _idle_sysc(struct omap_hwmod *oh)
 {
 	u8 idlemode, sf;
 	u32 v;
@@ -743,13 +835,13 @@ static void _sysc_idle(struct omap_hwmod *oh)
 }
 
 /**
- * _sysc_shutdown - force a module into idle via OCP_SYSCONFIG
+ * _shutdown_sysc - force a module into idle via OCP_SYSCONFIG
  * @oh: struct omap_hwmod *
  *
  * Force the module into slave idle and master suspend. No return
  * value.
  */
-static void _sysc_shutdown(struct omap_hwmod *oh)
+static void _shutdown_sysc(struct omap_hwmod *oh)
 {
 	u32 v;
 	u8 sf;
@@ -1071,8 +1163,11 @@ dis_opt_clks:
  * @oh: struct omap_hwmod *
  *
  * Enables an omap_hwmod @oh such that the MPU can access the hwmod's
- * register target.  Returns -EINVAL if the hwmod is in the wrong
- * state or passes along the return value of _wait_target_ready().
+ * register target.  (This function has a full name --
+ * _omap_hwmod_enable() rather than simply _enable() -- because it is
+ * currently required by the pm34xx.c idle loop.)  Returns -EINVAL if
+ * the hwmod is in the wrong state or passes along the return value of
+ * _wait_target_ready().
  */
 int _omap_hwmod_enable(struct omap_hwmod *oh)
 {
@@ -1110,7 +1205,7 @@ int _omap_hwmod_enable(struct omap_hwmod *oh)
 		if (oh->class->sysc) {
 			if (!(oh->_int_flags & _HWMOD_SYSCONFIG_LOADED))
 				_update_sysc_cache(oh);
-			_sysc_enable(oh);
+			_enable_sysc(oh);
 		}
 	} else {
 		pr_debug("omap_hwmod: %s: _wait_target_ready: %d\n",
@@ -1121,12 +1216,14 @@ int _omap_hwmod_enable(struct omap_hwmod *oh)
 }
 
 /**
- * _idle - idle an omap_hwmod
+ * _omap_hwmod_idle - idle an omap_hwmod
  * @oh: struct omap_hwmod *
  *
  * Idles an omap_hwmod @oh.  This should be called once the hwmod has
- * no further work.  Returns -EINVAL if the hwmod is in the wrong
- * state or returns 0.
+ * no further work.  (This function has a full name --
+ * _omap_hwmod_idle() rather than simply _idle() -- because it is
+ * currently required by the pm34xx.c idle loop.)  Returns -EINVAL if
+ * the hwmod is in the wrong state or returns 0.
  */
 int _omap_hwmod_idle(struct omap_hwmod *oh)
 {
@@ -1139,7 +1236,7 @@ int _omap_hwmod_idle(struct omap_hwmod *oh)
 	pr_debug("omap_hwmod: %s: idling\n", oh->name);
 
 	if (oh->class->sysc)
-		_sysc_idle(oh);
+		_idle_sysc(oh);
 	_del_initiator_dep(oh, mpu_oh);
 	_disable_clocks(oh);
 
@@ -1169,7 +1266,7 @@ static int _shutdown(struct omap_hwmod *oh)
 	pr_debug("omap_hwmod: %s: disabling\n", oh->name);
 
 	if (oh->class->sysc)
-		_sysc_shutdown(oh);
+		_shutdown_sysc(oh);
 
 	/*
 	 * If an IP contains only one HW reset line, then assert it
@@ -1262,7 +1359,7 @@ static int _setup(struct omap_hwmod *oh, void *data)
 		 */
 		if (oh->class->sysc) {
 			_update_sysc_cache(oh);
-			_sysc_enable(oh);
+			_enable_sysc(oh);
 		}
 	}
 
@@ -1518,7 +1615,7 @@ int omap_hwmod_unregister(struct omap_hwmod *oh)
  * omap_hwmod_enable - enable an omap_hwmod
  * @oh: struct omap_hwmod *
  *
- * Enable an omap_hwomd @oh.  Intended to be called by omap_device_enable().
+ * Enable an omap_hwmod @oh.  Intended to be called by omap_device_enable().
  * Returns -EINVAL on error or passes along the return value from _enable().
  */
 int omap_hwmod_enable(struct omap_hwmod *oh)
@@ -1540,7 +1637,7 @@ int omap_hwmod_enable(struct omap_hwmod *oh)
  * omap_hwmod_idle - idle an omap_hwmod
  * @oh: struct omap_hwmod *
  *
- * Idle an omap_hwomd @oh.  Intended to be called by omap_device_idle().
+ * Idle an omap_hwmod @oh.  Intended to be called by omap_device_idle().
  * Returns -EINVAL on error or passes along the return value from _idle().
  */
 int omap_hwmod_idle(struct omap_hwmod *oh)
@@ -1559,7 +1656,7 @@ int omap_hwmod_idle(struct omap_hwmod *oh)
  * omap_hwmod_shutdown - shutdown an omap_hwmod
  * @oh: struct omap_hwmod *
  *
- * Shutdown an omap_hwomd @oh.  Intended to be called by
+ * Shutdown an omap_hwmod @oh.  Intended to be called by
  * omap_device_shutdown().  Returns -EINVAL on error or passes along
  * the return value from _shutdown().
  */
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index ee53758..7290281 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -14,19 +14,16 @@
  *
  * These headers and macros are used to define OMAP on-chip module
  * data and their integration with other OMAP modules and Linux.
- *
- * References:
- * - OMAP2420 Multimedia Processor Silicon Revision 2.1.1, 2.2 (SWPU064)
- * - OMAP2430 Multimedia Device POP Silicon Revision 2.1 (SWPU090)
- * - OMAP34xx Multimedia Device Silicon Revision 3.1 (SWPU108)
- * - OMAP4430 Multimedia Device Silicon Revision 1.0 (SWPU140)
- * - Open Core Protocol Specification 2.2
+ * Copious documentation and references can also be found in the
+ * omap_hwmod code, in arch/arm/mach-omap2/omap_hwmod.c (as of this
+ * writing).
  *
  * To do:
  * - add interconnect error log structures
  * - add pinmuxing
  * - init_conn_id_bit (CONNID_BIT_VECTOR)
  * - implement default hwmod SMS/SDRC flags?
+ * - remove unused fields
  *
  */
 #ifndef __ARCH_ARM_PLAT_OMAP_INCLUDE_MACH_OMAP_HWMOD_H
