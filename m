From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 26 May 2014 18:14:21 +0200
Subject: [PATCH] ALSA: hda: fix tegra build
Message-ID: <4769804.MRZYg8zfIB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_PM is disabled, the CONFIG_SND_HDA_POWER_SAVE_DEFAULT symbol
does not get defined, which causes a build error for the hda-tegra driver:

hda/hda_tegra.c:80:25: error: 'CONFIG_SND_HDA_POWER_SAVE_DEFAULT' undeclared here (not in a function)
 static int power_save = CONFIG_SND_HDA_POWER_SAVE_DEFAULT;
                         ^
/git/arm-soc/sound/pci/hda/hda_tegra.c:235:13: warning: 'hda_tegra_disable_clocks' defined but not used [-Wunused-function]
 static void hda_tegra_disable_clocks(struct hda_tegra *data)
             ^

This works around the problem by not referencing that macro
when CONFIG_PM is disabled. Instead, we assume that it's disabled
unconditionally and cannot be enabled at runtime.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
Reviewed-by: Stephen Warren <swarren@nvidia.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index 086fd06..a366ba9 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -77,10 +77,14 @@ struct hda_tegra {
 	void __iomem *regs;
 };
 
+#ifdef CONFIG_PM
 static int power_save = CONFIG_SND_HDA_POWER_SAVE_DEFAULT;
 module_param(power_save, bint, 0644);
 MODULE_PARM_DESC(power_save,
 		 "Automatic power-saving timeout (in seconds, 0 = disable).");
+#else
+static int power_save = 0;
+#endif
 
 /*
  * DMA page allocation ops.
