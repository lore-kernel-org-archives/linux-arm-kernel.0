From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 13 Mar 2013 19:42:45 +0800
Subject: [PATCH v3 06/11] ARM: vexpress: use clocksource_of_init for sp804
In-Reply-To: <1363173037.3100.22.camel@hornet>
References: <1363151142-32162-1-git-send-email-haojian.zhuang@linaro.org>
 <1363151142-32162-7-git-send-email-haojian.zhuang@linaro.org>
 <1363173037.3100.22.camel@hornet>
Message-ID: <CAD6h2NQWB3+1QepQjBE0BZiG44YAQRi7e-9+oZvVYpYV8QycDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 March 2013 19:10, Pawel Moll <pawel.moll@arm.com> wrote:
> On Wed, 2013-03-13 at 05:05 +0000, Haojian Zhuang wrote:
>> Remove all code to parse sp804. Use clocksource_of_init() instead since
>> all these code are implemented in sp804 driver already.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>> ---
>>  arch/arm/boot/dts/vexpress-v2m-rs1.dtsi |    2 ++
>>  arch/arm/boot/dts/vexpress-v2m.dtsi     |    2 ++
>>  arch/arm/boot/dts/vexpress-v2p-ca9.dts  |    2 ++
>>  arch/arm/mach-vexpress/Kconfig          |    1 +
>>  arch/arm/mach-vexpress/v2m.c            |   13 ++-----------
>>  5 files changed, 9 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
>> index ac870fb..3fa798f 100644
>> --- a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
>> +++ b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
>> @@ -183,6 +183,8 @@
>>                               interrupts = <2>;
>>                               clocks = <&v2m_sysctl 0>, <&v2m_sysctl 1>, <&smbclk>;
>>                               clock-names = "timclken1", "timclken2", "apb_pclk";
>> +                             arm,sp804-clocksource = <0x20>;
>> +                             arm,sp804-clockevent = <0>;
>>                       };
>>
>>                       v2m_timer23: timer at 120000 {
>> diff --git a/arch/arm/boot/dts/vexpress-v2m.dtsi b/arch/arm/boot/dts/vexpress-v2m.dtsi
>> index f142036..86e4046 100644
>> --- a/arch/arm/boot/dts/vexpress-v2m.dtsi
>> +++ b/arch/arm/boot/dts/vexpress-v2m.dtsi
>> @@ -182,6 +182,8 @@
>>                               interrupts = <2>;
>>                               clocks = <&v2m_sysctl 0>, <&v2m_sysctl 1>, <&smbclk>;
>>                               clock-names = "timclken1", "timclken2", "apb_pclk";
>> +                             arm,sp804-clocksource = <0x20>;
>> +                             arm,sp804-clockevent = <0>;
>>                       };
>>
>>                       v2m_timer23: timer at 12000 {
>> diff --git a/arch/arm/boot/dts/vexpress-v2p-ca9.dts b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
>> index 1420bb1..a2eba95 100644
>> --- a/arch/arm/boot/dts/vexpress-v2p-ca9.dts
>> +++ b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
>> @@ -98,6 +98,8 @@
>>                            <0 49 4>;
>>               clocks = <&oscclk2>, <&oscclk2>;
>>               clock-names = "timclk", "apb_pclk";
>> +             arm,sp804-clocksource = <0x20>;
>> +             arm,sp804-clockevent = <0>;
>>       };
>>
>>       watchdog at 100e5000 {
>
> I love the possibility of removing the SP804 code from the VE machine
> (thanks for your work!), but I'd like to avoid it being replaced by
> cryptic properties in the tree.
>
> Now, to get this right: I'm not saying that there should be completly no
> OS-specific (but neutral) properties for the clocking system.
>
> I'm saying that in "my" (the VE) case, there are four, effectively
> identical timers (each pair sharing an interrupt though). Every single
> one of them is perfectly capable of serving as clocksource or
> clockevent. Therefore I believe the driver/framework/OS should make its
> own decision.
>
I can move those properties into dts file instead.

If clocksource uses alias to configure source or event. There's still a lot
of work. At least we need to split dual timer into two timer devices in DTS.
