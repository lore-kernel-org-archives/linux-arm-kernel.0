From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 20 Feb 2012 20:47:36 +0100
Subject: [PATCH v3 0/3] MFD: twl6040: Conversion to i2c driver
In-Reply-To: <1328868018-24668-1-git-send-email-peter.ujfalusi@ti.com>
References: <1328868018-24668-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120220194736.GN5387@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Fri, Feb 10, 2012 at 12:00:15PM +0200, Peter Ujfalusi wrote:
> Hello,
> 
> Changes since v2:
> - soc/codec/Kconfig: make twl6040 depend on I2C
> - Regulator related patches has been removed (to be sent as separate series)
I applied all 3 patches. Patch #2 did not apply cleanly, due to the fact that
several struct twl4030_codec_data omap4panda.c references are not upstream
yet. This is my .rej:

--- arch/arm/mach-omap2/board-omap4panda.c
+++ arch/arm/mach-omap2/board-omap4panda.c
@@ -278,7 +279,7 @@
 	return 0;
 }
 
-static struct twl4030_codec_data twl6040_codec = {
+static struct twl6040_codec_data twl6040_codec = {
 	/* single-step ramp for headset and handsfree */
 	.hs_left_step	= 0x0f,
 	.hs_right_step	= 0x0f,
@@ -286,17 +287,14 @@
 	.hf_right_step	= 0x1d,
 };
 
-static struct twl4030_audio_data twl6040_audio = {
+static struct twl6040_platform_data twl6040_data = {
 	.codec		= &twl6040_codec,
 	.audpwron_gpio	= 127,
-	.naudint_irq	= OMAP44XX_IRQ_SYS_2N,
 	.irq_base	= TWL6040_CODEC_IRQ_BASE,
 };
 
 /* Panda board uses the common PMIC configuration */
-static struct twl4030_platform_data omap4_panda_twldata = {
-	.audio		= &twl6040_audio,
-};
+static struct twl4030_platform_data omap4_panda_twldata;

I'm not sure hwo we could handle that properly. Either by letting Tony
carrying this patchset, or by sending me the panda patch that adds those
structures. As you prefer.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
