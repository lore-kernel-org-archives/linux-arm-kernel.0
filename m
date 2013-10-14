From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 14 Oct 2013 09:43:04 +0100
Subject: [PATCH] ARM: KVM: drop arbitrary limitation to 4 CPU VMs
In-Reply-To: <20131013010956.GA8200@cbox>
References: <1381252628-17840-1-git-send-email-marc.zyngier@arm.com>
 <20131013010956.GA8200@cbox>
Message-ID: <525BAE98.8050505@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/10/13 02:09, Christoffer Dall wrote:
> On Tue, Oct 08, 2013 at 06:17:08PM +0100, Marc Zyngier wrote:
>> It appears we have an arbitrary limitation where we refuse to
>> create more than 4 virtual A15 in a single VM.
>>
>> This limitation doesn't make much sense (the number 4 probably
>> comes from the maximum number of CPUs in a A15 cluster, but
>> KVM doesn't have any notion of cluster), and directly
>> contradicts CONFIG_MAX_VCPUS.
> 
> So this comes from the early days where I looked at the A15 TRM and the
> MPIDR bit field for the CPU ID is limited to 2 bits.  Exactly because
> I wasn't sure what remifications (if any) it would have to start
> populating this register with cluster id = (vcpu_id / 4) and cpu id =
> (vcpu_id % 4) I put this nice arbitrary restriction in there.
> 
> I think we need to fix how we show this register to the guest
> otherwise... No?

I don't see this being an issue, but if we really want to be 100% true
to the A15/A7 TRM, we can always compute MPIDR that way, and adjust
L2CTLR as well.

That will require some userspace change in kvmtool though (need to
change the DT generator to cope with the cluster ID).

	M.
-- 
Jazz is not dead. It just smells funny...
