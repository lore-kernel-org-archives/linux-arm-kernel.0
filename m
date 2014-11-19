From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 19 Nov 2014 17:25:41 +0100
Subject: [PATCH RFC] ARM: option for loading modules into vmalloc area
In-Reply-To: <20141119160747.GH4042@n2100.arm.linux.org.uk>
References: <20141118172146.3784.81151.stgit@buzz>
 <20141118173413.GB4042@n2100.arm.linux.org.uk>
 <546B8C64.3010904@samsung.com> <2041617.Kxhx5O4MMr@wuerfel>
 <CAKv+Gu-8qhHYOry+LsDzp+LDZqYxVZ5G7cj48E3G2Unp2+=_yg@mail.gmail.com>
 <CALYGNiMt2A3DP02cOtxqu4RrnmhojrDxkRG7bkHMByUnzG+PeA@mail.gmail.com>
 <CAKv+Gu-rYWutr-45MsZH6KOhhUyNCVLfkO9JQrqCm1L6ms_DUg@mail.gmail.com>
 <20141119160747.GH4042@n2100.arm.linux.org.uk>
Message-ID: <CAKv+Gu-kvmkhrptmaN0miM3c0K3ZOh4maTFXL=NpYTMi9Q83kA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 November 2014 17:07, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Nov 19, 2014 at 05:02:40PM +0100, Ard Biesheuvel wrote:
>> On 19 November 2014 16:52, Konstantin Khlebnikov <koct9i@gmail.com> wrote:
>> > Do you mean ldr pc, =symbol ?
>> >
>> > In this case I get this error:
>> >
>> > /tmp/ccAHtONU.s: Assembler messages:
>> > /tmp/ccAHtONU.s:220: Error: invalid literal constant: pool needs to be closer
>> >
>> > Probably constant pool doesn't work well in inline assembly.
>> >
>> >
>> > Something like this seems work:
>> >
>> > add     lr, pc, #4
>> > ldr       pc, [pc, #-4]
>> > .long symbol
>> >
>>
>> You can add a '.ltorg' instruction which tells the assembler to dump
>> the literal pool, but you still need to jump over it, i.e.,
>>
>> adr lr, 0f
>> ldr pc, =symbol
>> .ltorg
>> 0:
>
> Which is not a good idea either, because the compiler needs to know how
> far away its own manually generated literal pool is from the instructions
> which reference it.  The .ltorg statement can end up emitting any number
> of literals at that point, which makes it indeterminant how many words
> are contained within the asm() statement.
>

That applies to any inline asm statement in general: the compiler
assumes that the expanded size will not interfere with its ability to
emit literals after the function's return instruction.
Sometimes it will put a literal pool in the middle of the function if
it is very large, and I am not sure if an inline asm by itself would
ever trigger that heuristic to kick in.

But by the same logic, i.e., due to the fact that GCC manages its own
literals, the literal pool at the assembly level is unlikely to be so
large that you will actually hit this condition.

> Yes, it isn't desirable to waste an entire data cache line per indirect
> call like the original quote above, but I don't see a practical
> alternative.
>

We could at least add some labels instead of doing explicit pc arithmetic, i.e.,

adr lr, 1f
ldr pc, 0f
0: .long symbol
1:
