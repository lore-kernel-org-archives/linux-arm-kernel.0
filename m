From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  6 Jun 2016 16:56:55 +0100
Subject: [PATCH 7/7] usb: dwc3: st: Inform the reset framework that our reset
 line may be shared
In-Reply-To: <20160606155655.10860-1-lee.jones@linaro.org>
References: <20160606155655.10860-1-lee.jones@linaro.org>
Message-ID: <20160606155655.10860-8-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the STiH410 B2120 development board the MiPHY28lp shares its reset
line with the Synopsys DWC3 SuperSpeed (SS) USB 3.0 Dual-Role-Device
(DRD).  New functionality in the reset subsystems forces consumers to
be explicit when requesting shared/exclusive reset lines.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/dwc3/dwc3-st.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-st.c b/drivers/usb/dwc3/dwc3-st.c
index 5c0adb9..e77bacb 100644
--- a/drivers/usb/dwc3/dwc3-st.c
+++ b/drivers/usb/dwc3/dwc3-st.c
@@ -227,7 +227,8 @@ static int st_dwc3_probe(struct platform_device *pdev)
 	dev_vdbg(&pdev->dev, "glue-logic addr 0x%p, syscfg-reg offset 0x%x\n",
 		 dwc3_data->glue_base, dwc3_data->syscfg_reg_off);
 
-	dwc3_data->rstc_pwrdn = devm_reset_control_get(dev, "powerdown");
+	dwc3_data->rstc_pwrdn =
+		devm_reset_control_get_exclusive(dev, "powerdown");
 	if (IS_ERR(dwc3_data->rstc_pwrdn)) {
 		dev_err(&pdev->dev, "could not get power controller\n");
 		ret = PTR_ERR(dwc3_data->rstc_pwrdn);
@@ -237,7 +238,8 @@ static int st_dwc3_probe(struct platform_device *pdev)
 	/* Manage PowerDown */
 	reset_control_deassert(dwc3_data->rstc_pwrdn);
 
-	dwc3_data->rstc_rst = devm_reset_control_get(dev, "softreset");
+	dwc3_data->rstc_rst =
+		devm_reset_control_get_shared(dev, "softreset");
 	if (IS_ERR(dwc3_data->rstc_rst)) {
 		dev_err(&pdev->dev, "could not get reset controller\n");
 		ret = PTR_ERR(dwc3_data->rstc_rst);
-- 
2.8.3
