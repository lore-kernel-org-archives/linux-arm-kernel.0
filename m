From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 25 Nov 2016 18:03:09 +0800
Subject: [PATCH 05/10] mfd: axp20x: add separate MFD cell for AXP223
In-Reply-To: <20161125090921.23138-6-quentin.schulz@free-electrons.com>
References: <20161125090921.23138-1-quentin.schulz@free-electrons.com>
 <20161125090921.23138-6-quentin.schulz@free-electrons.com>
Message-ID: <CAGb2v65G5rXgwh23OKHr0dk5BfMgGvOr3q0XVP4GGxzh4d_L6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 25, 2016 at 5:09 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> The AXP223 shares most of its logic with the AXP221 but has some
> differences for the VBUS power supply driver. Thus, to probe the driver
> with the correct compatible, the AXP221 and the AXP223 now have separate
> MFD cells.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  drivers/mfd/axp20x.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index ba130be..989d568 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -602,6 +602,21 @@ static struct mfd_cell axp22x_cells[] = {
>         },
>  };
>
> +static struct mfd_cell axp223_cells[] = {
> +       {
> +               .name                   = "axp20x-pek",
> +               .num_resources          = ARRAY_SIZE(axp22x_pek_resources),
> +               .resources              = axp22x_pek_resources,
> +       }, {
> +               .name                   = "axp20x-regulator",
> +       }, {
> +               .name           = "axp20x-usb-power-supply",
> +               .of_compatible  = "x-powers,axp223-usb-power-supply",
> +               .num_resources  = ARRAY_SIZE(axp22x_usb_power_supply_resources),
> +               .resources      = axp22x_usb_power_supply_resources,

Nit: Please align the statements. And you might want to rename the original
axp22x_cells to axp221_cells to avoid confusion. Otherwise,

Acked-by: Chen-Yu Tsai <wens@csie.org>

> +       },
> +};
> +
>  static struct mfd_cell axp152_cells[] = {
>         {
>                 .name                   = "axp20x-pek",
> @@ -789,12 +804,17 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
>                 axp20x->regmap_irq_chip = &axp20x_regmap_irq_chip;
>                 break;
>         case AXP221_ID:
> -       case AXP223_ID:
>                 axp20x->nr_cells = ARRAY_SIZE(axp22x_cells);
>                 axp20x->cells = axp22x_cells;
>                 axp20x->regmap_cfg = &axp22x_regmap_config;
>                 axp20x->regmap_irq_chip = &axp22x_regmap_irq_chip;
>                 break;
> +       case AXP223_ID:
> +               axp20x->nr_cells = ARRAY_SIZE(axp223_cells);
> +               axp20x->cells = axp223_cells;
> +               axp20x->regmap_cfg = &axp22x_regmap_config;
> +               axp20x->regmap_irq_chip = &axp22x_regmap_irq_chip;
> +               break;
>         case AXP288_ID:
>                 axp20x->cells = axp288_cells;
>                 axp20x->nr_cells = ARRAY_SIZE(axp288_cells);
> --
> 2.9.3
>
