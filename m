From: illusionist.neo@gmail.com (Shubham Bansal)
Date: Wed, 24 May 2017 00:43:59 +0530
Subject: [PATCH] RFC: arm: eBPF JIT compiler
In-Reply-To: <20170523190041.GB22219@n2100.armlinux.org.uk>
References: <1495564433-9750-1-git-send-email-illusionist.neo@gmail.com>
 <20170523190041.GB22219@n2100.armlinux.org.uk>
Message-ID: <CAHgaXdKEv8zt-pHUrDE9J3K_fY-+z9ctxP+YCBOiWm5TUusr7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Wed, May 24, 2017 at 12:30 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> Hi,
>
> On Wed, May 24, 2017 at 12:03:53AM +0530, Shubham Bansal wrote:
>> The JIT compiler emits ARM 32 bit instructions. Currently, It supports
>> eBPF only. Classic BPF is supported because of the conversion by BPF
>> core.
>>
>> JIT is enabled with
>>
>>       echo 1 > /proc/sys/net/core/bpf_jit_enable
>>
>> Constant Blinding can be enabled along with JIT using
>>
>>       echo 1 > /proc/sys/net/core/bpf_jit_enable
>>       echo 2 > /proc/sys/net/core/bpf_jit_harden
>>
>> See Documentation/networking/filter.txt for more information.
>> Tested on ARMv7 with CONFIG_FRAME_POINTER enabled.
>
> What is this patch actually doing?
This is the first implementation of eBPF JIT for ARM.
>
> The commit message doesn't describe what changes this patch is doing,
> and it needs to.  Presumably, it's adding support for eBPF?

Apologies. I thought commit message was good enough to understand. I
will resend the patch if needed.
Although, Its an RFC. I am requesting the community for with testing
and suggestions.

>
> If that's so, doesn't it need to change us from selecting HAVE_CBPF_JIT
> to selecting HAVE_EBPF_JIT ?

This patch is only for comments and testing. I thought, KConfig
changes wouldn't be needed unless
the patch is accepted.

>
> What about cases where the frame pointer is not enabled?If that's
> not supported then shouldn't the Kconfig be adjusted?  What about
> users who are using cBPF without the frame pointer enabled?

I have tested it with and without the frame pointer as indicated in
the results shown in the mail.

>
> I haven't been able to go through the patch analysing it fully, but
> what I have read doesn't give me any immediate concerns.  Only one
> spelling mistake stood out.

>
> Some things that I'm wondering though - what about endian issues?
> LDRD, for example, takes two registers, in ARM mode, these registers
> must be an even-odd pair.  The even register is loaded from at the
> lowest address, the odd register from the higher address.  This means
> when loading a BE value, the most significant word is in the even
> numbered register and the least significant word is in the odd numbered
> register.  For LE values, the even numbered register contains the least
> significant word.  Are we properly handling issues like this in all
> places?

Actually I haven't tested it with BE but tested it LE as I wasn't able
to run qemu to test it properly for BE.
I request anyone who has information on how to test it to help me with it.

>
>> +static const u8 bpf2a32[][2] = {
>> +     /* return value from in-kernel function, and exit value from eBPF */
>> +     [BPF_REG_0] = {ARM_R1, ARM_R0},
>> +     /* arguments from eBPF program to in-kernel function */
>> +     [BPF_REG_1] = {ARM_R3, ARM_R2},
>> +     /* Stored on stack scratch space */
>> +     [BPF_REG_2] = {STACK_OFFSET(0), STACK_OFFSET(4)},
>> +     [BPF_REG_3] = {STACK_OFFSET(8), STACK_OFFSET(12)},
>> +     [BPF_REG_4] = {STACK_OFFSET(16), STACK_OFFSET(20)},
>> +     [BPF_REG_5] = {STACK_OFFSET(24), STACK_OFFSET(28)},
>> +     /* callee saved registers that in-kernel function will preserve */
>> +     [BPF_REG_6] = {ARM_R5, ARM_R4},
>> +     /* Stored on stack scratch space */
>> +     [BPF_REG_7] = {STACK_OFFSET(32), STACK_OFFSET(36)},
>> +     [BPF_REG_8] = {STACK_OFFSET(40), STACK_OFFSET(44)},
>> +     [BPF_REG_9] = {STACK_OFFSET(48), STACK_OFFSET(52)},
>> +     /* Read only Frame Pointer to access Stack */
>> +     [BPF_REG_FP] = {STACK_OFFSET(56), STACK_OFFSET(60)},
>> +     /* Temperory Register for internal BPF JIT, can be used
>
>         "Temporary"
I will correct that right away.

Thanks for the suggestions Russell.

-Shubham
