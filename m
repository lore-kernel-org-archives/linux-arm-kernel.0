From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 11 Mar 2015 21:08:58 +0200
Subject: [PATCHv3 34/35] ARM: dts: dra7: add system control module node
In-Reply-To: <20150311171708.GB5264@atomide.com>
References: <1424891085-10392-1-git-send-email-t-kristo@ti.com>
 <1424891085-10392-35-git-send-email-t-kristo@ti.com>
 <20150311171708.GB5264@atomide.com>
Message-ID: <550092CA.9030008@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/2015 07:17 PM, Tony Lindgren wrote:
> Hi Tero,
>
> * Tero Kristo <t-kristo@ti.com> [150225 11:09]:
>> Add node for system control module, and move all the existing system
>> control IO space users under this new node as its children. A new node
>> for scm_conf area is also added.
> ...
>
>> --- a/arch/arm/boot/dts/dra7.dtsi
>> +++ b/arch/arm/boot/dts/dra7.dtsi
>> @@ -203,26 +203,47 @@
>>   			};
>>   		};
>>
>> +		scm: scm at 4a002000 {
>> +			compatible = "ti,dra7-ctrl", "simple-bus";
>> +			reg = <0x4a002000 0x1400>,
>> +			      <0x4a003400 0x600>,
>> +			      <0x4ae0c000 0x600>;
>> +			#address-cells = <2>;
>> +			#size-cells = <1>;
>> +			ranges = <0 0 0x4a002000 0x1400>,
>> +				 <1 0 0x4a003400 0x600>,
>> +				 <2 0 0x4ae0c000 0x600>;
>> +
>> +			scm_conf: tisyscon at 0,0 {
>> +				compatible = "syscon";
>> +				reg = <0 0x0 0x1400>;
>> +				#address-cells = <1>;
>> +				#size-cells = <1>;
>> +			};
>> +
>> +			dra7_pmx_core: pinmux at 1,0 {
>> +				compatible = "ti,dra7-padconf",
>> +					     "pinctrl-single";
>> +				reg = <1 0x0 0x0464>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				#interrupt-cells = <1>;
>> +				interrupt-controller;
>> +				pinctrl-single,register-width = <32>;
>> +				pinctrl-single,function-mask = <0x3fffffff>;
>> +			};
>> +		};
>
> Wouldn't it make more sense to have separate device_scm, core_scm and
> wkup_scm instead of stuffing multiple ranges here?
 >
> Or are there other reasons for the multiple ranges?

Yea that was the alternative I was thinking about, I ended up with this 
for some reason. I think personally I liked having them all under the 
same SCM part, because they are nicely grouped then, and well, its the 
same system control part in the chip. We can split it up easily of 
course. Should we have a higher level scm part and then have core_scm 
and wkup_scm under this followed by the sub-functions, or just drop the 
top level scm part completely?

This same question applies to omap4 + omap5 also. In some part for omap3 
also, as it also has pmx_core + pmx_wkup separately, even if they are 
part of the same register space.

Anyway, just a political decision from your side, I am fine either way. :)

-Tero
