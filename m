From: luto@amacapital.net (Andy Lutomirski)
Date: Tue, 1 Jul 2014 07:11:54 -0700
Subject: [PATCH v7 7/9] ARM: add vdso user-space code
In-Reply-To: <53B2B8D3.7040400@mentor.com>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
 <1403493118-7597-8-git-send-email-nathan_lynch@mentor.com>
 <53B1D6B8.7080806@amacapital.net> <20140701090034.GB28164@arm.com>
 <53B2B8D3.7040400@mentor.com>
Message-ID: <CALCETrXQKT8NkPCggdXZHz7+P+X1jpnzpH8BGLULVOE1fvoJ1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 1, 2014 at 6:34 AM, Nathan Lynch <Nathan_Lynch@mentor.com> wrote:
> On 07/01/2014 04:00 AM, Will Deacon wrote:
>> On Mon, Jun 30, 2014 at 10:29:28PM +0100, Andy Lutomirski wrote:
>>> On 06/22/2014 08:11 PM, Nathan Lynch wrote:
>>>> diff --git a/arch/arm/kernel/vdso/datapage.S b/arch/arm/kernel/vdso/datapage.S
>>>> new file mode 100644
>>>> index 000000000000..fbf36d75da06
>>>> --- /dev/null
>>>> +++ b/arch/arm/kernel/vdso/datapage.S
>>>> @@ -0,0 +1,15 @@
>>>> +#include <linux/linkage.h>
>>>> +#include <asm/asm-offsets.h>
>>>> +
>>>> +   .align 2
>>>> +.L_vdso_data_ptr:
>>>> +   .long   _start - . - VDSO_DATA_SIZE
>>>> +
>>>> +ENTRY(__get_datapage)
>>>> +   .cfi_startproc
>>>> +   adr     r0, .L_vdso_data_ptr
>>>> +   ldr     r1, [r0]
>>>> +   add     r0, r0, r1
>>>> +   bx      lr
>>>> +   .cfi_endproc
>>>> +ENDPROC(__get_datapage)
>>>
>>> Can you translate this into English for the non-ARM-speakers here?
>>
>> Also, I'm not sure .cfi directives are the right things to use for AArch32.
>> ARM has special .fnstart, .fnend, .movsp diretives for its own unwind
>> format.
>>
>> Maybe GDB works with both -- have you tried unwinding out of this with
>> anything?
>
> Not since it stopped crashing, which was months ago :-)
>
> I think it worked with GDB 7.5 at least.

Keep in mind that gdb might not be noticing your unwind information at
all, and it might be unwinding correctly by dumb luck.

FWIW, on all x86 targets, -fPIC and a symbol in the linker script do
exactly the right thing.  Well, almost: x86_32 doesn't have real
PC-relative addressing, so gcc ends up storing the GOT address in a
register instead of the actual target in a register, but that doesn't
seem to make a big difference.  Maybe ARM can get away with the same
thing.

--Andy
