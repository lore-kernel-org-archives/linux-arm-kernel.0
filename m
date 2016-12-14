From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 14 Dec 2016 23:43:01 +0800
Subject: [PATCH v2 02/11] mfd: axp20x: add volatile and writeable reg
 ranges for VBUS power supply driver
In-Reply-To: <20161209110419.28981-3-quentin.schulz@free-electrons.com>
References: <20161209110419.28981-1-quentin.schulz@free-electrons.com>
 <20161209110419.28981-3-quentin.schulz@free-electrons.com>
Message-ID: <CAGb2v66jDsU2rt4d-0ydWR926y-hHTfOBJQmyYVdKd7rcm1WWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 9, 2016 at 7:04 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> The X-Powers AXP20X and AXP22X PMICs allow to choose the maximum voltage
> and minimum current delivered by the VBUS power supply.
>
> This adds the register used by the VBUS power supply driver to the range
> of volatile and writeable regs ranges.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>
> added in v2
>
>  drivers/mfd/axp20x.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index ba130be..6ee2cc6 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -65,12 +65,14 @@ static const struct regmap_access_table axp152_volatile_table = {
>
>  static const struct regmap_range axp20x_writeable_ranges[] = {
>         regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ5_STATE),
> +       regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_VBUS_IPSOUT_MGMT),

This is already covered by the previous entry.

>         regmap_reg_range(AXP20X_DCDC_MODE, AXP20X_FG_RES),
>         regmap_reg_range(AXP20X_RDC_H, AXP20X_OCV(AXP20X_OCV_MAX)),
>  };
>
>  static const struct regmap_range axp20x_volatile_ranges[] = {
>         regmap_reg_range(AXP20X_PWR_INPUT_STATUS, AXP20X_USB_OTG_STATUS),
> +       regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_VBUS_IPSOUT_MGMT),

And I'm not sure why you specify it as volatile? The PMIC doesn't change any
of the bits in this register on its own.

Same for the AXP22x bits. So basically I think you don't need this patch.

ChenYu

>         regmap_reg_range(AXP20X_CHRG_CTRL1, AXP20X_CHRG_CTRL2),
>         regmap_reg_range(AXP20X_IRQ1_EN, AXP20X_IRQ5_STATE),
>         regmap_reg_range(AXP20X_ACIN_V_ADC_H, AXP20X_IPSOUT_V_HIGH_L),
> @@ -91,11 +93,13 @@ static const struct regmap_access_table axp20x_volatile_table = {
>  /* AXP22x ranges are shared with the AXP809, as they cover the same range */
>  static const struct regmap_range axp22x_writeable_ranges[] = {
>         regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ5_STATE),
> +       regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_VBUS_IPSOUT_MGMT),
>         regmap_reg_range(AXP20X_DCDC_MODE, AXP22X_BATLOW_THRES1),
>  };
>
>  static const struct regmap_range axp22x_volatile_ranges[] = {
>         regmap_reg_range(AXP20X_PWR_INPUT_STATUS, AXP20X_PWR_OP_MODE),
> +       regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_VBUS_IPSOUT_MGMT),
>         regmap_reg_range(AXP20X_IRQ1_EN, AXP20X_IRQ5_STATE),
>         regmap_reg_range(AXP22X_GPIO_STATE, AXP22X_GPIO_STATE),
>         regmap_reg_range(AXP20X_FG_RES, AXP20X_FG_RES),
> --
> 2.9.3
>
