From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 4 Aug 2016 15:58:25 +0200
Subject: [PATCH 1/8] ARM: assembler: introduce adr_l,
 ldr_l and str_l macros
In-Reply-To: <20160804121619.GS1041@n2100.armlinux.org.uk>
References: <1470238730-30038-1-git-send-email-ard.biesheuvel@linaro.org>
 <1470238730-30038-2-git-send-email-ard.biesheuvel@linaro.org>
 <20160803164940.GC7147@e103592.cambridge.arm.com>
 <CAKv+Gu_3YKfdCyMuTdrk+t16qQOuMiSqWEHf-h1K2ajM5s1rxw@mail.gmail.com>
 <20160804094451.GE7147@e103592.cambridge.arm.com>
 <CAKv+Gu-T9+fhvRk-RroDqr7QvQ24cUTuONL9uT-Ws24n_nHrCw@mail.gmail.com>
 <20160804112229.GG7147@e103592.cambridge.arm.com>
 <20160804121619.GS1041@n2100.armlinux.org.uk>
Message-ID: <CAKv+Gu-XTg0+teZ4i3FbHdiFqZuKLxnEr299-4QOujY5xxytEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 August 2016 at 14:16, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Thu, Aug 04, 2016 at 12:22:29PM +0100, Dave Martin wrote:
>> The more conventional literal-.long approach could still be macro-ised
>> along the same lines, which might make the affected code more readable,
>> but the idiom you'd be replacing is well-understood and not very common.
>
> I don't see how it could be.  You can't efficiently place the literal
> data alongside the instructions dealing with it.
>
> The only alternative is to use ldr rd, =foo, but that gets very stupid
> when you want to calculate the relative offset, and you end up with
> something like this for every relative load:
>
>         ldr rd, =.
>         sub rd, rd, #. - 4
>         ldr r1, =foo
>         add r1, r1, rd
>

This does the trick

#ifdef CONFIG_THUMB2_KERNEL
#define PC_BIAS 4
#else
#define PC_BIAS 8
#endif

/*
* @dst: destination register
* @sym: name of the symbol
*/
.macro adr_l, dst, sym, tmp:req
#if __LINUX_ARM_ARCH__ >= 7
movw \dst, #:lower16:(\sym) - (. + 8 + PC_BIAS)
movt \dst, #:upper16:(\sym) - (. + 4 + PC_BIAS)
add \dst, \dst, pc
#else
ldr \tmp, =\sym
ldr \dst, =. + 12
sub \dst, \dst, pc
sub \dst, \tmp, \dst
#endif
.endm

but it is suboptimal for v6 and earlier, and now the macro requires a
temp register.

> As I've already said, I prefer the existing solution.  It works, it's
> been known to work for the last 22 years.
>
> If it isn't broken, don't try to fix it.
>

It seemed like low hanging fruit, but obviously not ...

Thanks for your time,
Ard.
