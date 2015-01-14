From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 14 Jan 2015 23:04:53 +0800
Subject: [PATCH v7 05/17] ARM64 / ACPI: If we chose to boot from acpi then
 disable FDT
In-Reply-To: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1421247905-3749-6-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Graeme Gregory <graeme.gregory@linaro.org>

If the early boot methods of acpi are happy that we have valid ACPI
tables and acpi=force has been passed, then do not unflat devicetree
effectively disabling further hardware probing from DT.

Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Tested-by: Yijing Wang <wangyijing@huawei.com>
Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/kernel/setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 4580ed3..5d139e1 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -411,7 +411,8 @@ void __init setup_arch(char **cmdline_p)
 	efi_idmap_init();
 	early_ioremap_reset();
 
-	unflatten_device_tree();
+	if (acpi_disabled)
+		unflatten_device_tree();
 
 	psci_init();
 
-- 
1.9.1
