From: elder@linaro.org (Alex Elder)
Date: Thu, 29 May 2014 09:05:56 -0500
Subject: [PATCH v3 0/5] clk: bcm: prerequisite and bus clock support
Message-ID: <1401372361-18842-1-git-send-email-elder@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently only peripheral clocks are supported for Broadcom platforms
that use Kona style CCUs for clocking.  This series adds support for
bus clocks as well.

One motivation for doing this is that there exist peripheral clocks
that cannot be configured without having first initialized a related
bus clock.  Adding bus clock support allows such peripheral clocks
to be usable.

This also imposes a new requirement, however--that the bus clock
be initialized *before* the clock that depends on it.  For this,
we define the notion of a "prerequisite" clock.  If a clock has a
prerequisite specified, that prequisite clock will be initialized
first.  For now this only affects startup-time initialization.

These patches are based on Mike Turquette's current "clk-next"
branch.
    4c8f806 Merge branch 'clk-fixes' into clk-next

They are available here:
    http://git.linaro.org/landing-teams/working/broadcom/kernel.git
    Branch review/bcm-bus-clk-v3

					-Alex

Version history:
v3: - Deleted unused clk_lookup field from struct kona_clk
    - Now use term "initialized" rather than "enabled"
v2: - Added field "p" to the previously unnamed prereq union.


Alex Elder (5):
  clk: bcm281xx: add an initialized flag
  clk: bcm281xx: implement prerequisite clocks
  clk: bcm281xx: add bus clock support
  clk: bcm281xx: define a bus clock
  ARM: dts: add bus clock bsc3_apb for bcm281xx

 arch/arm/boot/dts/bcm11351.dtsi      |   3 +-
 drivers/clk/bcm/clk-bcm281xx.c       |  13 +++-
 drivers/clk/bcm/clk-kona-setup.c     |  96 +++++++++++++++++++++++++++-
 drivers/clk/bcm/clk-kona.c           | 120 ++++++++++++++++++++++++++++++++++-
 drivers/clk/bcm/clk-kona.h           |  34 +++++++++-
 include/dt-bindings/clock/bcm281xx.h |   3 +-
 6 files changed, 258 insertions(+), 11 deletions(-)

-- 
1.9.1
