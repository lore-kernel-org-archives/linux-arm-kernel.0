From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 15 Mar 2017 14:33:31 +0000
Subject: [PATCH 3/3] kvm: arm/arm64: Fix locking for kvm_free_stage2_pgd
In-Reply-To: <0e5ff7f7-855c-ea28-fdee-73c062c3d289@arm.com>
References: <1489503154-20705-1-git-send-email-suzuki.poulose@arm.com>
 <1489503154-20705-4-git-send-email-suzuki.poulose@arm.com>
 <20170315092147.GM1277@cbox> <314fbde3-17e6-414b-85e6-326de22bdc1c@arm.com>
 <20170315105639.GA31974@cbox> <0e5ff7f7-855c-ea28-fdee-73c062c3d289@arm.com>
Message-ID: <0afc4248-9a1b-ee0f-8f9b-5357707b9d72@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/03/17 13:28, Marc Zyngier wrote:
> On 15/03/17 10:56, Christoffer Dall wrote:
>> On Wed, Mar 15, 2017 at 09:39:26AM +0000, Marc Zyngier wrote:
>>> On 15/03/17 09:21, Christoffer Dall wrote:
>>>> On Tue, Mar 14, 2017 at 02:52:34PM +0000, Suzuki K Poulose wrote:
>>>>> In kvm_free_stage2_pgd() we don't hold the kvm->mmu_lock while calling
>>>>> unmap_stage2_range() on the entire memory range for the guest. This could
>>>>> cause problems with other callers (e.g, munmap on a memslot) trying to
>>>>> unmap a range.
>>>>>
>>>>> Fixes: commit d5d8184d35c9 ("KVM: ARM: Memory virtualization setup")
>>>>> Cc: stable at vger.kernel.org # v3.10+
>>>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>>>> Cc: Christoffer Dall <christoffer.dall@linaro.org>
>>>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

...

>> ok, then there's just the concern that we may be holding a spinlock for
>> a very long time.  I seem to recall Mario once added something where he
>> unlocked and gave a chance to schedule something else for each PUD or
>> something like that, because he ran into the issue during migration.  Am
>> I confusing this with something else?
>
> That definitely rings a bell: stage2_wp_range() uses that kind of trick
> to give the system a chance to breathe. Maybe we could use a similar
> trick in our S2 unmapping code? How about this (completely untested) patch:
>
> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index 962616fd4ddd..1786c24212d4 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -292,8 +292,13 @@ static void unmap_stage2_range(struct kvm *kvm, phys_addr_t start, u64 size)
>  	phys_addr_t addr = start, end = start + size;
>  	phys_addr_t next;
>
> +	BUG_ON(!spin_is_locked(&kvm->mmu_lock));
> +
>  	pgd = kvm->arch.pgd + stage2_pgd_index(addr);
>  	do {
> +		if (need_resched() || spin_needbreak(&kvm->mmu_lock))
> +			cond_resched_lock(&kvm->mmu_lock);

nit: I think we could make the cond_resched_lock() unconditionally here:
Given, __cond_resched_lock() already does all the above checks :

kernel/sched/core.c:

int __cond_resched_lock(spinlock_t *lock)
{
         int resched = should_resched(PREEMPT_LOCK_OFFSET);

...

         if (spin_needbreak(lock) || resched) {


Suzuki
