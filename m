From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 28 Sep 2011 04:05:01 +0300
Subject: [PATCH v4 2/3] arm/tegra: add support for ventana pinmuxing
In-Reply-To: <1317171902-14736-1-git-send-email-pdeschrijver@nvidia.com>
References: <1317171902-14736-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1317171902-14736-3-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for ventana pinmuxing as a seaboard derivative. This is a cut down
version of work done by Jong Kim <jongk@nvidia.com>.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 arch/arm/mach-tegra/Makefile                |    1 +
 arch/arm/mach-tegra/board-seaboard-pinmux.c |   49 +++++++++++++++++++++++++-
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index f11b910..91a07e1 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -31,6 +31,7 @@ obj-${CONFIG_MACH_SEABOARD}             += board-seaboard-pinmux.o
 
 obj-${CONFIG_MACH_TEGRA_DT}             += board-dt.o
 obj-${CONFIG_MACH_TEGRA_DT}             += board-harmony-pinmux.o
+obj-${CONFIG_MACH_TEGRA_DT}             += board-seaboard-pinmux.o
 
 obj-${CONFIG_MACH_TRIMSLICE}            += board-trimslice.o
 obj-${CONFIG_MACH_TRIMSLICE}            += board-trimslice-pinmux.o
diff --git a/arch/arm/mach-tegra/board-seaboard-pinmux.c b/arch/arm/mach-tegra/board-seaboard-pinmux.c
index b31c765..b62b04d 100644
--- a/arch/arm/mach-tegra/board-seaboard-pinmux.c
+++ b/arch/arm/mach-tegra/board-seaboard-pinmux.c
@@ -158,8 +158,26 @@ static __initdata struct tegra_pingroup_config seaboard_pinmux[] = {
 	{TEGRA_PINGROUP_XM2D,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
 };
 
-
-
+static __initdata struct tegra_pingroup_config ventana_pinmux[] = {
+	{TEGRA_PINGROUP_DAP3, TEGRA_MUX_DAP3,     TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_DDC,  TEGRA_MUX_RSVD2,    TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_DTA,  TEGRA_MUX_VI,       TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_DTB,  TEGRA_MUX_VI,       TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_DTC,  TEGRA_MUX_VI,       TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_DTD,  TEGRA_MUX_VI,       TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_GMD,  TEGRA_MUX_SFLASH,   TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_LPW0, TEGRA_MUX_RSVD4,    TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LPW2, TEGRA_MUX_RSVD4,    TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LSC1, TEGRA_MUX_RSVD4,    TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LSCK, TEGRA_MUX_RSVD4,    TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_LSDA, TEGRA_MUX_RSVD4,    TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_PTA,  TEGRA_MUX_RSVD2,    TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_SLXC, TEGRA_MUX_SDIO3,    TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_SLXK, TEGRA_MUX_SDIO3,    TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_SPIA, TEGRA_MUX_GMI,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_SPIC, TEGRA_MUX_GMI,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_SPIG, TEGRA_MUX_SPI2_ALT, TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+};
 
 static struct tegra_gpio_table common_gpio_table[] = {
 	{ .gpio = TEGRA_GPIO_SD2_CD,		.enable = true },
@@ -172,6 +190,26 @@ static struct tegra_gpio_table common_gpio_table[] = {
 	{ .gpio = TEGRA_GPIO_USB1,		.enable = true },
 };
 
+static void __init update_pinmux(struct tegra_pingroup_config *newtbl, int size)
+{
+	int i, j;
+	struct tegra_pingroup_config *new_pingroup, *base_pingroup;
+
+	/* Update base seaboard pinmux table with secondary board
+	 * specific pinmux table table.
+	 */
+	for (i = 0; i < size; i++) {
+		new_pingroup = &newtbl[i];
+		for (j = 0; j < ARRAY_SIZE(seaboard_pinmux); j++) {
+			base_pingroup = &seaboard_pinmux[j];
+			if (new_pingroup->pingroup == base_pingroup->pingroup) {
+				*base_pingroup = *new_pingroup;
+				break;
+			}
+		}
+	}
+}
+
 static void __init seaboard_common_pinmux_init(void)
 {
 	tegra_pinmux_config_table(seaboard_pinmux, ARRAY_SIZE(seaboard_pinmux));
@@ -186,3 +224,10 @@ void __init seaboard_pinmux_init(void)
 {
 	seaboard_common_pinmux_init();
 }
+
+void __init ventana_pinmux_init(void)
+{
+	update_pinmux(ventana_pinmux, ARRAY_SIZE(ventana_pinmux));
+	seaboard_common_pinmux_init();
+}
+
-- 
1.7.0.4
