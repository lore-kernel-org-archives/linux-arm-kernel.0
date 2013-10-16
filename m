From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 16 Oct 2013 10:49:56 +0100
Subject: [PATCH] ARM: KVM: drop arbitrary limitation to 4 CPU VMs
In-Reply-To: <20131015232108.GD20547@cbox>
References: <1381252628-17840-1-git-send-email-marc.zyngier@arm.com>
 <20131013010956.GA8200@cbox> <525BAE98.8050505@arm.com>
 <20131015232108.GD20547@cbox>
Message-ID: <525E6144.3060004@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/10/13 00:21, Christoffer Dall wrote:
> On Mon, Oct 14, 2013 at 09:43:04AM +0100, Marc Zyngier wrote:
>> On 13/10/13 02:09, Christoffer Dall wrote:
>>> On Tue, Oct 08, 2013 at 06:17:08PM +0100, Marc Zyngier wrote:
>>>> It appears we have an arbitrary limitation where we refuse to
>>>> create more than 4 virtual A15 in a single VM.
>>>>
>>>> This limitation doesn't make much sense (the number 4 probably
>>>> comes from the maximum number of CPUs in a A15 cluster, but
>>>> KVM doesn't have any notion of cluster), and directly
>>>> contradicts CONFIG_MAX_VCPUS.
>>>
>>> So this comes from the early days where I looked at the A15 TRM and the
>>> MPIDR bit field for the CPU ID is limited to 2 bits.  Exactly because
>>> I wasn't sure what remifications (if any) it would have to start
>>> populating this register with cluster id = (vcpu_id / 4) and cpu id =
>>> (vcpu_id % 4) I put this nice arbitrary restriction in there.
>>>
>>> I think we need to fix how we show this register to the guest
>>> otherwise... No?
>>
>> I don't see this being an issue, but if we really want to be 100% true
>> to the A15/A7 TRM, we can always compute MPIDR that way, and adjust
>> L2CTLR as well.
> 
> Even with mach-virt we're still pretending to be an A15/A7 right? I
> think we should adhere to that.  Is there some other reason why people
> shouldn't generally expect MPIDR to be correct (merging this code to KVM
> and running in a VM notwithstanding)?

Yes, it is probably better to adhere to the law of least surprise. I'm
reworking this patch and will repost (slightly longer) the series.

>>
>> That will require some userspace change in kvmtool though (need to
>> change the DT generator to cope with the cluster ID).
>>
> That would be the less fun part...

Actually, it is surprisingly easy once the kernel does the right thing.

	M.
-- 
Jazz is not dead. It just smells funny...
