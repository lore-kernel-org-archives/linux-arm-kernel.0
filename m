From: lkundrak@v3.sk (Lubomir Rintel)
Date: Fri, 16 Nov 2018 17:23:58 +0100
Subject: [PATCH v2 12/17] x86,
 olpc: Use a correct version when making up a battery node
In-Reply-To: <20181116162403.49854-1-lkundrak@v3.sk>
References: <20181116162403.49854-1-lkundrak@v3.sk>
Message-ID: <20181116162403.49854-13-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The XO-1 and XO-1.5 batteries apparently differ in an ability to report
ambient temperature. Add a different compatible string to the 1.5
battery.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>

---
Changes since v1:
- Avoid splitting string literals

 arch/x86/platform/olpc/olpc_dt.c | 85 +++++++++++++++++++++-----------
 1 file changed, 57 insertions(+), 28 deletions(-)

diff --git a/arch/x86/platform/olpc/olpc_dt.c b/arch/x86/platform/olpc/olpc_dt.c
index 24d2175a9480..6063f52ed807 100644
--- a/arch/x86/platform/olpc/olpc_dt.c
+++ b/arch/x86/platform/olpc/olpc_dt.c
@@ -218,10 +218,28 @@ static u32 __init olpc_dt_get_board_revision(void)
 	return be32_to_cpu(rev);
 }
 
-void __init olpc_dt_fixup(void)
+int olpc_dt_compatible_match(phandle node, const char *compat)
 {
-	int r;
 	char buf[64];
+	int plen;
+	char *p;
+	int len;
+
+	plen = olpc_dt_getproperty(node, "compatible", buf, sizeof(buf));
+	if (plen <= 0)
+		return 0;
+
+	len = strlen(compat);
+	for (p = buf; p < buf + plen; p += strlen(p) + 1) {
+		if (strcmp(p, compat) == 0)
+			return 1;
+	}
+
+	return 0;
+}
+
+void __init olpc_dt_fixup(void)
+{
 	phandle node;
 	u32 board_rev;
 
@@ -229,41 +247,51 @@ void __init olpc_dt_fixup(void)
 	if (!node)
 		return;
 
-	/*
-	 * If the battery node has a compatible property, we are running a new
-	 * enough firmware and don't have fixups to make.
-	 */
-	r = olpc_dt_getproperty(node, "compatible", buf, sizeof(buf));
-	if (r > 0)
-		return;
-
-	pr_info("PROM DT: Old firmware detected, applying fixes\n");
-
-	/* Add olpc,xo1-battery compatible marker to battery node */
-	olpc_dt_interpret("\" /battery at 0\" find-device"
-		" \" olpc,xo1-battery\" +compatible"
-		" device-end");
-
 	board_rev = olpc_dt_get_board_revision();
 	if (!board_rev)
 		return;
 
 	if (board_rev >= olpc_board_pre(0xd0)) {
+		if (olpc_dt_compatible_match(node, "olpc,xo1.5-battery"))
+			return;
+
+		/* Add olpc,xo1.5-battery compatible marker to battery node */
+		olpc_dt_interpret("\" /battery at 0\" find-device");
+		olpc_dt_interpret("  \" olpc,xo1.5-battery\" +compatible");
+		olpc_dt_interpret("device-end");
+
+		/* We're running a very old firmware if this is missing. */
+		if (olpc_dt_compatible_match(node, "olpc,xo1-battery"))
+			return;
+
 		/* XO-1.5: add dcon device */
-		olpc_dt_interpret("\" /pci/display at 1\" find-device"
-			" new-device"
-			" \" dcon\" device-name \" olpc,xo1-dcon\" +compatible"
-			" finish-device device-end");
+		olpc_dt_interpret("\" /pci/display at 1\" find-device");
+		olpc_dt_interpret("  new-device");
+		olpc_dt_interpret("    \" dcon\" device-name");
+		olpc_dt_interpret("    \" olpc,xo1-dcon\" +compatible");
+		olpc_dt_interpret("  finish-device");
+		olpc_dt_interpret("device-end");
 	} else {
+		/* We're running a very old firmware if this is missing. */
+		if (olpc_dt_compatible_match(node, "olpc,xo1-battery"))
+			return;
+
 		/* XO-1: add dcon device, mark RTC as olpc,xo1-rtc */
-		olpc_dt_interpret("\" /pci/display at 1,1\" find-device"
-			" new-device"
-			" \" dcon\" device-name \" olpc,xo1-dcon\" +compatible"
-			" finish-device device-end"
-			" \" /rtc\" find-device"
-			" \" olpc,xo1-rtc\" +compatible"
-			" device-end");
+		olpc_dt_interpret("\" /pci/display at 1,1\" find-device");
+		olpc_dt_interpret("  new-device");
+		olpc_dt_interpret("    \" dcon\" device-name");
+		olpc_dt_interpret("    \" olpc,xo1-dcon\" +compatible");
+		olpc_dt_interpret("  finish-device");
+		olpc_dt_interpret("device-end");
+		olpc_dt_interpret("\" /rtc\" find-device");
+		olpc_dt_interpret("  \" olpc,xo1-rtc\" +compatible");
+		olpc_dt_interpret("device-end");
 	}
+
+	/* Add olpc,xo1-battery compatible marker to battery node */
+	olpc_dt_interpret("\" /battery at 0\" find-device");
+	olpc_dt_interpret("  \" olpc,xo1-battery\" +compatible");
+	olpc_dt_interpret("device-end");
 }
 
 void __init olpc_dt_build_devicetree(void)
@@ -289,6 +317,7 @@ void __init olpc_dt_build_devicetree(void)
 /* A list of DT node/bus matches that we want to expose as platform devices */
 static struct of_device_id __initdata of_ids[] = {
 	{ .compatible = "olpc,xo1-battery" },
+	{ .compatible = "olpc,xo1.5-battery" },
 	{ .compatible = "olpc,xo1-dcon" },
 	{ .compatible = "olpc,xo1-rtc" },
 	{},
-- 
2.19.1
