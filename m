From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 29 Jan 2013 02:51:03 -0500
Subject: [PATCH v3 08/15] ARM: introduce common set_auxcr/get_auxcr functions
In-Reply-To: <1359445870-18925-1-git-send-email-nicolas.pitre@linaro.org>
References: <1359445870-18925-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1359445870-18925-9-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Move the private set_auxcr/get_auxcr functions from
drivers/cpuidle/cpuidle-calxeda.c so they can be used across platforms.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/include/asm/cp15.h       | 14 ++++++++++++++
 drivers/cpuidle/cpuidle-calxeda.c | 14 --------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/include/asm/cp15.h b/arch/arm/include/asm/cp15.h
index 5ef4d8015a..ce4d01c03e 100644
--- a/arch/arm/include/asm/cp15.h
+++ b/arch/arm/include/asm/cp15.h
@@ -59,6 +59,20 @@ static inline void set_cr(unsigned int val)
 	isb();
 }
 
+static inline unsigned int get_auxcr(void)
+{
+	unsigned int val;
+	asm("mrc p15, 0, %0, c1, c0, 1	@ get AUXCR" : "=r" (val));
+	return val;
+}
+
+static inline void set_auxcr(unsigned int val)
+{
+	asm volatile("mcr p15, 0, %0, c1, c0, 1	@ set AUXCR"
+	  : : "r" (val));
+	isb();
+}
+
 #ifndef CONFIG_SMP
 extern void adjust_cr(unsigned long mask, unsigned long set);
 #endif
diff --git a/drivers/cpuidle/cpuidle-calxeda.c b/drivers/cpuidle/cpuidle-calxeda.c
index e1aab38c5a..ece83d6e04 100644
--- a/drivers/cpuidle/cpuidle-calxeda.c
+++ b/drivers/cpuidle/cpuidle-calxeda.c
@@ -37,20 +37,6 @@ extern void *scu_base_addr;
 
 static struct cpuidle_device __percpu *calxeda_idle_cpuidle_devices;
 
-static inline unsigned int get_auxcr(void)
-{
-	unsigned int val;
-	asm("mrc p15, 0, %0, c1, c0, 1	@ get AUXCR" : "=r" (val) : : "cc");
-	return val;
-}
-
-static inline void set_auxcr(unsigned int val)
-{
-	asm volatile("mcr p15, 0, %0, c1, c0, 1	@ set AUXCR"
-	  : : "r" (val) : "cc");
-	isb();
-}
-
 static noinline void calxeda_idle_restore(void)
 {
 	set_cr(get_cr() | CR_C);
-- 
1.8.1.2
