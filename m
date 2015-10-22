From: tony@atomide.com (Tony Lindgren)
Date: Thu, 22 Oct 2015 11:02:16 -0700
Subject: MUSB peripheral DMA regression caused by driver core runtime PM
 change
In-Reply-To: <20151021234134.GQ3078@atomide.com>
References: <20151021234134.GQ3078@atomide.com>
Message-ID: <20151022180216.GT3078@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [151021 16:44]:
> Hi all,
> 
> I noticed a regresssino in v4.3-rc series to day with MUSB gadgets
> and DMA. Doing a git bisect between v4.2..v4.3-rc1 on it pointed to:
> 
> ddef08dd00f5 ("Driver core: wakeup the parent device before trying probe")
> 
> With the commit above reverted things work fine with DMA and USB gadgets.
> 
> This is on omap3 with CONFIG_USB_INVENTRA_DMA selected. Selecting
> CONFIG_MUSB_PIO_ONLY still works even without reverting ddef08dd00f5.
> 
> Anybody got ideas what might be wrong? Some wrong runtime PM usage
> under drivers/usb/musb?

Here's some more debug info on where things are different initializing
the USB gadgets. I added some printks and diffed the dmesg output. The
added calls from commit ddef08dd00f5 start with dd:


+dd __device_attach pm_runtime_put parent 480ab000.usb_otg_hs
+dd driver_probe_device pm_runtime_get_sync parent 0-0048
 twl4030_usb 48070000.i2c:twl at 48:twl4030-usb: Initialized TWL4030 USB module
+dd driver_probe_device pm_runtime_put parent 0-0048
+dd __device_attach pm_runtime_get_sync parent 480ab000.usb_otg_hs
+dd driver_probe_device pm_runtime_get_sync parent 480ab000.usb_otg_hs
 musb musb-hdrc.0.auto _pm_runtime_get_sync
 musb musb-hdrc.0.auto _pm_runtime_get_sync
 musb-hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, bulk combine, bulk split, HB-ISO Rx, HB-ISO Tx, SoftConn)
@@ -273,11 +695,24 @@
 usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
 usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
 usb usb1: Product: MUSB HDRC host driver
-usb usb1: Manufacturer: Linux 4.3.0-rc6-00005-gb037ac9 musb-hcd
+usb usb1: Manufacturer: Linux 4.3.0-rc6-00005-g24b084c musb-hcd
 usb usb1: SerialNumber: musb-hdrc.0.auto
+dd __device_attach pm_runtime_get_sync parent musb-hdrc.0.auto
+dd driver_probe_device pm_runtime_get_sync parent musb-hdrc.0.auto
+dd __device_attach pm_runtime_get_sync parent usb1
+dd driver_probe_device pm_runtime_get_sync parent usb1
 hub 1-0:1.0: USB hub found
 hub 1-0:1.0: 1 port detected
+dd driver_probe_device pm_runtime_put parent usb1
+dd __device_attach pm_runtime_put parent usb1
+dd driver_probe_device pm_runtime_put parent musb-hdrc.0.auto
+dd __device_attach pm_runtime_put parent musb-hdrc.0.auto
 musb musb-hdrc.0.auto _pm_runtime_put
+dd driver_probe_device pm_runtime_put parent 480ab000.usb_otg_hs
+dd __device_attach pm_runtime_put parent 480ab000.usb_otg_hs
 modprobe: module 'usb_core' not found
 userial_init: registered 4 ttyGS* devices
 Mass Storage Function, version: 2009/09/11

The musb driver is using autosuspend like Felipe pointed out offline,
so maybe that's where things go wrong with commit ddef08dd00f5?

Regards,

Tony
