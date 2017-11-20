From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 20 Nov 2017 13:39:50 +0000
Subject: [RFC PATCH] arm64: ftrace: move ftrace-mod.o contents into linker
 script
In-Reply-To: <20171120132902.GB2687@arm.com>
References: <20171120131538.10492-1-ard.biesheuvel@linaro.org>
 <20171120132902.GB2687@arm.com>
Message-ID: <CAKv+Gu-+Z+O=cTar9-K=PJjEZfzoYdYNiVYAxXM1_WwESfw9sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 November 2017 at 13:29, Will Deacon <will.deacon@arm.com> wrote:
> Hi Ard,
>
> Thanks for this. Somebody ran across this internally a while back, but
> it slipped through the cracks. I remember thinking at the time that the
> Kconfig dependencies here looked a little weird too and perhaps
> ARM64_MODULE_PLTS should be selected by RANDOMIZE_MODULE_REGION_FULL
> instead of RANDOMIZE_BASE.
>

No. Even without RANDOMIZE_MODULE_REGION_FULL, the module region is
shared with the vmalloc space if the kernel is randomized, and so
other vmalloc allocations could eat into the module space as well.

> Anyhow, comments below.
>
> On Mon, Nov 20, 2017 at 01:15:38PM +0000, Ard Biesheuvel wrote:
>> When building the arm64 kernel with bot CONFIG_ARM64_MODULE_PLTS and
>> CONFIG_DYNAMIC_FTRACE enabled, the ftrace-mod.o object file is built
>> with the kernel and contains a trampoline that is linked into each
>> module, so that modules can be loaded far away from the kernel and
>> still reach the ftrace entry point in the core kernel with an ordinary
>> relative branch, as is emitted by the compiler instrumentation code
>> dynamic ftrace relies on.
>>
>> In order to be able to build out of tree modules, this object file
>> needs to be included into the linux-headers or linux-devel packages,
>> which is undesirable, as it makes arm64 a special case (although a
>> precedent does exist for 32-bit PPC).
>
> Agreed that we should avoid the object file, if possible.
>
>> Given that the trampoline only consists of two instructions, let's
>> hack it into the module linker script instead.
>
> Why do we have to do this in the linker script? Couldn't we just generate
> the .S file we currently use?
>

Not sure I am following you there. You mean adding a .S source file to
each module target? Not sure how that would work.

>> diff --git a/arch/arm64/kernel/module-ftrace.lds b/arch/arm64/kernel/module-ftrace.lds
>> new file mode 100644
>> index 000000000000..9df69ddaa7bb
>> --- /dev/null
>> +++ b/arch/arm64/kernel/module-ftrace.lds
>> @@ -0,0 +1,7 @@
>> +SECTIONS {
>> +     .text.ftrace_trampoline : ALIGN (8) {
>> +             QUAD (0x0);             /* 0:   .quad   0x0             */
>> +             LONG (0x58ffffd0);      /*      ldr     x16, 0b         */
>> +             LONG (0xd61f0200);      /*      br      x16             */
>> +     }
>> +}
>
> How do we guarantee these are little-endian?
>

Ah good point. So we'll need BYTE() sequences here.
