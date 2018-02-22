From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 22 Feb 2018 14:20:53 +0100
Subject: [PATCH v3 2/5] m68k: rename UL() to TO_UL()
In-Reply-To: <1519301715-31798-3-git-send-email-yamada.masahiro@socionext.com>
References: <1519301715-31798-1-git-send-email-yamada.masahiro@socionext.com>
 <1519301715-31798-3-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAMuHMdXsobaUdxMO-3=B56_2pQ2MzG7vxOqt+GzG_OC1T5bL7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yamada-san,

On Thu, Feb 22, 2018 at 1:15 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> ARM, ARM64 and UniCore32 define UL(x) like follows:
>   #define UL(x) _AC(x, UL)
>
> While, M68K defines it differently:
>   #define UL(x) ((unsigned long) (x))
>
> I want to move the former to a common header.  Beforehand, this
> commit renames the latter to avoid name conflict.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> V2: https://patchwork.kernel.org/patch/9498273/
>
> Changes in v3: None
> Changes in v2:
>  - Split out as a prerequisite patch
>
>  arch/m68k/mm/init.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/m68k/mm/init.c b/arch/m68k/mm/init.c
> index e85acd1..583a8e5 100644
> --- a/arch/m68k/mm/init.c
> +++ b/arch/m68k/mm/init.c
> @@ -122,9 +122,9 @@ void free_initmem(void)
>
>  void __init print_memmap(void)
>  {
> -#define UL(x) ((unsigned long) (x))
> -#define MLK(b, t) UL(b), UL(t), (UL(t) - UL(b)) >> 10
> -#define MLM(b, t) UL(b), UL(t), (UL(t) - UL(b)) >> 20
> +#define TO_UL(x) ((unsigned long) (x))
> +#define MLK(b, t) TO_UL(b), TO_UL(t), (TO_UL(t) - TO_UL(b)) >> 10
> +#define MLM(b, t) TO_UL(b), TO_UL(t), (TO_UL(t) - TO_UL(b)) >> 20
>  #define MLK_ROUNDUP(b, t) b, t, DIV_ROUND_UP(((t) - (b)), 1024)

Please note that this code patch is scheduled for removal in v4.17, cfr.
"[PATCH] m68k/mm: Stop printing the virtual memory layout"
(https://lkml.org/lkml/2018/2/12/97).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
