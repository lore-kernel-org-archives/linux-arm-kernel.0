From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 19 May 2015 16:45:07 +0200
Subject: [PATCH v8 3/3] I2C: mediatek: Add driver for MediaTek MT8173 I2C
 controller
In-Reply-To: <1431967209-5261-4-git-send-email-eddie.huang@mediatek.com>
References: <1431967209-5261-1-git-send-email-eddie.huang@mediatek.com>
 <1431967209-5261-4-git-send-email-eddie.huang@mediatek.com>
Message-ID: <CABuKBeKJ=V6bP9iU9xDN0JecTTFoLDUfsX_QP5rpPj1bn167Vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-18 18:40 GMT+02:00 Eddie Huang <eddie.huang@mediatek.com>:
> Add mediatek MT8173 I2C controller driver. Compare to I2C controller
> of earlier mediatek SoC, MT8173 fix write-then-read limitation, and
> also increase message size to 64kb.
>
> Signed-off-by: Xudong Chen <xudong.chen@mediatek.com>
> Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>
> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/i2c/busses/i2c-mt65xx.c | 94 +++++++++++++++++++++++++++++------------
>  1 file changed, 67 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
> index 7462f05..1ebbf1a 100644
> --- a/drivers/i2c/busses/i2c-mt65xx.c
> +++ b/drivers/i2c/busses/i2c-mt65xx.c
> @@ -33,10 +33,13 @@
>  #include <linux/sched.h>
>  #include <linux/slab.h>
>
> +#define I2C_RS_TRANSFER                        (1 << 4)

As far as I can see, mt6589 and mt8127 don't have this bit defined in
their datasheets (and most probably others neither).
Is it save to write this bit, although it is not implemented?

>  #define I2C_HS_NACKERR                 (1 << 2)
>  #define I2C_ACKERR                     (1 << 1)
>  #define I2C_TRANSAC_COMP               (1 << 0)
>  #define I2C_TRANSAC_START              (1 << 0)
> +#define I2C_RS_MUL_CNFG                        (1 << 15)
> +#define I2C_RS_MUL_TRIG                        (1 << 14)
>  #define I2C_TIMING_STEP_DIV_MASK       (0x3f << 0)
>  #define I2C_TIMING_SAMPLE_COUNT_MASK   (0x7 << 0)
>  #define I2C_TIMING_SAMPLE_DIV_MASK     (0x7 << 8)
> @@ -130,6 +133,7 @@ struct mtk_i2c_compatible {
>         const struct i2c_adapter_quirks *quirks;
>         unsigned char pmic_i2c: 1;
>         unsigned char dcm: 1;
> +       unsigned char auto_restart: 1;
>  };
>
>  struct mtk_i2c {
> @@ -163,21 +167,39 @@ static const struct i2c_adapter_quirks mt6577_i2c_quirks = {
>         .max_comb_2nd_msg_len = 31,
>  };
>
> +static const struct i2c_adapter_quirks mt8173_i2c_quirks = {
> +       .max_num_msgs = 65535,
> +       .max_write_len = 65535,
> +       .max_read_len = 65535,
> +       .max_comb_1st_msg_len = 65535,
> +       .max_comb_2nd_msg_len = 65535,
> +};
> +
>  static const struct mtk_i2c_compatible mt6577_compat = {
>         .quirks = &mt6577_i2c_quirks,
>         .pmic_i2c = 0,
>         .dcm = 1,
> +       .auto_restart = 0,
>  };
>
>  static const struct mtk_i2c_compatible mt6589_compat = {
>         .quirks = &mt6577_i2c_quirks,
>         .pmic_i2c = 1,
>         .dcm = 0,
> +       .auto_restart = 0,
> +};
> +
> +static const struct mtk_i2c_compatible mt8173_compat = {
> +       .quirks = &mt8173_i2c_quirks,
> +       .pmic_i2c = 0,
> +       .dcm = 1,
> +       .auto_restart = 1,
>  };
>
>  static const struct of_device_id mtk_i2c_of_match[] = {
>         { .compatible = "mediatek,mt6577-i2c", .data = &mt6577_compat },
>         { .compatible = "mediatek,mt6589-i2c", .data = &mt6589_compat },
> +       { .compatible = "mediatek,mt8173-i2c", .data = &mt8173_compat },
>         {}
>  };
>  MODULE_DEVICE_TABLE(of, mtk_i2c_of_match);
> @@ -323,6 +345,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
>                                int num, int left_num)
>  {
>         u16 addr_reg;
> +       u16 start_reg;
>         u16 control_reg;
>         dma_addr_t rpaddr = 0;
>         dma_addr_t wpaddr = 0;
> @@ -338,6 +361,8 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
>                 control_reg |= I2C_CONTROL_RS;
>         if (i2c->op == I2C_MASTER_WRRD)
>                 control_reg |= I2C_CONTROL_DIR_CHANGE | I2C_CONTROL_RS;
> +       if (left_num >= 1)
> +               control_reg |= I2C_CONTROL_RS;

I would prefer:
if ((i2c->speed_hz > 400000) || (left_num >= 1))
    control_reg |= I2C_CONTROL_RS;
if (i2c->op == I2C_MASTER_WRRD)
    control_reg |= I2C_CONTROL_DIR_CHANGE | I2C_CONTROL_RS;

>         writew(control_reg, i2c->base + OFFSET_CONTROL);
>
>         /* set start condition */
> @@ -352,13 +377,13 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
>         writew(addr_reg, i2c->base + OFFSET_SLAVE_ADDR);
>
>         /* Clear interrupt status */
> -       writew(I2C_HS_NACKERR | I2C_ACKERR | I2C_TRANSAC_COMP,
> -              i2c->base + OFFSET_INTR_STAT);
> +       writew(I2C_RS_TRANSFER | I2C_HS_NACKERR | I2C_ACKERR
> +               | I2C_TRANSAC_COMP, i2c->base + OFFSET_INTR_STAT);
>         writew(I2C_FIFO_ADDR_CLR, i2c->base + OFFSET_FIFO_ADDR_CLR);
>
>         /* Enable interrupt */
> -       writew(I2C_HS_NACKERR | I2C_ACKERR | I2C_TRANSAC_COMP,
> -              i2c->base + OFFSET_INTR_MASK);
> +       writew(I2C_RS_TRANSFER | I2C_HS_NACKERR | I2C_ACKERR
> +               | I2C_TRANSAC_COMP, i2c->base + OFFSET_INTR_MASK);
>
>         /* Set transfer and transaction len */
>         if (i2c->op == I2C_MASTER_WRRD) {
> @@ -367,7 +392,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
>                 writew(I2C_WRRD_TRANAC_VALUE, i2c->base + OFFSET_TRANSAC_LEN);
>         } else {
>                 writew(msgs->len, i2c->base + OFFSET_TRANSFER_LEN);
> -               writew(I2C_RD_TRANAC_VALUE, i2c->base + OFFSET_TRANSAC_LEN);
> +               writew(num, i2c->base + OFFSET_TRANSAC_LEN);
>         }
>
>         /* Prepare buffer data to start transfer */
> @@ -411,13 +436,23 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
>         }
>
>         writel(I2C_DMA_START_EN, i2c->pdmabase + OFFSET_EN);
> -       writew(I2C_TRANSAC_START, i2c->base + OFFSET_START);
> +
> +       if (!i2c->dev_comp->auto_restart) {
> +               start_reg = I2C_TRANSAC_START;
> +       } else {
> +               if (left_num >= 1)
> +                       start_reg = I2C_TRANSAC_START | I2C_RS_MUL_CNFG
> +                                       | I2C_RS_MUL_TRIG;
> +               else
> +                       start_reg = I2C_TRANSAC_START | I2C_RS_MUL_TRIG;

I would prefer:
start_reg = I2C_TRANSAC_START | I2C_RS_MUL_TRIG;
if (left_num >= 1)
       start_reg |= I2C_RS_MUL_TRIG;

For me both suggestions make the code more readable, but it is up to
you to change it.
I'm more concerned about the missing bit I mentioned beforehand.

Thanks,
Matthias
