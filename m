From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 19 Mar 2010 14:48:16 +0900
Subject: [PATCH 3/3] ARM: S5PV210: Bug fix on PWM Timer
Message-ID: <1268977696-26286-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jongpill Lee <boyko.lee@samsung.com>

This patch fixes below bugs:
- Return value in the pwm_cfg_src_is_tclk
- Return value in the tcfg_to_divisor
- Return value in the pwm_tdiv_has_div1
- Return value in the pwm_tdiv_div_bits

Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/include/mach/pwm-clock.h |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-s5pv210/include/mach/pwm-clock.h b/arch/arm/mach-s5pv210/include/mach/pwm-clock.h
index 69027fe..c22c8fa 100644
--- a/arch/arm/mach-s5pv210/include/mach/pwm-clock.h
+++ b/arch/arm/mach-s5pv210/include/mach/pwm-clock.h
@@ -21,14 +21,14 @@
 
 /**
  * pwm_cfg_src_is_tclk() - return whether the given mux config is a tclk
- * @cfg: The timer TCFG1 register bits shifted down to 0.
+ * @tcfg: The timer TCFG1 register bits shifted down to 0.
  *
  * Return true if the given configuration from TCFG1 is a TCLK instead
  * any of the TDIV clocks.
  */
 static inline int pwm_cfg_src_is_tclk(unsigned long tcfg)
 {
-	return tcfg == S3C2410_TCFG1_MUX_TCLK;
+	return tcfg == S3C64XX_TCFG1_MUX_TCLK;
 }
 
 /**
@@ -40,7 +40,7 @@ static inline int pwm_cfg_src_is_tclk(unsigned long tcfg)
  */
 static inline unsigned long tcfg_to_divisor(unsigned long tcfg1)
 {
-	return 1 << (1 + tcfg1);
+	return 1 << tcfg1;
 }
 
 /**
@@ -50,7 +50,7 @@ static inline unsigned long tcfg_to_divisor(unsigned long tcfg1)
  */
 static inline unsigned int pwm_tdiv_has_div1(void)
 {
-	return 0;
+	return 1;
 }
 
 /**
@@ -61,7 +61,7 @@ static inline unsigned int pwm_tdiv_has_div1(void)
  */
 static inline unsigned long pwm_tdiv_div_bits(unsigned int div)
 {
-	return ilog2(div) - 1;
+	return ilog2(div);
 }
 
 #define S3C_TCFG1_MUX_TCLK S3C2410_TCFG1_MUX_TCLK
-- 
1.6.2.5
