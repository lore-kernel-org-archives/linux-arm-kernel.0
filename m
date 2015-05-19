From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 19 May 2015 15:34:10 +0200
Subject: [RFC PATCH 0/4] Add SPI flash support for Exynos Chromebooks
Message-ID: <1432042454-19234-1-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

This is an RFC patch series to add SPI flash support for the Exynos
Chromebooks. These machines store in the flash, firmware and system
parameters such as the Google Binary Block flags that controls many
aspects of the system.

There isn't a driver for this flash memory device so the downstream
tree uses spidev to access the device from userspace (i.e: flashrom).

For example, the Google Binary Block (GBB) flags can be updated with:

# flashrom -p linux_spi:dev=/dev/spidev1.0 -r gbb.bin
# gbb_utility -s --flags=0x39 gbb.bin
# flashrom -p linux_spi:dev=/dev/spidev1.0 -w gbb.bin

I took the downstream patches and posted a while ago [0] but you said
that using compatible = "spidev" is wrong since is an implementation
detail of Linux and does not describe the hardware [1].

By looking at a recent discussion [2] and commit [3], it seems that
you agree to use spidev as long as a relevant device ID is added to
the spidev OF device table.

This is a RFC series though since I may missunderstood your comments.

The series is composed of the following patches:

Doug Anderson (1):
  ARM: dts: Add spidev registration to exynos5250-snow

Javier Martinez Canillas (2):
  spi: spidev: Add Google SPI flash compatible string
  ARM: exynos_defconfig: Enable user mode SPI device support

Simon Glass (1):
  ARM: dts: Add SPI flash node for Peach boards

 arch/arm/boot/dts/exynos5250-snow.dts      | 20 ++++++++++++++++++++
 arch/arm/boot/dts/exynos5420-peach-pit.dts | 26 ++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5800-peach-pi.dts  | 26 ++++++++++++++++++++++++++
 arch/arm/configs/exynos_defconfig          |  1 +
 drivers/spi/spidev.c                       |  1 +
 5 files changed, 74 insertions(+)

Patch #1 adds a "google,spi-flash" entry to the spidev OF ID device table.

Patch #2 and #3 add as device node for the SPI flash to the Snow and Peach
Chromebooks DTS.

Patch #4 enables support for spidev to the exynos_defconfig.

The patches have been tested on an Exynos5250 Snow and Exynos5420 Peach Pit
and #1 should go through the spi tree while #2-4 through linux-samsung tree.

Best regards,
Javier

[0]: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/303348.html
[1]: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/304256.html
[2]: https://lkml.org/lkml/2015/4/26/28
[3]: https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=956b200a846e324322f6211034c734c65a38e550
