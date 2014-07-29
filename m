From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Tue, 29 Jul 2014 14:42:51 +0200
Subject: [PATCH v8 3/6] ARM: dts: Exynos: add CPU OPP and regulator supply
 property
In-Reply-To: <CAJuA9ag1xHm=vaXxXzj7ykKxYHxBndDsOTwN0vRdXvhb_DtQ2g@mail.gmail.com>
References: <1406611711-25112-1-git-send-email-thomas.ab@samsung.com>	<1406611711-25112-4-git-send-email-thomas.ab@samsung.com>	<53D78ED3.9090703@suse.de>
 <CAJuA9ag1xHm=vaXxXzj7ykKxYHxBndDsOTwN0vRdXvhb_DtQ2g@mail.gmail.com>
Message-ID: <53D796CB.5020805@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

Am 29.07.2014 14:35, schrieb Thomas Abraham:
> On Tue, Jul 29, 2014 at 5:38 PM, Andreas F?rber <afaerber@suse.de> wrote:
>> Am 29.07.2014 07:28, schrieb Thomas Abraham:
>>> diff --git a/arch/arm/boot/dts/exynos5250-cros-common.dtsi b/arch/arm/boot/dts/exynos5250-cros-common.dtsi
>>> index 89ac90f..34bb31c 100644
>>> --- a/arch/arm/boot/dts/exynos5250-cros-common.dtsi
>>> +++ b/arch/arm/boot/dts/exynos5250-cros-common.dtsi
>>> @@ -19,6 +19,12 @@
>>>       chosen {
>>>       };
>>>
>>> +     cpus {
>>> +             cpu at 0 {
>>> +                     cpu0-supply = <&buck2_reg>;
>>> +             };
>>> +     };
>>> +
>>>       pinctrl at 11400000 {
>>>               /*
>>>                * Disabled pullups since external part has its own pullups and
>>
>> I've been instructed to dismantle this .dtsi file, so please place this
>> into exynos5250-snow.dts. It's probably wrong here anyway, since Spring
>> doesn't use the max77686 but an s5m6787 PMIC.
> 
> Ok, I will move this to exynos5250-snow.dts.
> 
>>
>> How do I find out which -supply to specify here for Spring?
> 
> This information can be found in the Spring board schematic.

Are those available publicly somewhere? I guess not...

>> Also, wouldn't it make sense to assign a cpu0 label in exynos????.dtsi
>> to override it via &cpu0 { ... };?
> 
> Sorry, I did not understand the question.

Instead of adding

cpus { cpu at 0 { ... }; };

to the board's / node, I am suggesting you do in the SoC's .dtsi:

- cpu at 0 {
+ cpu0: cpu at 0 {

and then in the board's file after / { ... }; add the following:

&cpu0 {
	cpu0-supply = <&buck2_reg>;
};

This is the new preferred way to override or extend inherited nodes, I
am told. (&cpu0 should be inserted in alphabetical order then.)

Cheers,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
