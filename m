From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 12 Oct 2017 16:30:19 +0200
Subject: [PATCH 3/3] arm64: dts: marvell: add NAND support on the 7040-DB
 board
In-Reply-To: <874lrqkebi.fsf@free-electrons.com> (Gregory CLEMENT's message of
 "Mon, 25 Sep 2017 17:06:41 +0200")
References: <20170925145352.13145-1-miquel.raynal@free-electrons.com>
 <20170925145352.13145-4-miquel.raynal@free-electrons.com>
 <874lrqkebi.fsf@free-electrons.com>
Message-ID: <87sheoa16s.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miquel,
 
 On lun., sept. 25 2017, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Hi Miquel,
>  
>  On lun., sept. 25 2017, Miquel Raynal <miquel.raynal@free-electrons.com> wrote:
>
>> From: Gregory CLEMENT <gregory.clement@free-electrons.com>
>>
>> The NAND controller used in A7K/A8K is present on the CP110 master part.
>> It is compatible with the pxa3xx_nand driver but requires the use of the
>> marvell,armada-8k-nand compatible string due to the need to first enable
>> the NAND controller.
>>
>> Add properties to the NAND node to fit the bindings constraints of the
>> pxa3xx_nand driver and enable the NAND controller.
>>
>> Add the 'marvell,system-controller' property to the cp110 master NAND
>> node with a reference to the syscon node. This is new compared to other
>> boards using the pxa3xx_nand driver and it is needed to be bootloader
>> independent and enable the NAND controller from the NAND controller
>> driver itself by writing in these syscon registers.
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> [miquel.raynal at free-electrons.com: add NAND ready/busy MPP subnode,
>> change compatible string to fit the needs of the A7k/A8k SoCs and add
>> the system controller property]
>> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
>> ---
>>  arch/arm64/boot/dts/marvell/armada-7040-db.dts     | 24 ++++++++++++++++++++++
>>  arch/arm64/boot/dts/marvell/armada-70x0.dtsi       | 14 +++++++++++++
>>  .../boot/dts/marvell/armada-cp110-master.dtsi      |  3 ++-
>>  3 files changed, 40 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
>> index 9c3bdf87e543..b98cf265bae5 100644
>> --- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
>> +++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
>> @@ -144,6 +144,30 @@
>>  	};
>>  };
>>  
>> +&cpm_nand {
>> +	status = "okay";
>> +	num-cs = <1>;
>> +	pinctrl-0 = <&nand_pins>, <&nand_rb>;
>> +	pinctrl-names = "default";
>> +	nand-ecc-strength = <4>;
>> +	nand-ecc-step-size = <512>;
>> +	marvell,nand-enable-arbiter;
>> +	nand-on-flash-bbt;
>> +
>> +	partition at 0 {
>> +		label = "U-Boot";
>> +		reg = <0 0x200000>;
>> +	};
>> +	partition at 200000 {
>> +		label = "Linux";
>> +		reg = <0x200000 0xe00000>;
>> +	};
>> +	partition at 1000000 {
>> +		label = "Filesystem";
>> +		reg = <0x1000000 0x3f000000>;
>> +	};
>> +};
>> +
>>  &cpm_spi1 {
>>  	status = "okay";
>>  
>> diff --git a/arch/arm64/boot/dts/marvell/armada-70x0.dtsi b/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
>> index 860b6ae9dcc5..0e1a1e5be399 100644
>> --- a/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
>> +++ b/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
>> @@ -64,5 +64,19 @@
>>  &cpm_syscon0 {
>>  	cpm_pinctrl: pinctrl {
>>  		compatible = "marvell,armada-7k-pinctrl";
>> +
>> +		nand_pins: nand-pins {
>> +			marvell,pins =
>> +			"mpp15", "mpp16", "mpp17", "mpp18",
>> +			"mpp19", "mpp20", "mpp21", "mpp22",
>> +			"mpp23", "mpp24", "mpp25", "mpp26",
>> +			"mpp27";
>> +			marvell,function = "dev";
>> +		};
>> +
>> +		nand_rb: nand-rb {
>> +			marvell,pins = "mpp13";
>> +			marvell,function = "nf";
>> +		};
>>  	};
>>  };
>> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
>> index 8263a8a504a8..d41b41b613ec 100644
>> --- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
>> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
>> @@ -274,12 +274,13 @@
>>  				 * this controller is only usable on the CPM
>>  				 * for A7K and on the CPS for A8K.
>>  				 */
>> -				compatible = "marvell,armada370-nand";
>> +				compatible = "marvell,armada-8k-nand";
>
> the controller on cp110 remains compatible with the one on Armada 370
> (even if it needs more initialization steps), so we should keep it also
> and having instead the following line:
>
> compatible = "marvell,armada-8k-nand", "marvell,armada370-nand";
>
> You don't have to send a new version, unless someone is against it, I
> will amend it when applying on the mvebu branches.


Now applied on mvebu/dt64 with the changes I mentioned,

Thanks,

Gregory


>
> Thanks,
>
> Gregory
>
>
>>  				reg = <0x720000 0x54>;
>>  				#address-cells = <1>;
>>  				#size-cells = <1>;
>>  				interrupts = <ICU_GRP_NSR 115 IRQ_TYPE_LEVEL_HIGH>;
>>  				clocks = <&cpm_clk 1 2>;
>> +				marvell,system-controller = <&cpm_syscon0>;
>>  				status = "disabled";
>>  			};
>>  
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
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
