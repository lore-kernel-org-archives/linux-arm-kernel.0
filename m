From: yong.shen@linaro.org (yong.shen at linaro.org)
Date: Tue,  8 Feb 2011 16:14:44 +0100
Subject: [PATCH 2/2] ARM: iMX5 BBG: add cpuidle driver parameters
In-Reply-To: <1297178084-28363-1-git-send-email-yong.shen@linaro.org>
References: <1297178084-28363-1-git-send-email-yong.shen@linaro.org>
Message-ID: <1297178084-28363-3-git-send-email-yong.shen@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yong Shen <yong.shen@freescale.com>

Add cpuidle parameters to make cpuidle driver workable, but these
parameters need further tuning

Signed-off-by: Yong Shen <yong.shen@freescale.com>
---
 arch/arm/mach-mx5/board-mx51_babbage.c |  114 ++++++++++++++++++++++++++++++++
 arch/arm/mach-mx5/devices.c            |    4 +
 arch/arm/mach-mx5/devices.h            |    1 +
 3 files changed, 119 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index d9d402e..3c661e9 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -22,11 +22,13 @@
 #include <linux/input.h>
 #include <linux/spi/flash.h>
 #include <linux/spi/spi.h>
+#include <linux/cpuidle.h>
 
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/iomux-mx51.h>
 #include <mach/mxc_ehci.h>
+#include <mach/cpuidle.h>
 
 #include <asm/irq.h>
 #include <asm/setup.h>
@@ -37,6 +39,7 @@
 #include "devices-imx51.h"
 #include "devices.h"
 #include "cpu_op-mx51.h"
+#include "crm_regs.h"
 
 #define BABBAGE_USB_HUB_RESET	IMX_GPIO_NR(1, 7)
 #define BABBAGE_USBH1_STP	IMX_GPIO_NR(1, 27)
@@ -333,6 +336,117 @@ static const struct spi_imx_master mx51_babbage_spi_pdata __initconst = {
 	.num_chipselect = ARRAY_SIZE(mx51_babbage_spi_cs),
 };
 
+extern int tzic_enable_wake(int is_idle);
+static int imx51_enter_idle(struct cpuidle_device *dev,
+			       struct cpuidle_state *state)
+{
+	struct timeval before, after;
+	int idle_time;
+	u32 plat_lpc, arm_srpgcr, ccm_clpcr;
+	u32 empgc0, empgc1;
+	int stop_mode = 0;
+
+	local_irq_disable();
+	do_gettimeofday(&before);
+
+	plat_lpc = __raw_readl(MXC_CORTEXA8_PLAT_LPC) &
+	    ~(MXC_CORTEXA8_PLAT_LPC_DSM);
+	ccm_clpcr = __raw_readl(MXC_CCM_CLPCR) & ~(MXC_CCM_CLPCR_LPM_MASK);
+	arm_srpgcr = __raw_readl(MXC_SRPG_ARM_SRPGCR) & ~(MXC_SRPGCR_PCR);
+	empgc0 = __raw_readl(MXC_SRPG_EMPGC0_SRPGCR) & ~(MXC_SRPGCR_PCR);
+	empgc1 = __raw_readl(MXC_SRPG_EMPGC1_SRPGCR) & ~(MXC_SRPGCR_PCR);
+
+	if (state == &dev->states[0]) {
+		/* Wait clocked */
+		;
+	} else if (state == &dev->states[1]) {
+		/* Wait unclocked */
+		ccm_clpcr |= (0x1 << MXC_CCM_CLPCR_LPM_OFFSET);
+	} else {
+		plat_lpc |= MXC_CORTEXA8_PLAT_LPC_DSM
+			    | MXC_CORTEXA8_PLAT_LPC_DBG_DSM;
+		arm_srpgcr |= MXC_SRPGCR_PCR;
+		if (state == &dev->states[2]) {
+			/* Wait unclocked, power off */
+			ccm_clpcr |= (0x1 << MXC_CCM_CLPCR_LPM_OFFSET);
+			ccm_clpcr &= ~MXC_CCM_CLPCR_VSTBY;
+			ccm_clpcr &= ~MXC_CCM_CLPCR_SBYOS;
+			stop_mode = 0;
+		} else if (state == &dev->states[3]) {
+			/* Stop power off */
+			ccm_clpcr |= (0x2 << MXC_CCM_CLPCR_LPM_OFFSET);
+			ccm_clpcr |= (0x3 << MXC_CCM_CLPCR_STBY_COUNT_OFFSET);
+			ccm_clpcr |= MXC_CCM_CLPCR_VSTBY;
+			ccm_clpcr |= MXC_CCM_CLPCR_SBYOS;
+			empgc0 |= MXC_SRPGCR_PCR;
+			empgc1 |= MXC_SRPGCR_PCR;
+			stop_mode = 1;
+		}
+		if (tzic_enable_wake(1) != 0) {
+			local_irq_enable();
+			return 0;
+		}
+	}
+
+	__raw_writel(plat_lpc, MXC_CORTEXA8_PLAT_LPC);
+	__raw_writel(ccm_clpcr, MXC_CCM_CLPCR);
+	__raw_writel(arm_srpgcr, MXC_SRPG_ARM_SRPGCR);
+
+	if (stop_mode) {
+		__raw_writel(empgc0, MXC_SRPG_EMPGC0_SRPGCR);
+		__raw_writel(empgc1, MXC_SRPG_EMPGC1_SRPGCR);
+	}
+
+	cpu_do_idle();
+
+	do_gettimeofday(&after);
+	local_irq_enable();
+	idle_time = (after.tv_sec - before.tv_sec) * USEC_PER_SEC +
+			(after.tv_usec - before.tv_usec);
+	return idle_time;
+}
+
+static struct cpuidle_state babbage_cpuidle_state[] = {
+	{
+		.enter			= imx51_enter_idle,
+		.exit_latency		= 1,
+		.flags			= CPUIDLE_FLAG_TIME_VALID,
+		.name			= "WFI",
+		.desc			= "Wait with clock on",
+	},
+	{
+		.enter			= imx51_enter_idle,
+		.exit_latency		= 100,
+		.flags			= CPUIDLE_FLAG_TIME_VALID,
+		.name			= "WFI",
+		.desc			= "Wait with clock off",
+	},
+	{
+		.enter			= imx51_enter_idle,
+		.exit_latency		= 10000,
+		.flags			= CPUIDLE_FLAG_TIME_VALID,
+		.name			= "WFI",
+		.desc			= "Wait with clock off/power gating",
+	},
+	{
+		.enter			= imx51_enter_idle,
+		.exit_latency		= 1000000,
+		.flags			= CPUIDLE_FLAG_TIME_VALID,
+		.name			= "SR",
+		.desc			= "state retention",
+	},
+};
+
+static struct imx_cpuidle_state babbage_cpuidle_data = {
+	.state_number = ARRAY_SIZE(babbage_cpuidle_state),
+	.state = babbage_cpuidle_state,
+};
+
+static int imx51_init_cpuidle(void)
+{
+	return mxc_register_device(&mxc_cpuidle_device, &babbage_cpuidle_data);
+}
+device_initcall(imx51_init_cpuidle);
 /*
  * Board specific initialization.
  */
diff --git a/arch/arm/mach-mx5/devices.c b/arch/arm/mach-mx5/devices.c
index 153ada5..8daf5f6 100644
--- a/arch/arm/mach-mx5/devices.c
+++ b/arch/arm/mach-mx5/devices.c
@@ -37,6 +37,10 @@ struct platform_device mxc_hsi2c_device = {
 	.resource = mxc_hsi2c_resources
 };
 
+struct platform_device mxc_cpuidle_device = {
+	.name = "imx_cpuidle",
+};
+
 static u64 usb_dma_mask = DMA_BIT_MASK(32);
 
 static struct resource usbotg_resources[] = {
diff --git a/arch/arm/mach-mx5/devices.h b/arch/arm/mach-mx5/devices.h
index 55a5129..49e441c 100644
--- a/arch/arm/mach-mx5/devices.h
+++ b/arch/arm/mach-mx5/devices.h
@@ -3,3 +3,4 @@ extern struct platform_device mxc_usbh1_device;
 extern struct platform_device mxc_usbh2_device;
 extern struct platform_device mxc_usbdr_udc_device;
 extern struct platform_device mxc_hsi2c_device;
+extern struct platform_device mxc_cpuidle_device;
-- 
1.7.1
