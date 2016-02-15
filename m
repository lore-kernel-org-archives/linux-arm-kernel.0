From: eddie.huang@mediatek.com (Eddie Huang)
Date: Mon, 15 Feb 2016 11:52:08 +0800
Subject: mt1873-evb: MMC failing with linux-next
In-Reply-To: <7hegcmadfk.fsf@baylibre.com>
References: <7hegcmadfk.fsf@baylibre.com>
Message-ID: <1455508328.29366.14.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Mon, 2016-02-08 at 17:18 -0800, Kevin Hilman wrote:
> Hello,
> 
> I tried getting MMC working with linux-next (next-20160208) on
> mt8173-evb by enabling a few options[1] on top of the default defconfig,
> and this results in a kernel that hangs as soon as it starts userspace.
> 
> The MMC driver seems to start, though has some regulator issues:
> 
> [    0.526380] sdhci: Secure Digital Host Controller Interface driver
> [    0.527176] sdhci: Copyright(c) Pierre Ossman
> [    0.528835] vio18: unsupportable voltage range: 3300000-1980000uV
> [    0.529610] mtk-msdc 11230000.mmc: Regulator set error -22:    3300000 - 3300000
> [    0.563731] mtk-msdc 11240000.mmc: Got CD GPIO
>     
> The driver appears to be attempting to set 3.3V but using a 1.8V
> regulator (vio18), which is failing.

This message shows set 3.3V to vio18 fail. Then MMC core will set 1.8V
to vio18 again, this time should be ok.

> 
> Then, the kernel hangs after freeing unused memory:
> 
> [    0.616386] hctosys: unable to open rtc device (rtc0)
> [    0.624118] usb_vbus: disabling
> [    0.624547] vusb: disabling
> [    0.624929] vgp6: disabling
> [    0.625635] ALSA device list:
> [    0.626009]   No soundcards found.
> [    0.626963] Freeing unused kernel memory: 724K (ffffffc000977000 - ffffffc000a2c000)
> 
> And nothing further here.
> 
> It boots fine when disabling the MMC driver (CONFIG_MMC_MTK=n).
> 
> Any ideas?

MT8173-evb use MT8173 engineer sample, which has one bug that if disable
USB power domain, vcore (include mmc) power will be disabled too. MT8173
mass production chip already fix this bug. Sascha send one patch to fix
this issue [1] before. But I think it is not a good solution because if
mmc runtime suspend, vcore power will be disabled too. Please apply
following code and try again, I will send this fixup to public later.

By the way, you should set MMC_BLOCK_MINORS=32 because partition number
on eMMC is larger than default value 8.

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
b/arch/arm64/boot/dts/mediatek/mt8173-evb.d
index e427f04..7453a47 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -214,6 +214,9 @@
 };

 &pwrap {
+       /* Only MT8173 E1 needs USB power domain */
+       power-domains = <&scpsys MT8173_POWER_DOMAIN_USB>;
+
        pmic: mt6397 {
                compatible = "mediatek,mt6397";
                interrupt-parent = <&pio>;


[1]:http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/358065.html
