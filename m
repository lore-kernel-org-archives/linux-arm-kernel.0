From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 15 May 2014 22:12:48 +0200
Subject: [PATCH 3/4] irqchip: gic: Add support for per CPU bank offset
 specification in DT
In-Reply-To: <CAL_JsqKwSuRebXdtfmrRCxhfwFOk8AMYUdeYX7SFu=ssM3=_hg@mail.gmail.com>
References: <1397832181-5153-1-git-send-email-t.figa@samsung.com>	<1397832181-5153-4-git-send-email-t.figa@samsung.com>	<CAL_Jsq+wCDWnZ-wemMPc1tvpnK3kd=bx5fkT5GAP_QyLPjQfJQ@mail.gmail.com>	<536BBA3F.4020908@samsung.com>
 <CAL_JsqKwSuRebXdtfmrRCxhfwFOk8AMYUdeYX7SFu=ssM3=_hg@mail.gmail.com>
Message-ID: <53751FC0.8000500@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.05.2014 20:04, Rob Herring wrote:
> On Thu, May 8, 2014 at 12:09 PM, Tomasz Figa <t.figa@samsung.com> wrote:
>> On 08.05.2014 19:04, Rob Herring wrote:
>>> On Fri, Apr 18, 2014 at 9:43 AM, Tomasz Figa <t.figa@samsung.com> wrote:
>>>> On most platforms GIC registers are banked, so each CPU can access its
>>>> registers at the same address. However there is a small number of SoCs
>>>> on which the banking is not implemented and each CPU has its GIC
>>>> register set at different offset from GIC base address.
>>>>
>>>> Originally the driver used simple maths to calculate the address, i.e.
>>>> multiplying constant percpu_offset by cpu_logical_map(cpu). However this
>>>> assumed the namespace of cpu_logical_map() to be from 0 to num_cpus-1,
>>>> but if CPU topology is specified via DT, this changes to full ID in
>>>> the same format as MPIDR register and thus breaks the assumption.
>>>>
>>>> This patch adds support for per CPU GIC bank offset specification
>>>> through device tree to separate SoC-internal core wiring from CPU
>>>> multi-processor IDs.
>>>>
>>>> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/arm/cpus.txt |  7 ++
>>>>  Documentation/devicetree/bindings/arm/gic.txt  | 34 +++++++++-
>>>>  drivers/irqchip/irq-gic.c                      | 94 ++++++++++++++++++--------
>>>>  3 files changed, 105 insertions(+), 30 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
>>>> index 333f4ae..47654e6 100644
>>>> --- a/Documentation/devicetree/bindings/arm/cpus.txt
>>>> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
>>>> @@ -209,6 +209,13 @@ nodes to be present and contain the properties described below.
>>>>                 Value type: <phandle>
>>>>                 Definition: Specifies the ACC[2] node associated with this CPU.
>>>>
>>>> +       - gic-offset
>>>> +               Usage: required for systems that have non-banked GIC
>>>> +                      implementation that requires each CPU to use different
>>>> +                      offset to access its set of GIC registers
>>>> +               Value type: <u32>
>>>> +               Definition: Specifies the offset of GIC registers specific to
>>>> +                           this CPU.
>>>
>>> What if you have 1 distributor address and a per cpu address which is
>>> allowed in the gicv2 spec IIRC.
>>
>> Hmm, I need to take a look at GIC v2 spec... but I think my proposed
>> binding would still cover this, as the implementation (if modified to
>> support this) would simply ignore the offset for distributor in this case.
> 
> How does the implementation know whether to ignore the offset for the
> distributor or not?

Hmm, if GIC v2 spec allows both cases, then this solution is not enough
indeed. I need to find some time to familiarize with necessary
documentation...

>>> I think I would rather see this stay contained within the gic node and
>>> use reg property.
>>
>> How do we match reg entries with CPUs then? The first idea that comes to
>> my mind would be adding arm,cpu-map property that would list MPIDR
>> values of CPUs in the same order as register banks are listed in reg
>> property but I'm not sure this is a good idea.
> 
> How do you do it currently?

We don't. As I described in commit message, the driver expects
cpu_logical_map() to return a value from [0...N-1] range where N is the
number of CPUs and that respective per-CPU bank is located at gic_base +
cpu_offset * cpu_logical_map(). There are two problems with this:

a) after adding CPU topology data to DT, cpu_logical_map() starts
returning lower 24 bits of MPIDR and certain SoCs have non-zero cluster
ID, even if there is only a single cluster present,

b) obviously for multi-cluster SoCs the above assumption doesn't stand.

> 
> The issue with putting properties in the cpu node is it does not
> scale. What if you had 10 per cpu properties on 10 different blocks.
> 
> Using the MPIDR directly is a bit specific. I would perhaps just do
> something like this:
> 
> gic-cpu-map = <&CPU0 &CPU1>;

It sounds quite good. I'll try to get this implemented in next version,
but after looking through GIC v2 spec first.

Best regards,
Tomasz
