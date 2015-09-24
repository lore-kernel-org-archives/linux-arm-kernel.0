From: tiwai@suse.de (Takashi Iwai)
Date: Thu, 24 Sep 2015 11:49:57 +0200
Subject: [PATCH 0/3] ALSA: hda - Avoid potential deadlock
In-Reply-To: <s5hfv258q33.wl-tiwai@suse.de>
References: <1442484006-9614-1-git-send-email-thierry.reding@gmail.com>
 <s5hfv258q33.wl-tiwai@suse.de>
Message-ID: <s5hio705epm.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 23 Sep 2015 11:03:44 +0200,
Takashi Iwai wrote:
> 
> On Thu, 17 Sep 2015 12:00:03 +0200,
> Thierry Reding wrote:
> > 
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > The Tegra HDA controller driver committed in v3.16 causes deadlocks when
> > loaded as a module. The reason is that the driver core will lock the HDA
> > controller device upon calling its probe callback and the probe callback
> > then goes on to create child devices for detected codecs and loads their
> > modules via a request_module() call. This is problematic because the new
> > driver will immediately be bound to the device, which will in turn cause
> > the parent of the codec device (the HDA controller device) to be locked
> > again, causing a deadlock.
> > 
> > This problem seems to have been present since the modularization of the
> > HD-audio driver in commit 1289e9e8b42f ("ALSA: hda - Modularize HD-audio
> > driver"). On Intel platforms this has been worked around by splitting up
> > the probe sequence into a synchronous and an asynchronous part where the
> > request_module() calls are asynchronous and hence avoid the deadlock.
> > 
> > An alternative proposal is provided in this series of patches. Rather
> > than relying on explicit request_module() calls to load kernel modules
> > for HDA codec drivers, this implements a uevent callback for the HDA bus
> > to advertises the MODALIAS information to the userspace helper.
> > 
> > Effectively this results in the same modules being loaded, but it uses
> > the more canonical infrastructure to perform this. Deferring the module
> > loading to userspace removes the need for the explicit request_module()
> > calls and works around the recursive locking issue because both drivers
> > will be bound from separate contexts.
> 
> While this looks definitely like the right direction to go, I'm afraid
> that this will give a few major regressions.  First off, there is no
> way to bind with the generic codec driver.  There are two generic
> drivers, one for HDMI/DP and one for normal audio.  Binding to them is
> judged by parsing the codec widgets whether they are digital-only.
> So, either user-space or kernel needs to parse the codec widgets
> beforehand.  If we rip off all binding magic as in your patch, this
> has to be done by udev.  With the sysfs stuff, now it should be
> possible, but this would break the existing system.
> 
> Another possible regression is the matching with the vendor-only
> alias.  Maybe the current wildcard works, but we need to double
> check.
> 
> So, unless these are addressed, I think we need another quick band-aid
> over snd-hda-tegra just doing the async probe like snd-hda-intel.

Does the patch below work?  I only did a quick compile test.


thanks,

Takashi

-- 8< --
From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda/tegra - async probe for avoiding module loading
 deadlock

The Tegra HD-audio controller driver causes deadlocks when loaded as a
module since the driver invokes request_module() at binding with the
codec driver.  This patch works around it by deferring the probe in a
work like Intel HD-audio controller driver does.  Although hovering
the codec probe stuff into udev would be a better solution, it may
cause other regressions, so let's try this band-aid fix until the more
proper solution gets landed.

Reported-by: Thierry Reding <treding@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_tegra.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index 477742cb70a2..58c0aad37284 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -73,6 +73,7 @@ struct hda_tegra {
 	struct clk *hda2codec_2x_clk;
 	struct clk *hda2hdmi_clk;
 	void __iomem *regs;
+	struct work_struct probe_work;
 };
 
 #ifdef CONFIG_PM
@@ -294,7 +295,9 @@ static int hda_tegra_dev_disconnect(struct snd_device *device)
 static int hda_tegra_dev_free(struct snd_device *device)
 {
 	struct azx *chip = device->device_data;
+	struct hda_tegra *hda = container_of(chip, struct hda_tegra, chip);
 
+	cancel_work_sync(&hda->probe_work);
 	if (azx_bus(chip)->chip_init) {
 		azx_stop_all_streams(chip);
 		azx_stop_chip(chip);
@@ -426,6 +429,9 @@ static int hda_tegra_first_init(struct azx *chip, struct platform_device *pdev)
 /*
  * constructor
  */
+
+static void hda_tegra_probe_work(struct work_struct *work);
+
 static int hda_tegra_create(struct snd_card *card,
 			    unsigned int driver_caps,
 			    struct hda_tegra *hda)
@@ -452,6 +458,8 @@ static int hda_tegra_create(struct snd_card *card,
 	chip->single_cmd = false;
 	chip->snoop = true;
 
+	INIT_WORK(&hda->probe_work, hda_tegra_probe_work);
+
 	err = azx_bus_init(chip, NULL, &hda_tegra_io_ops);
 	if (err < 0)
 		return err;
@@ -499,6 +507,21 @@ static int hda_tegra_probe(struct platform_device *pdev)
 	card->private_data = chip;
 
 	dev_set_drvdata(&pdev->dev, card);
+	schedule_work(&hda->probe_work);
+
+	return 0;
+
+out_free:
+	snd_card_free(card);
+	return err;
+}
+
+static void hda_tegra_probe_work(struct work_struct *work)
+{
+	struct hda_tegra *hda = container_of(work, struct hda_tegra, probe_work);
+	struct azx *chip = &hda->chip;
+	struct platform_device *pdev = to_platform_device(hda->dev);
+	int err;
 
 	err = hda_tegra_first_init(chip, pdev);
 	if (err < 0)
@@ -520,11 +543,8 @@ static int hda_tegra_probe(struct platform_device *pdev)
 	chip->running = 1;
 	snd_hda_set_power_save(&chip->bus, power_save * 1000);
 
-	return 0;
-
-out_free:
-	snd_card_free(card);
-	return err;
+ out_free:
+	return; /* no error return from async probe */
 }
 
 static int hda_tegra_remove(struct platform_device *pdev)
-- 
2.5.1
