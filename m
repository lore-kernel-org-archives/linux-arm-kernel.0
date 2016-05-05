From: nm@ti.com (Nishanth Menon)
Date: Thu, 5 May 2016 14:00:29 -0500
Subject: [PATCH] ARM: dts: omap5-board-common: Describe the voltage supply
 mapping accurately
In-Reply-To: <20160505183611.GA5995@atomide.com>
References: <1462389618-28860-1-git-send-email-nm@ti.com>
 <572A528C.4090302@ti.com> <20160505183611.GA5995@atomide.com>
Message-ID: <572B984D.10203@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/05/2016 01:36 PM, Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [160504 12:52]:
>> On 05/04/2016 02:20 PM, Nishanth Menon wrote:
>> [...]
>>
>>> @@ -551,6 +590,8 @@
>>>  
>>>  				ldo9_reg: ldo9 {
>>>  					/* VCC_DV_SDIO: vdds_sdcard */
>>> +					vin-supply = <&vmmcsdio_fixed>;
>>> +
>>
>> There is an extra white space here, and vmmcsd_fixed is the regulator
>> to be used, looks like vmmcsdio_fixed should ideally been vwlan_fixed
>> or something.. the actual rail to LDO9_IN was called vmmc_3v3_SDIO..
>>
>> Sorry for the confusion. Unfortunately, I can not recreate the fail on
>> my board, but this sounded like the closest fix I can think of.
> 
> Looks like arch/arm/boot/dts/tegra114-dalmore.dts has entries like
> this instead for the PMIC:
> 
> ldo9-in-supply = <&palmas_smps9_reg>:
> ...
> 
> Doing simlar changes for omap5-board-common.dtsi seems to fix the
> issues for me:
> 
> LDO3: supplied by vdds_1v8_main
> LDO4: supplied by vdds_1v8_main
> ldo4: Bringing 0uV into 1800000-1800000uV
> LDO5: supplied by vsys_cobra
> LDO6: supplied by vdds_1v8_main
> LDO7: supplied by vsys_cobra
> ldo7: Bringing 0uV into 2000000-2000000uV
> LDO8: supplied by vsys_cobra
> LDO9: supplied by vmmcsd_fixed
> 
> See also the patch below too, and please check I got things right
> based on your earlier patch :)


> 
> Now I'm wondering if the x15 related vin-supply changes are actually all
> ignored? It seems that "vin" is only automatically configured for the
> fixed-regulator? Maybe regulator-palmas should be updated to use the

ok /me goes duh!!!! ofcourse! Sorry about not catching it..
hmm.. maybe we messed up am572x-idk as well.. I can quickly fix that
up as well

> "vin-supply" if configured to avoid confusion?
regulator-palmas using vin-supply is more sensible, but i am not sure
about the argument
for this originally was -> +Mark, Keerthy and Lakshman for feedback.

[...]
> +			smps123-in-supply = <&vsys_cobra>;
> +			smps45-in-supply = <&vsys_cobra>;
> +			smps6-in-supply = <&vsys_cobra>;
> +			smps7-in-supply = <&vsys_cobra>;
> +			smps8-in-supply = <&vsys_cobra>;
> +			smps9-in-supply = <&vsys_cobra>;
> +			smps10_out2-in-supply = <&vsys_cobra>;
> +			smps10_out1-in-supply = <&vsys_cobra>;
> +			ldo1-in-supply = <&vsys_cobra>;
> +			ldo2-in-supply = <&vsys_cobra>;
> +			ldo3-in-supply = <&vdds_1v8_main>;
> +			ldo4-in-supply = <&vdds_1v8_main>;
> +			ldo5-in-supply = <&vsys_cobra>;
> +			ldo6-in-supply = <&vdds_1v8_main>;
> +			ldo7-in-supply = <&vsys_cobra>;
> +			ldo8-in-supply = <&vsys_cobra>;
> +			ldo9-in-supply = <&vmmcsd_fixed>;
> +			ldousb-in-supply = <&vsys_cobra>;
ldoln is vsys_cobra as well.. I missed that.

Others look good. we should probably get this merged to fix the
regression.

> +
>  			regulators {
>  				smps123_reg: smps123 {
>  					/* VDD_OPP_MPU */
> 


-- 
Regards,
Nishanth Menon
