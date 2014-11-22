From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sat, 22 Nov 2014 15:56:47 +0100
Subject: [PATCH] usb: dwc3: return error code from the most recent call
Message-ID: <1416668207-10770-1-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Copy-paste error from the previous block of error handling code.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
expression e,e1;
@@

if (IS_ERR(e)) {
  ...
(
  ret = PTR_ERR(e);
|
*  ret = PTR_ERR(e1);
)
  ...
  return ret;
}
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/usb/dwc3/dwc3-st.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-st.c b/drivers/usb/dwc3/dwc3-st.c
index c7602b5..4a1a543 100644
--- a/drivers/usb/dwc3/dwc3-st.c
+++ b/drivers/usb/dwc3/dwc3-st.c
@@ -243,7 +243,7 @@ static int st_dwc3_probe(struct platform_device *pdev)
 	dwc3_data->rstc_rst = devm_reset_control_get(dev, "softreset");
 	if (IS_ERR(dwc3_data->rstc_rst)) {
 		dev_err(&pdev->dev, "could not get reset controller\n");
-		ret = PTR_ERR(dwc3_data->rstc_pwrdn);
+		ret = PTR_ERR(dwc3_data->rstc_rst);
 		goto undo_powerdown;
 	}
 
