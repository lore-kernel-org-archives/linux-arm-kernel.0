From: viresh.kumar@linaro.org (viresh kumar)
Date: Tue, 9 Oct 2012 23:04:48 +0530
Subject: [PATCH 05/11] fsmc: Implement ready/busy through gpio pin
In-Reply-To: <e455d98df0fba37e8b7ecd7e72d510a05f23d2ba.1349778821.git.vipin.kumar@st.com>
References: <cover.1349778820.git.vipin.kumar@st.com>
 <e455d98df0fba37e8b7ecd7e72d510a05f23d2ba.1349778821.git.vipin.kumar@st.com>
Message-ID: <CAOh2x=kAgD+0c4mgZsx+Gc+mxAEO9QPEj8_LdDxMaoqFi5g6_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 9, 2012 at 4:14 PM, Vipin Kumar <vipin.kumar@st.com> wrote:
> diff --git a/Documentation/devicetree/bindings/mtd/fsmc-nand.txt b/Documentation/devicetree/bindings/mtd/fsmc-nand.txt
> +- st,ready-busy: Should contain either of "rb-gpio" or "rb-wait". When
> +  this property is not defined, the default is to use rb-wait.
> +- st,rb-gpios: When the st,ready-busy is defined as "rb-gpio", a gpio
> +  pin number is defined in this property

Why st,*** maybe fsmc,***?

Would be better if you update the example too in this file.

> diff --git a/drivers/mtd/nand/fsmc_nand.c b/drivers/mtd/nand/fsmc_nand.c

> + * @rb_pin:            Ready/Busy data

> +       struct fsmc_rbpin       *rbpin;

comment variable mismatch :(

> -static void fsmc_nand_setup(void __iomem *regs, uint32_t bank,
> -                          uint32_t busw, struct fsmc_nand_timings *timings)
> +static void fsmc_nand_setup(void __iomem *regs, uint32_t bank, uint32_t busw,
> +                          struct fsmc_nand_timings *timings,
> +                          struct fsmc_rbpin *rbpin)

Can function prototype come in two lines instead of three?

> @@ -1049,6 +1075,8 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)

> +       if (host->rbpin->use_pin == FSMC_RB_GPIO) {
> +               ret = gpio_request(host->rbpin->gpio_pin, "fsmc-rb");
> +               if (ret < 0) {
> +                       dev_err(&pdev->dev, "gpio request fail: %d\n",
> +                                       host->rbpin->gpio_pin);
> +                       goto err_gpio_req;
> +               }
> +       }

Don't you want to set its direction to input?
