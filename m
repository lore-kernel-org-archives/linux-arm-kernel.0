From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 29 Aug 2013 17:40:34 +1000
Subject: linux-next: manual merge of the arm-soc tree with the v4l-dvb tree
Message-ID: <20130829174034.9594cef414d41a2943160ba3@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-shmobile/board-marzen.c between commit 7cef5e7fd1ab
("[media] ARM: shmobile: Marzen: add VIN and ADV7180 support") from the
v4l-dvb tree and commits 85469abe4930 ("ARM: shmobile: Remove Marzen use
of <mach/hardware.h>") and fee529df76ff ("ARM: shmobile: r8a7779: cleanup
registration of usb phy") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-shmobile/board-marzen.c
index ca7fb2e,3551b54..0000000
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@@ -38,8 -38,6 +39,7 @@@
  #include <linux/mmc/host.h>
  #include <linux/mmc/sh_mobile_sdhi.h>
  #include <linux/mfd/tmio.h>
 +#include <media/soc_camera.h>
- #include <mach/hardware.h>
  #include <mach/r8a7779.h>
  #include <mach/common.h>
  #include <mach/irqs.h>
@@@ -212,8 -203,7 +231,9 @@@ static struct platform_device *marzen_d
  	&thermal_device,
  	&hspi_device,
  	&leds_device,
 +	&camera0_device,
 +	&camera1_device,
+ 	&usb_phy,
  };
  
  static const struct pinctrl_map marzen_pinctrl_map[] = {
@@@ -274,9 -254,6 +294,8 @@@ static void __init marzen_init(void
  	r8a7779_init_irq_extpin(1); /* IRQ1 as individual interrupt */
  
  	r8a7779_add_standard_devices();
- 	r8a7779_add_usb_phy_device(&usb_phy_platform_data);
 +	r8a7779_add_vin_device(1, &vin_platform_data);
 +	r8a7779_add_vin_device(3, &vin_platform_data);
  	platform_add_devices(marzen_devices, ARRAY_SIZE(marzen_devices));
  }
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130829/d904edd6/attachment.sig>
