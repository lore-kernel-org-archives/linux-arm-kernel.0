From: alim.akhtar@gmail.com (Alim Akhtar)
Date: Sun, 22 Mar 2015 17:46:46 +0530
Subject: [PATCH] mmc: dw_mmc: Don't send clock off command if power is off
In-Reply-To: <1426874420-25103-1-git-send-email-dianders@chromium.org>
References: <1426874420-25103-1-git-send-email-dianders@chromium.org>
Message-ID: <CAGOxZ52OWucMh_HjWnZnhN=c7C3TXeQ4aV-GAe5XXtRbu0r2Kg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

On Fri, Mar 20, 2015 at 11:30 PM, Doug Anderson <dianders@chromium.org> wrote:
> We've already seen that it causes failures if we try to send the
> "SDMMC_CMD_UPD_CLK" command when power is off to the system.  Here's
> another case where we were doing it: we were sending an
> SDMMC_CMD_UPD_CLK to set the clock to 0 when the card was already
> powered off and the clock was already at 0.  Let's avoid that command
> and avoid problems.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
>  drivers/mmc/host/dw_mmc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 47dfd0e..aeec698 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1172,8 +1172,9 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>
>                 break;
>         case MMC_POWER_OFF:
> -               /* Turn clock off before power goes down */
> -               dw_mci_setup_bus(slot, false);
> +               /* Turn clock off before power goes down; only if powered */
> +               if (slot->host->vqmmc_enabled)
> +                       dw_mci_setup_bus(slot, false);
>
vqmmc_enabled is always _true_ when entering MMC_POWER_OFF case..right?
Is this done for extra protection? Or do you have a case where vqmmc
is OFF and driver still calls dw_mci_setup_bus from here?

>                 if (!IS_ERR(mmc->supply.vmmc))
>                         mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> --
> 2.2.0.rc0.207.ga3a616c
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards,
Alim
