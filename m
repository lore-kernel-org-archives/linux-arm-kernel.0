From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 15 May 2014 10:50:59 +0200
Subject: [PATCH on kgene/for-next] ARM: EXYNOS: Do not calculate boot address
 twice
Message-ID: <1400143859-21457-1-git-send-email-k.kozlowski@samsung.com>
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
index 51cdabee10e5..c64bfc68ff9a 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -180,7 +180,7 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 				ret = PTR_ERR(boot_reg);
 				goto fail;
 			}
-			__raw_writel(boot_addr, cpu_boot_reg(phys_cpu));
+			__raw_writel(boot_addr, boot_reg);
 		}
 
 		call_firmware_op(cpu_boot, phys_cpu);
@@ -267,7 +267,7 @@ static void __init exynos_smp_prepare_cpus(unsigned int max_cpus)
 
 			if (IS_ERR(boot_reg))
 				break;
-			__raw_writel(boot_addr, cpu_boot_reg(phys_cpu));
+			__raw_writel(boot_addr, boot_reg);
 		}
 	}
 }
-- 
1.9.1
