From: dianders@chromium.org (Doug Anderson)
Date: Wed, 29 Oct 2014 21:41:05 -0700
Subject: [PATCH] mmc: dw_mmc: add a quirk for the defferent bit of sdio
 interrupt
In-Reply-To: <1414635679-12565-1-git-send-email-addy.ke@rock-chips.com>
References: <1414635679-12565-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <CAD=FV=Uo3gcnGFn=gpZhV1r+qyZxJ_tpAEiSsu06P=csHTScug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Addy,

On Wed, Oct 29, 2014 at 7:21 PM, Addy Ke <addy.ke@rock-chips.com> wrote:
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -778,6 +778,12 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
>         u32 div;
>         u32 clk_en_a;
>         u32 sdmmc_cmd_bits = SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT;
> +       u32 sdio_int_bit;
> +
> +       if (host->quirks & DW_MCI_QUIRK_SDIO_INT_24BIT)
> +               sdio_int_bit = SDMMC_INT_SDIO_24BIT(slot->id);
> +       else
> +               sdio_int_bit = SDMMC_INT_SDIO(slot->id);

You can avoid a lot of "if" tests if you just add a new "sdio->id"
field to the slot and init it at probe time.  It would be "8 +
slot->id" for rk3288 systems.

> @@ -2452,6 +2471,9 @@ static struct dw_mci_of_quirks {
>         }, {
>                 .quirk  = "disable-wp",
>                 .id     = DW_MCI_QUIRK_NO_WRITE_PROTECT,
> +       }, {
> +               .quirk  = "sdio-int-24bit",
> +               .id     = DW_MCI_QUIRK_SDIO_INT_24BIT,

This is adding a device tree binding.  You need to document it.

...but you should probably avoid that anyway.  All rk3288 chips need
this.  You should just add do what you need to do automatically if
you're a rk3288.  You've already got a specific compatible string for
rk3288.

-Doug
