From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 11 Jun 2013 09:40:28 -0400
Subject: [PATCH 3/3] ARM: dts: keystone: Add minimal Keystone SOC device
 tree data
In-Reply-To: <20130611093818.GA22334@e106331-lin.cambridge.arm.com>
References: <1370894123-26846-1-git-send-email-santosh.shilimkar@ti.com>
 <1370894123-26846-4-git-send-email-santosh.shilimkar@ti.com>
 <20130611093818.GA22334@e106331-lin.cambridge.arm.com>
Message-ID: <51B728CC.40907@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 11 June 2013 05:38 AM, Mark Rutland wrote:
> On Mon, Jun 10, 2013 at 08:55:23PM +0100, Santosh Shilimkar wrote:
>> Add minimal device tree data for Keystone2 based SOCs. Patch
>> contains mainly ARM related SOC data and nothing about EVM specific
>> yet.
>>
>> Cc: Grant Likely <grant.likely@linaro.org>
>> Cc: Olof Johansson <olof@lixom.net>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: arm at kernel.org
>>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>> I have seen some ongoing #include cleanups from Stephen Warren and cpu_node
>> updates from Lorenzo, but since am unaware of the dependencies, dts file is
>> aligned with the v3.10rcx ARM dts files. The changes are very trivial so
>> I can fix them quickly when they show up in linux-next. 
>>
>>  .../devicetree/bindings/arm/keystone/keystone.txt  |    9 ++
>>  arch/arm/boot/dts/keystone.dts                     |   98 ++++++++++++++++++++
>>  2 files changed, 107 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/keystone/keystone.txt
>>  create mode 100644 arch/arm/boot/dts/keystone.dts
>>
>> diff --git a/Documentation/devicetree/bindings/arm/keystone/keystone.txt b/Documentation/devicetree/bindings/arm/keystone/keystone.txt
>> new file mode 100644
>> index 0000000..b496d4c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/keystone/keystone.txt
>> @@ -0,0 +1,9 @@
>> +TI Kesytone Platforms Device Tree Bindings
>> +-----------------------------------------------
>> +
>> +Boards with Keystone2 based devices (TCI66xxK2H) SOC shall have the
>> +following properties.
>> +
>> +Required properties:
>> + - compatible: Every devices present in Keystone SOC should be in
>> +   the form "ti,keystone-*";
> 
> I'm not sure that makes sense. The GIC for example isn't a "ti,keystone-gic",
> and the uarts in the soc node don't start with "ti,keystone-" either.
>
I shouldn't have generalized it. UART are compatible with ns16550 UARTs.
Will update the documentation line in next version.
 
>> diff --git a/arch/arm/boot/dts/keystone.dts b/arch/arm/boot/dts/keystone.dts
>> new file mode 100644
>> index 0000000..9ca7d25
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/keystone.dts
>> @@ -0,0 +1,98 @@
>> +/*
>> + * Copyright 2013 Texas Instruments, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +/dts-v1/;
>> +/include/ "skeleton.dtsi"
>> +
>> +/ {
>> +	model = "Texas Instruments Keystone 2 SoC";
>> +	compatible =  "ti,keystone-evm";
>> +	#address-cells = <2>;
>> +	#size-cells = <2>;
>> +	interrupt-parent = <&gic>;
>> +
>> +	aliases {
>> +		serial0	= &uart0;
>> +	};
>> +
>> +	memory {
>> +		reg = <0x00000000 0x80000000 0x00000000 0x40000000>;
>> +	};
>> +
>> +	cpus {
>> +		interrupt-parent = <&gic>;
>> +
>> +		cpu at 0 {
>> +			compatible = "arm,cortex-a15";
>> +		};
>> +
>> +		cpu at 1 {
>> +			compatible = "arm,cortex-a15";
>> +		};
>> +
>> +		cpu at 2 {
>> +			compatible = "arm,cortex-a15";
>> +		};
>> +
>> +		cpu at 3 {
>> +			compatible = "arm,cortex-a15";
>> +		};
>> +	};
> 
> It would be nice if these matched up with what's *currently* specified in the
> cpu bindings (each cpu has it's reg and device_type set, cpus have the
> requisite #address-cells and #size cells as required by ePAPR).
> 
> All you should need is:
> 
> 	cpus {
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 
> 		interrupt-parent = <&gic>;
> 
> 		cpu at 0 {
> 			compatible = "arm,cortex-a15";
> 			device_type = "cpu";
> 			reg = <0>;
> 		};
> 
> 		cpu at 1 {
> 			compatible = "arm,cortex-a15";
> 			device_type = "cpu";
> 			reg = <1>;
> 		};
> 
> 		cpu at 2 {
> 			compatible = "arm,cortex-a15";
> 			device_type = "cpu";
> 			reg = <2>;
> 		};
> 
> 		cpu at 3 {
> 			compatible = "arm,cortex-a15";
> 			device_type = "cpu";
> 			reg = <3>;
> 		};
> 	};
> 
I did notice this as mentioned in the comments but was not sure
about the dependency. Now since you confirmed there is none, consider
above updates taken care in next version.

Regards,
Santosh
