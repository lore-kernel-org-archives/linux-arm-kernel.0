From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 27 Nov 2014 12:04:47 +0100
Subject: [PATCH] ARM: mm: fix size rounding-down of arm_add_memory()
In-Reply-To: <CAKv+Gu8yOcxu2LXdunSH-vB+mcckigoJGrnV+TDXeN-+AVYoSA@mail.gmail.com>
References: <1402025567-18021-1-git-send-email-yamada.m@jp.panasonic.com>
 <20140801213719.D537.AA925319@jp.panasonic.com>
 <CAMuHMdXjX5AJT9fVja+GCTV4Zxp==xTe8ZFT8_uf=aFDYZ9+Jw@mail.gmail.com>
 <CAMuHMdXo9HCTJNi8ObutwcUZiXyfyta5+McoA9UaEhueh-6gRg@mail.gmail.com>
 <CAKv+Gu8yOcxu2LXdunSH-vB+mcckigoJGrnV+TDXeN-+AVYoSA@mail.gmail.com>
Message-ID: <CAMuHMdVMk=6NgkQ3AuMPOTZdqx2P2U2N-QkDco+Ocd3hD-hp4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 27, 2014 at 11:50 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>>>>> --- a/arch/arm/kernel/setup.c
>>>>> +++ b/arch/arm/kernel/setup.c
>>>>> @@ -641,8 +641,8 @@ int __init arm_add_memory(u64 start, u64 size)
>>>>>        * Ensure that start/size are aligned to a page boundary.
>>>>>        * Size is appropriately rounded down, start is rounded up.
>>>>>        */
>>>>> -     size -= start & ~PAGE_MASK;
>>>>>       aligned_start = PAGE_ALIGN(start);
>>>>> +     size -= aligned_start - start;
>
> Beware that if size if sufficiently small, (i.e., smaller than the
> unaligned leading fraction @ start), this wraps around and produces a
> bogus value.

That could have happened before, couldn't it?

Nevertheless, fixing that can be a follow-up patch?
Unless Yamada-san wants to incorporate the fix in this patch?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
