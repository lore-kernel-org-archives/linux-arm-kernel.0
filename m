From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Fri, 9 Sep 2016 16:41:55 +0200
Subject: [PATCH v5 0/9] Add STM32 EXTI interrupt controller support
Message-ID: <1473432124-6784-1-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This v5 fixes bad copy/paste inside stm32exti driver (spot by Jason), and remove
GPIOLIB_IRQCHIP config for stm32 pinctrl driver (Linus).

The series adds support to EXTI interrupt controller and GPIO IRQ support in
STM32 pinctrl driver.

The STM32 external interrupt controller consists of edge detectors that
generate interrupts requests or wake-up events.

Each line can be independently configured as interrupt or wake-up source,
and triggers either on rising, fallin or both edges. Each line can also
be masked independently.

Regards 

Alex

Changes since v4:
-----------------
 - Fix bad copy/paste in stm32 exti driver
 - Remove GPIOLIB_IRQCHIP config in stm32 pinctrl driver 

Changes since v3:
-----------------
 - Review domain dealloc/free irq in stm32 pinctrl driver
 - Review domain dealloc/free irq in stm32 exti driver
 - Fix remarks on coding style

Changes since v2:
-----------------
 - Define irq_chip for GPIO banks
 - Use hierarchical domain for GPIO banks
 - Improve search loop inside stm32_exti handler 
 - Rebased on top of v4.8-rc1

Changes since v1:
-----------------
 - Rebased on top of v4.6-rc1
 - Change variable name from virq to irq (Linus W.)


Alexandre TORGUE (9):
  Documentation: dt-bindings: Document STM32 EXTI controller bindings
  drivers: irqchip: Add STM32 external interrupts support
  ARM: STM32: Select external interrupts controller
  ARM: dts: Add EXTI controller node to stm32f429
  Documentation: dt-bindings: Add IRQ related properties of STM32
    pinctrl
  pinctrl: Add IRQ support to STM32 gpios
  ARM: dts: Add GPIO irq support to STM2F429
  ARM: dts: Declare push button as GPIO key on stm32f429 boards
  ARM: config: Enable GPIO Key driver in stm32_defconfig

 .../interrupt-controller/st,stm32-exti.txt         |  20 ++
 .../bindings/pinctrl/st,stm32-pinctrl.txt          |   3 +
 arch/arm/Kconfig                                   |   1 +
 arch/arm/boot/dts/stm32429i-eval.dts               |  18 ++
 arch/arm/boot/dts/stm32f429-disco.dts              |  13 ++
 arch/arm/boot/dts/stm32f429.dtsi                   |  10 +
 arch/arm/configs/stm32_defconfig                   |   6 +-
 drivers/irqchip/Kconfig                            |   4 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-stm32-exti.c                   | 202 +++++++++++++++++++++
 drivers/pinctrl/stm32/Kconfig                      |   1 +
 drivers/pinctrl/stm32/pinctrl-stm32.c              | 163 ++++++++++++++++-
 12 files changed, 440 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
 create mode 100644 drivers/irqchip/irq-stm32-exti.c

-- 
1.9.1
