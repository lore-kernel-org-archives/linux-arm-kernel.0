From: dianders@chromium.org (Doug Anderson)
Date: Tue, 10 May 2016 14:07:34 -0700
Subject: [PATCH] pinctrl: rockchip: fix pull setting error for rk3399
In-Reply-To: <1462878896-28956-1-git-send-email-wxt@rock-chips.com>
References: <1462878896-28956-1-git-send-email-wxt@rock-chips.com>
Message-ID: <CAD=FV=VrE=9=sgqUXBMwmoQin8S+yPbAgnrO1VUgx5QafYWXhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Caesar / David,

On Tue, May 10, 2016 at 4:14 AM, Caesar Wang <wxt@rock-chips.com> wrote:
> From: David Wu <david.wu@rock-chips.com>
>
> This patch fixes the pinctrl pull bias setting, since the pull up/down
> setting is the contrary for gpio0.

Commit message only mentions gpio0, but gpio2 is also fixed in the
commit.  Please mention gpio2 in the commit message.


> From the TRM said, the gpio0 pull polarity setting:
> gpio0a_p (gpio0 )
> GPIO0A PE/PS programmation section, every
> GPIO bit corresponding to 2bits[PS:PE]
> 2'b00: Z(Noraml operaton);
> 2'b11: weak 1(pull-up);
> 2'b01: weak 0(pull-down);
> 2'b10: Z(Noraml operaton);

Despite the fact that the typo (Noralm vs. Normal) is present in the
TRM, maybe we should fix it here?


> Then, the other gpios setting as the following:
> gpio1a_p (gpio1, gpio2, gpio3...)
> GPIO1A PU/PD programmation section, every
> GPIO bit corresponding to 2bits
> 2'b00: Z(Noraml operaton);
> 2'b01: weak 1(pull-up);
> 2'b10: weak 0(pull-down);
> 2'b11: Repeater(Bus keeper)
>
> For example,(rk3399evb board)
> sdmmc_cd --->gpio0_a7
> localhost / # io -r -4 0xff320040
> ff320040: 00004d5f
> In general,the value should be 0x0000cd5f since the pin set in the dts.
>
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: linux-gpio at vger.kernel.org
> ---
>
>  drivers/pinctrl/pinctrl-rockchip.c | 178 ++++++++++++++++++++++++++-----------
>  1 file changed, 126 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
> index 596b869..38be9c7 100644
> --- a/drivers/pinctrl/pinctrl-rockchip.c
> +++ b/drivers/pinctrl/pinctrl-rockchip.c
> @@ -99,6 +99,15 @@ enum rockchip_pin_drv_type {
>  };
>
>  /**
> + * enum type index corresponding to rockchip_pull_list arrays index.
> + */
> +enum rockchip_pin_pull_type {
> +       PULL_TYPE_IO_DEFAULT = 0,
> +       PULL_TYPE_IO_1V8_ONLY,
> +       PULL_TYPE_MAX
> +};
> +
> +/**
>   * @drv_type: drive strength variant using rockchip_perpin_drv_type
>   * @offset: if initialized to -1 it will be autocalculated, by specifying
>   *         an initial offset value the relevant source offset can be reset
> @@ -123,6 +132,7 @@ struct rockchip_drv {
>   * @bank_num: number of the bank, to account for holes
>   * @iomux: array describing the 4 iomux sources of the bank
>   * @drv: array describing the 4 drive strength sources of the bank
> + * @pull_type: array describing the 4 pull type sources of the bank
>   * @valid: are all necessary informations present
>   * @of_node: dt node of this bank
>   * @drvdata: common pinctrl basedata
> @@ -143,6 +153,7 @@ struct rockchip_pin_bank {
>         u8                              bank_num;
>         struct rockchip_iomux           iomux[4];
>         struct rockchip_drv             drv[4];
> +       enum rockchip_pin_pull_type     pull_type[4];
>         bool                            valid;
>         struct device_node              *of_node;
>         struct rockchip_pinctrl         *drvdata;
> @@ -198,6 +209,31 @@ struct rockchip_pin_bank {
>                 },                                                      \
>         }
>
> +#define PIN_BANK_DRV_FLAGS_PULL_FLAGS(id, pins, label, drv0, drv1,     \
> +                                     drv2, drv3, pull0, pull1,         \
> +                                     pull2, pull3)                     \
> +       {                                                               \
> +               .bank_num       = id,                                   \
> +               .nr_pins        = pins,                                 \
> +               .name           = label,                                \
> +               .iomux          = {                                     \
> +                       { .offset = -1 },                               \
> +                       { .offset = -1 },                               \
> +                       { .offset = -1 },                               \
> +                       { .offset = -1 },                               \
> +               },                                                      \
> +               .drv            = {                                     \
> +                       { .drv_type = drv0, .offset = -1 },             \
> +                       { .drv_type = drv1, .offset = -1 },             \
> +                       { .drv_type = drv2, .offset = -1 },             \
> +                       { .drv_type = drv3, .offset = -1 },             \
> +               },                                                      \
> +               .pull_type[0] = pull0,                                  \
> +               .pull_type[1] = pull1,                                  \
> +               .pull_type[2] = pull2,                                  \
> +               .pull_type[3] = pull3,                                  \
> +       }
> +
>  #define PIN_BANK_IOMUX_DRV_FLAGS_OFFSET(id, pins, label, iom0, iom1,   \
>                                         iom2, iom3, drv0, drv1, drv2,   \
>                                         drv3, offset0, offset1,         \
> @@ -220,6 +256,34 @@ struct rockchip_pin_bank {
>                 },                                                      \
>         }
>
> +#define PIN_BANK_IOMUX_FLAGS_DRV_FLAGS_OFFSET_PULL_FLAGS(id, pins,     \
> +                                             label, iom0, iom1, iom2,  \
> +                                             iom3, drv0, drv1, drv2,   \
> +                                             drv3, offset0, offset1,   \
> +                                             offset2, offset3, pull0,  \
> +                                             pull1, pull2, pull3)      \
> +       {                                                               \
> +               .bank_num       = id,                                   \
> +               .nr_pins        = pins,                                 \
> +               .name           = label,                                \
> +               .iomux          = {                                     \
> +                       { .type = iom0, .offset = -1 },                 \
> +                       { .type = iom1, .offset = -1 },                 \
> +                       { .type = iom2, .offset = -1 },                 \
> +                       { .type = iom3, .offset = -1 },                 \
> +               },                                                      \
> +               .drv            = {                                     \
> +                       { .drv_type = drv0, .offset = offset0 },        \
> +                       { .drv_type = drv1, .offset = offset1 },        \
> +                       { .drv_type = drv2, .offset = offset2 },        \
> +                       { .drv_type = drv3, .offset = offset3 },        \
> +               },                                                      \
> +               .pull_type[0] = pull0,                                  \
> +               .pull_type[1] = pull1,                                  \
> +               .pull_type[2] = pull2,                                  \
> +               .pull_type[3] = pull3,                                  \
> +       }
> +
>  /**
>   */
>  struct rockchip_pin_ctrl {
> @@ -1020,12 +1084,27 @@ static int rockchip_set_drive_perpin(struct rockchip_pin_bank *bank,
>         return ret;
>  }
>
> +static int rockchip_pull_list[PULL_TYPE_MAX][4] = {
> +       {
> +               PIN_CONFIG_BIAS_DISABLE,
> +               PIN_CONFIG_BIAS_PULL_UP,
> +               PIN_CONFIG_BIAS_PULL_DOWN,
> +               PIN_CONFIG_BIAS_BUS_HOLD
> +       },
> +       {
> +               PIN_CONFIG_BIAS_DISABLE,
> +               PIN_CONFIG_BIAS_PULL_DOWN,
> +               PIN_CONFIG_BIAS_DISABLE,
> +               PIN_CONFIG_BIAS_PULL_UP
> +       },
> +};
> +
>  static int rockchip_get_pull(struct rockchip_pin_bank *bank, int pin_num)
>  {
>         struct rockchip_pinctrl *info = bank->drvdata;
>         struct rockchip_pin_ctrl *ctrl = info->ctrl;
>         struct regmap *regmap;
> -       int reg, ret;
> +       int reg, ret, pull_type;
>         u8 bit;
>         u32 data;
>
> @@ -1048,22 +1127,11 @@ static int rockchip_get_pull(struct rockchip_pin_bank *bank, int pin_num)
>         case RK3288:
>         case RK3368:
>         case RK3399:
> +               pull_type = bank->pull_type[pin_num / 8];
>                 data >>= bit;
>                 data &= (1 << RK3188_PULL_BITS_PER_PIN) - 1;
>
> -               switch (data) {
> -               case 0:
> -                       return PIN_CONFIG_BIAS_DISABLE;
> -               case 1:
> -                       return PIN_CONFIG_BIAS_PULL_UP;
> -               case 2:
> -                       return PIN_CONFIG_BIAS_PULL_DOWN;
> -               case 3:
> -                       return PIN_CONFIG_BIAS_BUS_HOLD;
> -               }
> -
> -               dev_err(info->dev, "unknown pull setting\n");
> -               return -EIO;
> +               return rockchip_pull_list[pull_type][data];
>         default:
>                 dev_err(info->dev, "unsupported pinctrl type\n");
>                 return -EINVAL;
> @@ -1076,7 +1144,7 @@ static int rockchip_set_pull(struct rockchip_pin_bank *bank,
>         struct rockchip_pinctrl *info = bank->drvdata;
>         struct rockchip_pin_ctrl *ctrl = info->ctrl;
>         struct regmap *regmap;
> -       int reg, ret;
> +       int reg, ret, i, pull_type;
>         unsigned long flags;
>         u8 bit;
>         u32 data, rmask;
> @@ -1105,30 +1173,27 @@ static int rockchip_set_pull(struct rockchip_pin_bank *bank,
>         case RK3288:
>         case RK3368:
>         case RK3399:
> +               pull_type = bank->pull_type[pin_num / 8];
> +               ret = -EINVAL;
> +               for (i = 0; i < ARRAY_SIZE(rockchip_pull_list[pull_type]);
> +                       i++) {
> +                       if (rockchip_pull_list[pull_type][i] == pull) {
> +                               ret = i;
> +                               break;
> +                       }
> +               }
> +
> +               if (ret < 0) {
> +                       dev_err(info->dev, "unknown pull setting %d\n", pull);

nit: why change the error message?  Old message was "unsupported"
instead of your new "unknown".  "unsupported" was better IMHO.



> +                       return ret;
> +               }
> +
>                 spin_lock_irqsave(&bank->slock, flags);
>
>                 /* enable the write to the equivalent lower bits */
>                 data = ((1 << RK3188_PULL_BITS_PER_PIN) - 1) << (bit + 16);
>                 rmask = data | (data >> 16);
> -
> -               switch (pull) {
> -               case PIN_CONFIG_BIAS_DISABLE:
> -                       break;
> -               case PIN_CONFIG_BIAS_PULL_UP:
> -                       data |= (1 << bit);
> -                       break;
> -               case PIN_CONFIG_BIAS_PULL_DOWN:
> -                       data |= (2 << bit);
> -                       break;
> -               case PIN_CONFIG_BIAS_BUS_HOLD:
> -                       data |= (3 << bit);
> -                       break;
> -               default:
> -                       spin_unlock_irqrestore(&bank->slock, flags);
> -                       dev_err(info->dev, "unsupported pull setting %d\n",
> -                               pull);
> -                       return -EINVAL;
> -               }
> +               data |= (ret << bit);
>
>                 ret = regmap_update_bits(regmap, reg, rmask, data);
>
> @@ -2552,19 +2617,24 @@ static struct rockchip_pin_ctrl rk3368_pin_ctrl = {
>  };
>
>  static struct rockchip_pin_bank rk3399_pin_banks[] = {
> -       PIN_BANK_IOMUX_DRV_FLAGS_OFFSET(0, 32, "gpio0", IOMUX_SOURCE_PMU,
> -                                       IOMUX_SOURCE_PMU,
> -                                       IOMUX_SOURCE_PMU,
> -                                       IOMUX_SOURCE_PMU,
> -                                       DRV_TYPE_IO_1V8_ONLY,
> -                                       DRV_TYPE_IO_1V8_ONLY,
> -                                       DRV_TYPE_IO_DEFAULT,
> -                                       DRV_TYPE_IO_DEFAULT,
> -                                       0x0,
> -                                       0x8,
> -                                       -1,
> -                                       -1
> -                                       ),
> +       PIN_BANK_IOMUX_FLAGS_DRV_FLAGS_OFFSET_PULL_FLAGS(0, 32, "gpio0",
> +                                                        IOMUX_SOURCE_PMU,
> +                                                        IOMUX_SOURCE_PMU,
> +                                                        IOMUX_SOURCE_PMU,
> +                                                        IOMUX_SOURCE_PMU,
> +                                                        DRV_TYPE_IO_1V8_ONLY,
> +                                                        DRV_TYPE_IO_1V8_ONLY,
> +                                                        DRV_TYPE_IO_DEFAULT,
> +                                                        DRV_TYPE_IO_DEFAULT,
> +                                                        0x0,
> +                                                        0x8,
> +                                                        -1,
> +                                                        -1,
> +                                                        PULL_TYPE_IO_1V8_ONLY,
> +                                                        PULL_TYPE_IO_1V8_ONLY,
> +                                                        PULL_TYPE_IO_DEFAULT,
> +                                                        PULL_TYPE_IO_DEFAULT
> +                                                       ),
>         PIN_BANK_IOMUX_DRV_FLAGS_OFFSET(1, 32, "gpio1", IOMUX_SOURCE_PMU,
>                                         IOMUX_SOURCE_PMU,
>                                         IOMUX_SOURCE_PMU,
> @@ -2578,11 +2648,15 @@ static struct rockchip_pin_bank rk3399_pin_banks[] = {
>                                         0x30,
>                                         0x38
>                                         ),
> -       PIN_BANK_DRV_FLAGS(2, 32, "gpio2", DRV_TYPE_IO_1V8_OR_3V0,
> -                          DRV_TYPE_IO_1V8_OR_3V0,
> -                          DRV_TYPE_IO_1V8_ONLY,
> -                          DRV_TYPE_IO_1V8_ONLY
> -                          ),
> +       PIN_BANK_DRV_FLAGS_PULL_FLAGS(2, 32, "gpio2", DRV_TYPE_IO_1V8_OR_3V0,
> +                                     DRV_TYPE_IO_1V8_OR_3V0,
> +                                     DRV_TYPE_IO_1V8_ONLY,
> +                                     DRV_TYPE_IO_1V8_ONLY,
> +                                     PULL_TYPE_IO_DEFAULT,
> +                                     PULL_TYPE_IO_DEFAULT,
> +                                     PULL_TYPE_IO_1V8_ONLY,
> +                                     PULL_TYPE_IO_1V8_ONLY

Are you certain that gpio2 behaves the same way?  The TRM I have says
this for GPIO2C and GPIO2D:

2'b00: pervious-state
2'b01: weak 0(pull-down);
2'b10: pervious-state
2'b11: weak 1(pull-up);

Assuming that "pervious-state" is a simple typo for "previous state"
that would imply that it was behaving as "bus hold" and _not_ "bias
disable".

Note: if it actually is a "bus hold" state then we'll have to figure
out how this would work with existing device trees.  I'd imagine that
they are currently specifying "bias disable" and technically that
might not be possible?



-Doug
