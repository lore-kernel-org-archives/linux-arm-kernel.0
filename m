From: vijay.kilari@gmail.com (Vijay Kilari)
Date: Mon, 11 Nov 2013 16:39:46 +0530
Subject: [PATCH v4 3/4] AArch64: KGDB: Add step debugging support
In-Reply-To: <20131108141841.GI17461@mudshark.cambridge.arm.com>
References: <1383641146-27274-1-git-send-email-vijay.kilari@gmail.com>
 <1383641146-27274-4-git-send-email-vijay.kilari@gmail.com>
 <20131108141841.GI17461@mudshark.cambridge.arm.com>
Message-ID: <CALicx6uaK_xk+nNCvYMjO2FrNQDQWqhWk54NMccYTE2ji=gycw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 8, 2013 at 7:48 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Nov 05, 2013 at 08:45:45AM +0000, vijay.kilari at gmail.com wrote:
>> From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
>>
>> Add KGDB software step debugging support for EL1 debug
>> in AArch64 mode.
>>
>> KGDB registers step debug handler with debug monitor.
>> On receiving 'step' command from GDB tool, target enables
>> software step debugging and step address is updated.
>> If no step address is received from GDB tool, target assumes
>> next step address is current PC.
>>
>> Software Step debugging is disabled when 'continue' command
>> is received
>>
>> Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
>> ---
>>  arch/arm64/kernel/kgdb.c |   67 +++++++++++++++++++++++++++++++++++++++-------
>>  1 file changed, 58 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
>> index ec624bc..f10f2ba 100644
>> --- a/arch/arm64/kernel/kgdb.c
>> +++ b/arch/arm64/kernel/kgdb.c
>> @@ -137,13 +137,26 @@ void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc)
>>
>>  static int compiled_break;
>>
>> +static void kgdb_arch_update_addr(struct pt_regs *regs,
>> +                             char *remcom_in_buffer)
>> +{
>> +     unsigned long addr;
>> +     char *ptr;
>> +
>> +     ptr = &remcom_in_buffer[1];
>> +     if (kgdb_hex2long(&ptr, &addr))
>> +             kgdb_arch_set_pc(regs, addr);
>> +     else if (compiled_break == 1)
>> +             kgdb_arch_set_pc(regs, regs->pc + 4);
>> +
>> +     compiled_break = 0;
>> +}
>> +
>>  int kgdb_arch_handle_exception(int exception_vector, int signo,
>>                              int err_code, char *remcom_in_buffer,
>>                              char *remcom_out_buffer,
>>                              struct pt_regs *linux_regs)
>>  {
>> -     unsigned long addr;
>> -     char *ptr;
>>       int err;
>>
>>       switch (remcom_in_buffer[0]) {
>> @@ -153,6 +166,8 @@ int kgdb_arch_handle_exception(int exception_vector, int signo,
>>                * Packet D (Detach), k (kill). No special handling
>>                * is required here
>>                */
>> +             atomic_set(&kgdb_cpu_doing_single_step, -1);
>> +             kgdb_single_step =  0;
>
> This looks really weird: you have two variables, which you attempt to keep
> in sync, only one of them is an atomic access and you don't have any
> locking or memory barriers between them, so it must be ok if they're not
> in-sync. In which case, why do we have two variables?
>
IMHO, two variables are being used by kgdb framework
The variables 'kgdb_cpu_doing_single_step'  holds the cpu on which
step debugging
is happening. With this, when during step debugging, it ensures that on next
step debug exception only this CPU aquires master lock and step
debugging is performed.

The variable 'kgdb_single_step' is used to know if step debugging is
ongoing or not.
If so, the non-primary cpu's are not released untill the continue
command is received
So, with this the cpu's are not released and acquired for every step command

> Will
