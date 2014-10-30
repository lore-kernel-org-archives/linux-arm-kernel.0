From: amit.daniel@samsung.com (Amit Daniel Kachhap)
Date: Thu, 30 Oct 2014 09:25:37 +0530
Subject: [PATCH 2/3] arm64: psci: fix cpu_suspend to check idle state type for
 index
In-Reply-To: <1414641338-25279-1-git-send-email-amit.daniel@samsung.com>
References: <1414641338-25279-1-git-send-email-amit.daniel@samsung.com>
Message-ID: <1414641338-25279-2-git-send-email-amit.daniel@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fix rectifies the psci cpu_suspend to check the C-state type
corresponding to the requested index.

Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 arch/arm64/kernel/psci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 2178d6e..4ebc146 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -530,7 +530,7 @@ static int __maybe_unused cpu_psci_cpu_suspend(unsigned long index)
 	if (WARN_ON_ONCE(!index || !state))
 		return -EINVAL;
 
-	if (state->type == PSCI_POWER_STATE_TYPE_STANDBY)
+	if (state[index - 1].type == PSCI_POWER_STATE_TYPE_STANDBY)
 		ret = psci_ops.cpu_suspend(state[index - 1], 0);
 	else
 		ret = __cpu_suspend(index, psci_suspend_finisher);
-- 
1.9.1
