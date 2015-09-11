From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Fri, 11 Sep 2015 09:23:33 +0530
Subject: [PATCH v5 2/4] Documentation: arm64/arm: dt bindings for numa.
In-Reply-To: <CAFpQJXV66dAfDMttMNTApyy1554-rvw=Q0n60BOtsp=61gJ+zQ@mail.gmail.com>
References: <1439570374-4079-1-git-send-email-gkulkarni@caviumnetworks.com>
 <1439570374-4079-3-git-send-email-gkulkarni@caviumnetworks.com>
 <20150828123228.GE31748@leverpostej>
 <CAL_JsqLOpUTVeKbkJ6uPi0EYistd=BowAHdtSmaUYYDhU6c9Sg@mail.gmail.com>
 <55E17F58.5020101@huawei.com>
 <CAFpQJXWO0xT0kxWf09L_XcAOXm1Lov8i2U2BQzk-x0TStj7vBg@mail.gmail.com>
 <55EEE229.7070301@linaro.org>
 <CAFpQJXV66dAfDMttMNTApyy1554-rvw=Q0n60BOtsp=61gJ+zQ@mail.gmail.com>
Message-ID: <CAFpQJXX0KYiKKgxM3B467PFLS0jCakTp8A2u=QEs8_Fj4EZYBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thunder,


On Tue, Sep 8, 2015 at 9:57 PM, Ganapatrao Kulkarni
<gpkulkarni@gmail.com> wrote:
> Hi Hanjun,
>
> On Tue, Sep 8, 2015 at 6:57 PM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>> Hi Ganapatrao,
>>
>>
>> On 08/29/2015 10:56 PM, Ganapatrao Kulkarni wrote:
>>>
>>> Hi Thunder,
>>>
>>> On Sat, Aug 29, 2015 at 3:16 PM, Leizhen (ThunderTown)
>>> <thunder.leizhen@huawei.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2015/8/28 22:02, Rob Herring wrote:
>>>>>
>>>>> +benh
>>>>>
>>>>> On Fri, Aug 28, 2015 at 7:32 AM, Mark Rutland <mark.rutland@arm.com>
>>>>> wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> On Fri, Aug 14, 2015 at 05:39:32PM +0100, Ganapatrao Kulkarni wrote:
>>>>>>>
>>>>>>> DT bindings for numa map for memory, cores and IOs using
>>>>>>> arm,associativity device node property.
>>>>>>
>>>>>>
>>>>>> Given this is just a copy of ibm,associativity, I'm not sure I see much
>>>>>> point in renaming the properties.
>>>>>
>>>>>
>>>>> So just keep the ibm? I'm okay with that. That would help move to
>>>>> common code. Alternatively, we could drop the vendor prefix and have
>>>>> common code just check for both.
>>>>>
>>>>
>>>> Hi all,
>>>>
>>>> Why not copy the method of ACPI numa? There only three elements should be
>>>> configured:
>>>> 1) a cpu belong to which node
>>>> 2) a memory block belong to which node
>>>> 3) the distance of each two nodes
I too thought acpi only defines mapping for cpu and memory to numa
nodes and no specification to define for IOs.
however after going through the x86 implementation, i can see there is
provision for mapping IOs to numa node in acpi.
in x86 code, function pci_acpi_scan_root calls acpi_get_node to get
associated node for pci bus using _PXM object.
it imply there is entry in acpi tables to map pci bus for numa
node(proximity domain).
so in dt also, we should  have binding to define cpu, memory and IOs
to node mapping.
>>>>
>>>> The devicetree nodes of numa can be like below:
>>>> / {
>>>>          ...
>>>>
>>>>          numa-nodes-info {
>>>>                  node-name: node-description {
>>>>                          mem-ranges = <...>;
>>>>                          cpus-list = <...>;
>>>>                  };
>>>>
>>>>                  nodes-distance {
>>>>                          distance-list = <...>;
>>>>                  };
>>>>          };
>>>>
>>>>          ...
>>>> };
>>>>
>>> some what similar to what your are proposing is already implemented in
>>> my v2 patchset.
>>> https://lwn.net/Articles/623920/
>>>
>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/305164.html
>>> we have went to associativity property based implementation to keep it
>>> more generic.
>>> i do have both acpi(using linaro/hanjun's patches) and associativity
>>> based implementations on our internal tree
>>> and tested on thunderx platform.
>>
>>
>> Great thanks!
>>
>>> i do see issue in creating numa mapping using ACPI for IOs(for
>>> example, i am not able to create numa mapping for ITS which is on each
>>> node, using ACPI tables),  since ACPI spec (tables SRAT and SLIT)
>>> talks only about processor and memory.
>>
>>
>> I'm not sure why the ITS needs to know the NUMA domain, for my
>> understanding, the interrupt will route to the correct NUMA domain
>> using setting the affinity, ITS will configured to route it to
>> the right GICR(cpu), so I think the ITS don't need to know which
>> NUMA node belonging to, correct me if I missed something.
> IIUC, GICR/collection is per cpu and can be mapped to numa node using
> cpu to node mapping.
> However there are multiple its in multi-socket platform(at-least one
> its per socket),
> knowing its to numa node mapping will help in routing(optimal) the
> interrupts to  any one of GICR/collections of that node
> Hence, we need to find which its belongs to which socket/node using dt.
> same applies to pci bus too.
>>
>> Thanks
>> Hanjun
>
> thanks
> Ganapat
thanks
Ganapat
