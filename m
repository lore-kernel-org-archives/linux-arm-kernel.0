From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 29 Apr 2011 01:16:03 -0600
Subject: [PATCH v5 7/8] arm/dt: Basic tegra devicetree support
In-Reply-To: <20110429070135.12522.35745.stgit@ponder>
References: <20110429070135.12522.35745.stgit@ponder>
Message-ID: <20110429071603.12522.58598.stgit@ponder>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds adds very basic support for booting tegra with a
device tree.  It simply allows the existing machine_descs to match
against the tegra compatible values so that the kernel can boot.
Kernel parameters and the initrd pointer is read out of the tree
instead of atags.

This is not complete device tree support.  This change will be
reverted when a new machine_desc is added that can populate the
device registrations directly from data in the tree instead of using
hard coded data.  That change will be made in a future patch.

v2: Fixed cut-and-paste error in commit text

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/arm/boot/dts/tegra-harmony.dts |    7 +++++++
 arch/arm/mach-tegra/board-harmony.c |    6 ++++++
 2 files changed, 13 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/tegra-harmony.dts

diff --git a/arch/arm/boot/dts/tegra-harmony.dts b/arch/arm/boot/dts/tegra-harmony.dts
new file mode 100644
index 0000000..81032e7
--- /dev/null
+++ b/arch/arm/boot/dts/tegra-harmony.dts
@@ -0,0 +1,7 @@
+/dts-v1/;
+/include/ "skeleton.dtsi"
+
+/ {
+	model = "NVIDIA Tegra2 Harmony evaluation board";
+	compatible = "nvidia,harmony", "nvidia,tegra250";
+};
diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegra/board-harmony.c
index 75c918a..adbdb87 100644
--- a/arch/arm/mach-tegra/board-harmony.c
+++ b/arch/arm/mach-tegra/board-harmony.c
@@ -199,6 +199,11 @@ static void __init tegra_harmony_init(void)
 	harmony_regulator_init();
 }
 
+static const char * tegra_harmony_board_compat[] = {
+	"nvidia,harmony",
+	NULL
+};
+
 MACHINE_START(HARMONY, "harmony")
 	.boot_params  = 0x00000100,
 	.fixup		= tegra_harmony_fixup,
@@ -207,4 +212,5 @@ MACHINE_START(HARMONY, "harmony")
 	.init_irq       = tegra_init_irq,
 	.timer          = &tegra_timer,
 	.init_machine   = tegra_harmony_init,
+	.dt_compat      = tegra_harmony_board_compat,
 MACHINE_END
