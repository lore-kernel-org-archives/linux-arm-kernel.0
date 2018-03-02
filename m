From: monstr@monstr.eu (Michal Simek)
Date: Fri, 2 Mar 2018 19:42:26 +0100
Subject: [PATCH v2 4/8] arm64: zynqmp: Add support for Xilinx zcu104-revA
In-Reply-To: <20180302180258.hex77xmptf5ab3xd@rob-hp-laptop>
References: <cover.1519396753.git.michal.simek@xilinx.com>
 <68acadbb82fb0a8ac5abb9b1e156b9a9cf5b0f11.1519396753.git.michal.simek@xilinx.com>
 <20180302180258.hex77xmptf5ab3xd@rob-hp-laptop>
Message-ID: <b73d92a9-bbe0-e4a9-c0d7-c9379ac4ad80@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2.3.2018 19:02, Rob Herring wrote:
> On Fri, Feb 23, 2018 at 03:40:26PM +0100, Michal Simek wrote:
>> Xilinx zcu104 is another customer board. It is sort of zcu102 clone
>> with some differences.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>> Changes in v2:
>> - Remove i2c mw u-boot commands
>> - Record compatible string to xilinx.txt
>>
>>  Documentation/devicetree/bindings/arm/xilinx.txt  |   3 +
>>  arch/arm64/boot/dts/xilinx/Makefile               |   1 +
>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts | 197 ++++++++++++++++++++++
>>  3 files changed, 201 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
>>
>> diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Documentation/devicetree/bindings/arm/xilinx.txt
>> index 2b922ec3c82a..a9ce08a68711 100644
>> --- a/Documentation/devicetree/bindings/arm/xilinx.txt
>> +++ b/Documentation/devicetree/bindings/arm/xilinx.txt
>> @@ -26,3 +26,6 @@ Additional compatible strings:
>>    "xlnx,zynqmp-zcu102-revA", "xlnx,zynqmp-zcu102"
>>    "xlnx,zynqmp-zcu102-revB", "xlnx,zynqmp-zcu102"
>>    "xlnx,zynqmp-zcu102-rev1.0", "xlnx,zynqmp-zcu102"
>> +
>> +- Xilinx evaluation board zcu104
>> +  "xlnx,zynqmp-zcu104-revA", "xlnx,zynqmp-zcu104"
>> diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/xilinx/Makefile
>> index 24e3ce801304..1c039e59c7c3 100644
>> --- a/arch/arm64/boot/dts/xilinx/Makefile
>> +++ b/arch/arm64/boot/dts/xilinx/Makefile
>> @@ -4,3 +4,4 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu100-revC.dtb
>>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-revA.dtb
>>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-revB.dtb
>>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-rev1.0.dtb
>> +dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu104-revA.dtb
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
>> new file mode 100644
>> index 000000000000..89d26f56514b
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
>> @@ -0,0 +1,197 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * dts file for Xilinx ZynqMP ZCU104
>> + *
>> + * (C) Copyright 2017 - 2018, Xilinx, Inc.
>> + *
>> + * Michal Simek <michal.simek@xilinx.com>
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "zynqmp.dtsi"
>> +#include "zynqmp-clk.dtsi"
>> +#include <dt-bindings/gpio/gpio.h>
>> +
>> +/ {
>> +	model = "ZynqMP ZCU104 RevA";
>> +	compatible = "xlnx,zynqmp-zcu104-revA", "xlnx,zynqmp-zcu104", "xlnx,zynqmp";
>> +
>> +	aliases {
>> +		ethernet0 = &gem3;
>> +		gpio0 = &gpio;
> 
> Drop. Not a supported alias.
> 
>> +		i2c0 = &i2c1;
>> +		mmc0 = &sdhci1;
>> +		rtc0 = &rtc;
>> +		serial0 = &uart0;
>> +		serial1 = &uart1;
>> +		serial2 = &dcc;
>> +		usb0 = &usb0;
> 
> Drop. Not a supported alias.
> 
>> +	};
>> +
>> +	chosen {
>> +		bootargs = "earlycon";
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +
>> +	memory at 0 {
>> +		device_type = "memory";
>> +		reg = <0x0 0x0 0x0 0x80000000>;
>> +	};
>> +};
>> +
>> +&can1 {
>> +	status = "okay";
>> +};
>> +
>> +&dcc {
>> +	status = "okay";
>> +};
>> +
>> +&gem3 {
>> +	status = "okay";
>> +	phy-handle = <&phy0>;
>> +	phy-mode = "rgmii-id";
>> +	phy0: phy at c {
>> +		reg = <0xc>;
>> +		ti,rx-internal-delay = <0x8>;
>> +		ti,tx-internal-delay = <0xa>;
>> +		ti,fifo-depth = <0x1>;
>> +	};
>> +};
>> +
>> +&gpio {
>> +	status = "okay";
>> +};
>> +
>> +&i2c1 {
>> +	status = "okay";
>> +	clock-frequency = <400000>;
>> +
>> +	/* Another connection to this bus via PL i2c via PCA9306 - u45 */
>> +	i2cswitch at 74 { /* u34 */
> 
> i2c-mux at 74

grrr - this was done but squashed to 5/8 instead.

Will fix.

M


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180302/e3fdaae6/attachment-0001.sig>
