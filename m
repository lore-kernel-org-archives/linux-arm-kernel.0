From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Fri, 7 Apr 2017 14:42:57 +0200
Subject: [PATCH v2 0/7] Add STM32F469 pinctrl and fix issues in STM32 pinctrl
Message-ID: <1491568984-20169-1-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support of a dedicated driver for STM32F469 MCU pinctroller.
This add generates some changes inside STM32 pinctrl driver and inside STM32
device tree.

Changes in STM32 pinctrl driver:
-------------------------------
	
	- Add STM32F469 driver.
	
	- Change STM32 pinctrl core in order to use "gpio-ranges" devicetree definitions.
	  Indeed, on STM32F469 there an hole in BANK J. We need to declare a gpio-ranges
	  in gpioj controller node to handle this hole.

Changes in STM32 device tree:
----------------------------
I propose a new architecture (a new file split) for pinmux definition:
	
	- Create a common stm32f4-pinctrl.dtsi for pinmuxing definitions
	  which are common between STM32F429 and STM32F469 MCU. 
	
	- Create dedicated stm32fxxx-pinctrl.dtsi file for each MCU
	  (stm32f429-pinctrl.dtsi and stm32f469-pinctrl.dtsi) each one will
	  include stm32f4-pinctrl.dtsi. All differences (pinmuxing or GPIO
	  bank holes) will be put inside the dedicated files.

This series fix a locking issue when a gpio is used as IRQ.

Changes since v1:
 -Rebase on 4.11-rc1.
 -Fix issues for "gpio-ranges" patch.

Regards
Alex

Alexandre TORGUE (7):
  pinctrl: stm32: add possibility to use gpio-ranges to declare bank
    range
  Documentation: dt: Remove bindings for STM32 pinctrl
  includes: dt-bindings: Rename STM32F429 pinctrl DT bindings
  pinctrl: stm32: Add STM32F469 MCU support
  Documentation: dt: Add new compatible to STM32 pinctrl driver bindings
  ARM: Kconfig: Introduce MACH_STM32F469 flag
  ARM: dts: stm32: create dedicated files for pinctrl definitions

 .../bindings/pinctrl/st,stm32-pinctrl.txt          |    3 +-
 arch/arm/Kconfig                                   |    5 +
 arch/arm/boot/dts/stm32429i-eval.dts               |    1 +
 arch/arm/boot/dts/stm32f4-pinctrl.dtsi             |  243 +++
 arch/arm/boot/dts/stm32f429-disco.dts              |    1 +
 arch/arm/boot/dts/stm32f429-pinctrl.dtsi           |   95 ++
 arch/arm/boot/dts/stm32f429.dtsi                   |  196 ---
 arch/arm/boot/dts/stm32f469-disco.dts              |    1 +
 arch/arm/boot/dts/stm32f469-pinctrl.dtsi           |   96 ++
 drivers/pinctrl/stm32/Kconfig                      |    6 +
 drivers/pinctrl/stm32/Makefile                     |    1 +
 drivers/pinctrl/stm32/pinctrl-stm32.c              |  115 +-
 drivers/pinctrl/stm32/pinctrl-stm32f469.c          | 1578 ++++++++++++++++++++
 include/dt-bindings/pinctrl/stm32f4-pinfunc.h      | 1302 ++++++++++++++++
 include/dt-bindings/pinctrl/stm32f429-pinfunc.h    | 1239 ---------------
 15 files changed, 3395 insertions(+), 1487 deletions(-)
 create mode 100644 arch/arm/boot/dts/stm32f4-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stm32f429-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stm32f469-pinctrl.dtsi
 create mode 100644 drivers/pinctrl/stm32/pinctrl-stm32f469.c
 create mode 100644 include/dt-bindings/pinctrl/stm32f4-pinfunc.h
 delete mode 100644 include/dt-bindings/pinctrl/stm32f429-pinfunc.h

-- 
1.9.1
