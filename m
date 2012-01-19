From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Jan 2012 15:35:07 +0000
Subject: [PATCH 08/11] ARM: vexpress: fix two section mismatch warnings
In-Reply-To: <20120119153149.GB1068@n2100.arm.linux.org.uk>
References: <20120119153149.GB1068@n2100.arm.linux.org.uk>
Message-ID: <E1Rnu15-0002pn-Ks@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WARNING: vmlinux.o(.text+0x1bc9c): Section mismatch in reference from the function ct_ca9x4_init_cpu_map() to the function .init.text:scu_get_core_count()
The function ct_ca9x4_init_cpu_map() references
the function __init scu_get_core_count().

WARNING: vmlinux.o(.text+0x1bce8): Section mismatch in reference from the function ct_ca9x4_init_cpu_map() to the function .init.text:set_smp_cross_call()
The function ct_ca9x4_init_cpu_map() references
the function __init set_smp_cross_call().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-vexpress/ct-ca9x4.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index 2b1e836..b1e87c1 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -217,7 +217,7 @@ static void __init ct_ca9x4_init(void)
 }
 
 #ifdef CONFIG_SMP
-static void ct_ca9x4_init_cpu_map(void)
+static void __init ct_ca9x4_init_cpu_map(void)
 {
 	int i, ncores = scu_get_core_count(MMIO_P2V(A9_MPCORE_SCU));
 
@@ -233,7 +233,7 @@ static void ct_ca9x4_init_cpu_map(void)
 	set_smp_cross_call(gic_raise_softirq);
 }
 
-static void ct_ca9x4_smp_enable(unsigned int max_cpus)
+static void __init ct_ca9x4_smp_enable(unsigned int max_cpus)
 {
 	scu_enable(MMIO_P2V(A9_MPCORE_SCU));
 }
-- 
1.7.4.4
