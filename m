From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 30 Apr 2016 23:15:39 +0200
Subject: [RFC PATCH 7/7] ASoC: add new ac97 bus support
In-Reply-To: <1462050939-27940-1-git-send-email-robert.jarzmik@free.fr>
References: <1462050939-27940-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1462050939-27940-8-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the new ac97 bus support, with ac97 bus automatic probing.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 sound/Kconfig     | 7 +++++++
 sound/Makefile    | 1 +
 sound/soc/Kconfig | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/sound/Kconfig b/sound/Kconfig
index 5a240e050ae6..83d67eae3580 100644
--- a/sound/Kconfig
+++ b/sound/Kconfig
@@ -134,3 +134,10 @@ config AC97_BUS
 	  sound subsystem and other function drivers completely unrelated to
 	  sound although they're sharing the AC97 bus. Concerned drivers
 	  should "select" this.
+
+config AC97_BUS_NEW
+	tristate
+	help
+	  This is the new AC97 bus type, successor of AC97_BUS. The ported
+	  drivers which benefit from the AC97 automatic probing should "select"
+	  this instead of the AC97_BUS.
diff --git a/sound/Makefile b/sound/Makefile
index 77320709fd26..74728aee25d5 100644
--- a/sound/Makefile
+++ b/sound/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_SND_AOA) += aoa/
 
 # This one must be compilable even if sound is configured out
 obj-$(CONFIG_AC97_BUS) += ac97_bus.o
+obj-$(CONFIG_AC97_BUS_NEW) += ac97/
 
 ifeq ($(CONFIG_SND),y)
   obj-y += last.o
diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 182d92efc7c8..5ad0a0422054 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -6,6 +6,7 @@ menuconfig SND_SOC
 	tristate "ALSA for SoC audio support"
 	select SND_PCM
 	select AC97_BUS if SND_SOC_AC97_BUS
+	select AC97_BUS_NEW if SND_SOC_AC97_BUS_NEW
 	select SND_JACK
 	select REGMAP_I2C if I2C
 	select REGMAP_SPI if SPI_MASTER
@@ -25,6 +26,9 @@ if SND_SOC
 config SND_SOC_AC97_BUS
 	bool
 
+config SND_SOC_AC97_BUS_NEW
+	bool
+
 config SND_SOC_GENERIC_DMAENGINE_PCM
 	bool
 	select SND_DMAENGINE_PCM
-- 
2.1.4
