From: luc.vanoostenryck@gmail.com (Luc Van Oostenryck)
Date: Thu, 29 Jun 2017 17:15:19 +0200
Subject: [PATCH] arm64: fix endianness annotation for
 __apply_alternatives()/get_alt_insn()
In-Reply-To: <20170629142628.GE18630@arm.com>
References: <20170628145557.24454-1-luc.vanoostenryck@gmail.com>
 <20170629102851.GF14607@arm.com> <20170629132645.difv6xdjrkp5qvlh@ltop.local>
 <20170629141323.GH11040@leverpostej> <20170629141944.GD18630@arm.com>
 <20170629142233.GJ11040@leverpostej> <20170629142628.GE18630@arm.com>
Message-ID: <CAExDi1SxbM41MRuEUF0WSwzbs9yJNLGTtNfJySvAm6LSn9_mEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 29, 2017 at 4:26 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Thu, Jun 29, 2017 at 03:22:34PM +0100, Mark Rutland wrote:
>> On Thu, Jun 29, 2017 at 03:19:44PM +0100, Will Deacon wrote:
>> > On Thu, Jun 29, 2017 at 03:13:23PM +0100, Mark Rutland wrote:
>> > > On Thu, Jun 29, 2017 at 03:26:47PM +0200, Luc Van Oostenryck wrote:
>> > > > On Thu, Jun 29, 2017 at 11:28:51AM +0100, Will Deacon wrote:
>> > > > > > +           origptr = (__le32 __force *) ALT_ORIG_PTR(alt);
>> > > > > > +           replptr = (__le32 __force *) ALT_REPL_PTR(alt);
>> > > > >
>> > > > > Why is the __force needed here?
>> > > >
>> > > > Because of the cast to u32* in:
>> > > >         #define ALT_ORIG_PTR(a)         __ALT_PTR(a, orig_offset)
>> > > >         #define ALT_REPL_PTR(a)         __ALT_PTR(a, alt_offset)
>> > > >         #define __ALT_PTR(a,f)          (u32 *)((void *)&(a)->f + (a)->f)
>> > > >
>> > > > Of course, if this (u32*) is not really needed, then the __force
>> > > > is also not needed.
>> > > >
>> > > > And since, it seems indeed to be the case, I'll gladly sent a patch:
>> > > >         -#define __ALT_PTR(a,f)          (u32 *)((void *)&(a)->f + (a)->f)
>> > > >         +#define __ALT_PTR(a,f)          ((void *)&(a)->f + (a)->f)
>> > > > if it suits you.
>> > >
>> > > Given __ALT_PTR is intended to give a pointer to A64 instructions, which
>> > > are in le32 format, wouldn't it make more sense for __ALT_PTR to cast to
>> > > __le32 * ?

Yes, it could.

>> > Might be a bit weird for ALT_REPL_PTR, which is cast to unsigned long.
>>
>> Maybe, but that's one cast, rather than two, and matches other similar
>> casts from a pointer to unsigned long (e.g. the the addr cast in
>> __range_ok()).
>
> Sure, but isn't it a __force cast? I'd like to avoid that if we can.

No, once you cast to an integer all the specificities of pointers are
thrown away,
like for a const pointer and here the __bitwise underlying the __le32.
It's exactly the same fro cast from/to void*, the reasoning behind it
is something
like : "it's OK to drop all the qualifiers and such because you will anyway need
to cast the result to another pointer before being able to dereference it".

I already sent a version leaving the type as void*, without having seen your
replies here, but if you wish I can, of course, resend something for __le32*.

-- Luc
