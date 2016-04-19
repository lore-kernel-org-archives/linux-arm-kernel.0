From: stanislav.meduna@nxtcontrol.com (Stanislav Meduna)
Date: Tue, 19 Apr 2016 17:54:24 +0200
Subject: i.MX53 restart via watchdog does not work
In-Reply-To: <CAOMZO5DHTm2iSyGF1CcwuWxzmwbadttKmtVJQePd60A6a0jsgA@mail.gmail.com>
References: <57111429.6040802@nxtcontrol.com>
 <CAOMZO5DHTm2iSyGF1CcwuWxzmwbadttKmtVJQePd60A6a0jsgA@mail.gmail.com>
Message-ID: <571654B0.6040203@nxtcontrol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/19/2016 5:39 PM, Fabio Estevam wrote:

>> I am using an TQMa53 board, which expects to be resetted
>> by watchdog circuit. In older kernels ths was done in
>> by mxc_restart defined in arch/arm/mach-imx/system.c
>> and initialized and wired in mach-imx53.c.
>>
>> Current kernels however do not use this and the mach-imx53.c
>> does not set .restart. I am getting
>>   imx2-wdt 53f98000.wdog: Device shutdown: Expect reboot!
>>   reboot: Restarting system
>> and the system just hangs there.
> 
> I am able to reproduce this issue on a imx6ul-evk board.
> 
> It works fine on a imx6q sabresd board though.

After much head-scratching I was able to isolate the problem.
In fact it has nothing to do with the watchdog or at least
not directly. The reset is now located in the watchdog
code itself and gets called normally (which I have
overlooked when writing the original message).

The probable culprit is the eMMC card being left in some
state that the bootloader cannot handle. For now I worked
around it using the patch below (4.4-based), using a device
tree property to prevent the card from sleeping
in _mmc_suspend.

I'm not really sure what the 3.9 kernel does differently
here though...

Could you try to jump around the mmc_sleep(host)
call in _mmc_suspend to see whether it fixes the problem
also for you?

Regards
                                   Stano


commit a130df68e1c7770fa8ffc807fe40931615d2383a
Author: Stanislav Meduna <stanislav.meduna@nxtcontrol.com>
Date:   Mon Apr 18 19:19:28 2016 +0200

    mmc: disable card sleep via device-tree

    On a TQMa53 module the mmc_sleep leaves the eMMC card in a state
    that (probably) the U-Boot is unable to probe, resulting in
    reboot hanging. Add a device tree property to disable sleeping
    on suspend.

diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.txt b/Documentation/devicetree/bindings/mmc/mmc-card.txt
index a70fcd6..776a17333 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-card.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc-card.txt
@@ -12,6 +12,9 @@ Required properties:
 Optional properties:
 -broken-hpi : Use this to indicate that the mmc-card has a broken hpi
               implementation, and that hpi should not be used
+-no-sleep-on-suspend : do not put the card to sleep when suspending.
+              There are boards with bootloaders that are unable
+              to probe such card when rebooting.

 Example:

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 3d5087b..6506617 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -357,7 +357,11 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)

 	np = mmc_of_find_child_device(card->host, 0);
 	if (np && of_device_is_compatible(np, "mmc-card"))
+	{
 		broken_hpi = of_property_read_bool(np, "broken-hpi");
+		card->no_sleep_on_suspend =
+			of_property_read_bool(np, "no-sleep-on-suspend");
+	}
 	of_node_put(np);

 	/*
@@ -1824,7 +1828,7 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
 	if (mmc_can_poweroff_notify(host->card) &&
 		((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend))
 		err = mmc_poweroff_notify(host->card, notify_type);
-	else if (mmc_can_sleep(host->card))
+	else if (mmc_can_sleep(host->card) && !host->card->no_sleep_on_suspend)
 		err = mmc_sleep(host);
 	else if (!mmc_host_is_spi(host))
 		err = mmc_deselect_cards(host);
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index eb0151b..e1d275d 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -313,6 +313,7 @@ struct mmc_card {
 	struct dentry		*debugfs_root;
 	struct mmc_part	part[MMC_NUM_PHY_PARTITION]; /* physical partitions */
 	unsigned int    nr_parts;
+	bool	no_sleep_on_suspend;
 };

 /*
