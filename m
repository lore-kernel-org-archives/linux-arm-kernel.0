From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 30 Mar 2017 16:41:49 +0100
Subject: KVM/ARM: sleeping function called from invalid context
In-Reply-To: <20170330152955.GJ16211@leverpostej>
References: <20170330143112.GI16211@leverpostej>
 <20170330152955.GJ16211@leverpostej>
Message-ID: <e25e57ee-5ba5-4343-ed4e-aad6f4e665b4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/03/17 16:29, Mark Rutland wrote:
> On Thu, Mar 30, 2017 at 03:31:12PM +0100, Mark Rutland wrote:
>> Hi,
>>
>> I'm seeing the splat below when running KVM on an arm64 host with
>> CONFIG_DEBUG_ATOMIC_SLEEP and CONFIG_LOCKDEP enabled.
>>
>> I saw this on v4.11-rc1, and I can reproduce the problem on the current
>> kvmarm master branch (563e2f5daa66fbc1).
>>
>> I've hacked noinlines into arch/arm/kvm/mmu.c in an attempt to get a
>> better backtrace; without this, the report says the call is at
>> arch/arm/kvm/mmu.c:299, which is somewhat confusing.
> 
> Looking again, that initial kernel was not a vanilla v4.11-rc1, and I am
> *not* able to reproduce this issue with a vanilla v4.11-rc1.
> 
> I believe I had applied an earlier fix for the locking issue Suzuki
> recently addressed, which was why my line numbers were off.
> 
> I *can* trigger this issue with the current kvmarm master, and the log I
> posted is valid.
> 
> Sorry for the bogus info; I will be more careful next time.

No worries, thanks Mark.

So here's my (very) superficial analysis of the issue:
- Memory pressure, we try to swap out something
- try_to_unmap_one takes a spinlock (via page_vma_mapped_walk)
- MMU notifier kick in with the spinlock held
- we take kvm->mmu_lock
- in unmap_stage2_range, we do a cond_resched_lock(kvm->mmu_lock)
- we still hold the page_vma_mapped_walk spinlock, might_sleep screams

I can see multiple ways of doing this:
1) We track that we're coming via an MMU notifier, and don't call
cond_resched_lock() in that case
2) We get rid of cond_resched_lock()
3) we have a different code path for the MMU notifier that doesn't
involve cond_resched_lock().

Only (1) vaguely appeals to me, and I positively hate (3). We could
revert to (2), but it is likely to be helpful when tearing down large
ranges.

Another possibility is that the might_sleep() warning is just spurious,
and I think that Suzuki has a theory...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
