From: olof@lixom.net (Olof Johansson)
Date: Tue, 17 Jan 2017 14:10:42 -0800
Subject: [PATCH v3 2/3] arm64: dts: juno: fix CoreSight support for Juno
 r1/r2 variants
In-Reply-To: <ae9edbff-b315-7709-84e7-d72bc6394a4e@arm.com>
References: <1484234410-7670-1-git-send-email-sudeep.holla@arm.com>
 <1484234410-7670-3-git-send-email-sudeep.holla@arm.com>
 <CAOesGMj_23cehRP0ftdM_+Wvuj3tUWi5T5+w5z5v62zfkLu9+w@mail.gmail.com>
 <ae9edbff-b315-7709-84e7-d72bc6394a4e@arm.com>
Message-ID: <CAOesGMiULmYezwL3PQXGkOAOQrev-pXw2eGAYx+=rWJUM9QJWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2017 at 3:37 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 17/01/17 06:58, Olof Johansson wrote:
>> Hi,
>>
>> On Thu, Jan 12, 2017 at 7:20 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>> From: Mike Leach <mike.leach@linaro.org>
>>>
>>> The CoreSight support added for Juno is valid for only Juno r0.
>>> The Juno r1 and r2 variants have additional components and alternative
>>> connection routes between trace source and sinks.
>>>
>>> This patch builds on top of the existing r0 support and extends it to
>>> Juno r1/r2 variants.
>>>
>>> Signed-off-by: Mike Leach <mike.leach@linaro.org>
>>> [sudeep.holla at arm.com: minor changelog update and reorganising the common
>>>         coresight components back into juno-base.dtsi to avoid duplication]
>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>> ---
>>>  arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi | 102 ++++++++++++++++++++++++++++++
>>>  arch/arm64/boot/dts/arm/juno-r1.dts       |   9 +++
>>>  arch/arm64/boot/dts/arm/juno-r2.dts       |   9 +++
>>>  3 files changed, 120 insertions(+)
>>>  create mode 100644 arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi b/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
>>> new file mode 100644
>>> index 000000000000..89fcef366ff9
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
>>> @@ -0,0 +1,102 @@
>>> +       csys1_funnel at 20130000 {
>>> +               compatible = "arm,coresight-funnel", "arm,primecell";
>>> +               reg = <0 0x20130000 0 0x1000>;
>>> +
>>> +               clocks = <&soc_smc50mhz>;
>>> +               clock-names = "apb_pclk";
>>> +               power-domains = <&scpi_devpd 0>;
>>> +               ports {
>>> +                       #address-cells = <1>;
>>> +                       #size-cells = <0>;
>>> +
>>> +                       /* input port */
>>> +                       port at 0 {
>>> +                               reg = <0>;
>>> +                               csys1_funnel_out_port: endpoint {
>>> +                                       remote-endpoint =
>>> +                                               <&etf1_in_port>;
>>> +                               };
>>> +                       };
>>> +
>>> +                       /* output port */
>>> +                       port at 1 {
>>> +                               reg = <0>;
>>> +                               csys1_funnel_in_port0: endpoint {
>>> +                                       slave-mode;
>>> +                               };
>>> +                       };
>>> +
>>> +               };
>>> +       };
>>> +
>>> +       etf1 at 20140000 {
>>
>> The concept behind device-tree is that you name the nodes based on the
>> type of device they are. "i2c", "ethernet", etc. Not "eth0", "i2c3",
>> and so on.
>>
>> So, this should probably be something else than "etf1", and the
>> etf->etf0 rename you did somewhere else shouldn't be made either.
>>
>
> Agreed, will fix it. Sorry for not noticing that before. I somehow
> always confused them to be labels rather that node names and even missed
> to observe that when I changed for R0.
>
> [...]
>
>>> diff --git a/arch/arm64/boot/dts/arm/juno-r1.dts b/arch/arm64/boot/dts/arm/juno-r1.dts
>>> index eec37feee8fc..d4b85d9d343e 100644
>>> --- a/arch/arm64/boot/dts/arm/juno-r1.dts
>>> +++ b/arch/arm64/boot/dts/arm/juno-r1.dts
>>> @@ -178,6 +178,7 @@
>>>         };
>>>
>>>         #include "juno-base.dtsi"
>>> +       #include "juno-cs-r1r2.dtsi"
>>
>> Please don't nest dtsi inside a structure like this. We normally let
>> them stand by themselves at the top of the file instead.
>>
>> (yes, please fix for juno-base too).
>
> Agreed and fixed locally, will post it as part of v4.

Both look reasonable here on repost!


-Olof
