From: will.deacon@arm.com (Will Deacon)
Date: Fri, 12 Mar 2010 17:29:44 +0000
Subject: [RFC PATCH 6/6] ARM: pxa: register PMU IRQs during board
	initialisation
In-Reply-To: <1268414985-22699-6-git-send-email-will.deacon@arm.com>
References: <1268414985-22699-1-git-send-email-will.deacon@arm.com>
	<1268414985-22699-2-git-send-email-will.deacon@arm.com>
	<1268414985-22699-3-git-send-email-will.deacon@arm.com>
	<1268414985-22699-4-git-send-email-will.deacon@arm.com>
	<1268414985-22699-5-git-send-email-will.deacon@arm.com>
	<1268414985-22699-6-git-send-email-will.deacon@arm.com>
Message-ID: <1268414985-22699-7-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modifies the initialisation routines for the PXA25x, PXA27x
and PXA3xx platforms so that they register their PMU IRQs with the PMU
framework in the Kernel.

Cc: Eric Miao <eric.y.miao@gmail.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-pxa/pxa25x.c |   14 ++++++++++++++
 arch/arm/mach-pxa/pxa27x.c |   13 +++++++++++++
 arch/arm/mach-pxa/pxa3xx.c |   14 ++++++++++++++
 3 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index 2c1b0b7..e2c30a2 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -23,6 +23,8 @@
 #include <linux/suspend.h>
 #include <linux/sysdev.h>
 
+#include <asm/pmu.h>
+
 #include <mach/hardware.h>
 #include <mach/irqs.h>
 #include <mach/gpio.h>
@@ -341,6 +343,16 @@ static struct sys_device pxa25x_sysdev[] = {
 	},
 };
 
+static int pmu_irqs[] = {
+	IRQ_PMU,
+};
+
+static struct pmu_irqs cpu_pmu_device = {
+	.device_type		= ARM_PMU_DEVICE_CPU,
+	.irqs			= pmu_irqs,
+	.num_irqs		= ARRAY_SIZE(pmu_irqs),
+};
+
 static int __init pxa25x_init(void)
 {
 	int i, ret = 0;
@@ -366,6 +378,8 @@ static int __init pxa25x_init(void)
 					   ARRAY_SIZE(pxa25x_devices));
 		if (ret)
 			return ret;
+
+		pmu_device_register(&cpu_pmu_device);
 	}
 
 	/* Only add HWUART for PXA255/26x; PXA210/250 do not have it. */
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 6a0b731..6e74cc0 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -18,6 +18,8 @@
 #include <linux/platform_device.h>
 #include <linux/sysdev.h>
 
+#include <asm/pmu.h>
+
 #include <mach/hardware.h>
 #include <asm/irq.h>
 #include <mach/irqs.h>
@@ -384,6 +386,16 @@ static struct sys_device pxa27x_sysdev[] = {
 	},
 };
 
+static int pmu_irqs[] = {
+	IRQ_PMU,
+};
+
+static struct pmu_irqs cpu_pmu_device = {
+	.device_type		= ARM_PMU_DEVICE_CPU,
+	.irqs			= pmu_irqs,
+	.num_irqs		= ARRAY_SIZE(pmu_irqs),
+};
+
 static int __init pxa27x_init(void)
 {
 	int i, ret = 0;
@@ -406,6 +418,7 @@ static int __init pxa27x_init(void)
 		}
 
 		ret = platform_add_devices(devices, ARRAY_SIZE(devices));
+		pmu_device_register(&cpu_pmu_device);
 	}
 
 	return ret;
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index fcb0721..b84681a 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -22,8 +22,11 @@
 #include <linux/io.h>
 #include <linux/sysdev.h>
 
+#include <asm/pmu.h>
+
 #include <mach/hardware.h>
 #include <mach/gpio.h>
+#include <mach/irqs.h>
 #include <mach/pxa3xx-regs.h>
 #include <mach/reset.h>
 #include <mach/ohci.h>
@@ -618,6 +621,16 @@ static struct sys_device pxa3xx_sysdev[] = {
 	},
 };
 
+static int pmu_irqs[] = {
+	IRQ_PMU,
+};
+
+static struct pmu_irqs cpu_pmu_device = {
+	.device_type		= ARM_PMU_DEVICE_CPU,
+	.irqs			= pmu_irqs,
+	.num_irqs		= ARRAY_SIZE(pmu_irqs),
+};
+
 static int __init pxa3xx_init(void)
 {
 	int i, ret = 0;
@@ -648,6 +661,7 @@ static int __init pxa3xx_init(void)
 		}
 
 		ret = platform_add_devices(devices, ARRAY_SIZE(devices));
+		pmu_device_register(&cpu_pmu_device);
 	}
 
 	return ret;
-- 
1.6.3.3
