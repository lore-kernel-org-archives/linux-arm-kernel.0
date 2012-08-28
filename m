From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 28 Aug 2012 15:03:08 +0800
Subject: [PATCH v2 02/11] USB: chipidea: delay 2ms before read ID status at
 probe time
In-Reply-To: <1346137397-32374-1-git-send-email-richard.zhao@freescale.com>
References: <1346137397-32374-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1346137397-32374-3-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ID pin needs 1ms debounce time, event at probe time. We delay 2ms
for safe.

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 drivers/usb/chipidea/core.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 1083585..3c3ed77 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -462,6 +462,8 @@ static int __devinit ci_hdrc_probe(struct platform_device *pdev)
 
 	if (ci->roles[CI_ROLE_HOST] && ci->roles[CI_ROLE_GADGET]) {
 		ci->is_otg = true;
+		/* ID pin needs 1ms debouce time, we delay 2ms for safe */
+		mdelay(2);
 		ci->role = ci_otg_role(ci);
 	} else {
 		ci->role = ci->roles[CI_ROLE_HOST]
-- 
1.7.9.5
