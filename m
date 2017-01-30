From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 30 Jan 2017 15:55:02 +0100
Subject: [PATCH 0/8] Add STM32F469 pinctrl and fix issues in STM32 pinctrl
In-Reply-To: <1485533721-9019-1-git-send-email-alexandre.torgue@st.com>
References: <1485533721-9019-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <0df054a3-a0bf-7691-4546-4710bc8f32ce@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/27/2017 05:15 PM, Alexandre TORGUE wrote:
> This series adds support of a dedicated driver for STM32F469 MCU pinctroller.
> This add generates some changes inside STM32 pinctrl driver and inside STM32
> device tree.
>
> Changes in STM32 pinctrl driver:
> -------------------------------
> 	
> 	- Add STM32F469 driver.
> 	
> 	- Change STM32 pinctrl core in order to use "gpio-ranges" devicetree definitions.
> 	  Indeed, on STM32F469 there an hole in BANK J. We need to declare a gpio-ranges
> 	  in gpioj controller node to handle this hole.
>
> Changes in STM32 device tree:
> ----------------------------
> I propose a new architecture (a new file split) for pinmux definition:
> 	
> 	- Create a common stm32f4-pinctrl.dtsi for pinmuxing definitions
> 	  which are common between STM32F429 and STM32F469 MCU.
> 	
> 	- Create dedicated stm32fxxx-pinctrl.dtsi file for each MCU
> 	  (stm32f429-pinctrl.dtsi and stm32f469-pinctrl.dtsi) each one will
> 	  include stm32f4-pinctrl.dtsi. All differences (pinmuxing or GPIO
> 	  bank holes) will be put inside the dedicated files.
>
> This series fix a locking issue when a gpio is used as IRQ.
>
> Regards
> Alex
>
> Alexandre TORGUE (8):
>   pinctrl: stm32: fix bad location of gpiochip_lock_as_irq
>   pinctrl: stm32: use gpio-ranges to declare bank range

I just see typo issue in patch 1&2. I will send a V2 when more review 
will be done.

Regards
Alex


>   Documentation: dt: Add bindings for STM32 pinctrl
>   includes: dt-bindings: Rename STM32F429 pinctrl DT bindings
>   pinctrl: stm32: Add STM32F469 MCU support
>   Documentation: dt: Add new compatible to STM32 pinctrl driver bindings
>   ARM: Kconfig: Introduce MACH_STM32F469 flag
>   ARM: dts: stm32: create dedicated files for pinctrl definitions
>
>  .../bindings/pinctrl/st,stm32-pinctrl.txt          |   57 +-
>  arch/arm/Kconfig                                   |    5 +
>  arch/arm/boot/dts/stm32429i-eval.dts               |    1 +
>  arch/arm/boot/dts/stm32f4-pinctrl.dtsi             |  196 +++
>  arch/arm/boot/dts/stm32f429-disco.dts              |    1 +
>  arch/arm/boot/dts/stm32f429-pinctrl.dtsi           |  106 ++
>  arch/arm/boot/dts/stm32f429.dtsi                   |  153 --
>  arch/arm/boot/dts/stm32f469-disco.dts              |    1 +
>  arch/arm/boot/dts/stm32f469-pinctrl.dtsi           |  107 ++
>  drivers/pinctrl/stm32/Kconfig                      |    6 +
>  drivers/pinctrl/stm32/Makefile                     |    1 +
>  drivers/pinctrl/stm32/pinctrl-stm32.c              |  129 +-
>  drivers/pinctrl/stm32/pinctrl-stm32f469.c          | 1574 ++++++++++++++++++++
>  include/dt-bindings/pinctrl/stm32f4-pinfunc.h      | 1302 ++++++++++++++++
>  include/dt-bindings/pinctrl/stm32f429-pinfunc.h    | 1239 ---------------
>  15 files changed, 3414 insertions(+), 1464 deletions(-)
>  create mode 100644 arch/arm/boot/dts/stm32f4-pinctrl.dtsi
>  create mode 100644 arch/arm/boot/dts/stm32f429-pinctrl.dtsi
>  create mode 100644 arch/arm/boot/dts/stm32f469-pinctrl.dtsi
>  create mode 100644 drivers/pinctrl/stm32/pinctrl-stm32f469.c
>  create mode 100644 include/dt-bindings/pinctrl/stm32f4-pinfunc.h
>  delete mode 100644 include/dt-bindings/pinctrl/stm32f429-pinfunc.h
>
