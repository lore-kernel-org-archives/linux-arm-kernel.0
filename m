From: mporter@linaro.org (Matt Porter)
Date: Fri, 13 Dec 2013 11:51:19 -0500
Subject: [PATCH v6 5/9] usb: gadget: s3c-hsotg: use generic
 phy_init()/phy_exit() support
In-Reply-To: <1386953483-21631-1-git-send-email-mporter@linaro.org>
References: <1386953483-21631-1-git-send-email-mporter@linaro.org>
Message-ID: <1386953483-21631-6-git-send-email-mporter@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a generic phy is present, call phy_init()/phy_exit(). This supports
generic phys that must be soft reset before power on.

Signed-off-by: Matt Porter <mporter@linaro.org>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/usb/gadget/s3c-hsotg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/gadget/s3c-hsotg.c b/drivers/usb/gadget/s3c-hsotg.c
index 7c5d8bd..e9683c2 100644
--- a/drivers/usb/gadget/s3c-hsotg.c
+++ b/drivers/usb/gadget/s3c-hsotg.c
@@ -3621,6 +3621,9 @@ static int s3c_hsotg_probe(struct platform_device *pdev)
 		goto err_supplies;
 	}
 
+	if (hsotg->phy)
+		phy_init(hsotg->phy);
+
 	/* usb phy enable */
 	s3c_hsotg_phy_enable(hsotg);
 
@@ -3714,6 +3717,8 @@ static int s3c_hsotg_remove(struct platform_device *pdev)
 	}
 
 	s3c_hsotg_phy_disable(hsotg);
+	if (hsotg->phy)
+		phy_exit(hsotg->phy);
 	clk_disable_unprepare(hsotg->clk);
 
 	return 0;
-- 
1.8.4
