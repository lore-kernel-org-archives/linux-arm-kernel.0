From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 5 Apr 2016 12:46:53 -0300
Subject: [PATCH 2/2] PCI: imx6: Add reset-gpio-active-high boolean
 property to DT
In-Reply-To: <1459514508-8557-3-git-send-email-ynezz@true.cz>
References: <1459514508-8557-1-git-send-email-ynezz@true.cz>
 <1459514508-8557-3-git-send-email-ynezz@true.cz>
Message-ID: <CAOMZO5AnN4_RrA4bksWNmioAP1PCBT1Ax4of_OnoCvG+VXgDUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 1, 2016 at 9:41 AM, Petr ?tetiar <ynezz@true.cz> wrote:

>         /* Some boards don't have PCIe reset GPIO. */
>         if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> -               gpio_set_value_cansleep(imx6_pcie->reset_gpio, 0);
> +               gpio_set_value_cansleep(imx6_pcie->reset_gpio,
> +                                       !!imx6_pcie->gpio_active_high);

gpio_set_value_cansleep(imx6_pcie->reset_gpio,
                                      imx6_pcie->gpio_active_high); is enough.

> @@ -546,9 +549,14 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>
>         /* Fetch GPIOs */
>         imx6_pcie->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
> +       imx6_pcie->gpio_active_high = of_property_read_bool(np,
> +                                               "reset-gpio-active-high");

You need to document reset-gpio-active-high property in
Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt.
