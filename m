From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 21 Jun 2016 12:27:04 +0100
Subject: [PATCH 1/3] arm64: dts: juno: add coresight support
In-Reply-To: <CAOesGMjQNEOcmYpUAxUxBJLyUYZQuRKK48a31Ys9LuTJFWqMFA@mail.gmail.com>
References: <1465228765-14038-1-git-send-email-sudeep.holla@arm.com>
 <1465228765-14038-2-git-send-email-sudeep.holla@arm.com>
 <CAOesGMjQNEOcmYpUAxUxBJLyUYZQuRKK48a31Ys9LuTJFWqMFA@mail.gmail.com>
Message-ID: <57692488.2030507@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21/06/16 06:41, Olof Johansson wrote:
> Hi,
>
> Some nits below.
>

My bad, I blindly copy-pasted it from vexpress TC2 platform.

> On Mon, Jun 6, 2016 at 8:59 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> Most of the debug-related components on Juno are located in the coreSight
>> subsystem while others are located in the Cortex-Axx clusters, the SCP
>> subsystem, and in the main system.
>>
>> Each core in the two processor clusters contain an Embedded Trace
>> Macrocell(ETM) which generates real-time trace information that trace
>> tools can use and an ATB trace output that is sent to a funnel before
>> going to the CoreSight subsystem.
>>
>> The trace output signals combine with two trace expansions using another
>> funnel and fed into the Embedded Trace FIFO(ETF0).
>>
>> The output trace data stream of the funnel is then replicated before it
>> is sent to either the:
>> - Trace Port Interface Unit(TPIU), that sends it out using the trace port.
>> - ETR that can write the trace data to memory located in the application
>>    memory space
>>
>> Cc: Liviu Dudau <liviu.dudau@arm.com>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: devicetree at vger.kernel.org
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>   arch/arm64/boot/dts/arm/juno-base.dtsi | 296 +++++++++++++++++++++++++++++++++
>>   arch/arm64/boot/dts/arm/juno-r1.dts    |  24 +++
>>   arch/arm64/boot/dts/arm/juno-r2.dts    |  24 +++
>>   arch/arm64/boot/dts/arm/juno.dts       |  24 +++
>>   4 files changed, 368 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
>> index dee2386d3b9b..90a8710f7032 100644
>> --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
>> +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
>> @@ -56,6 +56,302 @@
>>                               <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>;
>>          };
>>
>> +       /*
>> +        * Juno TRMs specify the size for these coresight components as 64K.
>> +        * The actual size is just 4K though 64K is reserved. Access to the
>> +        * unmapped reserved region results in a DECERR response.
>> +        */
>> +       etf at 20010000 {
>
> Would it make sense to name it something like trace-fifo instead? We
> normally name the nodes based on type of device (ethernet@, pci@,
> etc).
>

As Suzuki already pointed out, these are standard acronyms used in
various CoreSight specifications. Let me know if you need them to be
expanded instead of abbreviations.

>
>> +               compatible = "arm,coresight-tmc", "arm,primecell";
>
> Is there a more specific compatible needed here, or does
> arm,coresight-tmc give you all the information you need on how to use
> this interface?
>
> The bindings doc is sort of sparse in this area, all it says is "you
> might use one of these compatibles".
>

Again Suzuki commented on that. I will leave it to Mathieu who is the
author of the binding to comment further(if any).

But I agree, it would be good to have one line description on each of
them as they are pretty much standard primecells or even URL to their
specifications.

>> +       tpiu at 20030000 {
>
> Again, these names are not great. Luckily they don't affect the
> binding, so they can be fixed. What would be a more human readable and
> functionally describing name here?
>
>> +               compatible = "arm,coresight-tpiu", "arm,primecell";
>> +               reg = <0 0x20030000 0 0x1000>;
>> +
>> +               clocks = <&soc_smc50mhz>;
>> +               clock-names = "apb_pclk";
>> +               port {
>> +                       tpiu_in_port: endpoint {
>> +                               slave-mode;
>> +                               remote-endpoint = <&replicator_out_port0>;
>> +                       };
>> +               };
>> +       };
>> +
>> +       main_funnel at 20040000 {
>
> Underscores are usually frowned upon. funnel@ or ideally a better more
> descriptive name should be used here.
> Use dashes if you really have to.
>

Agreed and fixed locally now.

[...]

>> +               compatible = "arm,coresight-tmc", "arm,primecell";
>> +               reg = <0 0x20070000 0 0x1000>;
>> +
>> +               clocks = <&soc_smc50mhz>;
>> +               clock-names = "apb_pclk";
>> +               port {
>> +                       etr_in_port: endpoint {
>> +                               slave-mode;
>> +                               remote-endpoint = <&replicator_out_port1>;
>> +                       };
>> +               };
>> +       };
>> +
>> +       coresight-replicator {
>
> Hm. It'd sort of be nice to stick all the coresight stuff under one
> node instead of having them all at the toplevel, but that doesn't
> really go with the concept of having each device where it's at in the
> bus/address hierarchy.
>

I understand.

> Should _all_ the nodes be at the toplevel though? Looks like you have
> a few address ranges that most of the toplevel devices are at, is
> there really not a physical bus they're each connected to that you can
> describe?
>

I need to look at the Juno documents again and refine. It may affect
other devices too. Can that be addressed later separately ?

[...]


>> +
>> +       etm0: etm at 22040000 {
>
> If this file is sorted on reg values, then this node and the two after
> are out of order.
>

Yes that was the intent, will fix it. But I see some oddities, may be
will fix those once I address the address/bus hierarchy.

-- 
-- 
Regards,
Sudeep
