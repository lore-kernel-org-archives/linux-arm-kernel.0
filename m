From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 27 Sep 2013 13:28:53 +0530
Subject: [PATCH 2/2] ARM: dts: dra7-evm: Add mmc2 node for eMMC support
In-Reply-To: <52430C8A.6040404@ti.com>
References: <1377525218-7655-1-git-send-email-balajitk@ti.com>
 <1377525218-7655-3-git-send-email-balajitk@ti.com>
 <52415E41.7050301@baylibre.com> <52430C8A.6040404@ti.com>
Message-ID: <52453ABD.3070906@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/25/2013 9:47 PM, Balaji T K wrote:
> On Tuesday 24 September 2013 03:11 PM, Benoit Cousson wrote:
>> + Sekhar
>>
>> Hi Balaji,
>>
>> On 26/08/2013 15:53, Balaji T K wrote:
>>> Add mmc2 dt node to dra7-evm board
>>> and model eMMC vcc as fixed regulator.
>>>
>>> Signed-off-by: Balaji T K <balajitk@ti.com>
>>> ---
>>>   arch/arm/boot/dts/dra7-evm.dts |   14 ++++++++++++++
>>>   1 files changed, 14 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/dra7-evm.dts
>>> b/arch/arm/boot/dts/dra7-evm.dts
>>> index a59bbd0..2062724 100644
>>> --- a/arch/arm/boot/dts/dra7-evm.dts
>>> +++ b/arch/arm/boot/dts/dra7-evm.dts
>>> @@ -17,6 +17,13 @@
>>>           device_type = "memory";
>>>           reg = <0x80000000 0x60000000>; /* 1536 MB */
>>>       };
>>> +
>>> +    mmc2_3v3: fixedregulator-mmc2 {
>>> +        compatible = "regulator-fixed";
>>> +        regulator-name = "mmc2_3v3";
>>> +        regulator-min-microvolt = <3300000>;
>>> +        regulator-max-microvolt = <3300000>;
>>> +    };
>>>   };
>>>
>>>   &dra7_pmx_core {
>>> @@ -257,3 +264,10 @@
>>>       vmmc-supply = <&ldo1_reg>;
>>>       bus-width = <4>;
>>>   };
>>> +
>>> +&mmc2 {
>>> +    status = "okay";
>>> +    vmmc-supply = <&mmc2_3v3>;
>>> +    bus-width = <8>;
>>> +    ti,non-removable;
>>
>> Sekhar just posted a series to replace that with a non-TI attribute:
>> non-removable.
>>
>> I'm not sure if this got merged, but it might be good to use the
>> standard attribute instead.
> 
> Hi Benoit,
> 
> Those patches are not merged yet, standard attribute is good, but few
> cleanups are needed
> before ti,non-removable can be replaced by standard non-removable,
> no_regulator_off_init flag set under ti,non-removable is needed to
> detect eMMC
> during boot on OMAP4 devices to keep regulator ON during init. Given
> that eMMC on dra7-evm
> is powered by always ON regulator, ti,non-removable and standard
> attribute will behave same
> way. Let me know if you want to remove ti,non-removable attribute from
> this patch.

I dont think its an issue if ti,non-removable and non-removable behave
exactly the same. In fact, it will be confusing if they behave differently.

I understand there is a need to clean-up the code around
no_regulator_off_init, but I am hoping that can be kept separate from
moving to a generic binding. The two clean-ups can be done independent
of each other.

Thanks,
Sekhar
