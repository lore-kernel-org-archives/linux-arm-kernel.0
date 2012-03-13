From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 13 Mar 2012 19:28:44 +1100
Subject: linux-next: manual merge of the arm-soc tree with the sound tree
Message-ID: <20120313192844.34278a4baa0b475391191d40@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-omap2/board-omap4panda.c between commit 3c90c98a1ebb
("OMAP4: omap4panda: Enable audio support") from the sound tree and
commit 65f19159ddc4 ("ARM: OMAP: enable Bluetooth on the PandaBoard")
from the arm-soc tree.

Just context changes.  I fixed it up (see below) and can carry the fix as
necessary.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-omap2/board-omap4panda.c
index e441591,3f3055d..0000000
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@@ -92,34 -91,15 +92,40 @@@ static struct platform_device leds_gpi
  	},
  };
  
 +static struct omap_abe_twl6040_data panda_abe_audio_data = {
 +	/* Audio out */
 +	.has_hs		= ABE_TWL6040_LEFT | ABE_TWL6040_RIGHT,
 +	/* HandsFree through expasion connector */
 +	.has_hf		= ABE_TWL6040_LEFT | ABE_TWL6040_RIGHT,
 +	/* PandaBoard: FM TX, PandaBoardES: can be connected to audio out */
 +	.has_aux	= ABE_TWL6040_LEFT | ABE_TWL6040_RIGHT,
 +	/* PandaBoard: FM RX, PandaBoardES: audio in */
 +	.has_afm	= ABE_TWL6040_LEFT | ABE_TWL6040_RIGHT,
 +	/* No jack detection. */
 +	.jack_detection	= 0,
 +	/* MCLK input is 38.4MHz */
 +	.mclk_freq	= 38400000,
 +
 +};
 +
 +static struct platform_device panda_abe_audio = {
 +	.name		= "omap-abe-twl6040",
 +	.id		= -1,
 +	.dev = {
 +		.platform_data = &panda_abe_audio_data,
 +	},
 +};
 +
+ static struct platform_device btwilink_device = {
+ 	.name	= "btwilink",
+ 	.id	= -1,
+ };
+ 
  static struct platform_device *panda_devices[] __initdata = {
  	&leds_gpio,
  	&wl1271_device,
 +	&panda_abe_audio,
+ 	&btwilink_device,
  };
  
  static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120313/e7927678/attachment.sig>
