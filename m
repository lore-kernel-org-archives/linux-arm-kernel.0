From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 26 Nov 2012 13:06:26 +0900
Subject: [PATCH 1/7] mmc: sh-mmcif: provide default allowed voltage
In-Reply-To: <1353889014-17142-2-git-send-email-horms@verge.net.au>
References: <1353889014-17142-1-git-send-email-horms@verge.net.au>
 <1353889014-17142-2-git-send-email-horms@verge.net.au>
Message-ID: <CANqRtoT8yFx8fe0Fkmh6F91NxajgcPYmheSwpqKk4HtQkX6_pw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Mon, Nov 26, 2012 at 9:16 AM, Simon Horman <horms@verge.net.au> wrote:
> Use MMC_VDD_165_195 as the allowed voltages in the absence of
> platform data. This should allow device tree to initialise MMCIF
> for a number of boards.
>
> A more complete solution would be to provide either MMCIF or MMC device
> try bindings to set the allowed voltages.
>
> Tested on the KZM-A9-GT board
>
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Signed-off-by: Simon Horman <horms@verge.net.au>
> ---
>  drivers/mmc/host/sh_mmcif.c |    7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Thanks for your patch!

> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 11d2bc3..88d6866 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -1293,12 +1293,9 @@ static void sh_mmcif_init_ocr(struct sh_mmcif_host *host)
>
>         mmc_regulator_get_supply(mmc);
>
> -       if (!pd)
> -               return;
> -
>         if (!mmc->ocr_avail)
> -               mmc->ocr_avail = pd->ocr;
> -       else if (pd->ocr)
> +               mmc->ocr_avail = pd ? pd->ocr : MMC_VDD_165_195;
> +       else if (pd && pd->ocr)
>                 dev_warn(mmc_dev(mmc), "Platform OCR mask is ignored\n");
>  }

I may be mistaken, but I somehow thought that the code in
mmc_regulator_get_supply() would take care of this automatically for
us already. So this kind of patch isn't really needed as long as you
tie in regulators via DT as expected.

Thanks,

/ magnus
