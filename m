From: robh+dt@kernel.org (Rob Herring)
Date: Wed, 30 Nov 2016 17:30:47 -0600
Subject: [PATCH 1/3] of: Support parsing phandle argument lists through a
 nexus node
In-Reply-To: <20161124102529.20212-2-stephen.boyd@linaro.org>
References: <20161124102529.20212-1-stephen.boyd@linaro.org>
 <20161124102529.20212-2-stephen.boyd@linaro.org>
Message-ID: <CAL_JsqKZ_Ohcdi0n6XU+5=3o6OwC=r_5Cv1=gx7mytUUVd2dzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2016 at 4:25 AM, Stephen Boyd <stephen.boyd@linaro.org> wrote:
> Platforms like 96boards have a standardized connector/expansion
> slot that exposes signals like GPIOs to expansion boards in an
> SoC agnostic way. We'd like the DT overlays for the expansion
> boards to be written once without knowledge of the SoC on the
> other side of the connector. This avoids the unscalable
> combinatorial explosion of a different DT overlay for each
> expansion board and SoC pair.
>
> We need a way to describe the GPIOs routed through the connector
> in an SoC agnostic way. Let's introduce nexus property parsing
> into the OF core to do this. This is largely based on the
> interrupt nexus support we already have. This allows us to remap
> a phandle list in a consumer node (e.g. reset-gpios) through a
> connector in a generic way (e.g. via gpio-map). Do this in a
> generic routine so that we can remap any sort of variable length
> phandle list.
>
> Taking GPIOs as an example, the connector would be a GPIO nexus,
> supporting the remapping of a GPIO specifier space to multiple
> GPIO providers on the SoC. DT would look as shown below, where
> 'soc_gpio1' and 'soc_gpio2' are inside the SoC, 'connector' is an
> expansion port where boards can be plugged in, and
> 'expansion_device' is a device on the expansion board.
>
>         soc {
>                 soc_gpio1: gpio-controller1 {
>                         #gpio-cells = <2>;
>                 };
>
>                 soc_gpio2: gpio-controller2 {
>                         #gpio-cells = <2>;
>                 };
>         };
>
>         connector: connector {
>                 #gpio-cells = <2>;
>                 gpio-map = <0 GPIO_ACTIVE_LOW &soc_gpio1 1 GPIO_ACTIVE_LOW>,
>                            <1 GPIO_ACTIVE_LOW &soc_gpio2 4 GPIO_ACTIVE_LOW>,
>                            <2 GPIO_ACTIVE_LOW &soc_gpio1 3 GPIO_ACTIVE_LOW>,
>                            <3 GPIO_ACTIVE_LOW &soc_gpio2 2 GPIO_ACTIVE_LOW>;
>                 gpio-map-mask = <0xf 0x1>;

I think the common case is something more like this:

                 gpio-map = <0 0 &soc_gpio1 1 0>,
                            <1 0 &soc_gpio2 4 0>,
                            <2 0 &soc_gpio1 3 0>,
                            <3 0 &soc_gpio2 2 0>;
                 gpio-map-mask = <0xf 0>;

where we want to pass the 2nd cell of the consumer (e.g. reset-gpios)
thru. So here the GPIO_ACTIVE_LOW flag below needs to pass thru to
&soc_gpio1. Otherwise, the gpio-map is has to enumerate every possible
combination or it will be specific to the daughterboard's usage.

Also, GPIO cells are pretty well standardized, but some cases may need
a translation function which I guess would be part of a connector
driver. I don't think that affects the binding nor needs to be solved
now, but just want to raise that possibility.

>         };
>
>         expansion_device {
>                 reset-gpios = <&connector 2 GPIO_ACTIVE_LOW>;
>         };
>
> The GPIO core would use of_parse_phandle_with_args_map() instead
> of of_parse_phandle_with_args() and arrive at the same type of
> result, a phandle and argument list. The difference is that the
> phandle and arguments will be remapped through the nexus node to
> the underlying SoC GPIO controller node. In the example above,
> we would remap 'reset-gpios' from <&connector 2 GPIO_ACTIVE_LOW>
> to <&soc_gpio1 3 GPIO_ACTIVE_LOW>.

GPIOs also are interrupts frequently, so we need to make sure
interrupt translation works too. It's a bit tricky as interrupt-map
depends on #address-cells and #interrupt-cells. I think we just set
the #address-cells to 0 on the connector node and it will be fine. We
may need the same pass thru of flags though.

>
> Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
>  drivers/of/base.c  | 146 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/of.h |  14 +++++
>  2 files changed, 160 insertions(+)
>
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index d687e6de24a0..693b73f33675 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -1772,6 +1772,152 @@ int of_parse_phandle_with_args(const struct device_node *np, const char *list_na
>  EXPORT_SYMBOL(of_parse_phandle_with_args);
>
>  /**
> + * of_parse_phandle_with_args_map() - Find a node pointed by phandle in a list and remap it
> + * @np:                pointer to a device tree node containing a list
> + * @list_name: property name that contains a list
> + * @cells_name:        property name that specifies phandles' arguments count
> + * @index:     index of a phandle to parse out
> + * @out_args:  optional pointer to output arguments structure (will be filled)
> + *
> + * This function is useful to parse lists of phandles and their arguments.
> + * Returns 0 on success and fills out_args, on error returns appropriate
> + * errno value.
> + *
> + * Caller is responsible to call of_node_put() on the returned out_args->np
> + * pointer.
> + *
> + * Example:
> + *
> + * phandle1: node1 {
> + *     #list-cells = <2>;
> + * }
> + *
> + * phandle2: node2 {
> + *     #list-cells = <1>;
> + * }
> + *
> + * phandle3: node3 {
> + *     #list-cells = <1>;
> + *     list-map = <0 &phandle2 3>,
> + *                <1 &phandle2 2>,
> + *                <2 &phandle1 5 1>;
> + *     list-map-mask = <0x3>;
> + * };
> + *
> + * node4 {
> + *     list = <&phandle1 1 2 &phandle3 0>;
> + * }
> + *
> + * To get a device_node of the `node2' node you may call this:
> + * of_parse_phandle_with_args(node4, "list", "#list-cells", "list-map",
> + *                           "list-map-mask", 1, &args);
> + */
> +int of_parse_phandle_with_args_map(const struct device_node *np,
> +                                  const char *list_name,
> +                                  const char *cells_name,
> +                                  const char *map_name,
> +                                  const char *mask_name,

Perhaps these 3 could be just a single base name (e.g. "gpio")?
Doesn't really buy much other than enforce we don't mix 'gpios' and
'gpio'. That could never happen. ;)

> +                                  int index, struct of_phandle_args *out_args)
> +{

Rob
