From: dianders@chromium.org (Doug Anderson)
Date: Tue, 24 Jun 2014 11:17:28 -0700
Subject: [PATCH 3/3] mmc: dw_mmc: Support voltage changes
In-Reply-To: <1403520321-2431-4-git-send-email-yuvaraj.cd@samsung.com>
References: <1403520321-2431-1-git-send-email-yuvaraj.cd@samsung.com>
 <1403520321-2431-4-git-send-email-yuvaraj.cd@samsung.com>
Message-ID: <CAD=FV=XV7umnSWbLh3t_euC1kpvNiiC8rYu_eXvoHbFC_GGnCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yuvaraj,

On Mon, Jun 23, 2014 at 3:45 AM, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com> wrote:
> From: Doug Anderson <dianders@chromium.org>
>
> For UHS cards we need the ability to switch voltages from 3.3V to
> 1.8V.  Add support to the dw_mmc driver to handle this.  Note that
> dw_mmc needs a little bit of extra code since the interface needs a
> special bit programmed to the CMD register while CMD11 is progressing.
> This means adding a few extra states to the state machine to track.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
>
> ---
>  drivers/mmc/host/dw_mmc.c  |  145 +++++++++++++++++++++++++++++++++++++++++---
>  drivers/mmc/host/dw_mmc.h  |    5 +-
>  include/linux/mmc/dw_mmc.h |    2 +
>  3 files changed, 142 insertions(+), 10 deletions(-)

I will note to other interested parties that in the ChromeOS tree we
never actually cleaned up the MMC voltage change stuff enough to make
use of this functionality to actually get UHS cards working (though
the code is exercised as part of WiFi).


> @@ -254,6 +258,32 @@ static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
>         else if (cmd->opcode != MMC_SEND_STATUS && cmd->data)
>                 cmdr |= SDMMC_CMD_PRV_DAT_WAIT;
>
> +       if (cmd->opcode == SD_SWITCH_VOLTAGE) {
> +               u32 clk_en_a;
> +
> +               /* Special bit makes CMD11 not die */
> +               cmdr |= SDMMC_CMD_VOLT_SWITCH;
> +
> +               /* Change state to continue to handle CMD11 weirdness */
> +               WARN_ON(slot->host->state != STATE_SENDING_CMD);
> +               slot->host->state = STATE_SENDING_CMD11;
> +
> +               /*
> +                * We need to disable clock stop while doing voltage switch
> +                * according to 7.4.1.2 Voltage Switch Normal Scenario.

I think upstream hasn't tended to like the chapter number references,
though Grant really liked them locally.

> +static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +       struct dw_mci_slot *slot = mmc_priv(mmc);
> +       struct dw_mci *host = slot->host;
> +       u32 uhs;
> +       u32 v18 = SDMMC_UHS_18V << slot->id;
> +       int min_uv, max_uv;
> +       int ret;
> +
> +       /*
> +        * Program the voltage.  Note that some instances of dw_mmc may use
> +        * the UHS_REG for this.  For other instances (like exynos) the UHS_REG
> +        * does no harm but you need to set the regulator directly.  Try both.

I've only worked with exynos which doesn't use UHS_REG for anything,
so the setting of this bit was a best-guess.  If anyone actually had a
chip that uses it then please comment / test.
