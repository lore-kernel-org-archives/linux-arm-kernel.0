From: jonathan.austin@arm.com (Jonathan Austin)
Date: Tue, 14 May 2013 14:04:41 +0100
Subject: [PATCH 5/8] ARM: mpu: Complete initialisation of the MPU after
 reaching the C-world
In-Reply-To: <1368536684-13608-1-git-send-email-jonathan.austin@arm.com>
References: <1368536684-13608-1-git-send-email-jonathan.austin@arm.com>
Message-ID: <1368536684-13608-6-git-send-email-jonathan.austin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Much like with the MMU, MPU initialisation is performed in two stages; the
first in the pre-C world and the 'real' initialisation during arch setup.

This patch wires in previously added MPU initialisation functions so that
the whole of memory is mapped with the appropriate region properties for
'normal' RAM (the appropriate properties depend on whether the system is
SMP).

Stub initialisation functions are added for the case that there MPU support
is not configured in to the kernel.

Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
CC: Hyok S. Choi <hyok.choi@samsung.com>
---
 arch/arm/mm/nommu.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 0a9eb24..44ccdd4 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -265,6 +265,9 @@ void __init mpu_setup(void)
 			mpu_max_regions());
 	}
 }
+#else
+static void sanity_check_meminfo_mpu(void) {}
+static void __init mpu_setup(void) {}
 #endif /* CONFIG_ARM_MPU */
 
 void __init arm_mm_memblock_reserve(void)
@@ -279,7 +282,9 @@ void __init arm_mm_memblock_reserve(void)
 
 void __init sanity_check_meminfo(void)
 {
-	phys_addr_t end = bank_phys_end(&meminfo.bank[meminfo.nr_banks - 1]);
+	phys_addr_t end;
+	sanity_check_meminfo_mpu();
+	end = bank_phys_end(&meminfo.bank[meminfo.nr_banks - 1]);
 	high_memory = __va(end - 1) + 1;
 }
 
@@ -290,6 +295,7 @@ void __init sanity_check_meminfo(void)
 void __init paging_init(struct machine_desc *mdesc)
 {
 	early_trap_init((void *)CONFIG_VECTORS_BASE);
+	mpu_setup();
 	bootmem_init();
 }
 
-- 
1.7.9.5
