From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 03 Oct 2011 16:35:46 +0200
Subject: [PATCH v3] ASoC: samsung: wm8994 depends on mfd_wm8994
In-Reply-To: <20111003140824.GM3731@opensource.wolfsonmicro.com>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
	<11174515.ANsqIhx0NX@wuerfel>
	<20111003140824.GM3731@opensource.wolfsonmicro.com>
Message-ID: <1373438.oHCphrxVRr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Any driver that selects SND_SOC_WM8994 should also make sure that
MFD_WM8994 is set, since the codec relies on the mfd code:

  sound/built-in.o: In function `wm8994_read':
  last.c:(.text+0x20160): undefined reference to `wm8994_reg_read'
  sound/built-in.o: In function `wm8994_write':
  last.c:(.text+0x20e68): undefined reference to `wm8994_reg_write'

This solves the problem by selecting the MFD driver directly
and adding extra 'depends on' statements to make sure that we
respect the dependencies of that driver.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

---
On Monday 03 October 2011 15:08:24 Mark Brown wrote:
> On Mon, Oct 03, 2011 at 03:43:10PM +0200, Arnd Bergmann wrote:
> 
> > > You've not sent a seprate patch for that one yet...
> 
> > I wasn't sure any more which version you wanted. Is this this right one?
> 
> I was expecting something that selects the core.  I was also expecting
> something that can be applied against -next which this patch can't be,

I'm still confused, I thought you had NAKed the patch that selects the
core because it ignores the dependencies. Here comes another variant,
this time for your branch, and selecting the MFD driver directly while
respecting its dependencies.

> this doesn't feel like something we should be rushing into 3.1.

No, certainly not. This patch by itself helps nobody, the only reason
for doing it is to make randconfig work and that requires lots of
other patches.

	Arnd

--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -64,6 +64,8 @@ config SND_SOC_SAMSUNG_SMDK_WM8580
 config SND_SOC_SAMSUNG_SMDK_WM8994
 	tristate "SoC I2S Audio support for WM8994 on SMDK"
 	depends on SND_SOC_SAMSUNG && (MACH_SMDKV310 || MACH_SMDKC210 || MACH_SMDK4212)
+	depends on I2C=y && GENERIC_HARDIRQS
+	select MFD_WM8994
 	select SND_SOC_WM8994
 	select SND_SAMSUNG_I2S
 	help
@@ -150,7 +152,9 @@ config SND_SOC_SMARTQ
 config SND_SOC_GONI_AQUILA_WM8994
 	tristate "SoC I2S Audio support for AQUILA/GONI - WM8994"
 	depends on SND_SOC_SAMSUNG && (MACH_GONI || MACH_AQUILA)
+	depends on I2C=y && GENERIC_HARDIRQS
 	select SND_SAMSUNG_I2S
+	select MFD_WM8994
 	select SND_SOC_WM8994
 	help
 	  Say Y if you want to add support for SoC audio on goni or aquila
@@ -174,6 +178,8 @@ config SND_SOC_SMDK_WM8580_PCM
 config SND_SOC_SMDK_WM8994_PCM
 	tristate "SoC PCM Audio support for WM8994 on SMDK"
 	depends on SND_SOC_SAMSUNG && (MACH_SMDKC210 || MACH_SMDKV310 || MACH_SMDK4212)
+	depends on I2C=y && GENERIC_HARDIRQS
+	select MFD_WM8994
 	select SND_SOC_WM8994
 	select SND_SAMSUNG_PCM
 	help
