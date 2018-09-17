From: bhaskar.upadhaya@nxp.com (Bhaskar Upadhaya)
Date: Mon, 17 Sep 2018 05:43:47 +0000
Subject: [PATCH] arm64: dts: Add support for NXP LS1028A SoC
In-Reply-To: <20180903015709.GC3850@dragon>
References: <1535555668-7763-1-git-send-email-sudhanshu.gupta@nxp.com>
 <20180903015709.GC3850@dragon>
Message-ID: <AM6PR04MB4407A9A699D60F0243FD7FB98C1E0@AM6PR04MB4407.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>-----Original Message-----
>From: Shawn Guo <shawnguo@kernel.org>
>Sent: Monday, September 3, 2018 7:27 AM
>To: Sudhanshu Gupta <sudhanshu.gupta@nxp.com>
>Cc: devicetree at vger.kernel.org; Harninder Rai <harninder.rai@nxp.com>;
>Bhaskar Upadhaya <bhaskar.upadhaya@nxp.com>; stuart.yoder at nxp.com;
>Leo Li <leoyang.li@nxp.com>; oss at buserror.net; linux-arm-
>kernel at lists.infradead.org
>Subject: Re: [PATCH] arm64: dts: Add support for NXP LS1028A SoC
>
>On Wed, Aug 29, 2018 at 08:44:28PM +0530, Sudhanshu Gupta wrote:
>> From: Bhaskar Upadhaya <Bhaskar.Upadhaya@nxp.com>
>>
>> LS1028A contains two ARM v8 CortexA72 processor cores with 32 KB L1-D
>> cache and 48 KB L1-I cache
>> +&i2c0 {
>> +	status = "okay";
>> +
>> +	pca9847 at 77 {
>
>Please have generic node name for the device.
is i2c-mux at 77 ok ?
>
>> +		compatible = "nxp,pca9847";
>> +		reg = <0x77>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		i2c at 2 {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			reg = <0x2>;
>> +
>> +			ina220 at 40 {
>
>Ditto
Is current-monitor at 40 ok ?
>
>> +				compatible = "ti,ina220";
>> +				reg = <0x40>;
>> +				shunt-resistor = <1000>;
>> +			};
>> +
>> +			ina220 at 41 {
>> +				compatible = "ti,ina220";
>> +				reg = <0x41>;
>> +				shunt-resistor = <1000>;
>> +			};
>> +		};
>> +
>> +		i2c at 3 {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			reg = <0x3>;
>> +
>> +			eeprom at 56 {
>> +				compatible = "atmel,24c512";
>> +				reg = <0x56>;
>> +			};
>> +
>> +			eeprom at 57 {
>> +				compatible = "atmel,24c512";
>> +				reg = <0x57>;
>> +			};
>> +
>> +			sa56004 at 4c {
>
>Ditto
Is thermal-monitor at 4c ok ?
>> +	};
>> +};
>> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
>> b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
>> new file mode 100644
>> index 0000000..e5c4309
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
>> @@ -0,0 +1,74 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Device Tree file for NXP LS1028A RDB Board.
>> + *
>> + * Copyright 2018 NXP
>> + *
>> + * Harninder Rai <harninder.rai@nxp.com>
>> + *
>> + */
>> +
>> +/dts-v1/;
>> +#include "fsl-ls1028a.dtsi"
>> +
>> +/ {
>> +	model = "LS1028A RDB Board";
>> +	compatible = "fsl,ls1028a-rdb", "fsl,ls1028a";
>> +
>> +	aliases {
>> +		serial0 = &duart0;
>> +		serial1 = &duart1;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +};
>> +
>> +	pca9847 at 77 {
>> +		compatible = "nxp,pca9847";
>> +		reg = <0x77>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		i2c at 2 {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			reg = <0x02>;
>> +
>> +			ina220 at 40 {
>> +				compatible = "ti,ina220";
>> +				reg = <0x40>;
>> +				shunt-resistor = <500>;
>> +			};
>> +		};
>> +
>> +		i2c at 3 {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			reg = <0x3>;
>> +
>> +			sa56004 at 4c {
>> +				compatible = "nxp,sa56004";
>> +				reg = <0x4c>;
>> +			};
>> +
>> +			rtc at 51 {
>> +				compatible = "nxp,pcf2129";
>> +				reg = <0x51>;
>> +			};
>> +		};
>> +	};
>> +
>> +
>> +};
>> +
>> +&duart0 {
>> +	status = "okay";
>> +};
>> +
>> +&duart1 {
>> +	status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> new file mode 100644
>> index 0000000..bc860e2
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> @@ -0,0 +1,355 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Device Tree Include file for NXP Layerscape-1028A family SoC.
>> + *
>> + * Copyright 2018 NXP
>> + *
>> + * Harninder Rai <harninder.rai@nxp.com>
>> + *
>> + */
>> +
>> +	};
>> +
>> +	sysclk: sysclk {
>
>clock-sysclk for node name might be better?
Is clock-sysclk: sysclk { ok ?
>
>> +		compatible = "fixed-clock";
>> +		#clock-cells = <0>;
>> +		clock-frequency = <100000000>;
>> +		clock-output-names = "sysclk";
>> +	};
>> +	soc: soc {
>> +		compatible = "simple-bus";
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		smmu: iommu at 5000000 {
>> +			compatible = "arm,mmu-500";
>> +			reg = <0 0x5000000 0 0x800000>;
>> +			#global-interrupts = <8>;
>> +			#iommu-cells = <1>;
>> +			stream-match-mask = <0x7C00>;
>> +			/* global secure fault */
>> +			interrupts = <0 13 4>,
>> +			/* combined secure interrupt */
>> +				     <0 14 4>,
>> +			/* global non-secure fault */
>> +				     <0 15 4>,
>> +			/* combined non-secure interrupt */
>> +				     <0 16 4>,
>> +			/* performance counter interrupts 0-7 */
>> +				     <0 211 4>, <0 212 4>,
>> +				     <0 213 4>, <0 214 4>,
>> +			/* per context interrupt, 64 interrupts */
>> +				     <0 146 4>, <0 147 4>,
>> +				     <0 148 4>, <0 149 4>,
>> +				     <0 150 4>, <0 151 4>,
>> +				     <0 152 4>, <0 153 4>,
>> +				     <0 154 4>, <0 155 4>,
>> +				     <0 156 4>, <0 157 4>,
>> +				     <0 158 4>, <0 159 4>,
>> +				     <0 160 4>, <0 161 4>,
>> +				     <0 162 4>, <0 163 4>,
>> +				     <0 164 4>, <0 165 4>,
>> +				     <0 166 4>, <0 167 4>,
>> +				     <0 168 4>, <0 169 4>,
>> +				     <0 170 4>, <0 171 4>,
>> +				     <0 172 4>, <0 173 4>,
>> +				     <0 174 4>, <0 175 4>,
>> +				     <0 176 4>, <0 177 4>,
>> +				     <0 178 4>, <0 179 4>,
>> +				     <0 180 4>, <0 181 4>,
>> +				     <0 182 4>, <0 183 4>,
>> +				     <0 184 4>, <0 185 4>,
>> +				     <0 186 4>, <0 187 4>,
>> +				     <0 188 4>, <0 189 4>,
>> +				     <0 190 4>, <0 191 4>,
>> +				     <0 192 4>, <0 193 4>,
>> +				     <0 194 4>, <0 195 4>,
>> +				     <0 196 4>, <0 197 4>,
>> +				     <0 198 4>, <0 199 4>,
>> +				     <0 200 4>, <0 201 4>,
>> +				     <0 202 4>, <0 203 4>,
>> +				     <0 204 4>, <0 205 4>,
>> +				     <0 206 4>, <0 207 4>,
>> +				     <0 208 4>, <0 209 4>;
>> +		};
>> +
>> +		ddr: memory-controller at 1080000 {
>> +			compatible = "fsl,qoriq-memory-controller";
>> +			reg = <0x0 0x1080000 0x0 0x1000>;
>> +			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
>> +			big-endian;
>> +		};
>> +
>> +		scfg: scfg at 1fc0000 {
>
>syscon is recommended by device tree spec as the node name.
Is syscon:scfg at 1fc0000 { ok ?

>
>> +			compatible = "fsl,ls1028a-scfg", "syscon";
>> +			reg = <0x0 0x1fc0000 0x0 0x10000>;
>> +			big-endian;
>> +		};
>> +
>> +		dcfg: dcfg at 1e00000 {
>
>Ditto
Is syscon:dcfg at 1e00000 { ok ?
>
>> +			compatible = "fsl,ls1028a-dcfg", "syscon";
>> +			reg = <0x0 0x1e00000 0x0 0x10000>;
>> +			big-endian;
>> +		};
>> +
>> +		clockgen: clocking at 1300000 {
>
>clock-controller is recommended by device tree spec as the node name.
Is clock-controller: clocking at 1300000 { ok ?
>> +			compatible = "fsl,ls1028a-clockgen";
>> +			reg = <0x0 0x1300000 0x0 0xa0000>;
>> +			#clock-cells = <2>;
>> +			clocks = <&sysclk>;
>> +		};
>> +
>> +
>> +		wdog0: watchdog at 23c0000 {
>> +			compatible= "arm,armv8-timer";
>
>Why does a watchdog device get a timer compatible?
>
>Shawn
Ok will remove "arm,armv8-timer" and add "fsl,ls1028a-wdt" in compatible property.
>
>> +			reg = <0x0 0x23c0000 0x0 0x10000>;
>> +			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&clockgen 4 1>;
>> +			big-endian;
>> +			status = "disabled";
>> +		};
>> +
>> +		sata: sata at 3200000 {
>> +			compatible = "fsl,ls1028a-ahci";
>> +			reg = <0x0 0x3200000 0x0 0x10000>,
>> +				<0x0 0x20140520 0x0 0x4>;
>> +			reg-names = "ahci", "sata-ecc";
>> +			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&clockgen 4 1>;
>> +			status = "disabled";
>> +		};
>> +
>> +	};
>> +};
>> +
>> --
>> 1.9.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flist
>> s.infradead.org%2Fmailman%2Flistinfo%2Flinux-arm-
>kernel&amp;data=02%7C
>>
>01%7CBhaskar.Upadhaya%40nxp.com%7Ce64045be25434453549f08d61140bc
>b0%7C6
>>
>86ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636715367139688619&amp;
>sdata
>>
>=hnyzdSymQ1J%2FUwuF2UGfKCm56%2Fh%2FFpSadxvZ3P%2FO%2Ftg%3D&a
>mp;reserved
>> =0
