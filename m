From: tiwai@suse.de (Takashi Iwai)
Date: Wed, 17 Feb 2016 10:35:40 +0100
Subject: [PATCH] sound: hdmi: avoid dereferencing uninitialized 'jack'
 pointer
In-Reply-To: <s5h8u2j6749.wl-tiwai@suse.de>
References: <1455634059-1896914-1-git-send-email-arnd@arndb.de>
 <s5hr3gc60ph.wl-tiwai@suse.de> <2706488.VpKveMVPGI@wuerfel>
 <3395859.dhsfOsmVIe@wuerfel> <s5h8u2j6749.wl-tiwai@suse.de>
Message-ID: <s5h1t8b65n7.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 17 Feb 2016 10:03:50 +0100,
Takashi Iwai wrote:
> --- a/sound/core/Kconfig
> +++ b/sound/core/Kconfig
> @@ -24,11 +24,14 @@ config SND_RAWMIDI
>  config SND_COMPRESS_OFFLOAD
>  	tristate
>  
> -# To be effective this also requires INPUT - users should say:
> -#    select SND_JACK if INPUT=y || INPUT=SND
> -# to avoid having to force INPUT on.
>  config SND_JACK
> +	tristate

Oops, some unintentional change slipped in.  This must be bool.

Below is the revised patch.


Takashi

-- 8< --
From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2] ALSA: jack: Allow building the jack layer without
 input device

Since the recent integration of kctl jack and input jack layers, we
can basically build the jack layer even without input devices.  That
is, the jack layer itself can be built with conditional to enable the
input device support or not, while the users may enable always
CONFIG_SND_JACK unconditionally.

For achieving it, this patch changes the following:
- A new Kconfig, CONFIG_SND_JACK_INPUT_DEV, was introduced to indicate
  whether the jack layer supports the input device,
- A few items in snd_jack struct and relevant codes are conditionally
  built upon CONFIG_SND_JACK_INPUT_DEV,
- The users of CONFIG_SND_JACK drop the messy dependency on
  CONFIG_INPUT.

This change also automagically fixes a potential bug in HD-audio
driver Arnd reported, where the NULL or uninitialized jack instance is
dereferenced.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/jack.h  | 23 ++++++++++++++---------
 sound/core/Kconfig    |  9 ++++++---
 sound/core/jack.c     | 23 ++++++++++++++++++++---
 sound/pci/Kconfig     |  2 +-
 sound/pci/hda/Kconfig |  2 +-
 sound/soc/Kconfig     |  2 +-
 6 files changed, 43 insertions(+), 18 deletions(-)

diff --git a/include/sound/jack.h b/include/sound/jack.h
index 23bede121c78..1e84bfb553cf 100644
--- a/include/sound/jack.h
+++ b/include/sound/jack.h
@@ -72,14 +72,16 @@ enum snd_jack_types {
 #define SND_JACK_SWITCH_TYPES 6
 
 struct snd_jack {
-	struct input_dev *input_dev;
 	struct list_head kctl_list;
 	struct snd_card *card;
+	const char *id;
+#ifdef CONFIG_SND_JACK_INPUT_DEV
+	struct input_dev *input_dev;
 	int registered;
 	int type;
-	const char *id;
 	char name[100];
 	unsigned int key[6];   /* Keep in sync with definitions above */
+#endif /* CONFIG_SND_JACK_INPUT_DEV */
 	void *private_data;
 	void (*private_free)(struct snd_jack *);
 };
@@ -89,10 +91,11 @@ struct snd_jack {
 int snd_jack_new(struct snd_card *card, const char *id, int type,
 		 struct snd_jack **jack, bool initial_kctl, bool phantom_jack);
 int snd_jack_add_new_kctl(struct snd_jack *jack, const char * name, int mask);
+#ifdef CONFIG_SND_JACK_INPUT_DEV
 void snd_jack_set_parent(struct snd_jack *jack, struct device *parent);
 int snd_jack_set_key(struct snd_jack *jack, enum snd_jack_types type,
 		     int keytype);
-
+#endif
 void snd_jack_report(struct snd_jack *jack, int status);
 
 #else
@@ -107,6 +110,13 @@ static inline int snd_jack_add_new_kctl(struct snd_jack *jack, const char * name
 	return 0;
 }
 
+static inline void snd_jack_report(struct snd_jack *jack, int status)
+{
+}
+
+#endif
+
+#if !defined(CONFIG_SND_JACK) || !defined(CONFIG_SND_JACK_INPUT_DEV)
 static inline void snd_jack_set_parent(struct snd_jack *jack,
 				       struct device *parent)
 {
@@ -118,11 +128,6 @@ static inline int snd_jack_set_key(struct snd_jack *jack,
 {
 	return 0;
 }
-
-static inline void snd_jack_report(struct snd_jack *jack, int status)
-{
-}
-
-#endif
+#endif /* !CONFIG_SND_JACK || !CONFIG_SND_JACK_INPUT_DEV */
 
 #endif
diff --git a/sound/core/Kconfig b/sound/core/Kconfig
index a2a1e24becc6..6d12ca9bcb80 100644
--- a/sound/core/Kconfig
+++ b/sound/core/Kconfig
@@ -24,12 +24,15 @@ config SND_RAWMIDI
 config SND_COMPRESS_OFFLOAD
 	tristate
 
-# To be effective this also requires INPUT - users should say:
-#    select SND_JACK if INPUT=y || INPUT=SND
-# to avoid having to force INPUT on.
 config SND_JACK
 	bool
 
+# enable input device support in jack layer
+config SND_JACK_INPUT_DEV
+	bool
+	depends on SND_JACK
+	default y if INPUT=y || INPUT=SND
+
 config SND_SEQUENCER
 	tristate "Sequencer support"
 	select SND_TIMER
diff --git a/sound/core/jack.c b/sound/core/jack.c
index 7237acbdcbbc..f652e90efd7e 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -32,6 +32,7 @@ struct snd_jack_kctl {
 	unsigned int mask_bits; /* only masked status bits are reported via kctl */
 };
 
+#ifdef CONFIG_SND_JACK_INPUT_DEV
 static int jack_switch_types[SND_JACK_SWITCH_TYPES] = {
 	SW_HEADPHONE_INSERT,
 	SW_MICROPHONE_INSERT,
@@ -40,9 +41,11 @@ static int jack_switch_types[SND_JACK_SWITCH_TYPES] = {
 	SW_VIDEOOUT_INSERT,
 	SW_LINEIN_INSERT,
 };
+#endif /* CONFIG_SND_JACK_INPUT_DEV */
 
 static int snd_jack_dev_disconnect(struct snd_device *device)
 {
+#ifdef CONFIG_SND_JACK_INPUT_DEV
 	struct snd_jack *jack = device->device_data;
 
 	if (!jack->input_dev)
@@ -55,6 +58,7 @@ static int snd_jack_dev_disconnect(struct snd_device *device)
 	else
 		input_free_device(jack->input_dev);
 	jack->input_dev = NULL;
+#endif /* CONFIG_SND_JACK_INPUT_DEV */
 	return 0;
 }
 
@@ -79,6 +83,7 @@ static int snd_jack_dev_free(struct snd_device *device)
 	return 0;
 }
 
+#ifdef CONFIG_SND_JACK_INPUT_DEV
 static int snd_jack_dev_register(struct snd_device *device)
 {
 	struct snd_jack *jack = device->device_data;
@@ -116,6 +121,7 @@ static int snd_jack_dev_register(struct snd_device *device)
 
 	return err;
 }
+#endif /* CONFIG_SND_JACK_INPUT_DEV */
 
 static void snd_jack_kctl_private_free(struct snd_kcontrol *kctl)
 {
@@ -209,11 +215,12 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
 	struct snd_jack *jack;
 	struct snd_jack_kctl *jack_kctl = NULL;
 	int err;
-	int i;
 	static struct snd_device_ops ops = {
 		.dev_free = snd_jack_dev_free,
+#ifdef CONFIG_SND_JACK_INPUT_DEV
 		.dev_register = snd_jack_dev_register,
 		.dev_disconnect = snd_jack_dev_disconnect,
+#endif /* CONFIG_SND_JACK_INPUT_DEV */
 	};
 
 	if (initial_kctl) {
@@ -230,6 +237,9 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
 
 	/* don't creat input device for phantom jack */
 	if (!phantom_jack) {
+#ifdef CONFIG_SND_JACK_INPUT_DEV
+		int i;
+
 		jack->input_dev = input_allocate_device();
 		if (jack->input_dev == NULL) {
 			err = -ENOMEM;
@@ -245,6 +255,7 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
 				input_set_capability(jack->input_dev, EV_SW,
 						     jack_switch_types[i]);
 
+#endif /* CONFIG_SND_JACK_INPUT_DEV */
 	}
 
 	err = snd_device_new(card, SNDRV_DEV_JACK, jack, &ops);
@@ -262,13 +273,16 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
 	return 0;
 
 fail_input:
+#ifdef CONFIG_SND_JACK_INPUT_DEV
 	input_free_device(jack->input_dev);
+#endif
 	kfree(jack->id);
 	kfree(jack);
 	return err;
 }
 EXPORT_SYMBOL(snd_jack_new);
 
+#ifdef CONFIG_SND_JACK_INPUT_DEV
 /**
  * snd_jack_set_parent - Set the parent device for a jack
  *
@@ -326,10 +340,10 @@ int snd_jack_set_key(struct snd_jack *jack, enum snd_jack_types type,
 
 	jack->type |= type;
 	jack->key[key] = keytype;
-
 	return 0;
 }
 EXPORT_SYMBOL(snd_jack_set_key);
+#endif /* CONFIG_SND_JACK_INPUT_DEV */
 
 /**
  * snd_jack_report - Report the current status of a jack
@@ -340,7 +354,9 @@ EXPORT_SYMBOL(snd_jack_set_key);
 void snd_jack_report(struct snd_jack *jack, int status)
 {
 	struct snd_jack_kctl *jack_kctl;
+#ifdef CONFIG_SND_JACK_INPUT_DEV
 	int i;
+#endif
 
 	if (!jack)
 		return;
@@ -349,6 +365,7 @@ void snd_jack_report(struct snd_jack *jack, int status)
 		snd_kctl_jack_report(jack->card, jack_kctl->kctl,
 					    status & jack_kctl->mask_bits);
 
+#ifdef CONFIG_SND_JACK_INPUT_DEV
 	if (!jack->input_dev)
 		return;
 
@@ -369,6 +386,6 @@ void snd_jack_report(struct snd_jack *jack, int status)
 	}
 
 	input_sync(jack->input_dev);
-
+#endif /* CONFIG_SND_JACK_INPUT_DEV */
 }
 EXPORT_SYMBOL(snd_jack_report);
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
-- 
2.7.1
