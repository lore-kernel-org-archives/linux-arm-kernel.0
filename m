From: srinivas.kandagatla@st.com (srinivas.kandagatla at st.com)
Date: Mon, 3 Feb 2014 14:27:45 +0000
Subject: [PATCH v2 0/6] ARM: STi reset controller support
In-Reply-To: <1389696613-19683-1-git-send-email-srinivas.kandagatla@st.com>
References: <1389696613-19683-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <1391437665-11913-1-git-send-email-srinivas.kandagatla@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

Hi All,

This patch series adds reset controller support for STi SOC series STiH415 and
STiH416. It adds support for both power down reset and soft reset controllers.
On STi series SOCs reset lines are wired up to system configuration registers.
Most of the IPs on STi SOCs are left in reset state, so this driver is very
important for other drivers to use the IPs.

Patch 01: Adds reset controller based on system configuration registers via
regmap.

Patch 02, 03: adds STiH415 and STiH416 reset controller drivers.

Patch 04, 05: adds STiH415 and STiH416 soft reset controllers.

The final patch 06 selects reset controller in mach-sti Kconfig.

I would like get this driver in to 3.15, so that its possible to add dt
support for other IPs with reset lines. Without this patchset its impossible
to add DT support to IPs with reset lines as reset line definition is in
common header file in include/dt-bindings/.

This reset controller will be used by gmac, i2c and st-ir drivers.


Comments?

Changes since v1:
	- Added all the softreset lines.
	- rebased to v3.14-rc1.

Thanks,
srini


Srinivas Kandagatla (2):
  drivers: reset: stih415: add softreset controller
  drivers: reset: stih416: add softreset controller

Stephen Gallimore (4):
  drivers: reset: STi SoC system configuration reset controller support
  drivers: reset: Reset controller driver for STiH415
  drivers: reset: Reset controller driver for STiH416
  ARM: STi: Add reset controller support to mach-sti Kconfig

 .../devicetree/bindings/reset/st,sti-powerdown.txt |   47 +++++
 .../devicetree/bindings/reset/st,sti-softreset.txt |   46 +++++
 arch/arm/boot/dts/stih415.dtsi                     |   11 ++
 arch/arm/boot/dts/stih416.dtsi                     |   11 ++
 arch/arm/mach-sti/Kconfig                          |    3 +
 drivers/reset/Kconfig                              |    2 +
 drivers/reset/Makefile                             |    1 +
 drivers/reset/sti/Kconfig                          |   15 ++
 drivers/reset/sti/Makefile                         |    4 +
 drivers/reset/sti/reset-stih415.c                  |  112 ++++++++++++
 drivers/reset/sti/reset-stih416.c                  |  143 +++++++++++++++
 drivers/reset/sti/reset-syscfg.c                   |  186 ++++++++++++++++++++
 drivers/reset/sti/reset-syscfg.h                   |   69 ++++++++
 .../dt-bindings/reset-controller/stih415-resets.h  |   26 +++
 .../dt-bindings/reset-controller/stih416-resets.h  |   50 ++++++
 15 files changed, 726 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/st,sti-powerdown.txt
 create mode 100644 Documentation/devicetree/bindings/reset/st,sti-softreset.txt
 create mode 100644 drivers/reset/sti/Kconfig
 create mode 100644 drivers/reset/sti/Makefile
 create mode 100644 drivers/reset/sti/reset-stih415.c
 create mode 100644 drivers/reset/sti/reset-stih416.c
 create mode 100644 drivers/reset/sti/reset-syscfg.c
 create mode 100644 drivers/reset/sti/reset-syscfg.h
 create mode 100644 include/dt-bindings/reset-controller/stih415-resets.h
 create mode 100644 include/dt-bindings/reset-controller/stih416-resets.h

-- 
1.7.9.5
