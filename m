From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 3 Jan 2018 09:09:28 +0100
Subject: [PATCH] pinctrl: imx6ul: add IOMUXC SNVS pinctrl driver for i.MX
 6ULL
In-Reply-To: <20180102164059.14641-1-stefan@agner.ch>
References: <20180102164059.14641-1-stefan@agner.ch>
Message-ID: <CACRpkdYKiLeRZdBCWie+UGK=96FicXXmWvGUvwNFD2ZWOUx7Rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 2, 2018 at 5:40 PM, Stefan Agner <stefan@agner.ch> wrote:

> From: Bai Ping <ping.bai@nxp.com>
>
> On i.MX 6ULL, the BOOT_MODEx and TAMPERx pin MUX and CTRL registers
> are available in a separate IOMUXC_SNVS module. Add support for the
> IOMUXC_SNVS module to the i.MX 6UL pinctrl driver.
>
> Signed-off-by: Bai Ping <ping.bai@nxp.com>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

So 6 unsigned long 32 bit is succeeded by 6 unsigned long long, 64 bit?

Someone is having fun naming these platforms I see.

>  Required properties:
> -- compatible: "fsl,imx6ul-iomuxc"
> +- compatible: "fsl,imx6ul-iomuxc" for main IOMUX controller or
> +  "fsl,imx6ull-iomuxc-snvs" for i.MX 6ULL's SNVS IOMUX controller.

Pretty uncontroversial change but still nice to give the DT people a chance
to ACK it.

>  static int imx6ul_pinctrl_probe(struct platform_device *pdev)
>  {
> -       return imx_pinctrl_probe(pdev, &imx6ul_pinctrl_info);
> +       const struct of_device_id *match;
> +       struct imx_pinctrl_soc_info *pinctrl_info;
> +
> +       match = of_match_device(imx6ul_pinctrl_of_match, &pdev->dev);
> +
> +       if (!match)
> +               return -ENODEV;
> +
> +       pinctrl_info = (struct imx_pinctrl_soc_info *) match->data;

1. Do not use a cast on void * pointers.

2. Use this function:
extern const void *of_device_get_match_data(const struct device *dev);

>From <linux/of_device.h>

Yours,
Linus Walleij
