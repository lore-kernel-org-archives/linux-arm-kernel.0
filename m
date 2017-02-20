From: xuejiancheng@hisilicon.com (Jiancheng Xue)
Date: Mon, 20 Feb 2017 17:46:23 +0800
Subject: [PATCH] arm64: dts: hisilicon: add dts files for
 hi3798cv200-poplar board
In-Reply-To: <9f2ee9e4-964a-35e8-6783-c78f7fb93a3e@suse.de>
References: <1486624027-15156-1-git-send-email-xuejiancheng@hisilicon.com>
 <9f2ee9e4-964a-35e8-6783-c78f7fb93a3e@suse.de>
Message-ID: <e6163a8a-31fc-c7af-54df-4328400db23b@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andreas,

On 2017/2/19 7:22, Andreas F?rber wrote:
> Hi Jiancheng,
> 
> Am 09.02.2017 um 08:07 schrieb Jiancheng Xue:
>> Add basic dts files for hi3798cv200-poplar board. Poplar is the
>> first development board compliant with the 96Boards Enterprise
>> Edition TV Platform specification. The board features the
>> Hi3798CV200 with an integrated quad-core 64-bit ARM Cortex A53
>> processor and high performance Mali T720 GPU.
>>
>> Signed-off-by: Jiancheng Xue <xuejiancheng@hisilicon.com>
>> Reviewed-by: Alex Elder <elder@linaro.org>
> 
> Thanks for this patch! Some comments below. Do you have instructions for
> how to test? In my tries I so far only got resets like for example:
> 
> fastboot# bootm 0x01000000 - 0x20000000
> ## Booting kernel from Legacy Image at 01000000 ...
>    Image Name:   linux-next
>    Image Type:   AArch64 Linux Kernel Image (uncompressed)
>    Data Size:    8741376 Bytes = 8.3 MiB
>    Load Address: 02000000
>    Entry Point:  02000000
> ## Flattened Device Tree blob at 20000000
>    Booting using the fdt blob at 0x20000000
>    Loading Kernel Image from 0x16777280 to 0x33554432 ... OK
> OK
> 
> Starting kernel ...
> 
> 
> *** irq: undefined instruction
> undefined instruction
> pc : [<600001d3>]          lr : [<00c661ec>]
> sp : 00bfffb8  ip : 00000036     fp : 00000000
> r10: 00000000  r9 : 00000000     r8 : 00000000
> r7 : 00000080  r6 : 005fffc4     r5 : f36e6f75  r4 : 00000000
> r3 : 0000001e  r2 : 00000100     r1 : 00000000  r0 : 00000000
> Flags: nzcv  IRQs off  FIQs off  Mode UK12_32
> Resetting CPU ...
> 
> resetting ...
> 
> Does U-Boot need to be updated for this to work?
> 
Yes. The kernel should run with the corresponding U-Boot and Trusted Firmware.
If you were using the Poplar board, I think you can't load the kernel in this way now.

>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>> index 7df79a7..7d90bf1 100644
>> --- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>> @@ -1,5 +1,9 @@
>>  Hisilicon Platforms Device Tree Bindings
>>  ----------------------------------------------------
>> +Hi3798cv200 Poplar Board
>> +Required root node properties:
>> +	- compatible = "hisilicon,hi3798cv200-poplar", "hisilicon,hi3798cv200";
>> +
> 
> Shouldn't this rather be "tocoding,poplar", "hisilicon,hi3798cv200"?
> 
Poplar was designed by HiSilicon and manufactured by Tocoding. I am not sure
what should be used here. I will discuss about this with our team. Thank you.

> linux-next.git already has Hi3660 here, so you'll need to rebase.
> 
Thanks for your information. I'll do when I prepare the new version patch.

> Also, theoretically bindings documentation should be in a separate,
> preceding patch.
> 
OK. I will seperate it from this patch.

>>  Hi4511 Board
>>  Required root node properties:
>>  	- compatible = "hisilicon,hi3620-hi4511";
>> diff --git a/arch/arm64/boot/dts/hisilicon/Makefile b/arch/arm64/boot/dts/hisilicon/Makefile
>> index c8b8f80..96202fe 100644
>> --- a/arch/arm64/boot/dts/hisilicon/Makefile
>> +++ b/arch/arm64/boot/dts/hisilicon/Makefile
>> @@ -2,6 +2,7 @@ dtb-$(CONFIG_ARCH_HISI) += hi6220-hikey.dtb
>>  dtb-$(CONFIG_ARCH_HISI) += hip05-d02.dtb
>>  dtb-$(CONFIG_ARCH_HISI) += hip06-d03.dtb
>>  dtb-$(CONFIG_ARCH_HISI) += hip07-d05.dtb
>> +dtb-$(CONFIG_ARCH_HISI) += hi3798cv200-poplar.dtb
> 
> Please keep this sorted alphabetically.
> 

You are right. Thank you.

>>  
>>  always		:= $(dtb-y)
>>  subdir-y	:= $(dts-dirs)
>> diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts b/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
>> new file mode 100644
>> index 0000000..4e2b1d1
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
>> @@ -0,0 +1,169 @@
>> +/*
>> + * DTS File for HiSilicon Poplar Development Board
>> + *
>> + * Copyright (c) 2016-2017 HiSilicon Technologies Co., Ltd.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include "hi3798cv200.dtsi"
>> +
>> +/ {
>> +	model = "HiSilicon Poplar Development Board";
> 
> Ditto: HiSilicon?
> 
Same as above mentioned. I will discuss about this with our team.

>> +	compatible = "hisilicon,hi3798cv200-poplar", "hisilicon,hi3798cv200";
>> +
>> +	aliases {
>> +		serial0 = &uart0;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +
>> +	memory {
>> +		device_type = "memory";
>> +		reg = <0x000000000 0x00000000 0x00000000 0x80000000>;
> 
> First one has one zero too much.
> 

reg = <0x0, 0x0, 0x0, 0x80000000>  ?

>> +	};
>> +
>> +	soc {
> [...]
>> +	};
>> +};
>> +
>> +&uart0 {
>> +	status = "ok";
> 
> I believe the canonical form is "okay".
> 
>> +};
>> +
>> +&uart2 {
>> +	status = "ok";
>> +	label = "LS-UART0";
>> +};
>> +/* No optional LS-UART1 on Low Speed Expansion Connector. */
>> +
>> +&i2c0 {
>> +	status = "ok";
>> +	label = "LS-I2C0";
>> +};
>> +
>> +&i2c2 {
>> +	status = "ok";
>> +	label = "LS-I2C1";
>> +};
>> +
>> +&spi0 {
>> +	status = "ok";
>> +	label = "LS-SPI0";
>> +};
>> +
>> +&gpio1 {
>> +	status = "ok";
>> +	gpio-line-names = "LS-GPIO-E",	"",
>> +			  "",		"",
>> +			  "",		"LS-GPIO-F",
>> +			  "",		"LS-GPIO-J";
>> +};
>> +
>> +&gpio2 {
>> +	status = "ok";
>> +	gpio-line-names = "LS-GPIO-H",	"LS-GPIO-I",
>> +			  "LS-GPIO-L",	"LS-GPIO-G",
>> +			  "LS-GPIO-K",	"",
>> +			  "",		"";
>> +};
>> +
>> +&gpio3 {
>> +	status = "ok";
>> +	gpio-line-names = "",		"",
>> +			  "",		"",
>> +			  "LS-GPIO-C",	"",
>> +			  "",		"LS-GPIO-B";
>> +};
>> +
>> +&gpio4 {
>> +	status = "ok";
>> +	gpio-line-names = "",		"",
>> +			  "",		"",
>> +			  "",		"LS-GPIO-D",
>> +			  "",		"";
>> +};
>> +
>> +&gpio5 {
>> +	status = "ok";
>> +	gpio-line-names = "",		"USER-LED-1",
>> +			  "USER-LED-2",	"",
>> +			  "",		"LS-GPIO-A",
>> +			  "",		"";
>> +};
>> +
>> +&gpio6 {
>> +	status = "ok";
>> +	gpio-line-names = "",		"",
>> +			  "",		"USER-LED-0",
>> +			  "",		"",
>> +			  "",		"";
>> +};
>> +
>> +&gpio10 {
>> +	status = "ok";
>> +	gpio-line-names = "",		"",
>> +			  "",		"",
>> +			  "",		"",
>> +			  "USER-LED-3",	"";
>> +};
>> +
>> +&gmac0 {
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +	phy-handle = <&eth_phy1>;
>> +	phy-mode = "rgmii";
>> +	hisilicon,phy-reset-delays-us = <10000 10000 30000>;
> 
>> +	status = "ok";
> 
> Move this to the top for consistency?
> 
>> +
>> +	eth_phy1: phy at 3{
> 
> Space before brace missing.
> 
>> +		reg = <3>;
>> +	};
>> +};
>> diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
>> new file mode 100644
>> index 0000000..ae3ce6d
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
>> @@ -0,0 +1,413 @@
>> +/*
>> + * DTS File for HiSilicon Hi3798cv200 SOC.
> 
> "SoC"?
> 
>> + *
>> + * Copyright (c) 2016-2017 HiSilicon Technologies Co., Ltd.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/clock/histb-clock.h>
>> +#include <dt-bindings/reset/ti-syscon.h>
> 
> Sort alphabetically?
> 
>> +
>> +/ {
>> +	compatible = "hisilicon,hi3798cv200";
>> +	interrupt-parent = <&gic>;
>> +	#address-cells = <2>;
>> +	#size-cells = <2>;
>> +
>> +	psci {
>> +		compatible = "arm,psci-0.2";
>> +		method = "smc";
>> +	};
>> +
>> +	cpus {
>> +		#address-cells = <2>;
>> +		#size-cells = <0>;
>> +
>> +		cpu at 0 {
>> +			compatible = "arm,cortex-a53";
>> +			device_type = "cpu";
> 
> Nit: Elsewhere I've seen device_type before compatible?
> 
I also found many examples like this. Both two ways are okay for me.
If it's not required, I'd like to keep it unchanged.

>> +			reg = <0x0 0x0>;
>> +			enable-method = "psci";
>> +		};
>> +
>> +		cpu at 1 {
>> +			compatible = "arm,cortex-a53";
>> +			device_type = "cpu";
>> +			reg = <0x0 0x1>;
>> +			enable-method = "psci";
>> +		};
>> +
>> +		cpu at 2 {
>> +			compatible = "arm,cortex-a53";
>> +			device_type = "cpu";
>> +			reg = <0x0 0x2>;
>> +			enable-method = "psci";
>> +		};
>> +
>> +		cpu at 3 {
>> +			compatible = "arm,cortex-a53";
>> +			device_type = "cpu";
>> +			reg = <0x0 0x3>;
>> +			enable-method = "psci";
>> +		};
>> +	};
>> +
>> +	gic: interrupt-controller at f1001000 {
>> +		compatible = "arm,gic-400";
>> +		reg = <0x0 0xf1001000 0x0 0x1000>,  /*GICD*/
>> +		      <0x0 0xf1002000 0x0 0x100>;   /*GICC*/
> 
> Please leave spaces inside the comments for readability.
> 
OK.

> Are you sure about the size of the second region? 

We only used this range of the registers.

> And are there really
> only two, not four? (1k, 2k, 2k, 2k elsewhere [0])
> 
GICH (Virtural interface control register) and GICV (Virtual CPU interface) were
not used. So I didn't supply them here.

> [0]
> http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/480590.html
> 
>> +		#address-cells = <0>;
> 
> Unneeded since there are no subnodes?
> 
OK.

>> +		#interrupt-cells = <3>;
>> +		interrupt-controller;
> 
> No interrupts property with PPI 9 here?
> 
I found this was required to suppport GIC virtualization extensions. I didn't
consider this feature before. I will also disscuss about this issue with our team.
Thank you.

>> +	};
>> +
>> +	timer {
>> +		compatible = "arm,armv8-timer";
>> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>> +	};
>> +
>> +	soc {
>> +		compatible = "simple-bus";
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0x0 0x00000000 0x0 0xffffffff>;
> 
> ranges = <0x0 0x0 0x00000000 0xffffffff>? (addr, parent addr, size)
> 
>> +
>> +		crg: clock-reset-controller at f8a22000 {
>> +			compatible = "hisilicon,hi3798cv200-crg", "simple-mfd";
>> +			reg = <0xf8a22000 0x1000>;
>> +			#clock-cells = <1>;
>> +			#reset-cells = <2>;
>> +
>> +			gmacphyrst: reset-controller {
>> +				compatible = "ti,syscon-reset";
>> +				reset-cells = <1>;
>> +				ti,reset-bits = <
>> +					0xcc 12 0xcc 12 0 0 (ASSERT_CLEAR|DEASSERT_SET|STATUS_NONE)  /* 0: gmac0-phy-rst */
>> +					0xcc 13 0xcc 13 0 0 (ASSERT_CLEAR|DEASSERT_SET|STATUS_NONE)  /* 1: gmac1-phy-rst */
>> +				>;
> 
> Use <>, <> tuple syntax for the two lines instead?
> 
Appreciated it.

Regards,
Jiancheng

>> +			};
>> +		};
> [snip]
> 
> Regards,
> Andreas
> 
