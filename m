From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 22 Dec 2017 11:30:28 +0100
Subject: [GIT PULL] Renesas ARM Based SoC Fixes for v4.15
Message-ID: <cover.1513938447.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC fixes for v4.15.


The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes-for-v4.15

for you to fetch changes up to 7d2901f809c110bd9a261e879d59efe62e3bc758:

  arm64: dts: renesas: ulcb: Remove renesas, no-ether-link property (2017-12-22 09:39:17 +0100)

----------------------------------------------------------------
Renesas ARM Based SoC Fixes for v4.15

Vladimir Zapolskiy says:

The present change is a bug fix for AVB link iteratively up/down.

Steps to reproduce:
- start AVB TX stream (Using aplay via MSE),
- disconnect+reconnect the eth cable,
- after a reconnection the eth connection goes iteratively up/down
  without user interaction,
- this may heal after some seconds or even stay for minutes.

As the documentation specifies, the "renesas,no-ether-link" option
should be used when a board does not provide a proper AVB_LINK signal.
There is no need for this option enabled on RCAR H3/M3 Salvator-X/XS
and ULCB starter kits since the AVB_LINK is correctly handled by HW.

Choosing to keep or remove the "renesas,no-ether-link" option will
have impact on the code flow in the following ways:
- keeping this option enabled may lead to unexpected behavior since
  the RX & TX are enabled/disabled directly from adjust_link function
  without any HW interrogation,
- removing this option, the RX & TX will only be enabled/disabled after
  HW interrogation. The HW check is made through the LMON pin in PSR
  register which specifies AVB_LINK signal value (0 - at low level;
  1 - at high level).

In conclusion, the change is also a safety improvement because it
removes the "renesas,no-ether-link" option leading to a proper way
of detecting the link state based on HW interrogation and not on
software heuristic.

Note that DTS files for V3M Starter Kit, Draak and Eagle boards
contain the same property, the files are untouched due to unavailable
schematics to verify if the fix applies to these boards as well.

----------------------------------------------------------------
Bogdan Mirea (2):
      arm64: dts: renesas: salvator-x: Remove renesas, no-ether-link property
      arm64: dts: renesas: ulcb: Remove renesas, no-ether-link property

 arch/arm64/boot/dts/renesas/salvator-common.dtsi | 1 -
 arch/arm64/boot/dts/renesas/ulcb.dtsi            | 1 -
 2 files changed, 2 deletions(-)
