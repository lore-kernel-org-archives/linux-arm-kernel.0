From: zonque@gmail.com (Daniel Mack)
Date: Thu, 29 Nov 2012 17:01:28 +0100
Subject: [PATCH v6 1/5] ARM: OMAP: gpmc: don't create devices from initcall on
 DT
In-Reply-To: <1354204892-22762-1-git-send-email-zonque@gmail.com>
References: <1354204892-22762-1-git-send-email-zonque@gmail.com>
Message-ID: <1354204892-22762-2-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On DT driven boards, the gpmc node will match the driver. Hence, there's
no need to do that unconditionally from the initcall.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 arch/arm/mach-omap2/gpmc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 60f1cce..1dcb30c 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -844,6 +844,13 @@ static int __init omap_gpmc_init(void)
 	struct platform_device *pdev;
 	char *oh_name = "gpmc";
 
+	/*
+	 * if the board boots up with a populated DT, do not
+	 * manually add the device from this initcall
+	 */
+	if (of_have_populated_dt())
+		return -ENODEV;
+
 	oh = omap_hwmod_lookup(oh_name);
 	if (!oh) {
 		pr_err("Could not look up %s\n", oh_name);
-- 
1.7.11.7
