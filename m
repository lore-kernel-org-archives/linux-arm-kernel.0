From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 25 Jan 2017 10:14:59 +0100
Subject: [PATCH v2 0/4] Renesas CPG/MSSR Reset Control Support
Message-ID: <1485335703-27184-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi all,

This patch series adds reset control support to the Renesas Clock Pulse
Generator / Module Standby and Software Reset module, on the R-Car H3
and M3-W, RZ/G1M, and RZ/G1E SoCs.

  - Patch 1 amends the Renesas CPG/MSSR DT bindings for reset control,
  - Patches 2-4 add reset control to the Renesas CPG/MSSR driver.

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

Changes compared to v1:
  - Change oneline summary for binding update to refer to dt-bindings.
  - Add Acked-by, Reviewed-by,
  - Use variable bitmask in all reset operations, to make them more
    similar,
  - Dropped the DTS changes:
      - If CONFIG_RESET_CONTROLLER=y, they have a hard dependency on the
	driver patches (at least for USB on R-Car Gen3), so they can
	only go upstream in a later cycle,
      - The DTS changes will have to be respun anyway, to accommodate
	for changes in the DTS files between now and final upstreaming.

For your convenience, the driver and DTS changes (incl. dependencies)
are available in the topic/renesas-cpg-mssr-reset-driver-v2 resp.
topic/renesas-cpg-mssr-reset-dts-v1 branches of my topic/rcar-rst-v4
branch of my renesas-drivers git repository at
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git

This has been tested on the R-Car Gen3 Salvator-X (H3 and M3-W) and the
R-Car M2-W (using out-of-tree driver modifications) Koelsch development
boards, by inspecting device register contents before and after reset,
and by comparing them with their documented reset values.

As this modifies a Renesas clock driver, I'll queue this up in my
clk-renesas-for-v4.11 branch, and will send a pull request later this
week.  

Thanks!

Geert Uytterhoeven (4):
  dt-bindings: clock: renesas: cpg-mssr: Document reset control support
  clk: renesas: cpg-mssr: Document suitability for RZ/G1
  clk: renesas: cpg-mssr: Rename cpg_mssr_priv.mstp_lock
  clk: renesas: cpg-mssr: Add support for reset control

 .../devicetree/bindings/clock/renesas,cpg-mssr.txt |   6 +
 drivers/clk/renesas/renesas-cpg-mssr.c             | 138 ++++++++++++++++++++-
 2 files changed, 138 insertions(+), 6 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
