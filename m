From: maninder1.s@samsung.com (Maninder Singh)
Date: Wed, 30 Nov 2016 16:10:28 +0530
Subject: [PATCH 1/1] mach-omap2: fixing wrong strcat for Non-NULL terminated
 string
Message-ID: <1480502428-19509-1-git-send-email-maninder1.s@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

variable name can have Non NULL terminated string after cropping
which may result strcat to fail, and cropping is not
required if (strlen(oh->name) + 8 < MOD_CLK_MAX_NAME_LEN).

Issue caught with static analysis tool:
"Dangerous usage of 'name' (strncpy doesn't always 0-terminate it)"

Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 759e1d4..8adf272 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -742,12 +742,15 @@ static int _init_main_clk(struct omap_hwmod *oh)
 	char name[MOD_CLK_MAX_NAME_LEN];
 	struct clk *clk;
 
-	/* +7 magic comes from '_mod_ck' suffix */
-	if (strlen(oh->name) + 7 > MOD_CLK_MAX_NAME_LEN)
+	/* +8 magic comes from strlen("_mod_ck") added as suffix */
+	if (strlen(oh->name) + 8 > MOD_CLK_MAX_NAME_LEN) {
 		pr_warn("%s: warning: cropping name for %s\n", __func__,
 			oh->name);
+		strncpy(name, oh->name, MOD_CLK_MAX_NAME_LEN - 8);
+		name[MOD_CLK_MAX_NAME_LEN - 8] = '\0';
+	} else
+		strcpy(name, oh->name);
 
-	strncpy(name, oh->name, MOD_CLK_MAX_NAME_LEN - 7);
 	strcat(name, "_mod_ck");
 
 	clk = clk_get(NULL, name);
-- 
1.9.1
