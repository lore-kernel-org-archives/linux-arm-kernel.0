From: abrestic@chromium.org (Andrew Bresticker)
Date: Mon, 15 Dec 2014 15:44:24 -0800
Subject: [PATCH v2 2/3] mmc: dw_mmc: Use mmc_regulator_set_vqmmc in
 start_signal_voltage_switch
In-Reply-To: <1418685929-13096-2-git-send-email-dianders@chromium.org>
References: <1418685929-13096-1-git-send-email-dianders@chromium.org>
 <1418685929-13096-2-git-send-email-dianders@chromium.org>
Message-ID: <CAL1qeaHfsq1xOOBMQc58uSvV4unuEWHjqVpiZrpu2bQD36LbXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

On Mon, Dec 15, 2014 at 3:25 PM, Doug Anderson <dianders@chromium.org> wrote:
> We've introduced a new helper in the MMC core:
> mmc_regulator_set_vqmmc().  Let's use this in dw_mmc.  Using this new
> helper has some advantages:
>
> 1. We get the mmc_regulator_set_vqmmc() behavior of trying to match
>    VQMMC and VMMC when the signal voltage is 3.3V.  This ensures max
>    compatibility.
>
> 2. We get rid of a few more warnings when probing unsupported
>    voltages.
>
> 3. We get rid of some non-dw_mmc specific code in dw_mmc.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>

One small comment below...

> @@ -1170,24 +1168,11 @@ static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
>          */
>         uhs = mci_readl(host, UHS_REG);
>         if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
> -               min_uv = 2700000;
> -               max_uv = 3600000;
>                 uhs &= ~v18;
>         } else {
> -               min_uv = 1700000;
> -               max_uv = 1950000;
>                 uhs |= v18;
>         }
> -       if (!IS_ERR(mmc->supply.vqmmc)) {
> -               ret = regulator_set_voltage(mmc->supply.vqmmc, min_uv, max_uv);
> -
> -               if (ret) {
> -                       dev_dbg(&mmc->class_dev,
> -                                        "Regulator set error %d: %d - %d\n",
> -                                        ret, min_uv, max_uv);
> -                       return ret;
> -               }
> -       }
> +       mmc_regulator_set_vqmmc(mmc, ios);

Shouldn't we check the return value here and bail out of the voltage
switch procedure if it fails?
