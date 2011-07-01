From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri,  1 Jul 2011 10:57:33 +0900
Subject: [PATCH V2 4/8] ARM: SAMSUNG: Add support for failure of sleep mode
In-Reply-To: <1309485457-13305-1-git-send-email-kgene.kim@samsung.com>
References: <1309485457-13305-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1309485457-13305-5-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jaecheol Lee <jc.lee@samsung.com>

Signed-off-by: Jaecheol Lee <jc.lee@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/plat-samsung/pm.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-samsung/pm.c b/arch/arm/plat-samsung/pm.c
index 69d6b04..df12645 100644
--- a/arch/arm/plat-samsung/pm.c
+++ b/arch/arm/plat-samsung/pm.c
@@ -299,7 +299,10 @@ static int s3c_pm_enter(suspend_state_t state)
 	 * we resume as it saves its own register state and restores it
 	 * during the resume.  */
 
-	cpu_suspend(0, pm_cpu_sleep);
+	/* If entering sleep mode is failed, non-zero value is returned */
+
+	if (cpu_suspend(0, pm_cpu_sleep));
+		goto exit;
 
 	/* restore the system state */
 
@@ -323,6 +326,8 @@ static int s3c_pm_enter(suspend_state_t state)
 	/* ok, let's return from sleep */
 
 	S3C_PMDBG("S3C PM Resume (post-restore)\n");
+
+exit:
 	return 0;
 }
 
-- 
1.7.1
