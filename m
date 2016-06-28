From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 28 Jun 2016 10:27:40 +0100
Subject: [PATCH 1/1] usb: dwc3: st: Inform the reset framework that our reset
 line may be shared
In-Reply-To: <20160606155655.10860-8-lee.jones@linaro.org>
References: <20160606155655.10860-1-lee.jones@linaro.org>
 <20160606155655.10860-8-lee.jones@linaro.org>
Message-ID: <20160628092740.GP6720@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the STiH410 B2120 development board the MiPHY28lp shares its reset
line with the Synopsys DWC3 SuperSpeed (SS) USB 3.0 Dual-Role-Device
(DRD).  New functionality in the reset subsystems forces consumers to
be explicit when requesting shared/exclusive reset lines.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
Felipe,

I'd like to send this patch (amonst others) to the -rcs today if possible.

Would you be kind enough to Ack it, so I can do so please?

drivers/usb/dwc3/dwc3-st.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-st.c b/drivers/usb/dwc3/dwc3-st.c
index 5c0adb9..b204617 100644
--- a/drivers/usb/dwc3/dwc3-st.c
+++ b/drivers/usb/dwc3/dwc3-st.c
@@ -237,7 +237,8 @@ static int st_dwc3_probe(struct platform_device *pdev)
 	/* Manage PowerDown */
 	reset_control_deassert(dwc3_data->rstc_pwrdn);
 
-	dwc3_data->rstc_rst = devm_reset_control_get(dev, "softreset");
+	dwc3_data->rstc_rst =
+		devm_reset_control_get_shared(dev, "softreset");
 	if (IS_ERR(dwc3_data->rstc_rst)) {
 		dev_err(&pdev->dev, "could not get reset controller\n");
 		ret = PTR_ERR(dwc3_data->rstc_rst);
-- 
2.9.0
