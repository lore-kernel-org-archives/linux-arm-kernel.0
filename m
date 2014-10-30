From: amit.daniel@samsung.com (Amit Daniel Kachhap)
Date: Thu, 30 Oct 2014 09:25:38 +0530
Subject: [PATCH 3/3] arm64: psci: Add support to call cpu_suspend with deepest
 C state.
In-Reply-To: <1414641338-25279-1-git-send-email-amit.daniel@samsung.com>
References: <1414641338-25279-1-git-send-email-amit.daniel@samsung.com>
Message-ID: <1414641338-25279-3-git-send-email-amit.daniel@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This feature will be useful for system suspend/resume which may
intend to invoke cpu_suspend with deepest possible C state level.

Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 arch/arm64/include/asm/psci.h | 2 ++
 arch/arm64/kernel/psci.c      | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm64/include/asm/psci.h b/arch/arm64/include/asm/psci.h
index e5312ea..487e52b 100644
--- a/arch/arm64/include/asm/psci.h
+++ b/arch/arm64/include/asm/psci.h
@@ -14,6 +14,8 @@
 #ifndef __ASM_PSCI_H
 #define __ASM_PSCI_H
 
+#define CPU_PSCI_IDLE_INDEX_MAX		0xff
+
 int psci_init(void);
 
 #endif /* __ASM_PSCI_H */
diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 4ebc146..a761513 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -70,6 +70,7 @@ enum psci_function {
 static DEFINE_PER_CPU_READ_MOSTLY(struct psci_power_state *, psci_power_state);
 
 static u32 psci_function_id[PSCI_FN_MAX];
+static u32 cpu_psci_idle_state_count;
 
 static int psci_to_linux_errno(int errno)
 {
@@ -239,6 +240,8 @@ static int __maybe_unused cpu_psci_cpu_init_idle(struct device_node *cpu_node,
 	if (!count)
 		return -ENODEV;
 
+	cpu_psci_idle_state_count = count;
+
 	psci_states = kcalloc(count, sizeof(*psci_states), GFP_KERNEL);
 	if (!psci_states)
 		return -ENOMEM;
@@ -521,6 +524,11 @@ static int __maybe_unused cpu_psci_cpu_suspend(unsigned long index)
 {
 	int ret;
 	struct psci_power_state *state = __get_cpu_var(psci_power_state);
+
+	/* Check and select the deepest idle state */
+	if (index == CPU_PSCI_IDLE_INDEX_MAX)
+		index = cpu_psci_idle_state_count;
+
 	/*
 	 * idle state index 0 corresponds to wfi, should never be called
 	 * from the cpu_suspend operations.
-- 
1.9.1
