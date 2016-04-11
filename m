From: oss@buserror.net (Scott Wood)
Date: Sun, 10 Apr 2016 21:22:33 -0500
Subject: [RFC PATCH 2/2] ARM64: arch_timer: Work around QorIQ Erratum A-009971
In-Reply-To: <1460341353-15619-1-git-send-email-oss@buserror.net>
References: <1460341353-15619-1-git-send-email-oss@buserror.net>
Message-ID: <1460341353-15619-3-git-send-email-oss@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Priyanka Jain <priyanka.jain@nxp.com>

Erratum A-009971 says that it is possible for the timer value register
to be written incorrectly, resulting in "an incorrect and potentially
very long timeout".  The workaround is to read the timer count
immediately before and after writing the timer value register, and
repeat if the counter reads don't match.

This erratum can be found on LS2080A.

Signed-off-by: Priyanka Jain <priyanka.jain@nxp.com>
[scottwood: cleanup and fixes]
Signed-off-by: Scott Wood <oss@buserror.net>
---
 .../devicetree/bindings/arm/arch_timer.txt         |  5 ++++
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     |  1 +
 arch/arm64/include/asm/arch_timer.h                | 27 ++++++++++++++++++++--
 drivers/clocksource/arm_arch_timer.c               |  3 +++
 4 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/arch_timer.txt b/Documentation/devicetree/bindings/arm/arch_timer.txt
index 7117fbd..ab4d3b1 100644
--- a/Documentation/devicetree/bindings/arm/arch_timer.txt
+++ b/Documentation/devicetree/bindings/arm/arch_timer.txt
@@ -29,6 +29,11 @@ to deliver its interrupts via SPIs.
   QorIQ erratum A-008585, which says reading the timer is unreliable
   unless the same value is returned by back-to-back reads.
 
+- fsl,erratum-a009971 : A boolean property. Indicates the presence of
+  QorIQ erratum A-009971, which says writing the timer value register
+  is unreliable unless timer count reads before and after the timer write
+  return the same value.
+
 ** Optional properties:
 
 - arm,cpu-registers-not-fw-configured : Firmware does not initialize
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
index 0270ccf..529e441 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
@@ -172,6 +172,7 @@
 			     <1 11 0x8>, /* Virtual PPI, active-low */
 			     <1 10 0x8>; /* Hypervisor PPI, active-low */
 		fsl,erratum-a008585;
+		fsl,erratum-a009971;
 	};
 
 	pmu {
diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index 9367ee3..1867e60 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -28,6 +28,7 @@
 #include <clocksource/arm_arch_timer.h>
 
 extern bool arm_arch_timer_reread;
+extern bool arm_arch_timer_rewrite;
 
 /* QorIQ errata workarounds */
 #define ARCH_TIMER_REREAD(reg) ({ \
@@ -52,6 +53,20 @@ extern bool arm_arch_timer_reread;
 	_val; \
 })
 
+#define ARCH_TIMER_TVAL_REWRITE(pv, val) do { \
+	u64 _cnt_old, _cnt_new; \
+	int _timeout = 200; \
+	do { \
+		asm volatile("mrs %0, cntvct_el0;" \
+			     "msr cnt" pv "_tval_el0, %2;" \
+			     "mrs %1, cntvct_el0" \
+			     : "=&r" (_cnt_old), "=r" (_cnt_new) \
+			     : "r" (val)); \
+		_timeout--; \
+	} while (_cnt_old != _cnt_new && _timeout); \
+	WARN_ON_ONCE(!_timeout); \
+} while (0)
+
 /*
  * These register accessors are marked inline so the compiler can
  * nicely work out which register we want, and chuck away the rest of
@@ -66,7 +81,11 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u32 val)
 			asm volatile("msr cntp_ctl_el0,  %0" : : "r" (val));
 			break;
 		case ARCH_TIMER_REG_TVAL:
-			asm volatile("msr cntp_tval_el0, %0" : : "r" (val));
+			if (arm_arch_timer_rewrite)
+				ARCH_TIMER_TVAL_REWRITE("p", val);
+			else
+				asm volatile("msr cntp_tval_el0, %0" : :
+					     "r" (val));
 			break;
 		}
 	} else if (access == ARCH_TIMER_VIRT_ACCESS) {
@@ -75,7 +94,11 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u32 val)
 			asm volatile("msr cntv_ctl_el0,  %0" : : "r" (val));
 			break;
 		case ARCH_TIMER_REG_TVAL:
-			asm volatile("msr cntv_tval_el0, %0" : : "r" (val));
+			if (arm_arch_timer_rewrite)
+				ARCH_TIMER_TVAL_REWRITE("v", val);
+			else
+				asm volatile("msr cntv_tval_el0, %0" : :
+					     "r" (val));
 			break;
 		}
 	}
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 5ed7c7f..82b32cb 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -81,6 +81,7 @@ static bool arch_timer_mem_use_virtual;
 
 bool arm_arch_timer_reread; /* QorIQ erratum A-008585 */
 EXPORT_SYMBOL(arm_arch_timer_reread);
+bool arm_arch_timer_rewrite; /* QorIQ erratum A-009971 */
 
 /*
  * Architected system timer support.
@@ -767,6 +768,8 @@ static void __init arch_timer_of_init(struct device_node *np)
 	arch_timer_c3stop = !of_property_read_bool(np, "always-on");
 	arm_arch_timer_reread =
 		of_property_read_bool(np, "fsl,erratum-a008585");
+	arm_arch_timer_rewrite =
+		of_property_read_bool(np, "fsl,erratum-a009971");
 
 	/*
 	 * If we cannot rely on firmware initializing the timer registers then
-- 
2.5.0
