From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon,  5 Apr 2010 06:13:37 +0200
Subject: [PATCH 2/3] WM8750: Fix SPITZ machine
In-Reply-To: <1270440005-25459-1-git-send-email-marek.vasut@gmail.com>
References: <1270440005-25459-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1270440818-25790-2-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch registers the WM8750 codec on a proper place on the SPITZ machine
after the WM8750 driver was converted to new API. Moreover, the incorrect code
is hereby removed from the aSoC driver.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/spitz.c |    4 ++++
 sound/soc/pxa/spitz.c     |    7 -------
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 19b5109..58eb5e1 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -817,6 +817,10 @@ static struct i2c_board_info akita_i2c_board_info[] = {
 		.addr		= 0x18,
 		.platform_data	= &akita_ioexp,
 	},
+	{
+		.type		= "wm8750",
+		.addr		= 0x1b,
+	},
 };
 
 static void __init akita_init(void)
diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
index c4cd2ac..d256f5f 100644
--- a/sound/soc/pxa/spitz.c
+++ b/sound/soc/pxa/spitz.c
@@ -322,17 +322,10 @@ static struct snd_soc_card snd_soc_spitz = {
 	.num_links = 1,
 };
 
-/* spitz audio private data */
-static struct wm8750_setup_data spitz_wm8750_setup = {
-	.i2c_bus = 0,
-	.i2c_address = 0x1b,
-};
-
 /* spitz audio subsystem */
 static struct snd_soc_device spitz_snd_devdata = {
 	.card = &snd_soc_spitz,
 	.codec_dev = &soc_codec_dev_wm8750,
-	.codec_data = &spitz_wm8750_setup,
 };
 
 static struct platform_device *spitz_snd_device;
-- 
1.7.0
