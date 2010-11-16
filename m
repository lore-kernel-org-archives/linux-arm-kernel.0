From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Tue, 16 Nov 2010 10:36:35 -0800 (PST)
Subject: [PATCH 3/5] mx51: Add mx51 processor to the pwm driver
Message-ID: <766471.7361.qm@web51008.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/plat-mxc/pwm.c |? ? 8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-mxc/pwm.c b/arch/arm/plat-mxc/pwm.c
index c36f263..c6cdced 100644
--- a/arch/arm/plat-mxc/pwm.c
+++ b/arch/arm/plat-mxc/pwm.c
@@ -26,7 +26,7 @@
 #define MX1_PWMP? ? 0x08???/* PWM Period Register */
 
 
-/* i.MX27, i.MX31, i.MX35 share the same PWM function block: */
+/* i.MX25/27/31/35/51 share the same PWM function block: */
 
 #define MX3_PWMCR? ? ? ? ? ? ? ???0x00? ? /* PWM Control Register */
 #define MX3_PWMSAR? ? ? ? ? ? ? ? 0x0C? ? /* PWM Sample Register */
@@ -57,7 +57,7 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
 ??? if (pwm == NULL || period_ns == 0 || duty_ns > period_ns)
 ??? ??? return -EINVAL;
 
-??? if (cpu_is_mx27() || cpu_is_mx3() || cpu_is_mx25()) {
+??? if (cpu_is_mx27() || cpu_is_mx3() || cpu_is_mx25() || cpu_is_mx51()) {
 ??? ??? unsigned long long c;
 ??? ??? unsigned long period_cycles, duty_cycles, prescale;
 ??? ??? u32 cr;
@@ -79,7 +79,7 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
 
 ??? ??? cr = MX3_PWMCR_PRESCALER(prescale) | MX3_PWMCR_EN;
 
-??? ??? if (cpu_is_mx25())
+??? ??? if (cpu_is_mx25() || cpu_is_mx51())
 ??? ??? ??? cr |= MX3_PWMCR_CLKSRC_IPG;
 ??? ??? else
 ??? ??? ??? cr |= MX3_PWMCR_CLKSRC_IPG_HIGH;
@@ -198,6 +198,7 @@ static int __devinit mxc_pwm_probe(struct platform_device *pdev)
 
 ??? if (IS_ERR(pwm->clk)) {
 ??? ??? ret = PTR_ERR(pwm->clk);
+??? ??? dev_err(&pdev->dev, "can't get PWM clock\n");
 ??? ??? goto err_free;
 ??? }
 
@@ -233,6 +234,7 @@ static int __devinit mxc_pwm_probe(struct platform_device *pdev)
 ??? mutex_unlock(&pwm_lock);
 
 ??? platform_set_drvdata(pdev, pwm);
+??? dev_info(&pdev->dev, "i.MX PWM Driver Enabled\n");
 ??? return 0;
 
 err_free_mem:
-- 
1.6.0.4






      
