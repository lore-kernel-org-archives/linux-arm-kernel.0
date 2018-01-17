From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 17 Jan 2018 10:34:46 +0100
Subject: [PATCH v2 04/15] mmc: mmci: Add support for setting pad type via
 pinctrl
In-Reply-To: <1516105859-3525-5-git-send-email-patrice.chotard@st.com>
References: <1516105859-3525-1-git-send-email-patrice.chotard@st.com>
 <1516105859-3525-5-git-send-email-patrice.chotard@st.com>
Message-ID: <CAPDyKFoVT7rqLVzYVrO8JTD_MVLxr_R8PO=fWqLVG4DB1MpnTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

>         /*
> @@ -1616,6 +1625,32 @@ static int mmci_probe(struct amba_device *dev,
>         host = mmc_priv(mmc);
>         host->mmc = mmc;
>
> +       /*
> +        * Some variant (STM32) doesn't have opendrain bit, nevertheless
> +        * pins can be set accordingly using pinctrl
> +        */
> +       if (!variant->opendrain) {
> +               host->pinctrl = devm_pinctrl_get(&dev->dev);
> +               if (IS_ERR(host->pinctrl)) {
> +                       dev_err(&dev->dev, "failed to get pinctrl");
> +                       goto host_free;
> +               }
> +
> +               host->pins_default = pinctrl_lookup_state(host->pinctrl,
> +                                                         PINCTRL_STATE_DEFAULT);
> +               if (IS_ERR(host->pins_default)) {
> +                       dev_warn(mmc_dev(mmc), "Can't select default pins\n");
> +                       host->pins_default = NULL;

This is wrong, I think you should bail out and return the error code instead.

Moreover, calling pinctrl_select_state() from ->set_ios by using a
NULL state, will likely trigger a NULL pointer deference bug in the
pinctrl layer.

> +               }
> +
> +               host->pins_opendrain = pinctrl_lookup_state(host->pinctrl,
> +                                                           MMCI_PINCTRL_STATE_OPENDRAIN);
> +               if (IS_ERR(host->pins_opendrain)) {
> +                       dev_warn(mmc_dev(mmc), "Can't select opendrain pins\n");
> +                       host->pins_opendrain = NULL;

Ditto.

> +               }
> +       }
> +

[...]

Kind regards
Uffe
