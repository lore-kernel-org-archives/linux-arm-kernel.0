From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 20 Mar 2017 14:00:21 +0000
Subject: [PATCH] arm64: enable ARCH_WANT_RELAX_ORDER for aarch64
In-Reply-To: <5bcff420-2ba7-7f64-9c52-41a5c60e9c31@huawei.com>
References: <35233df0-3406-e66f-d9d2-bf7ed7814386@huawei.com>
 <d97d0876-3e00-1979-72de-35fd81bfedf5@arm.com>
 <5bcff420-2ba7-7f64-9c52-41a5c60e9c31@huawei.com>
Message-ID: <05adceeb-856e-ce40-c23a-0cfd309549df@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/03/17 14:06, Ding Tianhong wrote:
> Hi Robin?
> 
> On 2017/3/13 21:31, Robin Murphy wrote:
>> On 13/03/17 12:03, Ding Tianhong wrote:
>>> The ARCH_WANT_RELAX_ORDER will enable Relaxed Ordering (RO) which allows
>>> transactions that do not have any order of completion requirements to
>>> complete more efficiently compare to the Stricted Ordering (SO) for ixbge
>>> nic card.
>>
>> Which ixgbe NIC? As far as I can see we have an arch-level config option
>> here which applies to one single driver, and doesn't even cover all the
>> hardware supported by that driver (82598, for example, still has the
>> #ifndef CONFIG_SPARC in the equivalent place). Looking at the history,
>> I'd prefer to at least know what the "various issues with certain
>> chipsets" were, and why they wouldn't affect ARM systems,  before making
>> any judgement about whether this could be considered universally safe
>> for arm64.
>>
> 
> Indeed, in fact if the chipsets didn't support RO mode or has some errata for RO mode, it may
> occur some issues, but it looks no such aarch64 chips, maybe I miss something.
> 
> There are several intel nic card could support enable relax order, so need another patch to rename the SPARC
> to ARCH_WANT_RELAX_ORDER, the universal name looks more better.

I'm sure I'm not alone in disagreeing outright that it looks better,
because ARCH_ is hardly the appropriate namespace for a driver option
unrelated to an architecture port's interaction with core kernel code;
plus it's further confounded by a name which both doesn't imply any
relationship with said driver, and does overlap with the kind of CPU
memory model terminology which *is* the purview of architecture ports.

As an equivalent example, consider how equally misleading it would be
from the ARM maintainer perspective if CONFIG_IOMMU_IO_PGTABLE_LPAE was
just called CONFIG_ARCH_WANT_LPAE and implemented in this manner.

Having looked into it, I see that "Relaxed Order" does actually turn out
to be a specific PCIe term, but even in that context it doesn't apply at
the arch level - that's going to be a matter for particular endpoints
and particular host controllers and all the quirks in between.

>>> The system will see high write-to-memory performance when RO is
>>> enabled on the data transactions just like the SPARC did.
>>>
>>> The aarch64 pcie controller could both support Relaxed Ordering (RO)
>>
>> What is "the AArch64 PCIe controller", exactly? Disregarding that
>> talking of PCIe in terms of the CPU ISA makes little sense, I can barely
>> name two ARMv8-based systems which nominally use the same PCIe IP, and
>> the amount of various quirks and incompatibilities I'm aware of leaves
>> me with the default assumption that any such unqualified blanket
>> statement is probably wrong. I think we need some much more considered
>> reasoning here.
>>
> 
> Agree, till now I could only test on hip06/hip07 board and get the better performance,
> maybe I could test on other aarch64 platform.
>
>>> and Stricted Ordering (SO), so enable ARCH_WANT_RELAX_ORDER for ixgbe
>>> nic card to get much more better performance, and didn't see any
>>> adverse effects.
>>>
>>> Nic Card(Ixgbe)			Disable RO	|	Enable RO
>>> Performance(Per thread)		8.4Gb/s		|	9.4Gb/s
>>>
>>> Tested by Iperf on Hip06/Hip07 Soc Board.
>>>
>>> Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
>>> ---
>>>  arch/arm64/Kconfig | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>> index 8c7c244..36249a3 100644
>>> --- a/arch/arm64/Kconfig
>>> +++ b/arch/arm64/Kconfig
>>> @@ -115,6 +115,7 @@ config ARM64
>>>  	select SPARSE_IRQ
>>>  	select SYSCTL_EXCEPTION_TRACE
>>>  	select THREAD_INFO_IN_TASK
>>> +	select ARCH_WANT_RELAX_ORDER
>>
>> I'd say the first order of business is to rename this config option to
>> IXBGE_82599_WANT_RELAXED_ORDER so that it's not entirely misleading and
> 
> not only for 82599, including 82598, 82576....

So why does ixgbe_start_hw_82598() still have the original #ifndef
CONFIG_SPARC from 887012e80aea?

It was pretty clear from the outset that this is one of those patches
for making a particular card go faster in a particular system based on
what's available in the test lab - there's nothing inherently wrong with
that, but if it were presented merely in those terms there would
probably be a lot less to object to.

>> ambiguous. At first glance it looks far more like something scary to do
>> with memory barriers than a network driver option. Howcome this isn't
>> just in drivers/net/intel/Kconfig as a "default y if SPARC" bool anyway?
> 
> didn't see any essential differences, and I still need to get some Acked by arm maintainer.

The big difference is that had people done the sensible thing by adding,
say, CONFIG_IXGBE_ALLOW_RELAXED_ORDER to drivers/net/intel/... and
sending a self-contained patch through the net tree, architecture
maintainers wouldn't even need to be aware, let alone ack anything. Then
in future if someone sends another patch against the net tree changing
"y if (SPARC || ARM64)" back to "y if SPARC" because it happens to break
on their system, the resulting discussion and resolution can happen on
netdev, and architecture maintainers who aren't necessarily familiar
with particular ixgbe/PCIe hardware details *still* don't need to care.

Robin.
