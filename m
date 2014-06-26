From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 26 Jun 2014 13:46:03 +0200
Subject: [PATCH RESEND] ARM: EXYNOS: Do not calculate boot address twice
Message-ID: <1403783163-28638-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit b3205dea8fbf ("ARM: EXYNOS: Map SYSRAM through generic DT
bindings") introduced local variable boot_reg where boot address from
cpu_boot_reg() call is stored. Re-use it instead calling cpu_boot_reg()
again.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/mach-exynos/platsmp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 1c8d31e39520..55ed2e6729c5 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -155,7 +155,7 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 				ret = PTR_ERR(boot_reg);
 				goto fail;
 			}
-			__raw_writel(boot_addr, cpu_boot_reg(phys_cpu));
+			__raw_writel(boot_addr, boot_reg);
 		}
 
 		call_firmware_op(cpu_boot, phys_cpu);
@@ -242,7 +242,7 @@ static void __init exynos_smp_prepare_cpus(unsigned int max_cpus)
 
 			if (IS_ERR(boot_reg))
 				break;
-			__raw_writel(boot_addr, cpu_boot_reg(phys_cpu));
+			__raw_writel(boot_addr, boot_reg);
 		}
 	}
 }
-- 
1.9.1
