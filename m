From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Wed, 14 May 2014 07:18:26 -0700
Subject: [PATCH v3 13/14] ARM64: KVM: set and get of sys registers in BE
 case
In-Reply-To: <87lhu4hhou.fsf@approximate.cambridge.arm.com>
References: <1399997646-4716-1-git-send-email-victor.kamensky@linaro.org>
 <1399997646-4716-14-git-send-email-victor.kamensky@linaro.org>
 <87lhu4hhou.fsf@approximate.cambridge.arm.com>
Message-ID: <CAA3XUr0PigqiPwxUEMLvFoOaA8EzJfSteavqU4X1WoXSP2F4eA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 May 2014 01:45, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Hi Victor,
>
> On Tue, May 13 2014 at  5:14:05 pm BST, Victor Kamensky <victor.kamensky@linaro.org> wrote:
>> This patch addresses issue of reading and writing V8 sys registers in
>> BE case. Since only register size function deals with is 8 bytes,
>> existing code works in both little and big endian cases.
>> Removed comment about little endian. Added BUG_ON that register
>> size should be always 8 bytes.
>>
>> If these functions would ever need to support both 8 bytes and 4 bytes
>> register sizes to deals with them in endian agnostic way code should
>> do something along these lines:
>>
>>        unsigned long regsize = KVM_REG_SIZE(id);
>>        union {
>>                u32     word;
>>                u64     dword;
>>        } tmp = {0};
>>
>>        if (copy_from_user(&tmp, uaddr, regsize) != 0)
>>                return -EFAULT;
>>        switch (regsize) {
>>        case 4:
>>                *val = tmp.word;
>>                break;
>>        case 8:
>>                *val = tmp.dword;
>>                break;
>>        }
>>
>> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
>> ---
>>  arch/arm64/kvm/sys_regs.c | 19 +++++++++++++------
>>  1 file changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index 0324458..060c3a9 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -776,18 +776,25 @@ static struct sys_reg_desc invariant_sys_regs[] = {
>>         NULL, get_ctr_el0 },
>>  };
>>
>> -static int reg_from_user(void *val, const void __user *uaddr, u64 id)
>> +static int reg_from_user(u64 *val, const void __user *uaddr, u64 id)
>>  {
>> -     /* This Just Works because we are little endian. */
>> -     if (copy_from_user(val, uaddr, KVM_REG_SIZE(id)) != 0)
>> +     unsigned long regsize = KVM_REG_SIZE(id);
>> +
>> +     BUG_ON(regsize != 8);
>
> I haven't had time to review this series just yet, but this bit just
> sends chivers down my spine.
>
> regsize is derived from id, which comes from a struct one_reg, which is
> directly provided by userspace. Here, you're trusting the luser to give
> you 8 as a size, and panic the kernel if not.
>
> As much as I'd like to qualify this as only being a slightly undesirable
> effect, I think it deserves a NAK.

Fair enough. I agree. Good catch! I was following on Christoffer's comments
at [1], but I have not thought it through. Please advise should I come back to
previous version as in [2] or just ignore any sizes other than 8 without
having BUG_ON?

Thanks,
Victor

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-March/241815.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/231891.html

> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny.
