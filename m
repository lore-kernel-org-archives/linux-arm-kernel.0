From: rogershimizu@gmail.com (Roger Shimizu)
Date: Sun,  8 Jan 2017 00:04:49 +0900
Subject: [PATCH v4 0/2] make kurobox-pro be able to shutdown after device-tree
 migration
In-Reply-To: <20161227070611.14852-1-rogershimizu@gmail.com>
References: <20161227070611.14852-1-rogershimizu@gmail.com>
Message-ID: <20170107150451.17912-1-rogershimizu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Kernel Maintainers,

Kurobox-Pro (and variants) need more commands sending to UART1 to shutdown.
So here I make this patch series to let current qnap-poweroff implementation
be able to handle such case.

Here I give 3 patches, for 3 different kernel subsystems respectivelay:
  - Patch 1/3: System reset/shutdown driver
  - Patch 2/3: Open firmware and flattened device tree bindings
  - Patch 3/3: ARM/Marvell Dove/MV78xx0/Orion SOC support

Ryan Tandy, the issue reporter, and I have already tested those changes on
Linkstation/KuroBoxPro devices, and confirmed it's working well.

Merry Xmax and look forward to your feedback!

Changes:
  v0 => v1:
  - Update 0003 to split kuroboxpro related code into kuroboxpro-common.c
  v1 => v2:
  - Split off linkstation/kuroboxpro related code to linkstation-reset.c
    Because linkstation before kuroboxpro also need this driver to power
    off properly. It's more proper to call it linkstation driver.
  v2 => v3:
  - Split off devicetree bindings doc into a separate patch.
  - Add device-tree patch to make Linkstation LS-GL and KuroBox Pro to
    use the newly created linkstation-reset driver.
  - Remove the unused one-byte command sending case in linkstation-reset
    driver.
  v3 => v4:
  - Reduce the global singleton variables by moving to structure, which makes
    the driver easy to support reboot function in the future.  Thanks to
    Florian Fainelli.
  - Simplify the power_off function registration. Thanks to Florian Fainelli.
  - Drop DT binding doc.

Cheers,
Roger Shimizu, GMT +9 Tokyo
PGP/GPG: 4096R/6C6ACD6417B3ACB1

Roger Shimizu (2):
  power: reset: add linkstation-reset driver
  ARM: DT: add power-off support to linkstation lsgl and kuroboxpro

 arch/arm/boot/dts/orion5x-kuroboxpro.dts         |   8 +
 arch/arm/boot/dts/orion5x-linkstation-lsgl.dts   |  10 +
 arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts |   4 +
 arch/arm/boot/dts/orion5x-linkstation.dtsi       |   4 -
 drivers/power/reset/Kconfig                      |  10 +
 drivers/power/reset/Makefile                     |   1 +
 drivers/power/reset/linkstation-reset.c          | 270 +++++++++++++++++++++++
 7 files changed, 303 insertions(+), 4 deletions(-)
 create mode 100644 drivers/power/reset/linkstation-reset.c

-- 
2.11.0
