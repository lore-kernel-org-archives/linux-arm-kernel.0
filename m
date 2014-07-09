From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 09 Jul 2014 12:18:30 +0100
Subject: [PATCH v3 8/9] arm64: KVM: implement lazy world switch for debug
 registers
In-Reply-To: <20140709094505.GD19801@cbox> (Christoffer Dall's message of
 "Wed, 9 Jul 2014 10:45:05 +0100")
References: <1403269207-1625-1-git-send-email-marc.zyngier@arm.com>
 <1403269207-1625-9-git-send-email-marc.zyngier@arm.com>
 <20140709094505.GD19801@cbox>
Message-ID: <87d2de7pbt.fsf@why.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 09 2014 at 10:45:05 am BST, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> On Fri, Jun 20, 2014 at 02:00:06PM +0100, Marc Zyngier wrote:
>> Implement switching of the debug registers. While the number
>> of registers is massive, CPUs usually don't implement them all
>> (A57 has 6 breakpoints and 4 watchpoints, which gives us a total
>> of 22 registers "only").
>>
>> Also, we only save/restore them when MDSCR_EL1 has debug enabled,
>> or when we've flagged the debug registers as dirty. It means that
>> most of the time, we only save/restore MDSCR_EL1.
>>
>> Reviewed-by: Anup Patel <anup.patel@linaro.org>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm64/kernel/asm-offsets.c |   1 +
>>  arch/arm64/kvm/hyp.S            | 462 +++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 457 insertions(+), 6 deletions(-)
>>

[...]

>> @@ -609,6 +1052,13 @@ __kvm_vcpu_return:
>>
>>       bl __restore_sysregs
>>       bl __restore_fpsimd
>> +
>> +     skip_debug_state x3, 1f
>> +     // Clear the dirty flag for the next run, as all the state has
>> +     // already been saved.
>> +     str     xzr, [x0, #VCPU_DEBUG_FLAGS]
>> +     bl      __restore_debug
>> +1:
>>       restore_host_regs
>>
>>       mov     x0, x1
>> --
>> 1.8.3.4
>>
>
> let's just try to remember the fact that we overwrite the entire bitmask
> here if we add more bits to that value some time:

I'll add a comment to that effect.

> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>

Thanks!

	M.
-- 
Without deviation from the norm, progress is not possible.
