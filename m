From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 28 Jan 2013 17:34:04 +0000
Subject: [RFC PATCH] ARM: Export the CPU logical map to modules
Message-ID: <1359394444-16610-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is reasonable for loadable modules to be CPU topology aware
(particular examples include cpufreq and cpuidle drivers).

This patch exports __cpu_logical_map, so that modules can use the
cpu_logical_map() interface declared in <asm/smp_plat.h>.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
If anyone has a strong view on whether this should be
EXPORT_SYMBOL_GPL(), I don't have a problem with changing
that.  I'm not sure of the precise etiquette here.
Certainly this does not feel like a very "public" interface.

Perhaps we should wrap this in a real function for export
to modules, rather than encouraging them to poke the
__cpu_logical_map[] array (albeit via a predefined macro).


 arch/arm/kernel/setup.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 3f6cbb2..1b9e5bf 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -428,6 +428,7 @@ void cpu_init(void)
 }
 
 int __cpu_logical_map[NR_CPUS];
+EXPORT_SYMBOL(__cpu_logical_map);
 
 void __init smp_setup_processor_id(void)
 {
-- 
1.7.4.1
