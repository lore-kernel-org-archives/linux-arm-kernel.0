From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 20 Jan 2017 15:08:18 +0100
Subject: [PATCH 0/8] Renesas CPG/MSSR Reset Control Support
Message-ID: <1484921306-9967-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi all,

This patch series adds reset control support to the Renesas Clock Pulse
Generator / Module Standby and Software Reset module, on the R-Car H3
and M3-W, RZ/G1M, and RZ/G1E SoCs.

  - Patch 1 amends the Renesas CPG/MSSR DT bindings for reset control,
  - Patches 2-4 add reset control to the Renesas CPG/MSSR driver,
  - Patches 5-8 add reset control properties to the R-Car H3 and M3-W,
    RZ/G1M, and RZ/G1E DTSes.

Note that this patch series implements reset functionality only.
Actual reset policy is to be defined and implemented separately.

This is an optional feature, to be enabled explicitly using
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

Dependencies and upstreaming:
  - As patches 1-4 touch a driver under drivers/clk/renesas/, I think
    it's best if they go in through a pull request to the clock
    maintainers, like other Renesas clock driver changes,
  - Patches 5-8 have no dependencies nor impact as long as
    CONFIG_RESET_CONTROLLER=n.
    However, if CONFIG_RESET_CONTROLLER=y and resets properties are
    prsesent in DTS, the EHCI and OHCI drivers already deassert reset as
    part of their initialization sequences, and put the devices back
    into reset state in case initialization failed, or on unbind.
    Hence it's best to apply the DTS patches after the driver support
    has landed upstream.  Else USB on R-Car H3 will fail to initialize
    when booting a kernel with CONFIG_RESET_CONTROLLER=y.
    I'm not aware of other relevant drivers already using reset control.

For your convenience, the driver and DTS changes (incl. dependencies) are
available in the topic/renesas-cpg-mssr-reset-driver-v1 resp.
topic/renesas-cpg-mssr-reset-dts-v1 branches of my topic/rcar-rst-v4 branch of
my renesas-drivers git repository at
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git

This has been tested on the R-Car Gen3 Salvator-X (H3 and M3-W) and the
R-Car M2-W (using out-of-tree driver modifications) Koelsch development
boards, by inspecting device register contents before and after reset,
and by comparing them with their documented reset values.

Thanks for your comments!

Geert Uytterhoeven (8):
  clk: renesas: cpg-mssr: Document reset control support
  clk: renesas: cpg-mssr: Document suitability for RZ/G1
  clk: renesas: cpg-mssr: Rename cpg_mssr_priv.mstp_lock
  clk: renesas: cpg-mssr: Add support for reset control
  arm64: dts: r8a7795: Add reset control properties
  arm64: dts: r8a7796: Add reset control properties
  ARM: dts: r8a7743: Add reset control properties
  ARM: dts: r8a7745: Add reset control properties

 .../devicetree/bindings/clock/renesas,cpg-mssr.txt |   6 +
 arch/arm/boot/dts/r8a7743.dtsi                     |  24 ++++
 arch/arm/boot/dts/r8a7745.dtsi                     |  24 ++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 103 ++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           |  34 ++++++
 drivers/clk/renesas/renesas-cpg-mssr.c             | 134 ++++++++++++++++++++-
 6 files changed, 319 insertions(+), 6 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
