From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 21 Jun 2016 15:16:03 +0200
Subject: [PATCH 2/3] mmc: mmc: do not use CMD13 to get status after speed
 mode switch
In-Reply-To: <1463647662-27426-3-git-send-email-chaotian.jing@mediatek.com>
References: <1463647662-27426-1-git-send-email-chaotian.jing@mediatek.com>
 <1463647662-27426-3-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <CAPDyKFqaba9D4XtuDnPLcq2D4dpO6Cq9-RfhwoEu_vO=Pt9wEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 May 2016 at 10:47, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> Per JEDEC spec, it is not recommended to use CMD13 to get card status
> after speed mode switch. below are two reason about this:
> 1. CMD13 cannot be guaranteed due to the asynchronous operation.
> Therefore it is not recommended to use CMD13 to check busy completion
> of the timing change indication.
> 2. After switch to HS200, CMD13 will get response of 0x800, and even the
> busy signal gets de-asserted, the response of CMD13 is aslo 0x800.
>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>

Thanks, applied for next! (With a minor change, see below)

[...]

>
>         /* Switch HS to HS200 */
>         val = EXT_CSD_TIMING_HS200 |
>               card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
>         err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
>                            val, card->ext_csd.generic_cmd6_time, true,
> -                          send_status, true);
> +                          false, true);

To keep consistency with other calls to __mmc_switch(), I change these lines to:

err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
                       val, card->ext_csd.generic_cmd6_time,
                       true, false, true);

>         if (err)
>                 goto out_err;
>
>         mmc_set_timing(host, MMC_TIMING_MMC_HS200);
>
> -       if (!send_status) {
> -               err = mmc_switch_status(card);
> -               if (err)
> -                       goto out_err;
> -       }
> +       err = mmc_switch_status(card);
> +       if (err)
> +               goto out_err;
>
>         mmc_set_bus_speed(card);
>
> @@ -1243,7 +1227,6 @@ static void mmc_select_driver_type(struct mmc_card *card)
>  static int mmc_select_hs200(struct mmc_card *card)
>  {
>         struct mmc_host *host = card->host;
> -       bool send_status = true;
>         unsigned int old_timing;
>         int err = -EINVAL;
>         u8 val;
> @@ -1260,9 +1243,6 @@ static int mmc_select_hs200(struct mmc_card *card)
>
>         mmc_select_driver_type(card);
>
> -       if (host->caps & MMC_CAP_WAIT_WHILE_BUSY)
> -               send_status = false;
> -
>         /*
>          * Set the bus width(4 or 8) with host's support and
>          * switch to HS200 mode if bus width is set successfully.
> @@ -1274,20 +1254,18 @@ static int mmc_select_hs200(struct mmc_card *card)
>                 err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>                                    EXT_CSD_HS_TIMING, val,
>                                    card->ext_csd.generic_cmd6_time,
> -                                  true, send_status, true);
> +                                  true, false, true);

[...]

Kind regards
Uffe
