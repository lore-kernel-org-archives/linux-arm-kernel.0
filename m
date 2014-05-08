From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 08 May 2014 19:09:19 +0200
Subject: [PATCH 3/4] irqchip: gic: Add support for per CPU bank offset
 specification in DT
In-Reply-To: <CAL_Jsq+wCDWnZ-wemMPc1tvpnK3kd=bx5fkT5GAP_QyLPjQfJQ@mail.gmail.com>
References: <1397832181-5153-1-git-send-email-t.figa@samsung.com>
 <1397832181-5153-4-git-send-email-t.figa@samsung.com>
 <CAL_Jsq+wCDWnZ-wemMPc1tvpnK3kd=bx5fkT5GAP_QyLPjQfJQ@mail.gmail.com>
Message-ID: <536BBA3F.4020908@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.05.2014 19:04, Rob Herring wrote:
> On Fri, Apr 18, 2014 at 9:43 AM, Tomasz Figa <t.figa@samsung.com> wrote:
>> On most platforms GIC registers are banked, so each CPU can access its
>> registers at the same address. However there is a small number of SoCs
>> on which the banking is not implemented and each CPU has its GIC
>> register set at different offset from GIC base address.
>>
>> Originally the driver used simple maths to calculate the address, i.e.
>> multiplying constant percpu_offset by cpu_logical_map(cpu). However this
>> assumed the namespace of cpu_logical_map() to be from 0 to num_cpus-1,
>> but if CPU topology is specified via DT, this changes to full ID in
>> the same format as MPIDR register and thus breaks the assumption.
>>
>> This patch adds support for per CPU GIC bank offset specification
>> through device tree to separate SoC-internal core wiring from CPU
>> multi-processor IDs.
>>
>> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
>> ---
>>  Documentation/devicetree/bindings/arm/cpus.txt |  7 ++
>>  Documentation/devicetree/bindings/arm/gic.txt  | 34 +++++++++-
>>  drivers/irqchip/irq-gic.c                      | 94 ++++++++++++++++++--------
>>  3 files changed, 105 insertions(+), 30 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
>> index 333f4ae..47654e6 100644
>> --- a/Documentation/devicetree/bindings/arm/cpus.txt
>> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
>> @@ -209,6 +209,13 @@ nodes to be present and contain the properties described below.
>>                 Value type: <phandle>
>>                 Definition: Specifies the ACC[2] node associated with this CPU.
>>
>> +       - gic-offset
>> +               Usage: required for systems that have non-banked GIC
>> +                      implementation that requires each CPU to use different
>> +                      offset to access its set of GIC registers
>> +               Value type: <u32>
>> +               Definition: Specifies the offset of GIC registers specific to
>> +                           this CPU.
> 
> What if you have 1 distributor address and a per cpu address which is
> allowed in the gicv2 spec IIRC.

Hmm, I need to take a look at GIC v2 spec... but I think my proposed
binding would still cover this, as the implementation (if modified to
support this) would simply ignore the offset for distributor in this case.

> 
> I think I would rather see this stay contained within the gic node and
> use reg property.

How do we match reg entries with CPUs then? The first idea that comes to
my mind would be adding arm,cpu-map property that would list MPIDR
values of CPUs in the same order as register banks are listed in reg
property but I'm not sure this is a good idea.

Best regards,
Tomasz
