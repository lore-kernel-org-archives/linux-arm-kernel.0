From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 24 Jul 2014 21:00:23 +0800
Subject: [PATCH 17/19] ARM64 / ACPI: If we chose to boot from acpi then
 disable FDT
In-Reply-To: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1406206825-15590-18-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Graeme Gregory <graeme.gregory@linaro.org>

If the early boot methods of acpi are happy that we have valid ACPI
tables and acpi=off has not been passed. Then do not unflat devicetree
effectively disabling further hardware probing from DT.

Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/kernel/setup.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 17ab98e..4ace77c 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -397,8 +397,8 @@ void __init setup_arch(char **cmdline_p)
 	/* Get the boot CPU's MPIDR before cpu logical map is built */
 	cpu_logical_map(0) = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
 	acpi_boot_init();
-
-	unflatten_device_tree();
+	if (acpi_disabled)
+		unflatten_device_tree();
 
 	psci_init();
 
-- 
1.7.9.5
