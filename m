From: stefan@agner.ch (Stefan Agner)
Date: Wed, 22 Aug 2018 16:38:09 +0200
Subject: [PATCH] ARM: use choice for kernel unwinders
In-Reply-To: <CAK8P3a0oaMS12R4tazChMHENQduO0-Wb-gw-inKjH0oz7_5s3g@mail.gmail.com>
References: <20180821222416.7771-1-stefan@agner.ch>
 <CAK8P3a0oaMS12R4tazChMHENQduO0-Wb-gw-inKjH0oz7_5s3g@mail.gmail.com>
Message-ID: <77d139d225e16b90d9b8da1982a11707@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22.08.2018 12:02, Arnd Bergmann wrote:
> On Wed, Aug 22, 2018 at 12:24 AM Stefan Agner <stefan@agner.ch> wrote:
>>
>> While in theory multiple unwinders could be compiled in, it does
>> not make sense in practise. Use a choice to make the unwinder
>> selection mutually exclusive and mandatory.
>>
>> Already before this commit it has not been possible to deselect
>> FRAME_POINTER. Remove the obsolete comment.
>>
>> Furthermore, to produce a meaningful backtrace with FRAME_POINTER
>> enabled the kernel needs a specific function prologue:
>>     mov    ip, sp
>>     stmfd    sp!, {fp, ip, lr, pc}
>>     sub    fp, ip, #4
>>
>> To get to the required prologue gcc uses apcs and no-sched-prolog.
>> This compiler options are not available on clang, and clang is not
>> able to generate the required prologue. Make the FRAME_POINTER
>> config symbol depending on !clang.
>>
>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
> 
> Looks ok to me. I've added it to my randconfig test environment, you
> will hear from me within a day if I run into build regressions.
> 
> We may still want to clean up these three lines:
> 
> lib/Kconfig.debug:  select FRAME_POINTER if !MIPS && !PPC &&
> !ARM_UNWIND && !S390 && !MICROBLAZE && !ARC && !X86
> lib/Kconfig.debug:  select FRAME_POINTER if !MIPS && !PPC && !S390 &&
> !MICROBLAZE && !ARM_UNWIND && !ARC && !X86
> lib/Kconfig.debug:  select FRAME_POINTER if !MIPS && !PPC && !S390 &&
> !MICROBLAZE && !ARM_UNWIND && !ARC && !X86
> 
> in which ARM is the odd case that currently depends on an architecture
> specific rather than the architecture itself.

I guess we would just follow X86 lead by saying ARM is guaranteed to
have unwinding support, and hence we can add !ARM.

> We could introduce a 'config ARCH_HAS_UNWINDER' symbol that gets
> selected by mips, ppc, s390, microblaze, arm and x86 unconditionally,
> and then simplify the 'select' statements here.

Yeah I was thinking about something like that too.

It seems to be a bit weird to me that lib/Kconfig.debug selects a
specific stack unwinding technique...

Ideally other config symbol should just ask arch to make sure a
unwinding technique is available (NEED_STACK_UNWINDING?) and arch then
makes sure to provide a reasonable default.

This then also would make it possible to select no stack unwinding in
case arch supports that and all the users of stack unwinding are
disabled too. Not sure how that exactly would look like in Kconfig, I
was thinking like:

choice
    prompt "Choose kernel unwinder"
    optional if !NEED_STACK_UNWINDING
    default UNWINDER_ARM if AEABI && !FUNCTION_GRAPH_TRACER
    default UNWINDER_FRAME_POINTER if !AEABI || FUNCTION_GRAPH_TRACER

But "optional if" does not exist yet :-)

Reading the comments in arch/arm/Kconfig.debug seems to suggest that
once upon a time it was possible to disable stack unwinding on ARM.

But then, maybe we don't really want to go there? Might be interesting
for tinification efforts.

--
Stefan
