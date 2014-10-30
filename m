From: amit.daniel@samsung.com (Amit Daniel Kachhap)
Date: Thu, 30 Oct 2014 09:25:36 +0530
Subject: [PATCH 1/3] arm64: psci: warn if psci_power_state variable is not
 initialised
Message-ID: <1414641338-25279-1-git-send-email-amit.daniel@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this cpu_suspend may cause crash dump when psci cpuidle
is not initialised and cpu_suspend is called.

Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 arch/arm64/kernel/psci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 866c1c8..2178d6e 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -523,9 +523,11 @@ static int __maybe_unused cpu_psci_cpu_suspend(unsigned long index)
 	struct psci_power_state *state = __get_cpu_var(psci_power_state);
 	/*
 	 * idle state index 0 corresponds to wfi, should never be called
-	 * from the cpu_suspend operations
+	 * from the cpu_suspend operations.
+	 * Also psci_power_state variable should have been populated by
+	 * above init idle routine.
 	 */
-	if (WARN_ON_ONCE(!index))
+	if (WARN_ON_ONCE(!index || !state))
 		return -EINVAL;
 
 	if (state->type == PSCI_POWER_STATE_TYPE_STANDBY)
-- 
1.9.1
