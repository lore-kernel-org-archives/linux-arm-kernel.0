From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 13 May 2016 09:55:40 +0200
Subject: [PATCH 00/23] ARM/arm64: dts: renesas: Fix W=1 dtc warnings
Message-ID: <1463126163-29423-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus, Morimoto-san, Rob,

This patch series fixes the new warnings related to Renesas arm32/arm64
DTSes that can be seen in -next using "make W=1 dtbs", courtesy of
commit b993734718c01064 ("scripts/dtc: Update to upstream version
53bf130b1cdd") in Rob herring's for-next branch. They're all of the
form:

    Warning (unit_address_vs_reg): Node /cache-controller at 0 has a unit name, but no reg property
    Warning (unit_address_vs_reg): Node /cache-controller has a reg or ranges property, but no unit name
    Warning (unit_address_vs_reg): Node /clocks at e0110000/iic0_sclkdiv has a reg or ranges property, but no unit name
    Warning (unit_address_vs_reg): Node /i2c at 2 has a unit name, but no reg property
    Warning (unit_address_vs_reg): Node /keyboard/button at 1 has a unit name, but no reg property
    Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
    Warning (unit_address_vs_reg): Node /pfc at e0140200/serial at e1030000 has a unit name, but no reg property
    Warning (unit_address_vs_reg): Node /regulator at 0 has a unit name, but no reg property
    Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,ctu/ctu at 0 has a unit name, but no reg property
    Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,dvc/dvc at 0 has a unit name, but no reg property
    Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,mix/mix at 0 has a unit name, but no reg property
    Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,src/src at 0 has a unit name, but no reg property
    Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,ssi/ssi at 0 has a unit name, but no reg property

Fixes:
  - For cache-controllers of Cortex A7, A15, A53, and A57, I moved them
    inside the /cpus node, and made their unit names and reg properties
    match the MPIDR values,
  - For clocks, I added the missing unit names,
  - For regulators, i2c-gpios buses, and sound nodes, I (more-or-less)
    replaced the '@' by a dash,
  - For buttons, I changed the node name to match the key events,
  - For pinctrl, I changed the node name to the device name.

Note that to get rid of all warnings for the /memory node,
arch/arm/boot/dts/skeleton.dtsi should be fixed, too.

Morimoto-san: If this is accepted, the examples in
Documentation/devicetree/bindings/sound/renesas,rsnd.txt should be
updated, too.

Boot-tested on r8a73a4/ape6evm, r8a7740/armadillo, r8a7791/koelsch,
sh73a0/kzm9g, r8a7795/salvator-x. I didn't test sound, but the kernel
log didn't show any failures.

The patches are against renesas-devel-20160509-v4.6-rc7.

Thanks for your comments!

Geert Uytterhoeven (23):
  ARM: dts: emev2: Fix W=1 dtc warnings
  ARM: dts: r8a73a4: Fix W=1 dtc warnings
  ARM: dts: r8a7740: Fix W=1 dtc warnings
  ARM: dts: r8a7778: Fix W=1 dtc warnings
  ARM: dts: r8a7790: Fix W=1 dtc warnings
  ARM: dts: r8a7791: Fix W=1 dtc warnings
  ARM: dts: r8a7793: Fix W=1 dtc warnings
  ARM: dts: r8a7794: Fix W=1 dtc warnings
  ARM: dts: sh73a0: Fix W=1 dtc warnings
  ARM: dts: ape6evm: Fix W=1 dtc warnings
  ARM: dts: armadillo800eva: Fix W=1 dtc warnings
  ARM: dts: bockw: Fix W=1 dtc warnings
  ARM: dts: genmai: Fix W=1 dtc warnings
  ARM: dts: gose: Fix W=1 dtc warnings
  ARM: dts: koelsch: Fix W=1 dtc warnings
  ARM: dts: kzm9d: Fix W=1 dtc warnings
  ARM: dts: kzm9g: Fix W=1 dtc warnings
  ARM: dts: lager: Fix W=1 dtc warnings
  ARM: dts: marzen: Fix W=1 dtc warnings
  ARM: dts: porter: Fix W=1 dtc warnings
  ARM: dts: silk: Fix W=1 dtc warnings
  arm64: dts: r8a7795: Fix W=1 dtc warnings
  arm64: dts: salvator-x: Fix W=1 dtc warnings

 arch/arm/boot/dts/emev2-kzm9d.dts                  | 16 ++--
 arch/arm/boot/dts/emev2.dtsi                       | 26 +++---
 arch/arm/boot/dts/r7s72100-genmai.dts              |  2 +-
 arch/arm/boot/dts/r8a73a4-ape6evm.dts              |  8 +-
 arch/arm/boot/dts/r8a73a4.dtsi                     | 34 ++++----
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts      | 12 +--
 arch/arm/boot/dts/r8a7740.dtsi                     |  2 +-
 arch/arm/boot/dts/r8a7778-bockw.dts                |  4 +-
 arch/arm/boot/dts/r8a7778.dtsi                     | 28 +++----
 arch/arm/boot/dts/r8a7779-marzen.dts               |  4 +-
 arch/arm/boot/dts/r8a7790-lager.dts                | 20 ++---
 arch/arm/boot/dts/r8a7790.dtsi                     | 94 +++++++++++-----------
 arch/arm/boot/dts/r8a7791-koelsch.dts              | 12 +--
 arch/arm/boot/dts/r8a7791-porter.dts               |  8 +-
 arch/arm/boot/dts/r8a7791.dtsi                     | 79 +++++++++---------
 arch/arm/boot/dts/r8a7793-gose.dts                 | 12 +--
 arch/arm/boot/dts/r8a7793.dtsi                     | 59 +++++++-------
 arch/arm/boot/dts/r8a7794-silk.dts                 |  6 +-
 arch/arm/boot/dts/r8a7794.dtsi                     | 13 +--
 arch/arm/boot/dts/sh73a0-kzm9g.dts                 | 10 +--
 arch/arm/boot/dts/sh73a0.dtsi                      |  2 +-
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |  8 +-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 70 ++++++++--------
 23 files changed, 269 insertions(+), 260 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
