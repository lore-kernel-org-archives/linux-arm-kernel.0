From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 26 Feb 2018 10:49:51 +0100
Subject: [PATCH v3 2/5] m68k: rename UL() to TO_UL()
In-Reply-To: <CAK7LNASRtGPOopLkkSf0gx8NaRyak=oEdTfuyxtaZ3gNmCeK7A@mail.gmail.com>
References: <1519301715-31798-1-git-send-email-yamada.masahiro@socionext.com>
 <1519301715-31798-3-git-send-email-yamada.masahiro@socionext.com>
 <CAMuHMdXsobaUdxMO-3=B56_2pQ2MzG7vxOqt+GzG_OC1T5bL7w@mail.gmail.com>
 <CAK7LNASRtGPOopLkkSf0gx8NaRyak=oEdTfuyxtaZ3gNmCeK7A@mail.gmail.com>
Message-ID: <CAMuHMdV+_YDw_tv8OwrCv=DFEHZVB3vtTO7SsML1M6ZQmP==Pw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yamada-san,

CC sfr (conflict heads up)

On Thu, Feb 22, 2018 at 5:58 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2018-02-22 22:20 GMT+09:00 Geert Uytterhoeven <geert@linux-m68k.org>:
>> On Thu, Feb 22, 2018 at 1:15 PM, Masahiro Yamada
>> <yamada.masahiro@socionext.com> wrote:
>>> ARM, ARM64 and UniCore32 define UL(x) like follows:
>>>   #define UL(x) _AC(x, UL)
>>>
>>> While, M68K defines it differently:
>>>   #define UL(x) ((unsigned long) (x))
>>>
>>> I want to move the former to a common header.  Beforehand, this
>>> commit renames the latter to avoid name conflict.
>>>
>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>> ---
>>> V2: https://patchwork.kernel.org/patch/9498273/
>>>
>>> Changes in v3: None
>>> Changes in v2:
>>>  - Split out as a prerequisite patch
>>>
>>>  arch/m68k/mm/init.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/m68k/mm/init.c b/arch/m68k/mm/init.c
>>> index e85acd1..583a8e5 100644
>>> --- a/arch/m68k/mm/init.c
>>> +++ b/arch/m68k/mm/init.c
>>> @@ -122,9 +122,9 @@ void free_initmem(void)
>>>
>>>  void __init print_memmap(void)
>>>  {
>>> -#define UL(x) ((unsigned long) (x))
>>> -#define MLK(b, t) UL(b), UL(t), (UL(t) - UL(b)) >> 10
>>> -#define MLM(b, t) UL(b), UL(t), (UL(t) - UL(b)) >> 20
>>> +#define TO_UL(x) ((unsigned long) (x))
>>> +#define MLK(b, t) TO_UL(b), TO_UL(t), (TO_UL(t) - TO_UL(b)) >> 10
>>> +#define MLM(b, t) TO_UL(b), TO_UL(t), (TO_UL(t) - TO_UL(b)) >> 20
>>>  #define MLK_ROUNDUP(b, t) b, t, DIV_ROUND_UP(((t) - (b)), 1024)
>>
>> Please note that this code patch is scheduled for removal in v4.17, cfr.
>> "[PATCH] m68k/mm: Stop printing the virtual memory layout"
>> (https://lkml.org/lkml/2018/2/12/97).
>
> I see, but I do not see it in linux-next as of writing.

It will be tomorrow.

> Without this prerequisite, 3/5 would cause a build error.
> So, I needed to include it in this series.
>
> I am hoping this series will be picked up by Andrew Morton.
> In my understanding, he applies patches on top of the linux-next.
>
> I think either will happen:
>
> [1] If your patch appears in linux-next first,
>     my 2/5 will be skipped, and the rest of the series will be applied.
>
> [2] If my series is applied first,
>     Andrew will drop 2/5 when your patch appears in linux-next
>         (this is simply detected by patch conflict)

OK.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
