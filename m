From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 19 Dec 2012 17:54:43 +0000
Subject: [PATCH v2 4/7] arm64: Populate the platform devices
In-Reply-To: <1355939686-23728-1-git-send-email-catalin.marinas@arm.com>
References: <1355939686-23728-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1355939686-23728-5-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add a device_initcall() to populate the platform devices
(of_default_bus_match_table). This allows SoC implementations that do
not require earlier initcalls to avoid any platform-specific code under
arch/arm64.

GIC and generic timer initialisation is done via FDT and CPU notifiers
independently of the SoC code.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/setup.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 7665a9b..894c1e5 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -39,6 +39,7 @@
 #include <linux/proc_fs.h>
 #include <linux/memblock.h>
 #include <linux/of_fdt.h>
+#include <linux/of_platform.h>
 
 #include <asm/cputype.h>
 #include <asm/elf.h>
@@ -289,6 +290,13 @@ static int __init topology_init(void)
 }
 subsys_initcall(topology_init);
 
+static int __init arm64_device_probe(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	return 0;
+}
+device_initcall(arm64_device_probe);
+
 static const char *hwcap_str[] = {
 	"fp",
 	"asimd",
