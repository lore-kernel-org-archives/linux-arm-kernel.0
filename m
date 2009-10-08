From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  8 Oct 2009 09:47:22 +0200
Subject: [PATCH 6/6] pcm970 mmc: Fix ro switch
In-Reply-To: <1254988042-16737-6-git-send-email-s.hauer@pengutronix.de>
References: <1254988042-16737-1-git-send-email-s.hauer@pengutronix.de>
	<1254988042-16737-2-git-send-email-s.hauer@pengutronix.de>
	<1254988042-16737-3-git-send-email-s.hauer@pengutronix.de>
	<1254988042-16737-4-git-send-email-s.hauer@pengutronix.de>
	<1254988042-16737-5-git-send-email-s.hauer@pengutronix.de>
	<1254988042-16737-6-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1254988042-16737-7-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have to use mxc_gpio_mode() for the card detection pin
instead of mxc_gpio_setup_multiple_pins() because the latter
does a gpio_request() and thus a later gpio_request() fails.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx2/pcm970-baseboard.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx2/pcm970-baseboard.c b/arch/arm/mach-mx2/pcm970-baseboard.c
index c261f59..3cb7f45 100644
--- a/arch/arm/mach-mx2/pcm970-baseboard.c
+++ b/arch/arm/mach-mx2/pcm970-baseboard.c
@@ -39,7 +39,6 @@ static int pcm970_pins[] = {
 	PB7_PF_SD2_D3,
 	PB8_PF_SD2_CMD,
 	PB9_PF_SD2_CLK,
-	GPIO_PORTC | 28 | GPIO_GPIO | GPIO_IN, /* card detect */
 	/* display */
 	PA5_PF_LSCLK,
 	PA6_PF_LD0,
@@ -228,6 +227,7 @@ void __init pcm970_baseboard_init(void)
 			"PCM970");
 
 	mxc_register_device(&mxc_fb_device, &pcm038_fb_data);
+	mxc_gpio_mode(GPIO_PORTC | 28 | GPIO_GPIO | GPIO_IN);
 	mxc_register_device(&mxc_sdhc_device1, &sdhc_pdata);
 	platform_device_register(&pcm970_sja1000);
 }
-- 
1.6.4.3
