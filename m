From: elder@linaro.org (Alex Elder)
Date: Tue, 25 Feb 2014 18:15:40 -0600
Subject: [PATCH v2 00/12] clk: bcm281xx: updates for 3.15
Message-ID: <1393373752-30875-1-git-send-email-elder@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series includes updates for the bcm281xx clock code for 3.15.
I had held off posting this until the code on which this is based
was queued for 3.14, and it now has been:
    https://github.com/broadcom/mach-bcm/
    Branch armsoc/for-3.15/drivers
	clk: bcm281xx: don't disable unused peripheral clocks
	clk: bcm281xx: add initial clock framework support
followed by:
    (same repository)
    Branch armsoc/for-3.15/dt
	ARM: dts: bcm281xx: define real clocks

The patches in this series are available here:
    http://git.linaro.org/landing-teams/working/broadcom/kernel.git
    Branch review/bcm-clk-next-v2

I've grouped them, and offer a little explanation of each of the
groups below.

Note:  The final (DT) patch *must* be committed last.

The first version of this series had a patch from the middle of the
series that shouldn't have been there, and it has been removed in
this version (that patch affected mach-bcm, not clk).  I also split
the final patch into two, with the second one isolating the change
to a device tree file.

		    					-Alex

Alex Elder (12):
  clk: bcm281xx: warn if ccu_wait_bit() fails
  clk: bcm281xx: use init_data.name for clock name
  clk: bcm281xx: change some symbol names
       	Three small code improvements.

  clk: bcm281xx: initialize CCU structures statically
  clk: bcm281xx: define CCU clock data statically
	Rearrange the way CCUs and the clocks they provide are
	defined, so that they're defined statically to the extent
	possible rather than allocating and initializing things at
	runtime.

  clk: bcm281xx: add clock policy support
  clk: bcm281xx: add clock hysteresis support
  clk: bcm281xx: add an initialized flag
  clk: bcm281xx: implement prerequisite clocks
  clk: bcm281xx: add bus clock support
  clk: bcm281xx: define a bus clock
	Add a few new features, ultimately for the purpose of adding
	support for another type of Kona clock.  Currently only
	peripheral clocks are supported; this adds the ability to
	define and control bus clocks.  In addition, support is
	added for clocks to identify a prerequisite clock; a clock
	won't be initialized until after its prerequisite has been.

  ARM: dts: add bus clock bsc3_apb for bcm281xx
  	Add the new bus clock to the device tree.

 arch/arm/boot/dts/bcm11351.dtsi      |    3 +-
 drivers/clk/bcm/clk-bcm281xx.c       |  254 ++++++++++++--------------
 drivers/clk/bcm/clk-kona-setup.c     |  331 +++++++++++++++++++++++++++-------
 drivers/clk/bcm/clk-kona.c           |  331 ++++++++++++++++++++++++++++++++--
 drivers/clk/bcm/clk-kona.h           |  189 ++++++++++++++++---
 include/dt-bindings/clock/bcm281xx.h |    3 +-
 6 files changed, 872 insertions(+), 239 deletions(-)
-- 
1.7.9.5
