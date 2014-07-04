From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 4 Jul 2014 09:08:05 +0200
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <20140703224753.GB21766@n2100.arm.linux.org.uk>
References: <20140701234800.GA23577@sirena.org.uk>
 <20140702100133.GE18731@arm.com>
 <20140702163923.GJ410@sirena.org.uk>
 <20140702170141.GH24879@arm.com>
 <CACxGe6skyD-dNqR_XgqbWrwFsDs4Stwo81VQ4yviJMZK=kB8tA@mail.gmail.com>
 <20140703104135.GA28175@arm.com>
 <CACxGe6vmNamkAzvL8c5qaVEh9kvmTa=gEyr8KgBS1PW+KFc_=Q@mail.gmail.com>
 <20140703170558.GZ32514@n2100.arm.linux.org.uk>
 <20140703173226.GC17372@arm.com>
 <yw1xoax6dr67.fsf@unicorn.mansr.com>
 <20140703224753.GB21766@n2100.arm.linux.org.uk>
Message-ID: <CAKv+Gu-taih4ZdWkmup5JVSeWhcYbatzoHqra+=+bdZorTBCvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 July 2014 00:47, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Thu, Jul 03, 2014 at 11:16:16PM +0100, M?ns Rullg?rd wrote:
>> Will Deacon <will.deacon@arm.com> writes:
>>
>> > On Thu, Jul 03, 2014 at 06:05:58PM +0100, Russell King - ARM Linux wrote:
>> >> On Thu, Jul 03, 2014 at 05:22:30PM +0100, Grant Likely wrote:
>> >> > So, no. I completely reject any notion that breaking existing apps is
>> >> > okay. If we're going to say that v8 still supports 32-bit apps, then
>> >> > it has to be all of v7, not just the 'good' bits. Nor do I think
>> >> > saying "it's just a bunch of games" justifies anything. We're kernel
>> >> > engineers. Applications are applications and we don't break userspace.
>> >> > Period.
>> >>
>> >> +1 on all points above.  I'd go further - if we're going to say that v8
>> >> still supports 32-bit apps, that covers at least v6 *as well*.
>> >
>> > We've never pretended to support anything other than ARMv8 in the compat
>> > layer. uname even reports this in the machine name.
>> >
>> > If people are suddenly so concerned about *full* compatibility with an ARMv7
>> > kernel, that needs a lot more than just SWP emulation:
>> >
>> >   - Alignment fixups for ldm/stm
>>
>> No ARM variant ever supported unaligned ldm/stm.
>
> Quite right but that's not the point being discussed.  Please note that
> the sentence says "with an ARMv7 *kernel*" - we are not talking about
> the architecture there.
>
> So, what's more to the point is that on 32-bit ARM userspace under Linux,
> we _have_ supported it since early 2000 up to present.  It's not currently
> supported on 64-bit ARM running Linux, even when running a 32-bit binary
> in userspace.
>
> Ergo, it's a user visible ABI change, one which we don't know whether it
> matters.  In all probability, it doesn't because (hopefully) no one ever
> does unaligned LDMs/STMs - I think it would require hand-crafted assembly,
> at which point you're talking about optimising something, and you'd be
> silly to do it as it would invoke the alignment fault handling which
> would be slow.
>

Well, if something like this

struct bar {
    long l[4];
};

void foo(struct bar *dst, struct bar const *src)
{
    *dst = *src;
}

produces this:

foo:
@ args = 0, pretend = 0, frame = 0
@ frame_needed = 0, uses_anonymous_args = 0
@ link register save eliminated.
    mov ip, r0
    ldmia r1, {r0, r1, r2, r3}
    stmia ip, {r0, r1, r2, r3}
    bx lr

won't it take just a single cast from some unaligned char* to struct
bar* to trigger this?

-- 
Ard.
