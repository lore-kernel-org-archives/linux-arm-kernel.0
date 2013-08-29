From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 29 Aug 2013 17:59:32 +1000
Subject: linux-next: manual merge of the arm-soc tree with the v4l-dvb tree
Message-ID: <20130829175932.de8fe48f48a152172dd3d770@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-shmobile/setup-r8a7779.c between commit 4714a0255eee
("[media] ARM: shmobile: r8a7779: add VIN support") from the v4l-dvb tree
and commit fee529df76ff ("ARM: shmobile: r8a7779: cleanup registration of
usb phy") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-shmobile/setup-r8a7779.c
index 3d89288,6a99333..0000000
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@@ -629,24 -648,6 +675,16 @@@ void __init r8a7779_add_ether_device(st
  					  pdata, sizeof(*pdata));
  }
  
- void __init r8a7779_add_usb_phy_device(struct rcar_phy_platform_data *pdata)
- {
- 	platform_device_register_resndata(&platform_bus, "rcar_usb_phy", -1,
- 					  usb_phy_resources,
- 					  ARRAY_SIZE(usb_phy_resources),
- 					  pdata, sizeof(*pdata));
- }
- 
 +void __init r8a7779_add_vin_device(int id, struct rcar_vin_platform_data *pdata)
 +{
 +	BUG_ON(id < 0 || id > 3);
 +
 +	vin_info_table[id]->data = pdata;
 +	vin_info_table[id]->size_data = sizeof(*pdata);
 +
 +	platform_device_register_full(vin_info_table[id]);
 +}
 +
  /* do nothing for !CONFIG_SMP or !CONFIG_HAVE_TWD */
  void __init __weak r8a7779_register_twd(void) { }
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130829/10407caf/attachment.sig>
