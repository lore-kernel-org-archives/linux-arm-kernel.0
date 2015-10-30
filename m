From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Fri, 30 Oct 2015 14:54:01 +0530
Subject: [PATCH v4 2/4] ARM: dts: Add SROMc to Exynos 5410
In-Reply-To: <009f01d112dd$fab40830$f01c1890$@samsung.com>
References: <cover.1446122247.git.p.fedin@samsung.com>
 <eafa355058ff500a72ff2e3408ab635954467a76.1446122247.git.p.fedin@samsung.com>
 <CAGcde9EXfe0amqoTOwgKi-Y6=4mRcEbZrA=as-BxzfMv3ntAhQ@mail.gmail.com>
 <009f01d112dd$fab40830$f01c1890$@samsung.com>
Message-ID: <56333731.1000400@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

On Friday 30 October 2015 12:11 PM, Pavel Fedin wrote:
>   Hello!
>
>> -----Original Message-----
>> From: linux-samsung-soc-owner at vger.kernel.org [mailto:linux-samsung-soc-owner at vger.kernel.org]
>> On Behalf Of Pankaj Dubey
>> Sent: Thursday, October 29, 2015 8:28 PM
>> To: Pavel Fedin
>> Cc: devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-samsung-soc;
>> linux-kernel at vger.kernel.org; Rob Herring; Pawel Moll; Mark Rutland; Ian Campbell; Kumar Gala;
>> Kukjin Kim; Krzysztof Kozlowski
>> Subject: Re: [PATCH v4 2/4] ARM: dts: Add SROMc to Exynos 5410
>>
>> Hi Pavel,
>>
>> On 29 October 2015 at 18:12, Pavel Fedin <p.fedin@samsung.com> wrote:
>>> This machine uses own SoC device tree file, add missing part.
>>>
>>> Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
>>> ---
>>>   arch/arm/boot/dts/exynos5410.dtsi | 15 +++++++++++++++
>>>   1 file changed, 15 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
>>> index 4603356..da6a8fa0e 100644
>>> --- a/arch/arm/boot/dts/exynos5410.dtsi
>>> +++ b/arch/arm/boot/dts/exynos5410.dtsi
>>> @@ -101,6 +101,15 @@
>>>                          reg = <0x10000000 0x100>;
>>>                  };
>>>
>>> +               sromc: sromc at 12250000 {
>>> +                       #address-cells = <1>;
>>> +                       #size-cells = <1>;
>>> +                       ranges;
>>> +
>>
>> We do not need to specify these three properties as they are already
>> present in parent node "soc".
>
>   We do, otherwise dtc complains about defaults of #address-cells = 2 and #size-cells=1, and without empty "ranges" subnode's resources are not correctly translated.
>

First of all this patch will not give this error. So this part should 
not be a part of this patch.
You should be getting above error after applying v4 4/4 "ARM: dts: Add 
Ethernet chip to SMDK5410". So if its failing for ethernet subnode, you 
can move this address-cells and size-cells in dts file just above 
ethernet node as shown below:

index 311e7be..d69981d 100644
--- a/arch/arm/boot/dts/exynos5410-smdk5410.dts
+++ b/arch/arm/boot/dts/exynos5410-smdk5410.dts
@@ -95,6 +95,9 @@
  };

  &sromc {
+       #address-cells = <1>;
+       #size-cells = <1>;
+       ranges;
         pinctrl-names = "default";
         pinctrl-0 = <&srom_ctl>, <&srom_ebi>;

And another question still remains open, we can't just like that change 
"smsc,lan9115" binding by adding samsung specific properties. If you 
want to do and there is no other way, you need to update DT binding of 
"smsc,lan9115" and get it reviewed.
Probably you can check suggestions from Krzysztof, where he pointed out 
some hint on how other places this is getting used.


Thanks,
Pankaj Dubey
>>
>>> +                       compatible = "samsung,exynos-srom";
>>> +                       reg = <0x12250000 0x14>;
>>> +               };
>>> +
>>>                  pmu_system_controller: system-controller at 10040000 {
>>>                          compatible = "samsung,exynos5410-pmu", "syscon";
>>>                          reg = <0x10040000 0x5000>;
>>> @@ -133,6 +142,12 @@
>>>                                                  <10 &gic 0 130 0>,
>>>                                                  <11 &gic 0 131 0>;
>>>                          };
>>> +
>>> +                       arch_timer {
>>> +                               compatible = "arm,armv7-timer";
>>> +                               clock-frequency = <24000000>;
>>> +                       };
>>> +
>>
>> This change should not be part of this patch.
>
>   Ooops, thank you very much, this should not have been here at all. This is a leftover from my experiments, i was tracing DT parsing code and added it just for test, to see why timer gets probed as a subnode.
>   Just forgot to remove it afterwards and it slipped into the patch.
>
> Kind regards,
> Pavel Fedin
> Expert Engineer
> Samsung Electronics Research center Russia
>
>
