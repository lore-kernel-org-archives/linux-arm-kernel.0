From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Thu, 27 Jul 2017 15:49:52 +0200
Subject: [PATCH v3] ARM: dts: stm32: change pinctrl bindings definition
Message-ID: <1501163393-28884-1-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initially each pin was declared in "include/dt-bindings/stm32<SOC>-pinfunc.h"
and each definition contained SOC names (ex: STM32F429_PA9_FUNC_USART1_TX).
Since this approach was approved, the number of supported MCU has
increased (STM32F429/STM32F469/STM32f746/STM32H743). To avoid to add a new
file in "include/dt-bindings" each time a new STM32 SOC arrives I propose
a new approach which consist to use a macro to define pin muxing in device
tree. All STM32 DT will use the common macro to define pinmux. Furthermore, it
will make maintenance and integration of new SOC easier.

I made only one patch to avoid dependencies. Let me know if you prefer that I
split it.

To check that patch generate same dtb than befrore I used dtc binary to (re)generate dts files
(before and after apply the series).

Example on stm32f469-disco:

./scripts/dtc/dtc -I dtb -O dts -o stm32f469-disco-after.dts
stm32f469-disco-after.dtb

./scripts/dtc/dtc -I dtb -O dts -o stm32f469-disco-before.dts
stm32f469-disco-before.dtb

Then diff -u stm32f469-disco-before.dts stm32f469-disco-after.dts

Changes since v2:
 -Drop RFC tag
 -Add reviewers
 -Enhance modifications to all STM32 (F4/F7/H7)

Changes since v1:
 -According to Vikas Manocha review, use generic macro to define port.


Regards
Alex


Alexandre Torgue (1):
  ARM: dts: stm32: change pinctrl bindings definition

 .../bindings/pinctrl/st,stm32-pinctrl.txt          |   37 +-
 arch/arm/boot/dts/stm32f429.dtsi                   |  176 +--
 arch/arm/boot/dts/stm32f746.dtsi                   |   10 +-
 arch/arm/boot/dts/stm32h743-pinctrl.dtsi           |   10 +-
 include/dt-bindings/pinctrl/stm32-pinfunc.h        |   31 +
 include/dt-bindings/pinctrl/stm32f429-pinfunc.h    | 1239 ---------------
 include/dt-bindings/pinctrl/stm32f746-pinfunc.h    | 1324 ----------------
 include/dt-bindings/pinctrl/stm32h7-pinfunc.h      | 1612 --------------------
 8 files changed, 150 insertions(+), 4289 deletions(-)
 create mode 100644 include/dt-bindings/pinctrl/stm32-pinfunc.h
 delete mode 100644 include/dt-bindings/pinctrl/stm32f429-pinfunc.h
 delete mode 100644 include/dt-bindings/pinctrl/stm32f746-pinfunc.h
 delete mode 100644 include/dt-bindings/pinctrl/stm32h7-pinfunc.h

-- 
2.7.4
