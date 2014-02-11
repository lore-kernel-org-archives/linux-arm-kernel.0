From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 11 Feb 2014 11:04:13 +0100
Subject: [PATCH V2 2/3] ARM: dts: add dts files for exynos5260 SoC
In-Reply-To: <CAPdUM4NBwXcnL2KK9Rsi46GWQz_KQsXF0EEeSmCb=wB8WfgUKQ@mail.gmail.com>
References: <1391577375-17625-1-git-send-email-rahul.sharma@samsung.com>	<1391577375-17625-3-git-send-email-rahul.sharma@samsung.com>	<52F38C42.5030508@samsung.com>
 <CAPdUM4NBwXcnL2KK9Rsi46GWQz_KQsXF0EEeSmCb=wB8WfgUKQ@mail.gmail.com>
Message-ID: <52F9F59D.1090905@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rahul,

On 11.02.2014 06:22, Rahul Sharma wrote:
> Hi Tomasz,
>
> On 6 February 2014 18:51, Tomasz Figa <t.figa@samsung.com> wrote:
>> Hi Rahul, Pankaj, Arun,
>>
>> [adding linux-arm-kernel, devicetree MLs and DT people on Cc]
>>
>> I think it's good time to stop accepting DTS files like this and force new
>> ones to use the proper structure with soc node, labels for every node and
>> node references.
>
> I am unable to find information on SoC node and grouping inside SoC node. Please
> share some pointers.

Well, there is not much information needed about this. Basically all the 
devices built into the SoC should be listed under respective bus nodes 
or a single soc node, instead of root level. Such node should be a 
"simple-bus" and just group the components together to separate 
board-specific devices (which are still at root level) from SoC devices.

Even though it might seem useless, it improves DT readability a bit and 
still most of the platforms use this approach, so for consistency, 
Exynos should use too.

Just for reference, back in April 2013, in his review of S3C64xx DT 
series [1], Rob Herring requested that we don't submit any new device 
trees using flat approach and start using bus hierarchy.

[1] 
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-April/163659.html

>>
>>> +               spi0_bus: spi0-bus {
>>> +                       samsung,pins = "gpa2-0", "gpa2-1", "gpa2-2",
>>> "gpa2-3";
>>
>>
>> What is the reason for SPI0 to have 4 pins, while SPI1 has just 3?
>>
>
> I should align SPI1 with SPI0.
>

Are you sure that SPI0 is the correct one? SPI usually uses four pins - 
SDI, SDO, SCK and nCS, but we always used to treat nCS as a simple GPIO, 
due to the fact that the controller can only support one dedicated chip 
select and with direct GPIO control you can have more.

What is the fourth pin here?

>>
>>> +               cpu at 1 {
>>> +                       device_type = "cpu";
>>> +                       compatible = "arm,cortex-a15";
>>> +                       reg = <1>;
>>> +                       cci-control-port = <&cci_control1>;
>>> +               };
>>> +               cpu at 100 {
>>> +                       device_type = "cpu";
>>> +                       compatible = "arm,cortex-a7";
>>> +                       reg = <0x100>;
>>> +                       cci-control-port = <&cci_control0>;
>>> +               };
>>> +               cpu at 101 {
>>> +                       device_type = "cpu";
>>> +                       compatible = "arm,cortex-a7";
>>> +                       reg = <0x101>;
>>> +                       cci-control-port = <&cci_control0>;
>>> +               };
>>> +               cpu at 102 {
>>> +                       device_type = "cpu";
>>> +                       compatible = "arm,cortex-a7";
>>> +                       reg = <0x102>;
>>> +                       cci-control-port = <&cci_control0>;
>>> +               };
>>> +               cpu at 103 {
>>> +                       device_type = "cpu";
>>> +                       compatible = "arm,cortex-a7";
>>> +                       reg = <0x103>;
>>> +                       cci-control-port = <&cci_control0>;
>>> +               };
>>> +       };
>>> +
>>> +       cmus {
>>> +               #address-cells = <1>;
>>> +               #size-cells = <1>;
>>> +               ranges;
>>> +
>>
>>
>> I don't think there is a need to group these nodes under a parent node that
>> doesn't give any additional information, especially when the CMUs are
>> scattered trough the whole address space, while we'd like to keep the nodes
>> ordered by their addresses, as most platforms do.
>>
>
> This is exactly the same case as "cpus". I mean, "cpus" also doesn't provide
> any common information about child cpu nodes. This looks to me as a logical
> grouping and I have implemented same thing for cmu nodes.
> I am ok with removing this grouping Just want to understand the rational behind
> grouping cpus which seems similar to cmus.

The "cpus" node is a defined standard node that should be present at 
root of device tree and include subnodes for all CPUs. This is a 
standard binding defined for low level code to be able to simply find 
nodes of all CPUs in the system - so they can expect that at /cpus node 
all the subnodes are subsequent CPUs.

> Similarly "soc" is just a logical entity used to group SoC elements which looks
> optional to me. What are we achieving with this? Please help me in understanding
> this better.

Also "soc" has a slightly wider meaning. It is a node grouping all nodes 
from a single address space - the node specifies #address-cells and 
#size-cells of this address space and all the devices under this 
"simple-bus" can be accessed using addresses in this format. In 
addition, it separates board-level devices from generic SoC devices.

Now, in case of "cmus", the only purpose is to group all CMU nodes 
together and, while this improves readability a bit, it doesn't make the 
DT better express the hardware topology, because the CMUs in the 
hardware are in fact scattered through the whole address space, not 
under a contiguous block of it, as the grouping would suggest.

Best regards,
Tomasz
