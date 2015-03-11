From: fkan@apm.com (Feng Kan)
Date: Wed, 11 Mar 2015 10:19:02 -0700
Subject: [PATCH] arm64: dts: Fix GIC reg sizes for APM X-Gene
In-Reply-To: <550056FD.8060804@arm.com>
References: <1422342206-4750-1-git-send-email-psawargaonkar@apm.com>
 <550056FD.8060804@arm.com>
Message-ID: <CAL85gmCuB4LfNp+6B8cL9+emFqWPM6W9gevTzibyaAzL+7jVdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 11, 2015 at 7:53 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 27/01/15 07:03, Pranavkumar Sawargaonkar wrote:
>> In APM X-Gene, GIC register space is 64K aligned while the sizes mentioned
>> in the dt are 4K aligned. This breaks KVM when kernel is built with 64K page
>> size due to size alignment checking in vgic driver for VCPU Control and
>> VCPU register.
>>
>> This patch corrects the sizes to be inline with the hardware spec.
>
> This patch may be correct, but it is useless. The firmware on my APM
> system (some version of u-boot) repaints the DT at boot time, negating
> the effect of this patch.
We have updated u-boot to reflect this change. I can supply you with a updated
image if you wish.

>
> Another system I can remove from my 64k-capable list.
>
>         M.
>
>> CC: linux-arm-kernel at lists.infradead.org
>> CC: kvmarm at lists.cs.columbia.edu
>> CC: arnd at arndb.de
>> CC: marc.zyngier at arm.com
>> CC: christoffer.dall at linaro.org
>> CC: jcm at redhat.com
>> Signed-off-by: Pranavkumar Sawargaonkar <psawargaonkar@apm.com>
>> Signed-off-by: Tushar Jagad <tjagad@apm.com>
>> Signed-off-by: Feng Kan <fkan@apm.com>
>> ---
>>  arch/arm64/boot/dts/apm/apm-storm.dtsi |    8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
>> index f1ad9c2..65f0e6d 100644
>> --- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
>> +++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
>> @@ -81,10 +81,10 @@
>>               compatible = "arm,cortex-a15-gic";
>>               #interrupt-cells = <3>;
>>               interrupt-controller;
>> -             reg = <0x0 0x78010000 0x0 0x1000>,      /* GIC Dist */
>> -                   <0x0 0x78020000 0x0 0x1000>,      /* GIC CPU */
>> -                   <0x0 0x78040000 0x0 0x2000>,      /* GIC VCPU Control */
>> -                   <0x0 0x78060000 0x0 0x2000>;      /* GIC VCPU */
>> +             reg = <0x0 0x78010000 0x0 0x10000>,     /* GIC Dist */
>> +                   <0x0 0x78020000 0x0 0x20000>,     /* GIC CPU */
>> +                   <0x0 0x78040000 0x0 0x10000>,     /* GIC VCPU Control */
>> +                   <0x0 0x78060000 0x0 0x20000>;     /* GIC VCPU */
>>               interrupts = <1 9 0xf04>;       /* GIC Maintenence IRQ */
>>       };
>>
>> --
>> 1.7.9.5
>>
>>
>
>
> --
> Jazz is not dead. It just smells funny...
