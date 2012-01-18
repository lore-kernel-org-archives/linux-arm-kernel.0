From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 18 Jan 2012 14:36:45 +0000
Subject: [RFC PATCH 2/5] ARM: kernel: add cpu logical map DT init in setup_arch
In-Reply-To: <1326897408-11204-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1326897408-11204-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1326897408-11204-3-git-send-email-lorenzo.pieralisi@arm.com>
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
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
---
 arch/arm/kernel/setup.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index eedf7f0..efd1ea5 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -952,6 +952,7 @@ void __init setup_arch(char **cmdline_p)
 
 	unflatten_device_tree();
 
+	arm_dt_init_cpu_maps();
 #ifdef CONFIG_SMP
 	if (is_smp())
 		smp_init_cpus();
-- 
1.7.4.4
