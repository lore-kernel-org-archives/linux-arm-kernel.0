From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sat, 27 Oct 2012 14:47:54 +0530
Subject: [PATCH 9/9] pinctrl: SPEAr1340: Add clcd sleep mode pin configuration
In-Reply-To: <cover.1351329224.git.viresh.kumar@linaro.org>
References: <cover.1351329224.git.viresh.kumar@linaro.org>
Message-ID: <3e57c43f3f0572de7bec94020a4b59058541210c.1351329224.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vipul Kumar Samar <vipulkumar.samar@st.com>

CLCD pads must be configured differently for sleep mode. This patch adds support
for clcd_sleep_pingroup.

Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/pinctrl/spear/pinctrl-spear1340.c | 39 ++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/spear/pinctrl-spear1340.c b/drivers/pinctrl/spear/pinctrl-spear1340.c
index 3963675..0606b8c 100644
--- a/drivers/pinctrl/spear/pinctrl-spear1340.c
+++ b/drivers/pinctrl/spear/pinctrl-spear1340.c
@@ -1692,7 +1692,43 @@ static struct spear_pingroup clcd_pingroup = {
 	.nmodemuxs = ARRAY_SIZE(clcd_modemux),
 };
 
-static const char *const clcd_grps[] = { "clcd_grp" };
+/* Disable cld runtime to save panel damage */
+static struct spear_muxreg clcd_sleep_muxreg[] = {
+	{
+		.reg = PAD_SHARED_IP_EN_1,
+		.mask = ARM_TRACE_MASK | MIPHY_DBG_MASK,
+		.val = 0,
+	}, {
+		.reg = PAD_FUNCTION_EN_5,
+		.mask = CLCD_REG4_MASK | CLCD_AND_ARM_TRACE_REG4_MASK,
+		.val = 0x0,
+	}, {
+		.reg = PAD_FUNCTION_EN_6,
+		.mask = CLCD_AND_ARM_TRACE_REG5_MASK,
+		.val = 0x0,
+	}, {
+		.reg = PAD_FUNCTION_EN_7,
+		.mask = CLCD_AND_ARM_TRACE_REG6_MASK,
+		.val = 0x0,
+	},
+};
+
+static struct spear_modemux clcd_sleep_modemux[] = {
+	{
+		.muxregs = clcd_sleep_muxreg,
+		.nmuxregs = ARRAY_SIZE(clcd_sleep_muxreg),
+	},
+};
+
+static struct spear_pingroup clcd_sleep_pingroup = {
+	.name = "clcd_sleep_grp",
+	.pins = clcd_pins,
+	.npins = ARRAY_SIZE(clcd_pins),
+	.modemuxs = clcd_sleep_modemux,
+	.nmodemuxs = ARRAY_SIZE(clcd_sleep_modemux),
+};
+
+static const char *const clcd_grps[] = { "clcd_grp", "clcd_sleep_grp" };
 static struct spear_function clcd_function = {
 	.name = "clcd",
 	.groups = clcd_grps,
@@ -1893,6 +1929,7 @@ static struct spear_pingroup *spear1340_pingroups[] = {
 	&sdhci_pingroup,
 	&cf_pingroup,
 	&xd_pingroup,
+	&clcd_sleep_pingroup,
 	&clcd_pingroup,
 	&arm_trace_pingroup,
 	&miphy_dbg_pingroup,
-- 
1.7.12.rc2.18.g61b472e
