From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon,  1 Sep 2014 22:57:39 +0800
Subject: [PATCH v3 01/17] ARM64: Move the init of cpu_logical_map(0) before
 unflatten_device_tree()
In-Reply-To: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1409583475-6978-2-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It always make sense to initialize CPU0's logical map entry from the
hardware values, so move the initialization of cpu_logical_map(0)
before unflatten_device_tree() which is needed by ACPI code later.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/kernel/setup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index f6f0ccf..c96172a 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -390,11 +390,11 @@ void __init setup_arch(char **cmdline_p)
 
 	efi_idmap_init();
 
+	cpu_logical_map(0) = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
 	unflatten_device_tree();
 
 	psci_init();
 
-	cpu_logical_map(0) = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
 	cpu_read_bootcpu_ops();
 #ifdef CONFIG_SMP
 	smp_init_cpus();
-- 
1.7.9.5
