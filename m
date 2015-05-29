From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 29 May 2015 13:16:36 +0100
Subject: [PATCH 3/6] drivers: firmware: psci: move power_state handling to
 generic code
In-Reply-To: <1432901799-18359-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1432901799-18359-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1432901799-18359-4-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Functions implemented on arm64 to check if a power_state parameter
is valid and if the power_state implies context loss are not
arm64 specific and should be moved to generic code so that they
can be reused on arm systems too.

This patch moves the functions handling the power_state parameter
to generic PSCI firmware layer code.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/kernel/psci.c | 14 --------------
 drivers/firmware/psci.c  | 15 +++++++++++++++
 include/linux/psci.h     |  2 ++
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 8063891..a0fc99a 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -30,20 +30,6 @@
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
 
-static bool psci_power_state_loses_context(u32 state)
-{
-	return state & PSCI_0_2_POWER_STATE_TYPE_MASK;
-}
-
-static bool psci_power_state_is_valid(u32 state)
-{
-	const u32 valid_mask = PSCI_0_2_POWER_STATE_ID_MASK |
-			       PSCI_0_2_POWER_STATE_TYPE_MASK |
-			       PSCI_0_2_POWER_STATE_AFFL_MASK;
-
-	return !(state & ~valid_mask);
-}
-
 static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
 
 static int __maybe_unused cpu_psci_cpu_init_idle(unsigned int cpu)
diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index afb955f0..f1579a4 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -69,6 +69,21 @@ enum psci_function {
 
 static u32 psci_function_id[PSCI_FN_MAX];
 
+#define PSCI_0_2_POWER_STATE_MASK		\
+				(PSCI_0_2_POWER_STATE_ID_MASK | \
+				PSCI_0_2_POWER_STATE_TYPE_MASK | \
+				PSCI_0_2_POWER_STATE_AFFL_MASK)
+
+bool psci_power_state_loses_context(u32 state)
+{
+	return state & PSCI_0_2_POWER_STATE_TYPE_MASK;
+}
+
+bool psci_power_state_is_valid(u32 state)
+{
+	return !(state & ~PSCI_0_2_POWER_STATE_MASK);
+}
+
 static int psci_to_linux_errno(int errno)
 {
 	switch (errno) {
diff --git a/include/linux/psci.h b/include/linux/psci.h
index a682fcc..12c4865 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -21,6 +21,8 @@
 #define PSCI_POWER_STATE_TYPE_POWER_DOWN	1
 
 bool psci_tos_resident_on(int cpu);
+bool psci_power_state_loses_context(u32 state);
+bool psci_power_state_is_valid(u32 state);
 
 struct psci_operations {
 	int (*cpu_suspend)(u32 state, unsigned long entry_point);
-- 
2.2.1
