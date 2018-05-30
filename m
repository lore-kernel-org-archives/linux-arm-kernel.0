From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 30 May 2018 15:07:11 +1000
Subject: linux-next: manual merge of the regulator tree with the arm-soc tree
Message-ID: <20180530150711.2c7c1fe9@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the regulator tree got a conflict in:

  arch/arm/mach-omap1/board-ams-delta.c

between commit:

  0486738928bf ("ARM: OMAP1: ams-delta: add GPIO lookup tables")

from the arm-soc tree and commit:

  6059577cb28d ("regulator: fixed: Convert to use GPIO descriptor only")

from the regulator tree.

I fixed it up (see below - it may be better done) and can carry the fix
as necessary. This is now fixed as far as linux-next is concerned, but
any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc arch/arm/mach-omap1/board-ams-delta.c
index 80f54cb54276,759fa18f6ab4..000000000000
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@@ -203,10 -203,8 +203,10 @@@ static struct resource latch2_resources
  	},
  };
  
- #define LATCH2_LABEL	"latch2"
++#define LATCH2_LABEL	"ams-delta-latch2"
 +
  static struct bgpio_pdata latch2_pdata = {
 -	.label	= "ams-delta-latch2",
 +	.label	= LATCH2_LABEL,
  	.base	= AMS_DELTA_LATCH2_GPIO_BASE,
  	.ngpio	= AMS_DELTA_LATCH2_NGPIO,
  };
@@@ -303,6 -288,16 +302,15 @@@ static struct platform_device modem_nre
  	},
  };
  
+ static struct gpiod_lookup_table modem_nreset_gpiod_table = {
+ 	.dev_id = "reg-fixed-voltage",
+ 	.table = {
 -		/* The AMS_DELTA_GPIO_PIN_MODEM_NRESET is at offset 12 */
 -		GPIO_LOOKUP("ams-delta-latch2", 12,
++		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_MODEM_NRESET,
+ 			    "enable", GPIO_ACTIVE_HIGH),
+ 		{ },
+ 	},
+ };
+ 
  struct modem_private_data {
  	struct regulator *regulator;
  };
@@@ -658,15 -581,7 +666,15 @@@ static int __init late_init(void
  
  	platform_add_devices(late_devices, ARRAY_SIZE(late_devices));
  
 +	/*
 +	 * As soon as devices have been registered, assign their dev_names
 +	 * to respective GPIO lookup tables before they are added.
 +	 */
 +	ams_delta_lcd_gpio_table.dev_id = dev_name(&ams_delta_lcd_device.dev);
 +	ams_delta_nand_gpio_table.dev_id = dev_name(&ams_delta_nand_device.dev);
 +
 +	gpiod_add_lookup_tables(late_gpio_tables, ARRAY_SIZE(late_gpio_tables));
- 
+ 	gpiod_add_lookup_table(&modem_nreset_gpiod_table);
  	err = platform_device_register(&modem_nreset_device);
  	if (err) {
  		pr_err("Couldn't register the modem regulator device\n");
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180530/1b173abe/attachment-0001.sig>
