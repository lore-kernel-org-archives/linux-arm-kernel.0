From: amit.daniel@samsung.com (Amit Daniel Kachhap)
Date: Thu, 30 Oct 2014 17:54:51 +0530
Subject: [PATCH v2] arm64: psci: fix cpu_suspend to check idle state type for
 index
Message-ID: <1414671891-29448-1-git-send-email-amit.daniel@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fix rectifies the psci cpu_suspend implementation to check the
PSCI power state parameter type field associated with the requested idle
state index.

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 arch/arm64/kernel/psci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 866c1c8..663da77 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -528,7 +528,7 @@ static int __maybe_unused cpu_psci_cpu_suspend(unsigned long index)
 	if (WARN_ON_ONCE(!index))
 		return -EINVAL;
 
-	if (state->type == PSCI_POWER_STATE_TYPE_STANDBY)
+	if (state[index - 1].type == PSCI_POWER_STATE_TYPE_STANDBY)
 		ret = psci_ops.cpu_suspend(state[index - 1], 0);
 	else
 		ret = __cpu_suspend(index, psci_suspend_finisher);
-- 
1.9.1
