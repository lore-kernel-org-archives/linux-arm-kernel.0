From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 11 Mar 2015 20:39:35 +0800
Subject: [PATCH v10 09/21] ARM64 / ACPI: If we chose to boot from acpi then
 disable FDT
In-Reply-To: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1426077587-1561-10-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Graeme Gregory <graeme.gregory@linaro.org>

If the early boot methods of acpi are happy that we have valid ACPI
tables and acpi=force has been passed, then do not unflat devicetree
effectively disabling further hardware probing from DT.

CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will.deacon@arm.com>
Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Tested-by: Yijing Wang <wangyijing@huawei.com>
Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
Tested-by: Jon Masters <jcm@redhat.com>
Tested-by: Timur Tabi <timur@codeaurora.org>
Tested-by: Robert Richter <rrichter@cavium.com>
Acked-by: Robert Richter <rrichter@cavium.com>
Acked-by: Olof Johansson <olof@lixom.net>
Acked-by: Grant Likely <grant.likely@linaro.org>
Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/kernel/setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 4f1a014..e8c7000 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -390,7 +390,8 @@ void __init setup_arch(char **cmdline_p)
 
 	early_ioremap_reset();
 
-	unflatten_device_tree();
+	if (acpi_disabled)
+		unflatten_device_tree();
 
 	psci_init();
 
-- 
1.9.1
