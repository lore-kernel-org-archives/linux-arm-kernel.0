From: djkurtz@chromium.org (Daniel Kurtz)
Date: Fri, 22 Jan 2016 11:36:41 -0800
Subject: [PATCH] i2c: mt8173: add 4GB mode support in i2c driver.
In-Reply-To: <1453455482-3218-1-git-send-email-liguo.zhang@mediatek.com>
References: <1453455482-3218-1-git-send-email-liguo.zhang@mediatek.com>
Message-ID: <CAGS+omAwHd2icDYW5444QS7XRX5aR_2K=+jQRgxkLuz133tgdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Liguo,

Thanks for the patch.

On Fri, Jan 22, 2016 at 1:38 AM, Liguo Zhang <liguo.zhang@mediatek.com> wrote:
> If 4GB mode is enable, we should add 4gb mode support in i2c driver.
> Set 4GB mode register to support 4GB mode.
>
> Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>
> ---
>  drivers/i2c/busses/i2c-mt65xx.c |   41 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
> index aec8e6c..80d3c79 100644
> --- a/drivers/i2c/busses/i2c-mt65xx.c
> +++ b/drivers/i2c/busses/i2c-mt65xx.c
> @@ -60,6 +60,7 @@
>  #define I2C_DMA_INT_FLAG_NONE          0x0000
>  #define I2C_DMA_CLR_FLAG               0x0000
>  #define I2C_DMA_HARD_RST               0x0002
> +#define I2C_DMA_4G_MODE                        0x0001
>
>  #define I2C_DEFAULT_SPEED              100000  /* hz */
>  #define MAX_FS_MODE_SPEED              400000
> @@ -88,6 +89,8 @@ enum DMA_REGS_OFFSET {
>         OFFSET_RX_MEM_ADDR = 0x20,
>         OFFSET_TX_LEN = 0x24,
>         OFFSET_RX_LEN = 0x28,
> +       OFFSET_TX_4G_MODE = 0x54,
> +       OFFSET_RX_4G_MODE = 0x58,
>  };
>
>  enum i2c_trans_st_rs {
> @@ -133,6 +136,7 @@ struct mtk_i2c_compatible {
>         unsigned char dcm: 1;
>         unsigned char auto_restart: 1;
>         unsigned char aux_len_reg: 1;
> +       unsigned char support_33bits: 1;
>  };
>
>  struct mtk_i2c {
> @@ -182,6 +186,7 @@ static const struct mtk_i2c_compatible mt6577_compat = {
>         .dcm = 1,
>         .auto_restart = 0,
>         .aux_len_reg = 0,
> +       .support_33bits = 0,
>  };
>
>  static const struct mtk_i2c_compatible mt6589_compat = {
> @@ -190,6 +195,7 @@ static const struct mtk_i2c_compatible mt6589_compat = {
>         .dcm = 0,
>         .auto_restart = 0,
>         .aux_len_reg = 0,
> +       .support_33bits = 0,
>  };
>
>  static const struct mtk_i2c_compatible mt8173_compat = {
> @@ -198,6 +204,7 @@ static const struct mtk_i2c_compatible mt8173_compat = {
>         .dcm = 1,
>         .auto_restart = 1,
>         .aux_len_reg = 1,
> +       .support_33bits = 1,
>  };
>
>  static const struct of_device_id mtk_i2c_of_match[] = {
> @@ -373,6 +380,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
>         u16 start_reg;
>         u16 control_reg;
>         u16 restart_flag = 0;
> +       u32 reg_4g_mode = 0;
>         dma_addr_t rpaddr = 0;
>         dma_addr_t wpaddr = 0;
>         int ret;
> @@ -439,6 +447,13 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
>                                         msgs->len, DMA_FROM_DEVICE);
>                 if (dma_mapping_error(i2c->dev, rpaddr))
>                         return -ENOMEM;
> +
> +               if (i2c->dev_comp->support_33bits) {
> +                       reg_4g_mode = (rpaddr & 0x100000000ULL) ?
> +                                      I2C_DMA_4G_MODE : I2C_DMA_CLR_FLAG;

We do this same check in four places.
Please write it as a static inline helper function, instead.

-Dan
