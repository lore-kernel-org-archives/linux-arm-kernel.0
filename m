From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 1 Feb 2018 12:04:14 +0100
Subject: [PATCH] soc: mediatek: Handle return of of_match_device function
In-Reply-To: <1517482822-28758-1-git-send-email-himanshujha199640@gmail.com>
References: <1517482822-28758-1-git-send-email-himanshujha199640@gmail.com>
Message-ID: <CAMuHMdVzDpWdc-qav2Y0_p8m6u_jdmjtZ37B4-V7k2vuFTTRVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Himanshu,

On Thu, Feb 1, 2018 at 12:00 PM, Himanshu Jha
<himanshujha199640@gmail.com> wrote:
> In scpsys_probe function, return value of of_match_device function which
> returns null is dereferenced without checking. Therefore, add a check for
> potential null dereference.
>
> Detected by CoverityScan, CID#1424087 "Dereference null return value"
>
> Fixes: commit 53fddb1a66dd ("soc: mediatek: reduce code duplication of scpsys_probe across all SoCs")
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>

This is a false positive: as this is a pure-OF driver, scpsys_probe()
is called if
and only if a match was found in of_scpsys_match_tbl[].

> ---
>  drivers/soc/mediatek/mtk-scpsys.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index 435ce5e..6e7f196 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -981,6 +981,9 @@ static int scpsys_probe(struct platform_device *pdev)
>         int i, ret;
>
>         match = of_match_device(of_scpsys_match_tbl, &pdev->dev);
> +       if (!match)
> +               return -EINVAL;
> +
>         soc = (const struct scp_soc_data *)match->data;
>
>         scp = init_scp(pdev, soc->domains, soc->num_domains, &soc->regs,

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
