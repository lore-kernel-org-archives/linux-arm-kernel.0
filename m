From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 3 Nov 2014 10:04:30 +0100
Subject: [PATCH] mmc: host: atmel-mci: Add support for non-removable slots
In-Reply-To: <1414147803-29202-1-git-send-email-timo.kokkonen@offcode.fi>
References: <1414147803-29202-1-git-send-email-timo.kokkonen@offcode.fi>
Message-ID: <CAPDyKFpMGk4M=fjBKufxb9iMbV6FmRTEfE_ptXPmM=CHx3Q7iQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 October 2014 12:50, Timo Kokkonen <timo.kokkonen@offcode.fi> wrote:
> Add support for non-removable slots which have no card detection GPIO
> and which should not be polled for a card change.
>
> Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>

Hi Timo,

Please resend and include Ludovic Desroches on the "to-line".

Kind regards
Uffe

> ---
>  drivers/mmc/host/atmel-mci.c | 11 +++++++++--
>  include/linux/atmel-mci.h    |  2 ++
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 77250d4..4de1a31 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -560,6 +560,9 @@ atmci_of_init(struct platform_device *pdev)
>                 pdata->slot[slot_id].detect_is_active_high =
>                         of_property_read_bool(cnp, "cd-inverted");
>
> +               pdata->slot[slot_id].non_removable =
> +                       of_property_read_bool(cnp, "non-removable");
> +
>                 pdata->slot[slot_id].wp_pin =
>                         of_get_named_gpio(cnp, "wp-gpios", 0);
>         }
> @@ -2206,8 +2209,12 @@ static int __init atmci_init_slot(struct atmel_mci *host,
>                 }
>         }
>
> -       if (!gpio_is_valid(slot->detect_pin))
> -               mmc->caps |= MMC_CAP_NEEDS_POLL;
> +       if (!gpio_is_valid(slot->detect_pin)) {
> +               if (slot_data->non_removable)
> +                       mmc->caps |= MMC_CAP_NONREMOVABLE;
> +               else
> +                       mmc->caps |= MMC_CAP_NEEDS_POLL;
> +       }
>
>         if (gpio_is_valid(slot->wp_pin)) {
>                 if (devm_gpio_request(&host->pdev->dev, slot->wp_pin,
> diff --git a/include/linux/atmel-mci.h b/include/linux/atmel-mci.h
> index 91b77f8..9177947 100644
> --- a/include/linux/atmel-mci.h
> +++ b/include/linux/atmel-mci.h
> @@ -11,6 +11,7 @@
>   * @detect_pin: GPIO pin wired to the card detect switch
>   * @wp_pin: GPIO pin wired to the write protect sensor
>   * @detect_is_active_high: The state of the detect pin when it is active
> + * @non_removable: The slot is not removable, only detect once
>   *
>   * If a given slot is not present on the board, @bus_width should be
>   * set to 0. The other fields are ignored in this case.
> @@ -26,6 +27,7 @@ struct mci_slot_pdata {
>         int                     detect_pin;
>         int                     wp_pin;
>         bool                    detect_is_active_high;
> +       bool                    non_removable;
>  };
>
>  /**
> --
> 1.9.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
