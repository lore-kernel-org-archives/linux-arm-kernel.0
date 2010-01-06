From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed,  6 Jan 2010 10:32:06 -0800
Subject: [PATCH 24/35] davinci: da850/omap-l138 EVM: register for suspend
	support
In-Reply-To: <1262802737-6601-24-git-send-email-khilman@deeprootsystems.com>
References: <1262802737-6601-1-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-2-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-3-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-4-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-5-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-6-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-7-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-8-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-9-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-10-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-11-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-12-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-13-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-14-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-15-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-16-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-17-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-18-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-19-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-20-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-21-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-22-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-23-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-24-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1262802737-6601-25-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/board-da850-evm.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 76e4347..411284d 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -89,6 +89,18 @@ static struct platform_device da850_evm_norflash_device = {
 	.resource	= da850_evm_norflash_resource,
 };
 
+static struct davinci_pm_config da850_pm_pdata = {
+	.sleepcount = 128,
+};
+
+static struct platform_device da850_pm_device = {
+	.name           = "pm-davinci",
+	.dev = {
+		.platform_data	= &da850_pm_pdata,
+	},
+	.id             = -1,
+};
+
 /* DA850/OMAP-L138 EVM includes a 512 MByte large-page NAND flash
  * (128K blocks). It may be used instead of the (default) SPI flash
  * to boot, using TI's tools to install the secondary boot loader
@@ -709,6 +721,11 @@ static __init void da850_evm_init(void)
 	if (ret)
 		pr_warning("da850_evm_init: cpuidle registration failed: %d\n",
 				ret);
+
+	ret = da850_register_pm(&da850_pm_device);
+	if (ret)
+		pr_warning("da850_evm_init: suspend registration failed: %d\n",
+				ret);
 }
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
-- 
1.6.6.rc2.1.g42108
