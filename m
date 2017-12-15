From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 15 Dec 2017 11:44:08 +0100
Subject: [PATCH 11/12] ARM64: dts: marvell: use reworked NAND controller
 driver on Armada 7K
In-Reply-To: <87374cmghe.fsf@free-electrons.com> (Gregory CLEMENT's message of
 "Fri, 15 Dec 2017 11:29:33 +0100")
References: <20171207201814.30411-1-miquel.raynal@free-electrons.com>
 <20171207201814.30411-12-miquel.raynal@free-electrons.com>
 <87374cmghe.fsf@free-electrons.com>
Message-ID: <87r2rwl18n.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
 On ven., d?c. 15 2017, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Hi Miquel,
>  
>  On jeu., d?c. 07 2017, Miquel Raynal <miquel.raynal@free-electrons.com> wrote:
>
>> Use the new bindings of the reworked Marvell NAND controller driver.
>> Also adapt the nand controller node organization to distinguish which
>> property is relevant for the controller, and which one is NAND chip
>> specific. Expose the partitions as a subnode of the NAND chip.
>>
>> Remove the 'marvell,nand-enable-arbiter' property, not needed anymore as
>> the driver activates the arbiter by default for all boards (either
>> needed or harmless).
>>
>> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
>
> Applied on mvebu/dt64

Well I have been said that actually thess changes are not ready and that
we should wait for the driver would me merged first so I moved it on
mvebu/dt64-nand

>
> Thanks,
>
> Gregory
>
>> ---
>>  arch/arm64/boot/dts/marvell/armada-7040-db.dts     | 52 +++++++++++++---------
>>  .../boot/dts/marvell/armada-cp110-master.dtsi      |  8 ++--
>>  2 files changed, 36 insertions(+), 24 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
>> index 52b5341cb270..758452c10612 100644
>> --- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
>> +++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
>> @@ -156,36 +156,48 @@
>>  	};
>>  };
>>  
>> -&cpm_nand {
>> +&cpm_nand_controller {
>>  	/*
>>  	 * SPI on CPM and NAND have common pins on this board. We can
>> -	 * use only one at a time. To enable the NAND (whihch will
>> +	 * use only one at a time. To enable the NAND (which will
>>  	 * disable the SPI), the "status = "okay";" line have to be
>>  	 * added here.
>>  	 */
>> -	num-cs = <1>;
>>  	pinctrl-0 = <&nand_pins>, <&nand_rb>;
>>  	pinctrl-names = "default";
>> -	nand-ecc-strength = <4>;
>> -	nand-ecc-step-size = <512>;
>> -	marvell,nand-enable-arbiter;
>> -	nand-on-flash-bbt;
>> -
>> -	partition at 0 {
>> -		label = "U-Boot";
>> -		reg = <0 0x200000>;
>> -	};
>> -	partition at 200000 {
>> -		label = "Linux";
>> -		reg = <0x200000 0xe00000>;
>> -	};
>> -	partition at 1000000 {
>> -		label = "Filesystem";
>> -		reg = <0x1000000 0x3f000000>;
>> +
>> +	nand at 0 {
>> +		reg = <0>;
>> +		label = "pxa3xx_nand-0";
>> +		marvell,rb = <0>;
>> +		nand-on-flash-bbt;
>> +		nand-ecc-strength = <4>;
>> +		nand-ecc-step-size = <512>;
>> +
>> +		partitions {
>> +			compatible = "fixed-partitions";
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +
>> +			partition at 0 {
>> +				label = "U-Boot";
>> +				reg = <0 0x200000>;
>> +			};
>> +
>> +			partition at 200000 {
>> +				label = "Linux";
>> +				reg = <0x200000 0xe00000>;
>> +			};
>> +
>> +			partition at 1000000 {
>> +				label = "Filesystem";
>> +				reg = <0x1000000 0x3f000000>;
>> +			};
>> +
>> +		};
>>  	};
>>  };
>>  
>> -
>>  &cpm_spi1 {
>>  	status = "okay";
>>  
>> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
>> index e3b64d03fbd8..8a3cff9a7343 100644
>> --- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
>> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
>> @@ -309,17 +309,17 @@
>>  				status = "disabled";
>>  			};
>>  
>> -			cpm_nand: nand at 720000 {
>> +			cpm_nand_controller: nand at 720000 {
>>  				/*
>>  				 * Due to the limiation of the pin available
>>  				 * this controller is only usable on the CPM
>>  				 * for A7K and on the CPS for A8K.
>>  				 */
>> -				compatible = "marvell,armada-8k-nand",
>> -					     "marvell,armada370-nand";
>> +				compatible = "marvell,armada-8k-nand-controller",
>> +					     "marvell,armada370-nand-controller";
>>  				reg = <0x720000 0x54>;
>>  				#address-cells = <1>;
>> -				#size-cells = <1>;
>> +				#size-cells = <0>;
>>  				interrupts = <ICU_GRP_NSR 115 IRQ_TYPE_LEVEL_HIGH>;
>>  				clocks = <&cpm_clk 1 2>;
>>  				marvell,system-controller = <&cpm_syscon0>;
>> -- 
>> 2.11.0
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> -- 
> Gregory Clement, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
