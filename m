From: yamada.m@jp.panasonic.com (Masahiro Yamada)
Date: Fri, 28 Nov 2014 21:34:45 +0900
Subject: [PATCH] ARM: mm: fix size rounding-down of arm_add_memory()
In-Reply-To: <CAMuHMdVMk=6NgkQ3AuMPOTZdqx2P2U2N-QkDco+Ocd3hD-hp4A@mail.gmail.com>
References: <CAKv+Gu8yOcxu2LXdunSH-vB+mcckigoJGrnV+TDXeN-+AVYoSA@mail.gmail.com>
 <CAMuHMdVMk=6NgkQ3AuMPOTZdqx2P2U2N-QkDco+Ocd3hD-hp4A@mail.gmail.com>
Message-ID: <20141128213445.2EA9.AA925319@jp.panasonic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.


On Thu, 27 Nov 2014 12:04:47 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Thu, Nov 27, 2014 at 11:50 AM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >>>>> --- a/arch/arm/kernel/setup.c
> >>>>> +++ b/arch/arm/kernel/setup.c
> >>>>> @@ -641,8 +641,8 @@ int __init arm_add_memory(u64 start, u64 size)
> >>>>>        * Ensure that start/size are aligned to a page boundary.
> >>>>>        * Size is appropriately rounded down, start is rounded up.
> >>>>>        */
> >>>>> -     size -= start & ~PAGE_MASK;
> >>>>>       aligned_start = PAGE_ALIGN(start);
> >>>>> +     size -= aligned_start - start;
> >
> > Beware that if size if sufficiently small, (i.e., smaller than the
> > unaligned leading fraction @ start), this wraps around and produces a
> > bogus value.

Uh-oh, yes. I missed this.


> 
> That could have happened before, couldn't it?
> 
> Nevertheless, fixing that can be a follow-up patch?
> Unless Yamada-san wants to incorporate the fix in this patch?

We don't two patches to fix one place.

If you are willing to fix it,
please feel free to discard mine and send a new patch.


(If nobody would fix that, I am happy to contribute
for fixing this issue, of course.)



Best Regards
Masahiro Yamada
