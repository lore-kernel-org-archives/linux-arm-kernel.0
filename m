From: alex.shi@linaro.org (Alex Shi)
Date: Thu,  1 Mar 2018 20:53:58 +0800
Subject: [PATCH 21/45] arm64: cpufeature: Pass capability structure to
 ->enable callback
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
Message-ID: <1519908862-11425-22-git-send-email-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

commit 0a0d111d40fd upstream.

In order to invoke the CPU capability ->matches callback from the ->enable
callback for applying local-CPU workarounds, we need a handle on the
capability structure.

This patch passes a pointer to the capability structure to the ->enable
callback.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/kernel/cpufeature.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index fcb67e0..5c41ef6 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -949,7 +949,7 @@ void __init enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
 			 * uses an IPI, giving us a PSTATE that disappears when
 			 * we return.
 			 */
-			stop_machine(caps->enable, NULL, cpu_online_mask);
+			stop_machine(caps->enable, (void *)caps, cpu_online_mask);
 }
 
 /*
@@ -1005,7 +1005,7 @@ verify_local_cpu_features(const struct arm64_cpu_capabilities *caps)
 			cpu_die_early();
 		}
 		if (caps->enable)
-			caps->enable(NULL);
+			caps->enable((void *)caps);
 	}
 }
 
-- 
2.7.4
