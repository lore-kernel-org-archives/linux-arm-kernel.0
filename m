From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 9 Apr 2013 17:40:47 +1000
Subject: linux-next: manual merge of the arm-soc tree with the omap_dss2 tree
Message-ID: <20130409174047.c506479e08e9688c0a4ced9a@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-omap2/board-2430sdp.c between commit 3b4ece75b9e9 ("arm:
omap: board-2430: use generic dpi panel's gpio handling") from the
omap_dss2 tree and commit 5b6513d27775 ("ARM: OMAP: fix typo
"CONFIG_SMC91x_MODULE"") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-omap2/board-2430sdp.c
index e551aae,cb0596b..0000000
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@@ -135,7 -146,27 +135,7 @@@ static struct omap_dss_board_info sdp24
  	.default_device	= &sdp2430_lcd_device,
  };
  
- #if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91x_MODULE)
 -static void __init sdp2430_display_init(void)
 -{
 -	int r;
 -
 -	static struct gpio gpios[] __initdata = {
 -		{ SDP2430_LCD_PANEL_ENABLE_GPIO, GPIOF_OUT_INIT_LOW,
 -			"LCD reset" },
 -		{ SDP2430_LCD_PANEL_BACKLIGHT_GPIO, GPIOF_OUT_INIT_LOW,
 -			"LCD Backlight" },
 -	};
 -
 -	r = gpio_request_array(gpios, ARRAY_SIZE(gpios));
 -	if (r) {
 -		pr_err("Cannot request LCD GPIOs, error %d\n", r);
 -		return;
 -	}
 -
 -	omap_display_init(&sdp2430_dss_data);
 -}
 -
+ #if IS_ENABLED(CONFIG_SMC91X)
  
  static struct omap_smc91x_platform_data board_smc91x_data = {
  	.cs		= 5,
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130409/fc3b5762/attachment-0001.sig>
