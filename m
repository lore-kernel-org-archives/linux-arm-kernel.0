From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 10 Nov 2011 12:54:08 +0800
Subject: [PATCH 3/9] ARM: mxc: pwm: convert to clk_prepare/clk_unprepare
In-Reply-To: <1320900854-13031-1-git-send-email-richard.zhao@linaro.org>
References: <1320900854-13031-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1320900854-13031-3-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/plat-mxc/pwm.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/pwm.c b/arch/arm/plat-mxc/pwm.c
index 42d74ea..3371698 100644
--- a/arch/arm/plat-mxc/pwm.c
+++ b/arch/arm/plat-mxc/pwm.c
@@ -118,9 +118,13 @@ int pwm_enable(struct pwm_device *pwm)
 	int rc = 0;
 
 	if (!pwm->clk_enabled) {
-		rc = clk_enable(pwm->clk);
+		rc = clk_prepare(pwm->clk);
 		if (!rc)
+			rc = clk_enable(pwm->clk);
+		if (!rc) {
 			pwm->clk_enabled = 1;
+		} else
+			clk_unprepare(pwm->clk);
 	}
 	return rc;
 }
@@ -132,6 +136,7 @@ void pwm_disable(struct pwm_device *pwm)
 
 	if (pwm->clk_enabled) {
 		clk_disable(pwm->clk);
+		clk_unprepare(pwm->clk);
 		pwm->clk_enabled = 0;
 	}
 }
-- 
1.7.5.4
