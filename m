From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 19 Nov 2012 12:45:04 +0000
Subject: [PATCH v4 5/7] ARM: kernel: add cpu logical map DT init in setup_arch
In-Reply-To: <1353329106-24084-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1353329106-24084-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1353329106-24084-6-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As soon as the device tree is unflattened the cpu logical to physical
mapping is carried out in setup_arch to build a proper array of MPIDR and
corresponding logical indexes.

The mapping could have been carried out using the flattened DT blob and
related primitives, but since the mapping is not needed by early boot
code it can safely be executed when the device tree has been uncompressed to
its tree data structure.

This patch adds the arm_dt_init_cpu maps() function call in setup_arch().

If the kernel is not compiled with DT support the function is empty and
no logical mapping takes place through it; the mapping carried out in
smp_setup_processor_id() is left unchanged.
If DT is supported the mapping created in smp_setup_processor_id() is overriden.
The DT mapping also sets the possible cpus mask, hence platform
code need not set it again in the respective smp_init_cpus() functions.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Acked-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/kernel/setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 4515bf6..d15f1c5 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -759,6 +759,7 @@ void __init setup_arch(char **cmdline_p)
 
 	unflatten_device_tree();
 
+	arm_dt_init_cpu_maps();
 #ifdef CONFIG_SMP
 	if (is_smp()) {
 		smp_set_ops(mdesc->smp);
-- 
1.7.12
