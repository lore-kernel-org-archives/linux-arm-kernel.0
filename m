From: lee.jones@linaro.org (Lee Jones)
Date: Tue,  2 Apr 2013 14:21:53 +0100
Subject: [PATCH 6/9] ARM: ux500: Create a new of_dev_auxdata structure for
 u8540 enablement
In-Reply-To: <1364908916-29803-1-git-send-email-lee.jones@linaro.org>
References: <1364908916-29803-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1364908916-29803-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we attempt to use the existing u8500 of_dev_auxdata struct to boot
the u8540, we fail to obtain a console, due to a lack of DMA support
on the platform.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/cpu-db8500.c |   19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index f1a5818..e027865 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -297,6 +297,16 @@ static struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
 	{},
 };
 
+static struct of_dev_auxdata u8540_auxdata_lookup[] __initdata = {
+	/* Requires DMA bindings. */
+	OF_DEV_AUXDATA("arm,pl011", 0x80120000, "uart0", NULL),
+	OF_DEV_AUXDATA("arm,pl011", 0x80121000, "uart1", NULL),
+	OF_DEV_AUXDATA("arm,pl011", 0x80007000, "uart2", NULL),
+	OF_DEV_AUXDATA("stericsson,db8500-prcmu", 0x80157000, "db8500-prcmu",
+			&db8500_prcmu_pdata),
+	{},
+};
+
 static const struct of_device_id u8500_local_bus_nodes[] = {
 	/* only create devices below soc node */
 	{ .compatible = "stericsson,db8500", },
@@ -323,8 +333,13 @@ static void __init u8500_init_machine(void)
 	/* TODO: Export SoC, USB, cpu-freq and DMA40 */
 	parent = u8500_of_init_devices();
 
-	/* automatically probe child nodes of db8500 device */
-	of_platform_populate(NULL, u8500_local_bus_nodes, u8500_auxdata_lookup, parent);
+	/* automatically probe child nodes of dbx5x0 devices */
+	if (of_machine_is_compatible("st-ericsson,u8540"))
+		of_platform_populate(NULL, u8500_local_bus_nodes,
+				     u8540_auxdata_lookup, parent);
+	else
+		of_platform_populate(NULL, u8500_local_bus_nodes,
+				     u8500_auxdata_lookup, parent);
 }
 
 static const char * stericsson_dt_platform_compat[] = {
-- 
1.7.10.4
