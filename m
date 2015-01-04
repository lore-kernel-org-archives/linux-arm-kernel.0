From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Sun,  4 Jan 2015 18:55:07 +0800
Subject: [PATCH v6 06/17] ARM64 / ACPI: If we chose to boot from acpi then
 disable FDT
In-Reply-To: <1420368918-5086-1-git-send-email-hanjun.guo@linaro.org>
References: <1420368918-5086-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1420368918-5086-7-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Graeme Gregory <graeme.gregory@linaro.org>

If the early boot methods of acpi are happy that we have valid ACPI
tables and acpi=force has been passed, then do not unflat devicetree
effectively disabling further hardware probing from DT.

Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/kernel/setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 22e6895..2534de3 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -410,7 +410,8 @@ void __init setup_arch(char **cmdline_p)
 
 	efi_idmap_init();
 
-	unflatten_device_tree();
+	if (acpi_disabled)
+		unflatten_device_tree();
 
 	psci_init();
 
-- 
1.9.1
