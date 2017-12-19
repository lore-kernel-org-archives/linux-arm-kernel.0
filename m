From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 19 Dec 2017 12:11:24 +0000
Subject: [PATCH 0/2] arm64 SMMUv3 PMU driver with IORT support
In-Reply-To: <20171219065524.GB13415@virtx40>
References: <1501876754-1064-1-git-send-email-nleeder@codeaurora.org>
 <20171210023549.GA22492@virtx40>
 <999b7132-2de8-2872-1067-fc7e02cbc57a@arm.com>
 <7312293d-8897-95d8-9045-9e97a6c150eb@arm.com>
 <20171219065524.GB13415@virtx40>
Message-ID: <03d6c071-84ee-953e-950b-4aaa3a78df2b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/12/17 06:55, Linu Cherian wrote:
> Hi Marc,
> 
> On Mon Dec 18, 2017 at 03:39:22PM +0000, Marc Zyngier wrote:
>> Thanks for putting me in the loop Robin.
>>
>> On 18/12/17 14:48, Robin Murphy wrote:
>>> On 10/12/17 02:35, Linu Cherian wrote:
>>>> Hi,
>>>>
>>>>
>>>> On Fri Aug 04, 2017 at 03:59:12PM -0400, Neil Leeder wrote:
>>>>> This adds a driver for the SMMUv3 PMU into the perf framework.
>>>>> It includes an IORT update to support PM Counter Groups.
>>>>>
>>>>
>>>> In one of Cavium's upcoming SOC, SMMU PMCG implementation is such a way
>>>> that platform bus id (Device ID in ITS terminmology)is shared with that of SMMU.
>>>> This would be a matter of concern for software if the SMMU and SMMU PMCG blocks
>>>> are managed by two independent drivers.
>>>>
>>>> The problem arises when we want to alloc/free MSIs for these devices
>>>> using the APIs, platform_msi_domain_alloc/free_irqs.
>>>> Platform bus id being same for these two hardware blocks, they end up sharing the same
>>>> ITT(Interrupt Translation Table) in GIC ITS and hence alloc, free and management
>>>> of this shared ITT becomes a problem when they are managed by two independent
>>>> drivers.
>>>
>>> What is the problem exactly? IIRC resizing a possibly-live ITT is a 
>>> right pain in the bum to do - is it just that?
>>
>> Understatement of the day! ;-) Yes, it is a massive headache, and will
>> either result in a temporary loss of interrupts (at some point you have
>> to unmap the ITT), or with spurious interrupts (you generate interrupts
>> for all the MSIs you've blackholed when unmapping the ITT).
> 
> Just sharing a thought.
> 
> If the firmware, through device tree/ACPI 
> can provide the following input to the ITS driver,
> (For example, as part of msi-parent property in device tree)
> 
> 1. flag indicating the ITT (Device ID) is being shared 
> 2. the maximum number of vectors that are required to be allocated for this ITT
> 
> resizing of ITT and the associated complexities could be avoided.

I'm not sure it is that simple.

First, this is a change of the spec, and we need to support the current
states of ACPI and DT. In any case, this would need to affect all nodes.

Then, MSIs are very dynamic, and there may be decision that SW makes at
runtime that would change the parameters of the ITT allocation
(platform_msi_domain_alloc_irqs does take an nvec parameter that could
override firmware data -- what if all the drivers do that?).

Finally, and assuming we still want to go in that direction, I'd rather
have each node describing its maximum MSI allocation and let the ITS
driver sum it up, much like we do it on PCI.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
