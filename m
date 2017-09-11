From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 11 Sep 2017 15:09:54 +0200
Subject: [PATCH 0/5] ARM: dts: rcar-gen2: Add reset control properties
Message-ID: <1505135399-24840-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

This patch series describes the reset topology on all R-Car Gen2 Socs, like
was done before for R-Car Gen3 and RZ/G1.

Resets usually match the corresponding module clocks.  Exceptions are:
  - The audio module has resets for the Serial Sound Interfaces only,
  - The display module has only a single reset for all DU channels, but
    adding reset properties for the display is postponed upon request from
    Laurent.

Note that this patch series contains hardware description only.
Actual reset policy is to be defined and implemented separately.
Also, this is an optional feature, to be enabled explicitly using
CONFIG_RESET_CONTROLLER=y.  When enabled, an on-SoC device can be reset
easily using device_reset(), or by using the reset_control_*() API when
more fine-grained control is desired.

Possible use cases are (not exhaustive):
  - Reset a device before use, to make sure it's in a predefined state, and
    doesn't depend on earlier configuration by e.g. the boot loader,
  - Reset a device after detecting an anomaly,
  - Reset a device to verify suspend/resume is handled correctly by the
    driver in case the device would be part of a power domain on a
    different/future SoC.

This has been tested on r8a7790/lager, r8a7791/koelsch, r8a7792/blanche,
and r8a7794/alt (r8a7793/gose was offline).

Thanks for applying!

Geert Uytterhoeven (5):
  ARM: dts: r8a7790: Add reset control properties
  ARM: dts: r8a7791: Add reset control properties
  ARM: dts: r8a7792: Add reset control properties
  ARM: dts: r8a7793: Add reset control properties
  ARM: dts: r8a7794: Add reset control properties

 arch/arm/boot/dts/r8a7790.dtsi | 76 +++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7791.dtsi | 82 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7792.dtsi | 45 +++++++++++++++++++++++
 arch/arm/boot/dts/r8a7793.dtsi | 62 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7794.dtsi | 64 +++++++++++++++++++++++++++++++++
 5 files changed, 329 insertions(+)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
