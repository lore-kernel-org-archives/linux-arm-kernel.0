From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 23 Oct 2013 16:35:08 +0800
Subject: [PATCH 2/3] usb: chipidea: add freescale imx28 special write register
 method
In-Reply-To: <1382517309-6730-1-git-send-email-peter.chen@freescale.com>
References: <1382517309-6730-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1382517309-6730-2-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to Freescale imx28 Errata, "ENGR119653 USB: ARM to USB
register error issue", All USB register write operations must
use the ARM SWP instruction. So, we implement special hw_write
and hw_test_and_clear for imx28.

Discussion for it at below:
http://marc.info/?l=linux-usb&m=137996395529294&w=2

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/ci.h    |   23 +++++++++++++++++++++++
 drivers/usb/chipidea/core.c  |    2 ++
 drivers/usb/chipidea/host.c  |    1 +
 include/linux/usb/chipidea.h |    1 +
 4 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
index 38598b3..4714e31 100644
--- a/drivers/usb/chipidea/ci.h
+++ b/drivers/usb/chipidea/ci.h
@@ -176,6 +176,8 @@ struct ci_hdrc {
 	bool				supports_runtime_pm;
 	bool				in_lpm;
 	bool				wakeup_int;
+	/* imx28 needs swp instruction for writing */
+	bool				imx28_write_fix;
 };
 
 static inline struct ci_role_driver *ci_role(struct ci_hdrc *ci)
@@ -256,6 +258,13 @@ static inline u32 hw_read(struct ci_hdrc *ci, enum ci_hw_regs reg, u32 mask)
 	return ioread32(ci->hw_bank.regmap[reg]) & mask;
 }
 
+#ifdef CONFIG_SOC_IMX28
+static inline void imx28_ci_writel(u32 val32, volatile u32 *addr)
+{
+	__asm__ ("swp %0, %0, [%1]" : : "r"(val32), "r"(addr));
+}
+#endif
+
 /**
  * hw_write: writes to a hw register
  * @reg:  register index
@@ -269,7 +278,14 @@ static inline void hw_write(struct ci_hdrc *ci, enum ci_hw_regs reg,
 		data = (ioread32(ci->hw_bank.regmap[reg]) & ~mask)
 			| (data & mask);
 
+#ifdef CONFIG_SOC_IMX28
+	if (ci->imx28_write_fix)
+		imx28_ci_writel(data, ci->hw_bank.regmap[reg]);
+	else
+		iowrite32(data, ci->hw_bank.regmap[reg]);
+#else
 	iowrite32(data, ci->hw_bank.regmap[reg]);
+#endif
 }
 
 /**
@@ -284,7 +300,14 @@ static inline u32 hw_test_and_clear(struct ci_hdrc *ci, enum ci_hw_regs reg,
 {
 	u32 val = ioread32(ci->hw_bank.regmap[reg]) & mask;
 
+#ifdef CONFIG_SOC_IMX28
+	if (ci->imx28_write_fix)
+		imx28_ci_writel(val, ci->hw_bank.regmap[reg]);
+	else
+		iowrite32(val, ci->hw_bank.regmap[reg]);
+#else
 	iowrite32(val, ci->hw_bank.regmap[reg]);
+#endif
 	return val;
 }
 
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index a9497eb..b89c154 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -565,6 +565,8 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 
 	ci->dev = dev;
 	ci->platdata = dev->platform_data;
+	ci->imx28_write_fix = !!(ci->platdata->flags &
+		CI_HDRC_IMX28_WRITE_FIX);
 
 	ret = hw_device_init(ci, base);
 	if (ret < 0) {
diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
index c1d05c4..66866cd 100644
--- a/drivers/usb/chipidea/host.c
+++ b/drivers/usb/chipidea/host.c
@@ -235,6 +235,7 @@ static int host_start(struct ci_hdrc *ci)
 	ehci->caps = ci->hw_bank.cap;
 	ehci->has_hostpc = ci->hw_bank.lpm;
 	ehci->has_tdi_phy_lpm = ci->hw_bank.lpm;
+	ehci->imx28_write_fix = ci->imx28_write_fix;
 
 	if (ci->platdata->reg_vbus) {
 		ret = regulator_enable(ci->platdata->reg_vbus);
diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
index 8ce3daf..e66fb19 100644
--- a/include/linux/usb/chipidea.h
+++ b/include/linux/usb/chipidea.h
@@ -26,6 +26,7 @@ struct ci_hdrc_platform_data {
 	 */
 #define CI_HDRC_DUAL_ROLE_NOT_OTG	BIT(4)
 #define CI_HDRC_IMX_EHCI_QUIRK		BIT(5)
+#define CI_HDRC_IMX28_WRITE_FIX		BIT(6)
 	enum usb_dr_mode	dr_mode;
 #define CI_HDRC_CONTROLLER_RESET_EVENT		0
 #define CI_HDRC_CONTROLLER_STOPPED_EVENT	1
-- 
1.7.1
