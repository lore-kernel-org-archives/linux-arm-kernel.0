From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 12 Jul 2012 15:01:45 +0800
Subject: [PATCH 05/12] USB: chipidea: don't let probe fail if otg controller
 start one role failed
In-Reply-To: <1342076512-19207-1-git-send-email-richard.zhao@freescale.com>
References: <1342076512-19207-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1342076512-19207-6-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One role failed, but the other role will possiblly still work.
For example, when udc start failed, if plug in a host device,
it works.

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 drivers/usb/chipidea/core.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 19ef324..8fd390a 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -473,8 +473,11 @@ static int __devinit ci_hdrc_probe(struct platform_device *pdev)
 	ret = ci_role_start(ci, ci->role);
 	if (ret) {
 		dev_err(dev, "can't start %s role\n", ci_role(ci)->name);
-		ret = -ENODEV;
-		goto rm_wq;
+		ci->role = CI_ROLE_END;
+		if (!ci->is_otg) {
+			ret = -ENODEV;
+			goto rm_wq;
+		}
 	}
 
 	platform_set_drvdata(pdev, ci);
-- 
1.7.9.5
