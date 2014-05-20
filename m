From: elder@linaro.org (Alex Elder)
Date: Tue, 20 May 2014 07:52:37 -0500
Subject: [PATCH v2 0/5] clk: bcm: prerequisite and bus clock support
Message-ID: <1400590362-11177-1-git-send-email-elder@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently only peripheral clocks are supported for Broadcom platforms
that use Kona style CCUs for clocking.  This series adds support for
bus clocks as well.

One motivation for doing this is that there exist peripheral clocks
that cannot be configured without having first enabled a related
bus clock.  Adding bus clock support allows such peripheral clocks
to be usable.

This also imposes a new requirement, however--that the bus clock
be enabled *before* the clock that depends on it.  For this, we
define the notion of a "prerequisite" clock.  If a clock has a
prerequisite specified, that prequisite clock will be initialized
first.  For now this only affects startup-time initialization.

These patches are based on Mike Turquette's current "clk-next"
branch.
    6ed8eb5 Merge tag 'clk-hisi-for-v3.16' of https://git.kern...

They are available here:
    http://git.linaro.org/landing-teams/working/broadcom/kernel.git
    Branch review/bcm-bus-clk

					-Alex

Version history:
v2: Added field "p" to the previously unnamed prereq union.

Alex Elder (5):
  clk: bcm281xx: add an initialized flag
  clk: bcm281xx: implement prerequisite clocks
  clk: bcm281xx: add bus clock support
  clk: bcm281xx: define a bus clock
  ARM: dts: add bus clock bsc3_apb for bcm281xx

 arch/arm/boot/dts/bcm11351.dtsi      |   3 +-
 drivers/clk/bcm/clk-bcm281xx.c       |  13 +++-
 drivers/clk/bcm/clk-kona-setup.c     | 112 ++++++++++++++++++++++++++++++--
 drivers/clk/bcm/clk-kona.c           | 120 ++++++++++++++++++++++++++++++++++-
 drivers/clk/bcm/clk-kona.h           |  35 +++++++++-
 include/dt-bindings/clock/bcm281xx.h |   3 +-
 6 files changed, 271 insertions(+), 15 deletions(-)

-- 
1.9.1
