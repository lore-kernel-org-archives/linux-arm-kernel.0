From: jason.chen@linaro.org (Jason Chen)
Date: Wed, 30 Nov 2011 11:34:27 +0800
Subject: [PATCH] MXC PWM: should active during DOZE/WAIT/DBG mode
Message-ID: <1322624067-3591-1-git-send-email-jason.chen@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jason Chen <jason.chen@linaro.org>
---
 arch/arm/plat-mxc/pwm.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/pwm.c b/arch/arm/plat-mxc/pwm.c
index 5dda436..9ba9c2c 100644
--- a/arch/arm/plat-mxc/pwm.c
+++ b/arch/arm/plat-mxc/pwm.c
@@ -32,6 +32,9 @@
 #define MX3_PWMSAR                0x0C    /* PWM Sample Register */
 #define MX3_PWMPR                 0x10    /* PWM Period Register */
 #define MX3_PWMCR_PRESCALER(x)    (((x - 1) & 0xFFF) << 4)
+#define MX3_PWMCR_DOZEEN                (1 << 24)
+#define MX3_PWMCR_WAITEN                (1 << 23)
+#define MX3_PWMCR_DBGEN			(1 << 22)
 #define MX3_PWMCR_CLKSRC_IPG_HIGH (2 << 16)
 #define MX3_PWMCR_CLKSRC_IPG      (1 << 16)
 #define MX3_PWMCR_EN              (1 << 0)
@@ -78,7 +81,9 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
 		writel(duty_cycles, pwm->mmio_base + MX3_PWMSAR);
 		writel(period_cycles, pwm->mmio_base + MX3_PWMPR);
 
-		cr = MX3_PWMCR_PRESCALER(prescale) | MX3_PWMCR_EN;
+		cr = MX3_PWMCR_PRESCALER(prescale) |
+			MX3_PWMCR_DOZEEN | MX3_PWMCR_WAITEN |
+			MX3_PWMCR_DBGEN | MX3_PWMCR_EN;
 
 		if (cpu_is_mx25())
 			cr |= MX3_PWMCR_CLKSRC_IPG;
-- 
1.7.4.1
