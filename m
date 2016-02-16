From: tiwai@suse.de (Takashi Iwai)
Date: Tue, 16 Feb 2016 16:49:42 +0100
Subject: [PATCH] sound: hdmi: avoid dereferencing uninitialized 'jack'
 pointer
In-Reply-To: <1455634059-1896914-1-git-send-email-arnd@arndb.de>
References: <1455634059-1896914-1-git-send-email-arnd@arndb.de>
Message-ID: <s5hbn7g7izt.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 16 Feb 2016 15:47:28 +0100,
Arnd Bergmann wrote:
> 
> When CONFIG_SND_JACK is disabled, the hdmi driver tries to create
> a new output jack structure and dereferences it even though
> the pointer is never assigned:
> 
> sound/pci/hda/patch_hdmi.c: In function 'generic_hdmi_build_jack':
> sound/pci/hda/patch_hdmi.c:2534:30: error: 'jack' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> sound/pci/hda/patch_hdmi.c:2526:19: note: 'jack' was declared here
> 
> This uses a compile-time check to avoid calling a nonworking
> snd_jack_new() function, and sets an explicit NULL pointer instead.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 788d441a164c ("ALSA: hda - Use component ops for i915 HDMI/DP audio jack handling")

Thanks for the patch.  But I think it's cleaner to fix Kconfig.

Thinking more of it, maybe splitting jack stuff as a separate module
and does reverse-select to CONFIG_INPUT would be better.  Then its
users can select simply SND_JACK, and everything would fit.

An untested patch is below.  Mark, what do you think?


Takashi

---
diff --git a/sound/core/Kconfig b/sound/core/Kconfig
index a2a1e24becc6..cf4058dde959 100644
--- a/sound/core/Kconfig
+++ b/sound/core/Kconfig
@@ -24,11 +24,9 @@ config SND_RAWMIDI
 config SND_COMPRESS_OFFLOAD
 	tristate
 
-# To be effective this also requires INPUT - users should say:
-#    select SND_JACK if INPUT=y || INPUT=SND
-# to avoid having to force INPUT on.
 config SND_JACK
-	bool
+	tristate
+	select INPUT
 
 config SND_SEQUENCER
 	tristate "Sequencer support"
diff --git a/sound/core/Makefile b/sound/core/Makefile
index 48ab4b8f8279..d16e2b0ba4fb 100644
--- a/sound/core/Makefile
+++ b/sound/core/Makefile
@@ -11,7 +11,8 @@ endif
 snd-$(CONFIG_ISA_DMA_API) += isadma.o
 snd-$(CONFIG_SND_OSSEMUL) += sound_oss.o
 snd-$(CONFIG_SND_VMASTER) += vmaster.o
-snd-$(CONFIG_SND_JACK)	  += ctljack.o jack.o
+
+snd-jack-objs	:= ctljack.o jack.o
 
 snd-pcm-y := pcm.o pcm_native.o pcm_lib.o pcm_misc.o \
 		pcm_memory.o memalloc.o
@@ -41,6 +42,7 @@ obj-$(CONFIG_SND_RTCTIMER)	+= snd-rtctimer.o
 obj-$(CONFIG_SND_PCM)		+= snd-pcm.o
 obj-$(CONFIG_SND_DMAENGINE_PCM)	+= snd-pcm-dmaengine.o
 obj-$(CONFIG_SND_RAWMIDI)	+= snd-rawmidi.o
+obj-$(CONFIG_SND_JACK)		+= snd-jack.o
 
 obj-$(CONFIG_SND_OSSEMUL)	+= oss/
 obj-$(CONFIG_SND_SEQUENCER)	+= seq/
diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
index 8f6594a7d37f..32151d8c6bb8 100644
--- a/sound/pci/Kconfig
+++ b/sound/pci/Kconfig
@@ -866,7 +866,7 @@ config SND_VIRTUOSO
 	select SND_OXYGEN_LIB
 	select SND_PCM
 	select SND_MPU401_UART
-	select SND_JACK if INPUT=y || INPUT=SND
+	select SND_JACK
 	help
 	  Say Y here to include support for sound cards based on the
 	  Asus AV66/AV100/AV200 chips, i.e., Xonar D1, DX, D2, D2X, DS, DSX,
diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index e94cfd5c69f7..bb02c2d48fd5 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -4,7 +4,7 @@ config SND_HDA
 	tristate
 	select SND_PCM
 	select SND_VMASTER
-	select SND_JACK if INPUT=y || INPUT=SND
+	select SND_JACK
 	select SND_HDA_CORE
 
 config SND_HDA_INTEL
diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 7ea66ee3653f..182d92efc7c8 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -6,7 +6,7 @@ menuconfig SND_SOC
 	tristate "ALSA for SoC audio support"
 	select SND_PCM
 	select AC97_BUS if SND_SOC_AC97_BUS
-	select SND_JACK if INPUT=y || INPUT=SND
+	select SND_JACK
 	select REGMAP_I2C if I2C
 	select REGMAP_SPI if SPI_MASTER
 	---help---
