From: will.deacon@arm.com (Will Deacon)
Date: Fri,  5 Jan 2018 13:12:34 +0000
Subject: [PATCH v2 04/11] arm64: cpufeature: Pass capability structure to
 ->enable callback
In-Reply-To: <1515157961-20963-1-git-send-email-will.deacon@arm.com>
References: <1515157961-20963-1-git-send-email-will.deacon@arm.com>
Message-ID: <1515157961-20963-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to invoke the CPU capability ->matches callback from the ->enable
callback for applying local-CPU workarounds, we need a handle on the
capability structure.

This patch passes a pointer to the capability structure to the ->enable
callback.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index d723fc071f39..55712ab4e3bf 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1152,7 +1152,7 @@ void __init enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
 			 * uses an IPI, giving us a PSTATE that disappears when
 			 * we return.
 			 */
-			stop_machine(caps->enable, NULL, cpu_online_mask);
+			stop_machine(caps->enable, (void *)caps, cpu_online_mask);
 		}
 	}
 }
@@ -1195,7 +1195,7 @@ verify_local_cpu_features(const struct arm64_cpu_capabilities *caps)
 			cpu_die_early();
 		}
 		if (caps->enable)
-			caps->enable(NULL);
+			caps->enable((void *)caps);
 	}
 }
 
-- 
2.1.4
