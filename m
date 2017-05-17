From: haibo.chen@nxp.com (Bough Chen)
Date: Wed, 17 May 2017 02:10:32 +0000
Subject: imx7: mmc_select_hs200 failed, error -74
In-Reply-To: <CAOMZO5AXb3-YGc7hGRP_OY8C-Go0pBECbDoQo1SUB1i=t1Xi4w@mail.gmail.com>
References: <CAOMZO5ByTR1C4qUdc+hBcGTFVf-NH2gS5PmH3=w5-TrAoDQVUA@mail.gmail.com>
 <CAOMZO5AXb3-YGc7hGRP_OY8C-Go0pBECbDoQo1SUB1i=t1Xi4w@mail.gmail.com>
Message-ID: <AM4PR0401MB232411A003DC9F9D2F9CAEA490E70@AM4PR0401MB2324.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-mmc-owner at vger.kernel.org [mailto:linux-mmc-
> owner at vger.kernel.org] On Behalf Of Fabio Estevam
> Sent: Tuesday, May 16, 2017 11:37 PM
> To: A.S. Dong <aisheng.dong@nxp.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>; linux-mmc at vger.kernel.org; Ulf
> Hansson <ulf.hansson@linaro.org>; Stefan Agner <stefan@agner.ch>; linux-
> arm-kernel at lists.infradead.org
> Subject: Re: imx7: mmc_select_hs200 failed, error -74
> 
> On Tue, May 16, 2017 at 10:58 AM, Fabio Estevam <festevam@gmail.com>
> wrote:
> > Hi,
> >
> > On a imx7s-warp board (sdhci-esdhc-imx.c driver) running 4.12-rc1 the
> > following mmc1 error message is seen:
> >
> > [    1.796192] mmc1: mmc_select_hs200 failed, error -74
Hi Fabio,

Can you open the mmc debug and show the full log?
By the way, you should first make sure whether the eMMC chip you used support HS200, and double
check whether the vccq voltage is 1.8v or 1.2v, HS200 mode can't work on 3.3v I/O voltage.

Best Regards
Haibo Chen

> > [    1.810220] mmc1: new MMC card at address 0001
> > [    1.823066] mmcblk1: mmc1:0001 V10008 7.05 GiB
> > [    1.834155] mmcblk1boot0: mmc1:0001 V10008 partition 1 4.00 MiB
> > [    1.841608] mmcblk1boot1: mmc1:0001 V10008 partition 2 4.00 MiB
> > [    1.848971] mmcblk1rpmb: mmc1:0001 V10008 partition 3 4.00 MiB
> > [    1.859576]  mmcblk1: p1 p2
> >
> > The rootfs can be mounted correctly from eMMC though.
> >
> > What is the proper way to fix the 'mmc_select_hs200 failed' error message?
> 
> with the following changes:
> 
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1454,7 +1454,7 @@ static int mmc_select_hs200(struct mmc_card *card)
>                 if (mmc_set_signal_voltage(host, old_signal_voltage))
>                         err = -EIO;
> 
> -               pr_err("%s: %s failed, error %d\n", mmc_hostname(card->host),
> +               pr_debug("%s: %s failed, error %d\n",
> + mmc_hostname(card->host),
>                        __func__, err);
>         }
>         return err;
> @@ -1474,7 +1474,7 @@ static int mmc_select_timing(struct mmc_card *card)
>                 err = mmc_select_hs400es(card);
>         else if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200)
>                 err = mmc_select_hs200(card);
> -       else if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS)
> +       if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS)
>                 err = mmc_select_hs(card);
> 
>         if (err && err != -EBADMSG)
> 
> the card is probed as DDR MMC and the error message is gone:
> 
> # dmesg | grep mmc1
> [    1.702797] mmc1: SDHCI controller on 30b60000.usdhc [30b60000.usdhc]
> using A
> [    1.811211] mmc1: new DDR MMC card at address 0001
> [    1.820786] mmcblk1: mmc1:0001 V10008 7.05 GiB
> [    1.833340] mmcblk1boot0: mmc1:0001 V10008 partition 1 4.00 MiB
> [    1.840518] mmcblk1boot1: mmc1:0001 V10008 partition 2 4.00 MiB
> [    1.847812] mmcblk1rpmb: mmc1:0001 V10008 partition 3 4.00 MiB
> 
> Is this a correct fix?
> 
> Thanks
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in the
> body of a message to majordomo at vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
