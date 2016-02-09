From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 08 Feb 2016 17:18:55 -0800
Subject: mt1873-evb: MMC failing with linux-next
Message-ID: <7hegcmadfk.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I tried getting MMC working with linux-next (next-20160208) on
mt8173-evb by enabling a few options[1] on top of the default defconfig,
and this results in a kernel that hangs as soon as it starts userspace.

The MMC driver seems to start, though has some regulator issues:

[    0.526380] sdhci: Secure Digital Host Controller Interface driver
[    0.527176] sdhci: Copyright(c) Pierre Ossman
[    0.528835] vio18: unsupportable voltage range: 3300000-1980000uV
[    0.529610] mtk-msdc 11230000.mmc: Regulator set error -22:    3300000 - 3300000
[    0.563731] mtk-msdc 11240000.mmc: Got CD GPIO
    
The driver appears to be attempting to set 3.3V but using a 1.8V
regulator (vio18), which is failing.

Then, the kernel hangs after freeing unused memory:

[    0.616386] hctosys: unable to open rtc device (rtc0)
[    0.624118] usb_vbus: disabling
[    0.624547] vusb: disabling
[    0.624929] vgp6: disabling
[    0.625635] ALSA device list:
[    0.626009]   No soundcards found.
[    0.626963] Freeing unused kernel memory: 724K (ffffffc000977000 - ffffffc000a2c000)

And nothing further here.

It boots fine when disabling the MMC driver (CONFIG_MMC_MTK=n).

Any ideas?

Kevin

[1]
CONFIG_MMC_MTK=y
CONFIG_MFD_MT6397=y
CONFIG_REGULATOR_MT6397=y
CONFIG_MTK_PMIC_WRAP=y
