From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Tue, 3 Jun 2014 09:27:24 -0700
Subject: [PATCH] arm64: ptrace: fix empty registers set in prstatus of
 aarch32 process core
In-Reply-To: <20140603144602.GN23149@arm.com>
References: <1401774369-7060-1-git-send-email-victor.kamensky@linaro.org>
 <1401774369-7060-2-git-send-email-victor.kamensky@linaro.org>
 <20140603144602.GN23149@arm.com>
Message-ID: <CAA3XUr2J7X3emYJgHFxBcP5TudazU68TQ4DL8YGLDmDSDbDCUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 3 June 2014 07:46, Will Deacon <will.deacon@arm.com> wrote:
> Hi Victor,
>
> Thanks for both the fix and the detailed explanation!
>
> On Tue, Jun 03, 2014 at 06:46:09AM +0100, Victor Kamensky wrote:
>> Currently core file of aarch32 process prstatus note has empty
>> registers set. As result aarch32 core files create by V8 kernel are
>> not very useful.
>>
>> It happens because compat_gpr_get and compat_gpr_set functions can
>> copy registers values to/from either kbuf or ubuf. ELF core file
>> collection function fill_thread_core_info calls compat_gpr_get
>> with kbuf set and ubuf set to 0. But current compat_gpr_get and
>> compat_gpr_set function handle copy to/from only ubuf case.
>>
>> Fix is to handle kbuf and ubuf as two separate cases in similar
>> way as other functions like user_regset_copyout, user_regset_copyin do.
>
> An alternative is to use set_fs when kbuf is set, then use
> copy_{to,from}_user for everything. However, given how ugly I find
> set_fs to start with, your patch looks good to me:
>
>   Acked-by: Will Deacon <will.deacon@arm.com>

Thank you for review. Please forgive my naive question, I've tried to
google it, but does not look I do a good job. Is there any special thing
I need to do, so you or Catalin would pick this up? I've posted patches
to Russell's patch system before but never dealt with arm64 patches.

Or I just need to repost the patch to linux-arm-kernel with your
'Acked-by'  and Cc: stable at vger.kernel.org in it?

Thanks,
Victor

> We probably want a CC stable too.
>
> Cheers,
>
> Will
>
>> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
>> ---
>>  arch/arm64/kernel/ptrace.c | 28 +++++++++++++++++++---------
>>  1 file changed, 19 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
>> index 6a8928b..9c9c2b9 100644
>> --- a/arch/arm64/kernel/ptrace.c
>> +++ b/arch/arm64/kernel/ptrace.c
>> @@ -650,11 +650,16 @@ static int compat_gpr_get(struct task_struct *target,
>>                       reg = task_pt_regs(target)->regs[idx];
>>               }
>>
>> -             ret = copy_to_user(ubuf, &reg, sizeof(reg));
>> -             if (ret)
>> -                     break;
>> -
>> -             ubuf += sizeof(reg);
>> +             if (kbuf) {
>> +                     memcpy(kbuf, &reg, sizeof(reg));
>> +                     kbuf += sizeof(reg);
>> +             } else {
>> +                     ret = copy_to_user(ubuf, &reg, sizeof(reg));
>> +                     if (ret)
>> +                             break;
>> +
>> +                     ubuf += sizeof(reg);
>> +             }
>>       }
>>
>>       return ret;
>> @@ -684,11 +689,16 @@ static int compat_gpr_set(struct task_struct *target,
>>               unsigned int idx = start + i;
>>               compat_ulong_t reg;
>>
>> -             ret = copy_from_user(&reg, ubuf, sizeof(reg));
>> -             if (ret)
>> -                     return ret;
>> +             if (kbuf) {
>> +                     memcpy(&reg, kbuf, sizeof(reg));
>> +                     kbuf += sizeof(reg);
>> +             } else {
>> +                     ret = copy_from_user(&reg, ubuf, sizeof(reg));
>> +                     if (ret)
>> +                             return ret;
>>
>> -             ubuf += sizeof(reg);
>> +                     ubuf += sizeof(reg);
>> +             }
>>
>>               switch (idx) {
>>               case 15:
>> --
>> 1.8.1.4
>>
>>
