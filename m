From: manabian@gmail.com (Joachim Eastwood)
Date: Sun, 8 May 2016 19:17:13 +0200
Subject: [PATCH v8 2/3] gpio: mmio: add DT support for memory-mapped GPIOs
In-Reply-To: <535f785bf6116c0fb6f46afbb77e6d4bd3ef5f60.1462543458.git.chunkeey@googlemail.com>
References: <cover.1462543457.git.chunkeey@googlemail.com>
 <535f785bf6116c0fb6f46afbb77e6d4bd3ef5f60.1462543458.git.chunkeey@googlemail.com>
Message-ID: <CAGhQ9VyG6yX+g=FjfB6VP0pUNYGYXo60CHkWmSiiOisjeX20cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christian,

On 8 May 2016 at 15:08, Christian Lamparter <chunkeey@googlemail.com> wrote:
> From: ?lvaro Fern?ndez Rojas <noltari@gmail.com>
>
> This patch adds support for defining memory-mapped GPIOs which
> are compatible with the existing gpio-mmio interface. The generic
> library provides support for many memory-mapped GPIO controllers
> that are found in various on-board FPGA and ASIC solutions that
> are used to control board's switches, LEDs, chip-selects,
> Ethernet/USB PHY power, etc.
>
> For setting GPIO's there are three configurations:
>         1. single input/output register resource (named "dat"),
>         2. set/clear pair (named "set" and "clr"),
>         3. single output register resource and single input resource
>            ("set" and dat").
>
> The configuration is detected by which resources are present.
> For the single output register, this drives a 1 by setting a bit
> and a zero by clearing a bit.  For the set clr pair, this drives
> a 1 by setting a bit in the set register and clears it by setting
> a bit in the clear register. The configuration is detected by
> which resources are present.
>
> For setting the GPIO direction, there are three configurations:
>         a. simple bidirectional GPIOs that requires no configuration.
>         b. an output direction register (named "dirout")
>            where a 1 bit indicates the GPIO is an output.
>         c. an input direction register (named "dirin")
>            where a 1 bit indicates the GPIO is an input.
>
> The first user for this binding is "wd,mbl-gpio".
>
> Signed-off-by: ?lvaro Fern?ndez Rojas <noltari@gmail.com>
> Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>
> ---

> +#define ADD(_name, _func) { .compatible = _name, .data = _func }

I don't see the point in having a macro for such a simple data
structure, but since this v8 and Linus hasn't complained I guess it's
fine.

Using a macro here makes it impossible to grep for 'compatible'. Doing
'git grep compatible drivers/gpio/' is sometimes very useful to see
which hardware the driver actually supports.

> +static const struct of_device_id bgpio_of_match[] = {
> +       ADD("wd,mbl-gpio", bgpio_basic_mmio_parse_dt),
> +       { }
> +};
> +#undef ADD
> +MODULE_DEVICE_TABLE(of, bgpio_of_match);
> +
> +static struct bgpio_pdata *bgpio_parse_dt(struct platform_device *pdev,
> +                                         unsigned long *flags)
> +{
> +       const int (*parse_dt)(struct platform_device *,
> +                             struct bgpio_pdata *, unsigned long *);
> +       const struct device_node *node = pdev->dev.of_node;
> +       const struct of_device_id *of_id;
> +       struct bgpio_pdata *pdata;
> +       int err = -ENODEV;
> +
> +       of_id = of_match_node(bgpio_of_match, node);
> +       if (!of_id)
> +               return NULL;
> +
> +       pdata = devm_kzalloc(&pdev->dev, sizeof(struct bgpio_pdata),
> +                            GFP_KERNEL);
> +       if (!pdata)
> +               return ERR_PTR(-ENOMEM);
> +
> +       parse_dt = (const void *)of_id->data;

You can retrieve OF match data using of_device_get_match_data(). Saves
you a couple of lines and better explains what your doing.


> +       if (parse_dt)
> +               err = parse_dt(pdev, pdata, flags);
> +       if (err)
> +               return ERR_PTR(err);
> +
> +       return pdata;
> +}


regards,
Joachim Eastwood
