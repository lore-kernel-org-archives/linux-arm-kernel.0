From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 8 Feb 2011 17:15:40 +0000
Subject: [PATCH v2] ARM: Define wfi() macro for v6 processors
In-Reply-To: <201102081758.14606.arnd@arndb.de>
References: <1297162885-2975-1-git-send-email-dave.martin@linaro.org>
	<201102081617.59092.arnd@arndb.de>
	<20110208163229.GC6188@n2100.arm.linux.org.uk>
	<201102081758.14606.arnd@arndb.de>
Message-ID: <AANLkTi=G2h0cV-iLczCtcUzWn7vpa0GDOhr=PArhFQLy@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 8, 2011 at 4:58 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 08 February 2011 17:32:29 Russell King - ARM Linux wrote:
>> On Tue, Feb 08, 2011 at 04:17:58PM +0100, Arnd Bergmann wrote:
>> > On Tuesday 08 February 2011, Dave Martin wrote:
>> > > CFLAGS_cpu_specific_object.o ? ? ? ?+= -march=armv7-a
>> > >
>> > > Whether it's safe to do it depends on whether code from that file
>> > > could ever get run on other processors. ?I'm not so sure of the answer
>> > > to that..., but perhaps someone else has a better idea.
>> >
>> > We already do this a lot from arch/arm/mm/Makefile, and those
>> > files are typically just one function per file, so they can easily
>> > be proven to be safe that way.
>>
>> No, we do that with assembly files. ?It doesn't work soo well with
>> C files as we really don't want GCC itself to generate v7 instructions
>> unless we explicitly ask for them.
>>
>> The other issue here is that somtimes generating code with different
>> -march options leads to the linker refusing to link them together...
>
> Ok, I see. Is that a bug in existing toolchains, or something more
> fundamental?
>
> I would have expected that you could at least mix all compiler options
> that don't impact the ABI or the instruction set like -mthumb.
>
> Also, I think we can still build with e.g. "-march=armv6 -Wa,-march=armv7",
> which should tell the compiler to only emit armv6 instructions, but make
> the assembler more permissive for inline assembly.

I think you can usually mix options provided the ABI isn't affected.
It could be interesting to try it just to see what happens...

I've seen this work, but I haven't tried it on a large scale such as
building the kernel...

I think the major problems in the past have usually between
OABI<->EABI, non-interworking<->interworking, non-PIC<->PIC and
floating-point ABI clashes, particularly regarding compiler helper
libs like libgcc.  I expect none of these are likely to affect the
kernel, particularly since the kernel has its own libgcc (I think).

Possibly EABI toolchains are better at handling this than the for old
ABI, but it's still not ideal: for example, if you build this with
-march=armv6

void fancy() {
    if(have_arch_v7()) {
        asm(".arch v7-a\n\t"
               /* ... fancy stuff ... */
               ".arch v6");
    } else {
        /* C implementation of fancy stuff */
    }
}

... the object is marked as requiring v7, since some v7 instructions
were emitted.  Really, the object only requires v6, but that
conclusion requires knowledge the tools don't have.  (Note that tools
guys I've talked to don't much like changing .arch mid-file, but from
my PoV it should be reasonable except for the problem of knowing what
.arch to restore to afterwards.)

If vmlinux ends up stamped as requiring v7, that has no effect
whatsoever on whether the kernel works.  That's down to what the
actual code does, as in the above example.

Cheers
---Dave
