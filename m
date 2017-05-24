From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 24 May 2017 13:27:42 +0100
Subject: [PATCH] ARM: dts: rockchip: correct regular setting for act8846
In-Reply-To: <1743163.DHHxsEJfsI@phil>
References: <1495611221-6749-1-git-send-email-eddie.cai.linux@gmail.com>
 <5352430.FzU3E8oYou@phil> <010ca6dc-e1f7-fb6d-7a22-056d4e1eeef2@arm.com>
 <1743163.DHHxsEJfsI@phil>
Message-ID: <05eab43d-1ed7-7aed-de45-181d948748cb@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/05/17 12:34, Heiko Stuebner wrote:
> Am Mittwoch, 24. Mai 2017, 11:26:10 CEST schrieb Robin Murphy:
>> On 24/05/17 09:17, Heiko Stuebner wrote:
>>> Hi Eddie,
>>>
>>> Am Mittwoch, 24. Mai 2017, 15:33:41 CEST schrieb Eddie Cai:
>>>> the previous setting of act8846 is just copy from firefly board. but
>>>> the reload board is a little different from firefly board. let's correct
>>>> it.
>>>>
>>>> Signed-off-by: Eddie Cai <eddie.cai.linux@gmail.com>
>>>> ---
>>>>  arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi | 21 +++++++++++----------
>>>>  1 file changed, 11 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi b/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi
>>>> index 8134966..4cfa109 100644
>>>> --- a/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi
>>>> +++ b/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi
>>>> @@ -179,6 +179,7 @@
>>>>  				regulator-name = "vccio_sd";
>>>>  				regulator-min-microvolt = <3300000>;
>>>>  				regulator-max-microvolt = <3300000>;
>>>> +				regulator-always-on;
>>>
>>> the rest below looks pretty straight forward, but why does vccio_sd
>>> need to be always on?
>>>
>>> I've checked the reload's schematics but did not find any further users
>>> of vccio_sd that may warant this attribute.
>>
>> It looks like the card detect line is pulled up externally to vcc_sd,
>> which isn't always-on either, so you probably do want this - on the
>> (unrelated) rk3288 TV box I've been hacking on, I discovered that
>> powering off the sdmmc-supply domain also kills the internal pull-up and
>> leaves sdmmc_cd floating. The resulting stochastic card polling
>> mechanism is amusing, but probably undesirable ;)
> 
> Hmm, are you mixing up vcc_sd and vccio_sd?
> 
> vccio_sd is the io supply (vqmmc in mmc-terms) to the mmc-host itself
> while vcc_sd is the actual card supply (vmmc in mmc-terms).

Yes, that is what I meant, although I was implicitly assuming the case
where the MMC host driver has already turned off vcc_sd due to no card
being present. I'll double-check, but I'm 99% certain that *unlike*
Firefly, the Hotack board I've got (seemingly a straight implementation
of the "Box" reference design based on what I've managed to
reverse-engineer from scouring the internet) has no external pull-ups
for anything on its microSD socket, so is entirely reliant on everything
being pulled up internally to SDMMC0_VDD, i.e. vccio_sd.

> After looking through some schematics, the pull-up to vcc_sd seems to be
> the common pattern for rk3288 devices. So I guess this means the fixed
> regulator vcc_sd should get an regulator-always-on instead to stabilize
> the card-detect?

That might make sense, especially where vcc_sd is just vcc_io behind a
MOSFET switch, so turning it "off" when there's no card to draw power
anyway probably doesn't achieve much. Plus if you can then rely on
vcc_sd not going away it might be worth disabling the internal pull-ups
which are still being set by all the sdmmc_* pinctrl configs as well.

Robin.

>>>>  			};
>>>>  
>>>>  			vdd10_lcd: REG6 {
>>>> @@ -187,24 +188,23 @@
>>>>  				regulator-max-microvolt = <1000000>;
>>>>  			};
>>>>  
>>>> -			vcca_18: REG7  {
>>>> -				regulator-name = "vcca_18";
>>>> -				regulator-min-microvolt = <1800000>;
>>>> -				regulator-max-microvolt = <1800000>;
>>>> -				regulator-always-on;
>>>> +			vcca_33: REG7  {
>>>> +				regulator-name = "vcca_33";
>>>> +				regulator-min-microvolt = <3300000>;
>>>> +				regulator-max-microvolt = <3300000>;
>>>>  			};
>>>>  
>>>> -			vcca_33: REG8 {
>>>> -				regulator-name = "vcca_33";
>>>> +			vcc_lan: REG8 {
>>>> +				regulator-name = "vcc_lan";
>>>>  				regulator-min-microvolt = <3300000>;
>>>>  				regulator-max-microvolt = <3300000>;
>>>> -				regulator-always-on;
>>>>  			};
>>>>  
>>>> -			vcc_lan: REG9 {
>>>> -				regulator-name = "vcca_lan";
>>>> +			vccio_pmu: REG9 {
>>>> +				regulator-name = "vccio_pmu";
>>>>  				regulator-min-microvolt = <3300000>;
>>>>  				regulator-max-microvolt = <3300000>;
>>>> +				regulator-always-on;
>>>>  			};
>>>>  
>>>>  			vdd_10: REG10 {
>>>> @@ -218,6 +218,7 @@
>>>>  				regulator-name = "vcc_18";
>>>>  				regulator-min-microvolt = <1800000>;
>>>>  				regulator-max-microvolt = <1800000>;
>>>> +				regulator-always-on;
>>>>  			};
>>>>  
>>>>  			vcc18_lcd: REG12 {
>>>>
>>>
>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>
>>
>>
>>
> 
> 
