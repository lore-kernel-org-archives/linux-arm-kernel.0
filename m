From: kishore.p@techveda.org (kishore.p at techveda.org)
Date: Sun, 24 Dec 2017 19:33:54 +0530
Subject: [PATCH v2] staging: vc04_services: Prefer WARN_ON_ONCE instead of if
 condition followed by BUG.
In-Reply-To: <397155882.297531.1514045090990@email.1und1.de>
References: <397155882.297531.1514045090990@email.1und1.de>
Message-ID: <1514124234-11205-1-git-send-email-kishore.p@techveda.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kishore KP <kishore.p@techveda.org>

Coccinelle suggested to use BUG_ON instead of if condition followed by BUG
but BUG_ON should be used in situations where integrity of the system is no
longer guaranteed. In this case, as suggested by Stefan Wahren, vchiq isn't
critical.
Since it is not critical, BUG_ON should be avoided.
Replaced if condition followed by BUG with WARN_ON_ONCE.

Signed-off-by: Kishore KP <kishore.p@techveda.org>
Signed-off-by: Suniel Mahesh <sunil.m@techveda.org>
---
Changes for v2:
- Subject and Description modified a bit based on the suggestion
  by Stefan Wahren.
---
Note:
- Patch was compile tested and built(ARCH=arm) on linux-next
  (latest).
- No build issues reported.
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
index 315b49c..f20cf88 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
@@ -224,8 +224,7 @@ int vchiq_platform_init(struct platform_device *pdev, VCHIQ_STATE_T *state)
 
 	platform_state   = (struct vchiq_2835_state *)state->platform_state;
 
-	if (!platform_state->inited)
-		BUG();
+	WARN_ON_ONCE(!platform_state->inited);
 
 	return &platform_state->arm_state;
 }
-- 
1.9.1
