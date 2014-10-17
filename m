From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 17 Oct 2014 21:36:57 +0800
Subject: [PATCH v5 01/18] ARM64: Move the init of cpu_logical_map(0) before
 unflatten_device_tree()
In-Reply-To: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1413553034-20956-2-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It always make sense to initialize CPU0's logical map entry from the
hardware values, so move the initialization of cpu_logical_map(0)
before unflatten_device_tree() which is needed by ACPI code later.

Acked-by: Olof Johansson <olof@lixom.net>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/kernel/setup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index edb146d..8f33f72 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -393,11 +393,11 @@ void __init setup_arch(char **cmdline_p)
 
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
