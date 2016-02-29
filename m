From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Mon, 29 Feb 2016 15:43:54 +0000
Subject: [PATCH 0/8] clk: bcm2835: add most missing clocks of bcm2835
Message-ID: <1456760642-2412-1-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Add a graphviz dot file containing the (currently) best known
representation of the bcm2835 clock tree.
This information has mostly been gleaned/guessed from the headerfiles
that broadcom shared for VideoCore4 at:
http://www.broadcom.com/docs/support/videocore/Brcm_Android_ICS_Graphics_Stack.tar.gz

These headers have been transformed and the extracted information
is more easily consumable at:
*  https://github.com/msperl/rpi-registers/blob/master/md/Region_A2W.md
*  https://github.com/msperl/rpi-registers/blob/master/md/Region_CM.md

Based on this information most of the missing clocks
are added in separate patches with logical grouping:
* pll-divider
* oscillator and peripherial clocks
* camera
* dsi/display
* arm
* gate clocks
* testdebug clock generator clocks

Note that the biggest possible problem can be identification of
the correct parent clocks for the relevant muxes.

The patches try to be conservative using only the "standard" pattern
(=osc clocks) where it seems a new mux is used for a specific clock(group).
It would be helpfull if someone with access to the HW documentation
can report the actual parents that are used so that the parents can get
corrected.

Having all those clocks in place should reduce the risk
that we disable another pll used by the firmware,
which can bring down the system
See: "clk: bcm2835: enable clocks that have been enabled by firmware"

Note that this patchset (except for the graphviz file)
requires at least the following patches from the new clock
initialization patch-set to be applied:
  clk: bcm2835: remove use of BCM2835_CLOCK_COUNT in driver
  clk: bcm2835: reorganize bcm2835_clock_array assignment

Martin Sperl (8):
  clk: bcm2835: documenentation: add graphiz bcm2835 clock tree
  clk: bcm2835: add missing PLL clock divider
  clk: bcm2835: add missing osc and per clocks
  clk: bcm2835: add the camera related clocks cam0, cam1 and ccp2
  clk: bcm2835: add the dsi clocks
  clk: bcm2835: add arm clock
  clk: bcm2835: add gates that require PM_DEBUG to be set
  clk: bcm2835: add the testdebug clock generators

 Documentation/clk/bcrm,bcm2835-clock-tree.dot |  350 +++++++++++++++++++++++++
 drivers/clk/bcm/clk-bcm2835.c                 |  329 ++++++++++++++++++++++-
 include/dt-bindings/clock/bcm2835.h           |   30 +++
 3 files changed, 708 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/clk/bcrm,bcm2835-clock-tree.dot

--
1.7.10.4
