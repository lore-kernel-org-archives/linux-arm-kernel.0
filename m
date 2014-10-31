From: tharvey@gateworks.com (Tim Harvey)
Date: Thu, 30 Oct 2014 21:27:06 -0700
Subject: [PATCH 0/5] ARM: imx: ventana: enable LDO-bypass mode
Message-ID: <1414729631-11005-1-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IMX6 has some internal LDO regulators provided by the anatop regulator
block that can regulate the arm, soc, gpu/vpu core supplies. Alternatively a
design can supply vdd_arm and vdd_soc externally via a PMIC to provide a lower
power draw (switches are more efficient that ldo's).

The first two patches add some helper functions to the regulator core that
allow us to determine if two regulator are the same and if a regulator is
in bypass mode.

There are two patches which add device-tree support for specifying core
regulators.

The patch to the imx6q cpufreq driver is where the logic that determines if
we should bypass the LDO's and attempts to do so. I chose to place the logic
there as this the driver that is affecting changes on the core regulators.

This is a followup to an RFC I posted previously [1] and the response I
recieved from Lucas. I feel that this approach is an improvement over the
initial proposal.

Hopefully I have Cc'd the proper parties - please advise if not as I'm not
extactly clear who should be in the loop on regulator core changes.

Tim

[1] http://www.spinics.net/lists/arm-kernel/msg365686.html

Tim Harvey (5):
  regulator: add function to determine if 2 regulators are the same
  regulator: add function to determine if a regulator is in bypass mode
  ARM: dts: imx: add cpu0 alias
  cpufreq: imx6q: add ldo-bypass support
  ARM: imx: ventana: enable LDO bypass mode for GW54xx

 arch/arm/boot/dts/imx6dl.dtsi         |  2 +-
 arch/arm/boot/dts/imx6q.dtsi          |  2 +-
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 55 +++++++++++++++++++++++++----------
 drivers/cpufreq/imx6q-cpufreq.c       | 51 ++++++++++++++++++++++++++++++++
 drivers/regulator/core.c              | 40 +++++++++++++++++++++++++
 include/linux/regulator/consumer.h    | 14 +++++++++
 6 files changed, 146 insertions(+), 18 deletions(-)

-- 
1.8.3.2
