From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 03 Dec 2014 10:44:32 +0000
Subject: [PATCH v4 15/19] arm/arm64: KVM: add virtual GICv3 distributor
 emulation
In-Reply-To: <20141203102913.GB17502@cbox>
References: <1415959683-26027-1-git-send-email-andre.przywara@arm.com>
 <1415959683-26027-16-git-send-email-andre.przywara@arm.com>
 <20141123143841.GB3401@cbox> <5473562E.7060303@arm.com>
 <20141125104129.GC31297@cbox> <5478939B.8010103@arm.com>
 <20141130083014.GA82106@macair> <547DE7D5.5020205@arm.com>
 <547DF181.8060402@arm.com> <20141203102913.GB17502@cbox>
Message-ID: <547EE990.9010707@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/14 10:29, Christoffer Dall wrote:
> On Tue, Dec 02, 2014 at 05:06:09PM +0000, Marc Zyngier wrote:
>> On 02/12/14 16:24, Andre Przywara wrote:
>>> Hej Christoffer,
>>>
>>> On 30/11/14 08:30, Christoffer Dall wrote:
>>>> On Fri, Nov 28, 2014 at 03:24:11PM +0000, Andre Przywara wrote:
>>>>> Hej Christoffer,
>>>>>
>>>>> On 25/11/14 10:41, Christoffer Dall wrote:
>>>>>> Hi Andre,
>>>>>>
>>>>>> On Mon, Nov 24, 2014 at 04:00:46PM +0000, Andre Przywara wrote:
>>>>>>
>>>>>
>>>
>>> [...]
>>>
>>>>>>>>> +
>>>>>>>>> +     if (!is_in_range(mmio->phys_addr, mmio->len, rdbase,
>>>>>>>>> +         GIC_V3_REDIST_SIZE * nrcpus))
>>>>>>>>> +             return false;
>>>>>>>>
>>>>>>>> Did you think more about the contiguous allocation issue here or can you
>>>>>>>> give me a pointer to the requirement in the spec?
>>>>>>>
>>>>>>> 5.4.1 Re-Distributor Addressing
>>>>>>>
>>>>>>
>>>>>> Section 5.4.1 talks about the pages within a single re-distributor having
>>>>>> to be contiguous, not all the re-deistributor regions having to be
>>>>>> contiguous, right?
>>>>>
>>>>> Ah yes, you are right. But I still think it does not matter:
>>>>> 1) We are "implementing" the GICv3. So as the spec does not forbid this,
>>>>> we just state that the redistributor register maps for each VCPU are
>>>>> contiguous. Also we create the FDT accordingly. I will add a comment in
>>>>> the documentation to state this.
>>>>>
>>>>> 2) The kernel's GICv3 DT bindings assume this allocation is the default.
>>>>> Although Marc added bindings to work around this (stride), it seems much
>>>>> more logical to me to not use it.
>>>>
>>>> I don't disagree (and never have) with the fact that it is up to us to
>>>> decide.
>>>>
>>>> My original question, which we haven't talked about yet, is if it is
>>>> *reasonable* to assume that all re-distributor regions will always be
>>>> contiguous?
>>>>
>>>> How will you handle VCPU hotplug for example?
>>>
>>> As kvmtool does not support hotplug, I haven't thought about this yet.
>>> To me it looks like userland should just use maxcpus for the allocation.
>>> If I get the current QEMU code right, there is room for 127 GICv3 VCPUs
>>> (2*64K per VCPU + 64K for the distributor in 16M space) at the moment.
>>> Kvmtool uses a different mapping, which allows to share 1G with virtio,
>>> so the limit is around 8000ish VCPUs here.
>>> Are there any issues with changing the QEMU virt mapping later?
>>> Migration, maybe?
>>> If the UART, the RTC and the virtio regions are moved more towards the
>>> beginning of the 256MB PCI mapping, then there should be space for a bit
>>> less than 1024 VCPUs, if I get this right.
>>>
>>>> Where in the guest
>>>> physical memory map of our various virt machines should these regions
>>>> sit so that we can allocate anough re-distributors for VCPUs etc.?
>>>
>>> Various? Are there other mappings than those described in hw/arm/virt.c?
>>>
>>>> I just want to make sure we're not limiting ourselves by some amount of
>>>> functionality or ABI (redistributor base addresses) that will be hard to
>>>> expand in the future.
>>>
>>> If we are flexible with the mapping at VM creation time, QEMU could just
>>> use a mapping depending on max_cpus:
>>> < 128 VCPUs: use the current mapping
>>> 128 <= x < 1020: use a more compressed mapping
>>>> = 1020: map the redistributor somewhere above 4 GB
>>>
>>> As the device tree binding for GICv3 just supports a stride value, we
>>> don't have any other real options beside this, right? So how I see this,
>>> a contiguous mapping (with possible holes) is the only way.
>>
>> Not really. The GICv3 binding definitely supports having several regions
>> for the redistributors (see the binding documentation). This allows for
>> the pathological case where you have N regions for N CPUs. Not that we
>> ever want to go there, really.
>>
> What are your thoughts on mapping all of the redistributor regions in
> one consecutive guest phys address space chunk?  Am I making an issue
> out of nothing?

I don't think this is too bad. It puts constraints on the physical
memory map, but we do have a massive IPA space anyway (at least on
arm64). Of course, the issue is slightly more acute on 32bit guests,
where IPA space is at a premium. But this is fairly accurately modelling
a monolithic GICv3 (as opposed to distributed).

I imagine that, over time, we'll have to introduce support for "split"
redistributor ranges, but that probably only become an issue when you
want to support guests with several hundred vcpus.

Another interesting point you raise is vcpu hotplug. I'm not completely
sure how that would work. Do we pre-allocate redistributors, do we have
a more coarse grained "socket hot-plug"? I think that we need to give it
some thoughts, as this probably require a slightly different model for
GICv3.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
