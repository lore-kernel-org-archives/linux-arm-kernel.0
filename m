From: vikas.manocha@st.com (Vikas Manocha)
Date: Mon, 10 Apr 2017 11:40:59 -0700
Subject: [PATCH] ARM: dts: stm32f7: add STM32f769I & stm32f746 discovery
 board support
In-Reply-To: <6ea617a3-94bc-870f-dd52-a45ad45c6d26@st.com>
References: <1491613929-11485-1-git-send-email-vikas.manocha@st.com>
 <6ea617a3-94bc-870f-dd52-a45ad45c6d26@st.com>
Message-ID: <6e07ebcf-4463-523f-ea24-5a176efb0779@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Alex,

On 04/10/2017 12:23 AM, Alexandre Torgue wrote:
> Hi
> 
> On 04/08/2017 03:12 AM, Vikas Manocha wrote:
>> Stm32f769I & stm32f746 are MCUs of stm32f7 family. Here are the major
>> spces of the two boards:
>>
>> stm32f769I discovery board:
>>     - Cortex-M7 core @216MHz
>>     - 2MB mcu internal flash
>>     - 512KB internal sram
>>     - 16MB sdram memory
>>     - 64MB qspi flash memory
>>     - 4 inch wvga LCD-TFT Display
>>
>> stm32f746 discovery board:
>>     - Cortex-M7 core @216MHz
>>     - 1MB mcu internal flash
>>     - 320KB internal sram
>>     - 8MB sdram memory
>>     - 16MB qspi flash memory
>>     - 4.3 inch 480x272 LCD-TFT display
>>
>> Signed-off-by: Vikas Manocha <vikas.manocha@st.com>
>> ---
>>  arch/arm/boot/dts/Makefile            |   2 +
>>  arch/arm/boot/dts/stm32f746-disco.dts | 101 ++++++++++++++++++++++++++++++++++
>>  arch/arm/boot/dts/stm32f746.dtsi      |   2 +-
>>  arch/arm/boot/dts/stm32f769-disco.dts | 101 ++++++++++++++++++++++++++++++++++
>>  4 files changed, 205 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/arm/boot/dts/stm32f746-disco.dts
>>  create mode 100644 arch/arm/boot/dts/stm32f769-disco.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 0118084..a119f74 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -763,6 +763,8 @@ dtb-$(CONFIG_ARCH_STI) += \
>>  dtb-$(CONFIG_ARCH_STM32)+= \
>>      stm32f429-disco.dtb \
>>      stm32f469-disco.dtb \
>> +    stm32f746-disco.dtb \
>> +    stm32f769-disco.dtb \
>>      stm32429i-eval.dtb \
>>      stm32746g-eval.dtb
>>  dtb-$(CONFIG_MACH_SUN4I) += \
>> diff --git a/arch/arm/boot/dts/stm32f746-disco.dts b/arch/arm/boot/dts/stm32f746-disco.dts
>> new file mode 100644
>> index 0000000..c0e313f
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/stm32f746-disco.dts
>> @@ -0,0 +1,101 @@
>> +/*
>> + * Copyright 2017 - Vikas MANOCHA <vikas.manocha@st.com>
>> + *
>> + * This file is dual-licensed: you can use it either under the terms
>> + * of the GPL or the X11 license, at your option. Note that this dual
>> + * licensing only applies to this file, and not this project as a
>> + * whole.
>> + *
>> + *  a) This file is free software; you can redistribute it and/or
>> + *     modify it under the terms of the GNU General Public License as
>> + *     published by the Free Software Foundation; either version 2 of the
>> + *     License, or (at your option) any later version.
>> + *
>> + *     This file is distributed in the hope that it will be useful,
>> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *     GNU General Public License for more details.
>> + *
>> + * Or, alternatively,
>> + *
>> + *  b) Permission is hereby granted, free of charge, to any person
>> + *     obtaining a copy of this software and associated documentation
>> + *     files (the "Software"), to deal in the Software without
>> + *     restriction, including without limitation the rights to use,
>> + *     copy, modify, merge, publish, distribute, sublicense, and/or
>> + *     sell copies of the Software, and to permit persons to whom the
>> + *     Software is furnished to do so, subject to the following
>> + *     conditions:
>> + *
>> + *     The above copyright notice and this permission notice shall be
>> + *     included in all copies or substantial portions of the Software.
>> + *
>> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + *     OTHER DEALINGS IN THE SOFTWARE.
>> + */
>> +
>> +/dts-v1/;
>> +#include "stm32f746.dtsi"
>> +#include <dt-bindings/input/input.h>
>> +
>> +/ {
>> +    model = "STMicroelectronics STM32F746-DISCO board";
>> +    compatible = "st,stm32f746-disco", "st,stm32f746";
>> +
>> +    chosen {
>> +        bootargs = "root=/dev/ram";
>> +        stdout-path = "serial0:115200n8";
>> +    };
>> +
>> +    memory {
>> +        reg = <0xC0000000 0x800000>;
>> +    };
>> +
>> +    aliases {
>> +        serial0 = &usart1;
>> +    };
>> +
>> +};
>> +
>> +&clk_hse {
>> +    clock-frequency = <25000000>;
>> +};
>> +
>> +&pinctrl {
> 
> 
> Pin muxing is not defined in board file. Please move it into SOC dtsi file.

Pin muxing used is different for different boards. e.g. usart1_rx pad is PA10 for stm32f769-disco board while it is PB7 for stm32f746-disco board. 
The other possibilities for same pad (usart1_rx) is PB15. To make situation bit more complex, it is only available in f769 device.

Putting in SOC dtsi file means having lot of combinations for different pins in separate groups. 
e.g. only for one instance of one ip (usart1), following groups might be required at one point of time:

usart1_pa10_pa9 {..}
usart1_pa10_pb14 {..}
usart1_pa10_pb6 {..}

usart1_pb7_pa9 {..}
usart1_pb7_pb14 {..}
usart1_pb7_pb6 {..}

usart1_pb15_pa9 {..}
usart1_pb15_pb14 {..}
usart1_pb15_pb6 {..}

In case of boards based on stm32f746 device, all the above mentioned groups with pb14 & pb15 will not be available.
One solution (to avoid using not available groups) could be to have separate dtsi (or separate pinmux.dtsi) for different devices of same family like one for stm32f746 & other for stm32f769. Still it does not resolve the need to have lot of groups combinations for each instance of every peripheral in dtsi as mentioned above.

It seems cleaner solution would be pin muxing in board dts file. Please let me know if there is some drawback of this approach. One point which i can think of is : duplication of pinmux groups in different board dts files.

Cheers,
Vikas

>> +    usart1_pins: usart1 at 0    {
>> +        pins1 {
>> +            pinmux = <STM32F746_PA9_FUNC_USART1_TX>;
>> +                bias-disable;
>> +                drive-push-pull;
>> +                slew-rate = <2>;
>> +        };
>> +        pins2 {
>> +            pinmux = <STM32F746_PB7_FUNC_USART1_RX>;
>> +            bias-disable;
>> +        };
>> +    };
>> +
>> +    qspi_pins: qspi at 0 {
>> +        pins {
>> +            pinmux = <STM32F746_PB2_FUNC_QUADSPI_CLK>,
>> +                   <STM32F746_PB6_FUNC_QUADSPI_BK1_NCS>,
>> +                   <STM32F746_PD11_FUNC_QUADSPI_BK1_IO0>,
>> +                   <STM32F746_PD12_FUNC_QUADSPI_BK1_IO1>,
>> +                   <STM32F746_PD13_FUNC_QUADSPI_BK1_IO3>,
>> +                   <STM32F746_PE2_FUNC_QUADSPI_BK1_IO2>;
>> +            slew-rate = <2>;
>> +        };
>> +    };
>> +};
>> +
>> +&usart1 {
>> +    pinctrl-0 = <&usart1_pins>;
>> +    pinctrl-names = "default";
>> +    status = "okay";
>> +};
>> diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
>> index f321ffe..826700f 100644
>> --- a/arch/arm/boot/dts/stm32f746.dtsi
>> +++ b/arch/arm/boot/dts/stm32f746.dtsi
>> @@ -178,7 +178,7 @@
>>              interrupts = <1>, <2>, <3>, <6>, <7>, <8>, <9>, <10>, <23>, <40>, <41>, <42>, <62>, <76>;
>>          };
>>
>> -        pin-controller {
>> +        pinctrl: pin-controller {
>>              #address-cells = <1>;
>>              #size-cells = <1>;
>>              compatible = "st,stm32f746-pinctrl";
>> diff --git a/arch/arm/boot/dts/stm32f769-disco.dts b/arch/arm/boot/dts/stm32f769-disco.dts
>> new file mode 100644
>> index 0000000..5f8558e
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/stm32f769-disco.dts
>> @@ -0,0 +1,101 @@
>> +/*
>> + * Copyright 2017 - Vikas MANOCHA <vikas.manocha@st.com>
>> + *
>> + * This file is dual-licensed: you can use it either under the terms
>> + * of the GPL or the X11 license, at your option. Note that this dual
>> + * licensing only applies to this file, and not this project as a
>> + * whole.
>> + *
>> + *  a) This file is free software; you can redistribute it and/or
>> + *     modify it under the terms of the GNU General Public License as
>> + *     published by the Free Software Foundation; either version 2 of the
>> + *     License, or (at your option) any later version.
>> + *
>> + *     This file is distributed in the hope that it will be useful,
>> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *     GNU General Public License for more details.
>> + *
>> + * Or, alternatively,
>> + *
>> + *  b) Permission is hereby granted, free of charge, to any person
>> + *     obtaining a copy of this software and associated documentation
>> + *     files (the "Software"), to deal in the Software without
>> + *     restriction, including without limitation the rights to use,
>> + *     copy, modify, merge, publish, distribute, sublicense, and/or
>> + *     sell copies of the Software, and to permit persons to whom the
>> + *     Software is furnished to do so, subject to the following
>> + *     conditions:
>> + *
>> + *     The above copyright notice and this permission notice shall be
>> + *     included in all copies or substantial portions of the Software.
>> + *
>> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + *     OTHER DEALINGS IN THE SOFTWARE.
>> + */
>> +
>> +/dts-v1/;
>> +#include "stm32f746.dtsi"
>> +#include <dt-bindings/input/input.h>
>> +
>> +/ {
>> +    model = "STMicroelectronics STM32F769-DISCO board";
>> +    compatible = "st,stm32f769-disco", "st,stm32f7";
>> +
>> +    chosen {
>> +        bootargs = "root=/dev/ram";
>> +        stdout-path = "serial0:115200n8";
>> +    };
>> +
>> +    memory {
>> +        reg = <0xC0000000 0x1000000>;
>> +    };
>> +
>> +    aliases {
>> +        serial0 = &usart1;
>> +    };
>> +
>> +};
>> +
>> +&clk_hse {
>> +    clock-frequency = <25000000>;
>> +};
>> +
>> +&pinctrl {
> 
> same.
> 
>> +    usart1_pins: usart1 at 0    {
>> +        pins1 {
>> +            pinmux = <STM32F746_PA9_FUNC_USART1_TX>;
>> +                bias-disable;
>> +                drive-push-pull;
>> +                slew-rate = <2>;
>> +        };
>> +        pins2 {
>> +            pinmux = <STM32F746_PA10_FUNC_USART1_RX>;
>> +            bias-disable;
>> +        };
>> +    };
>> +
>> +    qspi_pins: qspi at 0 {
>> +        pins {
>> +            pinmux = <STM32F746_PB2_FUNC_QUADSPI_CLK>,
>> +                   <STM32F746_PB6_FUNC_QUADSPI_BK1_NCS>,
>> +                   <STM32F746_PC9_FUNC_QUADSPI_BK1_IO0>,
>> +                   <STM32F746_PC10_FUNC_QUADSPI_BK1_IO1>,
>> +                   <STM32F746_PD13_FUNC_QUADSPI_BK1_IO3>,
>> +                   <STM32F746_PE2_FUNC_QUADSPI_BK1_IO2>;
>> +            slew-rate = <2>;
>> +        };
>> +    };
>> +};
>> +
>> +&usart1 {
>> +    pinctrl-0 = <&usart1_pins>;
>> +    pinctrl-names = "default";
>> +    status = "okay";
>> +};
>>
> .
> 
