From: bjorn.forsman@gmail.com (=?UTF-8?Q?Bj=C3=B8rn_Forsman?=)
Date: Thu, 15 Dec 2011 14:09:06 +0100
Subject: Atmel AHB DMA support breaks MMC/SD card support
Message-ID: <CAEYzJUFQBPcqma2O7upzkfDAemyRcbtv2tqcScH68XK3ZR1Wzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

It seems that Atmel AHB DMA support (CONFIG_AT_HDMAC) breaks MMC/SD
card support on AT91SAM9M10-G45-EK (probably other AT91 platforms too,
but this is the only one I have). CONFIG_AT_HDMAC is set in
at91sam9g45_defconfig.

With CONFIG_AT_HDMAC (insert + remove card):
 mmc0: problem reading SD Status register.
 mmc0: error -123 whilst initialising SD card

(With more debugging I get this:
 mmc0: mmc_rescan_try_freq: trying to init card at 400000 Hz
 mmc0: problem reading SD Status register.
 mmc0: error -123 whilst initialising SD card
 mmc0: mmc_rescan_try_freq: trying to init card at 300000 Hz
 mmc0: mmc_rescan_try_freq: trying to init card at 260417 Hz
)

Without CONFIG_AT_HDMAC (works):
 mmc0: host does not support reading read-only switch. assuming write-enable.
 mmc0: new high speed SDHC card at address d396
 mmcblk0: mmc0:d396 SD16G 14.9 GiB
  mmcblk0: p1
mmc0: card d396 removed

Tested with a 16GB Kingston SDHC card.

Although I could probably do without DMA at this moment, I hope the
maintainers can look into this (and fix it :-) ). I will try to do
some git bisect in the meantime.

Best regards,
Bj?rn Forsman
