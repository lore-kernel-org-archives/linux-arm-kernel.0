From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 12 Oct 2015 09:18:52 +0200
Subject: [PATCH 3/5] ARM: shmobile: R-Mobile: add missing of_node_put
In-Reply-To: <1444480254-14399-4-git-send-email-Julia.Lawall@lip6.fr>
References: <1444480254-14399-1-git-send-email-Julia.Lawall@lip6.fr>
 <1444480254-14399-4-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <CAMuHMdUVraBT+s1e-m89KmjbZnEQjBaSz+c93rCOWPMnT5CVPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julia,

On Sat, Oct 10, 2015 at 2:30 PM, Julia Lawall <Julia.Lawall@lip6.fr> wrote:
> --- a/arch/arm/mach-shmobile/pm-rmobile.c
> +++ b/arch/arm/mach-shmobile/pm-rmobile.c
> @@ -313,8 +313,10 @@ static int __init rmobile_add_pm_domains(void __iomem *base,
>                 }
>
>                 pd = kzalloc(sizeof(*pd), GFP_KERNEL);
> -               if (!pd)
> +               if (!pd) {
> +                       of_node_put(np);
>                         return -ENOMEM;
> +               }

While technically this patch is correct, the system will be dead anyway if it
ever goes OOM at core_initcall() time.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
