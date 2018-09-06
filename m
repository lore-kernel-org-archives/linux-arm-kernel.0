From: julien.thierry@arm.com (Julien Thierry)
Date: Thu, 6 Sep 2018 15:25:28 +0100
Subject: [RESEND PATCH 5/8] ARM: signal: copy registers using
 __copy_to_user()
In-Reply-To: <20180906124926.GP30658@n2100.armlinux.org.uk>
References: <1535447316-32187-1-git-send-email-julien.thierry@arm.com>
 <1535447316-32187-6-git-send-email-julien.thierry@arm.com>
 <20180906124926.GP30658@n2100.armlinux.org.uk>
Message-ID: <39d0fc48-8306-ce8a-0029-1cb329e43c9a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 06/09/18 13:49, Russell King - ARM Linux wrote:
> Hi Julien,
> 
> I would much prefer these to be ordered before the patches changing
> __put_user() etc.  That would then allow patch 2 (which would become
> the last patch) to get rid of __put_user_error() - __put_user_error()
> is utterly pointless with the need to work around Spectre, and that
> would reflect what was done in my series for Spectre variant 1.
> 

Yes, I organized the series this way so the mitigation patches could be 
picked up without the rest but I am happy reordering it.

> In any case, removing it from signal handling, vfp and oabi compat
> should mean that after your existing series, there are no users of
> __put_user_error(), but it still remains.
> 

Yes, I tried reducing the number of uses of __put_user_error but a few 
remained in signal.c where replacing with them with __copy_to_user  was 
less of an optimization since it was only writing unsigned longs.

But since there are just a few remaining calls to it, I'll replace them 
so __put_user_error can go.

I'll send a new version fixing this and the range checking.

Thanks,

> Thanks.
> 
> On Tue, Aug 28, 2018 at 10:08:33AM +0100, Julien Thierry wrote:
>> When saving the ARM integer registers, use __copy_to_user() to
>> copy them into user signal frame, rather than __put_user_error().
>> This has the benefit of disabling/enabling PAN once for the whole copy
>> intead of once per write.
>>
>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>> ---
>>   arch/arm/kernel/signal.c | 49 ++++++++++++++++++++++++++----------------------
>>   1 file changed, 27 insertions(+), 22 deletions(-)
>>
>> diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
>> index b8f766c..76fe75d 100644
>> --- a/arch/arm/kernel/signal.c
>> +++ b/arch/arm/kernel/signal.c
>> @@ -288,30 +288,35 @@ asmlinkage int sys_rt_sigreturn(struct pt_regs *regs)
>>   setup_sigframe(struct sigframe __user *sf, struct pt_regs *regs, sigset_t *set)
>>   {
>>   	struct aux_sigframe __user *aux;
>> +	struct sigcontext context;
>>   	int err = 0;
>>   
>> -	__put_user_error(regs->ARM_r0, &sf->uc.uc_mcontext.arm_r0, err);
>> -	__put_user_error(regs->ARM_r1, &sf->uc.uc_mcontext.arm_r1, err);
>> -	__put_user_error(regs->ARM_r2, &sf->uc.uc_mcontext.arm_r2, err);
>> -	__put_user_error(regs->ARM_r3, &sf->uc.uc_mcontext.arm_r3, err);
>> -	__put_user_error(regs->ARM_r4, &sf->uc.uc_mcontext.arm_r4, err);
>> -	__put_user_error(regs->ARM_r5, &sf->uc.uc_mcontext.arm_r5, err);
>> -	__put_user_error(regs->ARM_r6, &sf->uc.uc_mcontext.arm_r6, err);
>> -	__put_user_error(regs->ARM_r7, &sf->uc.uc_mcontext.arm_r7, err);
>> -	__put_user_error(regs->ARM_r8, &sf->uc.uc_mcontext.arm_r8, err);
>> -	__put_user_error(regs->ARM_r9, &sf->uc.uc_mcontext.arm_r9, err);
>> -	__put_user_error(regs->ARM_r10, &sf->uc.uc_mcontext.arm_r10, err);
>> -	__put_user_error(regs->ARM_fp, &sf->uc.uc_mcontext.arm_fp, err);
>> -	__put_user_error(regs->ARM_ip, &sf->uc.uc_mcontext.arm_ip, err);
>> -	__put_user_error(regs->ARM_sp, &sf->uc.uc_mcontext.arm_sp, err);
>> -	__put_user_error(regs->ARM_lr, &sf->uc.uc_mcontext.arm_lr, err);
>> -	__put_user_error(regs->ARM_pc, &sf->uc.uc_mcontext.arm_pc, err);
>> -	__put_user_error(regs->ARM_cpsr, &sf->uc.uc_mcontext.arm_cpsr, err);
>> -
>> -	__put_user_error(current->thread.trap_no, &sf->uc.uc_mcontext.trap_no, err);
>> -	__put_user_error(current->thread.error_code, &sf->uc.uc_mcontext.error_code, err);
>> -	__put_user_error(current->thread.address, &sf->uc.uc_mcontext.fault_address, err);
>> -	__put_user_error(set->sig[0], &sf->uc.uc_mcontext.oldmask, err);
>> +	context = (struct sigcontext) {
>> +		.arm_r0        = regs->ARM_r0,
>> +		.arm_r1        = regs->ARM_r1,
>> +		.arm_r2        = regs->ARM_r2,
>> +		.arm_r3        = regs->ARM_r3,
>> +		.arm_r4        = regs->ARM_r4,
>> +		.arm_r5        = regs->ARM_r5,
>> +		.arm_r6        = regs->ARM_r6,
>> +		.arm_r7        = regs->ARM_r7,
>> +		.arm_r8        = regs->ARM_r8,
>> +		.arm_r9        = regs->ARM_r9,
>> +		.arm_r10       = regs->ARM_r10,
>> +		.arm_fp        = regs->ARM_fp,
>> +		.arm_ip        = regs->ARM_ip,
>> +		.arm_sp        = regs->ARM_sp,
>> +		.arm_lr        = regs->ARM_lr,
>> +		.arm_pc        = regs->ARM_pc,
>> +		.arm_cpsr      = regs->ARM_cpsr,
>> +
>> +		.trap_no       = current->thread.trap_no,
>> +		.error_code    = current->thread.error_code,
>> +		.fault_address = current->thread.address,
>> +		.oldmask       = set->sig[0],
>> +	};
>> +
>> +	err |= __copy_to_user(&sf->uc.uc_mcontext, &context, sizeof(context));
>>   
>>   	err |= __copy_to_user(&sf->uc.uc_sigmask, set, sizeof(*set));
>>   
>> -- 
>> 1.9.1
>>
> 

-- 
Julien Thierry
