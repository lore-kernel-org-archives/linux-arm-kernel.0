From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 17 Jan 2018 10:33:28 +0100
Subject: [PATCH v2 03/15] mmc: mmci: Don't pretend all variants to have
 OPENDRAIN bit
In-Reply-To: <1516105859-3525-4-git-send-email-patrice.chotard@st.com>
References: <1516105859-3525-1-git-send-email-patrice.chotard@st.com>
 <1516105859-3525-4-git-send-email-patrice.chotard@st.com>
Message-ID: <CAPDyKFrhBfGq0RBBdFLex+88XqrLB-Bm3rc2Q_UZCw8XB520ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

>  /* Busy detection for the ST Micro variant */
> @@ -1455,16 +1465,13 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>                                 ~MCI_ST_DATA2DIREN);
>         }
>
> -       if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN) {
> -               if (host->hw_designer != AMBA_VENDOR_ST)
> -                       pwr |= MCI_ROD;
> -               else {
> -                       /*
> -                        * The ST Micro variant use the ROD bit for something
> -                        * else and only has OD (Open Drain).
> -                        */
> -                       pwr |= MCI_OD;
> -               }
> +       if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN &&
> +           host->variant->opendrain) {

A few nitpicks (because I anyway had some comment on patch4):

The above can be written on one line and the brackets isn't needed.

Replace host->variant->opendrain with variant->opendrain. The same
applies to the below change.

> +               /*
> +                * The ST Micro variant use the ROD bit for
> +                * something else and only has OD (Open Drain).
> +                */

I think we can remove this comment, as this information becomes
implicit when we start using the variant data.

> +               pwr |= host->variant->opendrain;
>         }
>
>         /*
> --
> 1.9.1
>

Kind regards
Uffe
