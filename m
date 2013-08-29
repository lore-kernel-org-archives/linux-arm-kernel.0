From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 29 Aug 2013 17:35:07 +1000
Subject: linux-next: manual merge of the arm-soc tree with the v4l-dvb tree
Message-ID: <20130829173507.d46106011201747a12a70eaf@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-shmobile/board-bockw.c between commit 9c43952d0f1e
("[media] ARM: shmobile: BOCK-W: add VIN and ML86V7667 support") from the
v4l-dvb tree and commit bockw_init ("ARM: shmobile: r8a7778: cleanup
registration of mmcif") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-shmobile/board-bockw.c
index 35dd7f2,255e97e..0000000
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@@ -217,21 -205,7 +235,17 @@@ static void __init bockw_init(void
  	r8a7778_clock_init();
  	r8a7778_init_irq_extpin(1);
  	r8a7778_add_standard_devices();
- 	r8a7778_add_usb_phy_device(&usb_phy_platform_data);
  	r8a7778_add_ether_device(&ether_platform_data);
- 	r8a7778_add_i2c_device(0);
- 	r8a7778_add_hspi_device(0);
- 	r8a7778_add_mmc_device(&sh_mmcif_plat);
 +	r8a7778_add_vin_device(0, &vin_platform_data);
 +	/* VIN1 has a pin conflict with Ether */
 +	if (!IS_ENABLED(CONFIG_SH_ETH))
 +		r8a7778_add_vin_device(1, &vin_platform_data);
 +	platform_device_register_data(&platform_bus, "soc-camera-pdrv", 0,
 +				      &iclink0_ml86v7667,
 +				      sizeof(iclink0_ml86v7667));
 +	platform_device_register_data(&platform_bus, "soc-camera-pdrv", 1,
 +				      &iclink1_ml86v7667,
 +				      sizeof(iclink1_ml86v7667));
  
  	i2c_register_board_info(0, i2c0_devices,
  				ARRAY_SIZE(i2c0_devices));
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130829/e5e7de49/attachment.sig>
