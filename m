From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 4 Aug 2016 12:34:58 +0200
Subject: [PATCH 1/8] ARM: assembler: introduce adr_l,
 ldr_l and str_l macros
In-Reply-To: <20160804094451.GE7147@e103592.cambridge.arm.com>
References: <1470238730-30038-1-git-send-email-ard.biesheuvel@linaro.org>
 <1470238730-30038-2-git-send-email-ard.biesheuvel@linaro.org>
 <20160803164940.GC7147@e103592.cambridge.arm.com>
 <CAKv+Gu_3YKfdCyMuTdrk+t16qQOuMiSqWEHf-h1K2ajM5s1rxw@mail.gmail.com>
 <20160804094451.GE7147@e103592.cambridge.arm.com>
Message-ID: <CAKv+Gu-T9+fhvRk-RroDqr7QvQ24cUTuONL9uT-Ws24n_nHrCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 August 2016 at 11:44, Dave Martin <Dave.Martin@arm.com> wrote:
> On Thu, Aug 04, 2016 at 09:40:31AM +0200, Ard Biesheuvel wrote:
>> On 3 August 2016 at 18:49, Dave Martin <Dave.Martin@arm.com> wrote:
>> > On Wed, Aug 03, 2016 at 05:38:43PM +0200, Ard Biesheuvel wrote:
[...]
>> >> +#else
>> >> +     add     \dst, pc, #:pc_g0_nc:(\sym) - 8
>> >> +     add     \dst, \dst, #:pc_g1_nc:(\sym) - 4
>> >> +     add     \dst, \dst, #:pc_g2:(\sym)
>> >
>> > Whoah.  I've never seen this syntax before...  does this work for any
>> > named reloc, or just for certain blessed relocs?  (I'm also _assuming_
>> > the assembler support for this functionality is ancient -- if not,
>> > there may be toolchain compatibility issues.)
>> >
>> > Based on my understanding of how these relocs work, this should do the
>> > right thing, though.
>> >
>> >
>> > Second question: for arm, this reduces the range addressable to
>> > pc +/- 26-bit offset (24-bit if sym is not word aligned, but that
>> > probably never happens).
>> >
>> > I can't remember the de facto limit on the size of vmlinux for arm --
>> > are you sure this extra limitation won't break some cases of huge
>> > initramfs where adr_l gets used for cross-section references?
>> >
>>
>> Yes, that seems a valid concern. We have +/- 64 MB for the adr_l
>> variant (as you say, for word aligned symbols), but this may be
>> insufficient. The ldr/str variants don't have the same limitation.
>
> True, but they're still limited, I think in effect to +/- 256 MB.
>

Yes. I managed to hack around the limitation by doing this

.macro adr_fwd, dst, sym, tmp
add \dst, pc, #:pc_g0_nc:(\sym) - 8
add \dst, \dst, #:pc_g1_nc:(\sym) - 4
.reloc ., R_ARM_LDR_PC_G2, \sym
mov \tmp, #0
add \dst, \dst, \tmp
.endm

but it is becoming very hacky, and this only works for forward
references anyway.

So I think this is a dead end. Series withdrawn.

Thanks for your time,
Ard.
