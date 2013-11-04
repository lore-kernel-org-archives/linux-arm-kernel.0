From: vijay.kilari@gmail.com (Vijay Kilari)
Date: Mon, 4 Nov 2013 16:51:07 +0530
Subject: [PATCH v3 3/4] AArch64: KGDB: Add step debugging support
In-Reply-To: <5271C20E.4020104@linaro.org>
References: <1382094469-7971-1-git-send-email-vijay.kilari@gmail.com>
 <1382094469-7971-4-git-send-email-vijay.kilari@gmail.com>
 <5271C20E.4020104@linaro.org>
Message-ID: <CALicx6uvWOivPLj6dTENy_ujZMCnS_bxAWfG5GGzaKGz0NFpag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 31, 2013 at 8:05 AM, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
> Hi,
>
>
> On 10/18/2013 08:07 PM, vijay.kilari at gmail.com wrote:
>>
>> From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
>>
>> Add KGDB software step debugging support for EL1 debug
>> in AArch64 mode.
>>
>> diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
>> index 50cef79..2b0b987 100644
>> --- a/arch/arm64/kernel/kgdb.c
>> +++ b/arch/arm64/kernel/kgdb.c
>
>> ...
>
>>   int kgdb_arch_handle_exception(int exception_vector, int signo,
>>                                int err_code, char *remcom_in_buffer,
>>                                char *remcom_out_buffer,
>>                                struct pt_regs *linux_regs)
>>   {
>
>> ...
>
>> +       case 's':
>> +               /*
>> +                * Update step address value with address passed
>> +                * with step packet.
>> +                * On debug exception return PC is copied to ELR
>> +                * So just update PC.
>> +                * If no step address is passed, resume from the address
>> +                * pointed by PC. Do not update PC
>> +                */
>> +               kgdb_arch_update_addr(linux_regs, remcom_in_buffer);
>>
>> +               /*
>> +                * Enable single step handling
>> +                */
>> +               if (!kernel_active_single_step())
>> +                       kernel_enable_single_step(linux_regs);
>>                 err = 0;
>>                 break;
>>         default:
>
>
> Other architectures handle the state, by modifying kgdb_single_step or
> kgdb_cpu_doing_single_step, when entering into or exiting from single
> step mode.
>
> Do you have a good reason that you don't need to do so on arm64?
> (I'm just asking because my own kgdb patch follows the way that x86 does.)
>

 The 'kgdb_cpu_doing_single_step' is set with the cpu on which the step command
is issued for that pid. So when an debug exception occurs, the debug
handler (kdgb_cpu_enter)
checks if cpu on which step debug was enabled acquires master lock and
step debugging
is performed on the same cpu for the pid

In case of arm64, the step exception is always taken on the cpu on
which the step
debugging is enabled and step debugging is disabled on continue command.

In case of kgdb_single_step, if this is not set, the slave locks
(cpu's which has not
taken debug exception) are released for every step command and
acquired on next step
exception and slave cpu's are again set into tight loop by sending smp
request/nmi.
When set, the slave locks are not released untill step debugging ends.
So it avoids acquiring slave lock for every step debug exception

This improvement can be taken for arm64. I will re-send new version of patches
But I don't see this is taken care in armv7

> -Takahiro AKASHI
