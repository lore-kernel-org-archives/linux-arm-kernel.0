From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Tue, 26 Jul 2016 11:05:49 +0200
Subject: [PATCH v3 1/4] hwmon: iio_hwmon: delay probing with late_initcall
In-Reply-To: <10d14cc4-26f1-8f2d-2997-3b2bc323c40e@free-electrons.com>
References: <1469519027-11387-1-git-send-email-quentin.schulz@free-electrons.com>
 <209942367.uny0GxrY2s@ws-stein>
 <10d14cc4-26f1-8f2d-2997-3b2bc323c40e@free-electrons.com>
Message-ID: <5277864.qlyRKbC1Zy@ws-stein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 July 2016 10:24:48, Quentin Schulz wrote:
> On 26/07/2016 10:21, Alexander Stein wrote:
> > On Tuesday 26 July 2016 09:43:44, Quentin Schulz wrote:
> >> iio_channel_get_all returns -ENODEV when it cannot find either phandles
> >> and
> >> properties in the Device Tree or channels whose consumer_dev_name matches
> >> iio_hwmon in iio_map_list. The iio_map_list is filled in by iio drivers
> >> which might be probed after iio_hwmon.
> > 
> > Would it work if iio_channel_get_all returning ENODEV is used for
> > returning
> > EPROBE_DEFER in iio_channel_get_all? Using late initcalls for
> > driver/device
> > dependencies seems not right for me at this place.
> 
> Then what if the iio_channel_get_all is called outside of the probe of a
> driver? We'll have to change the error code, things we are apparently
> trying to avoid (see v2 patches' discussions).

Maybe I didn't express my idea enough. I don't want to change the behavior of  
iio_channel_get_all at all. Just the result evaluation of iio_channel_get_all 
in iio_hwmon_probe. I have something link the patch below in mind.

Best regards,
Alexander
---
diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
index b550ba5..e32d150 100644
--- a/drivers/hwmon/iio_hwmon.c
+++ b/drivers/hwmon/iio_hwmon.c
@@ -73,8 +73,12 @@ static int iio_hwmon_probe(struct platform_device *pdev)
                name = dev->of_node->name;
 
        channels = iio_channel_get_all(dev);
-       if (IS_ERR(channels))
-               return PTR_ERR(channels);
+       if (IS_ERR(channels)) {
+               if (PTR_ERR(channels) == -ENODEV)
+                       return -EPROBE_DEFER;
+               else
+                       return PTR_ERR(channels);
+       }
 
        st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
        if (st == NULL) {
