From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 19 Nov 2014 17:41:53 +0100
Subject: [PATCH RFC] ARM: option for loading modules into vmalloc area
In-Reply-To: <alpine.LFD.2.11.1411191130480.11690@knanqh.ubzr>
References: <20141118172146.3784.81151.stgit@buzz>
 <20141118173413.GB4042@n2100.arm.linux.org.uk>
 <546B8C64.3010904@samsung.com> <2041617.Kxhx5O4MMr@wuerfel>
 <CAKv+Gu-8qhHYOry+LsDzp+LDZqYxVZ5G7cj48E3G2Unp2+=_yg@mail.gmail.com>
 <CALYGNiMt2A3DP02cOtxqu4RrnmhojrDxkRG7bkHMByUnzG+PeA@mail.gmail.com>
 <CAKv+Gu-rYWutr-45MsZH6KOhhUyNCVLfkO9JQrqCm1L6ms_DUg@mail.gmail.com>
 <20141119160747.GH4042@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1411191130480.11690@knanqh.ubzr>
Message-ID: <CAKv+Gu_USuMfNWfxcj6fSztOva5614v1YTQxFTonh6KRkKvUGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 November 2014 17:37, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Wed, 19 Nov 2014, Russell King - ARM Linux wrote:
>
>> On Wed, Nov 19, 2014 at 05:02:40PM +0100, Ard Biesheuvel wrote:
>> > On 19 November 2014 16:52, Konstantin Khlebnikov <koct9i@gmail.com> wrote:
>> > > Do you mean ldr pc, =symbol ?
>> > >
>> > > In this case I get this error:
>> > >
>> > > /tmp/ccAHtONU.s: Assembler messages:
>> > > /tmp/ccAHtONU.s:220: Error: invalid literal constant: pool needs to be closer
>> > >
>> > > Probably constant pool doesn't work well in inline assembly.
>> > >
>> > >
>> > > Something like this seems work:
>> > >
>> > > add     lr, pc, #4
>> > > ldr       pc, [pc, #-4]
>> > > .long symbol
>> > >
>> >
>> > You can add a '.ltorg' instruction which tells the assembler to dump
>> > the literal pool, but you still need to jump over it, i.e.,
>> >
>> > adr lr, 0f
>> > ldr pc, =symbol
>> > .ltorg
>> > 0:
>>
>> Which is not a good idea either, because the compiler needs to know how
>> far away its own manually generated literal pool is from the instructions
>> which reference it.  The .ltorg statement can end up emitting any number
>> of literals at that point, which makes it indeterminant how many words
>> are contained within the asm() statement.
>>
>> Yes, it isn't desirable to waste an entire data cache line per indirect
>> call like the original quote above, but I don't see a practical
>> alternative.
>
> Modules could be built without far calls by default, and then the module
> linker would only have to redirect those calls whose destination is too
> far away to a dynamically created trampoline table.
>
> If I remember correctly you even posted some patches to that effect a
> couple years ago.  Maybe those could be salvaged?
>
> I would largely recommend a solution where the link process could deal
> with it automatically and as needed rather than sprinkling yet more
> manually maintained macros into assembly code.
>

Yes, that would be preferable. I played around with 'bl symbol at PLT'
instead of plain 'bl symbol' but unfortunately, our .ko's are not
proper ELF shared libraries, so that doesn't work.
But essentially, we just need a (eager) PLT.

-- 
Ard.
