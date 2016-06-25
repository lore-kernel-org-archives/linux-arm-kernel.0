From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Sat, 25 Jun 2016 23:20:46 +0530
Subject: [RFC PATCH v2 1/9] mailbox: Add Amlogic Meson
 Message-Handling-Unit
In-Reply-To: <576C045A.3070701@baylibre.com>
References: <1466503374-28841-1-git-send-email-narmstrong@baylibre.com>
 <1466503374-28841-2-git-send-email-narmstrong@baylibre.com>
 <CABb+yY3r3_B9wbW6D-do8h8xMKCANQWfz1gFGyre1oWadd7A8Q@mail.gmail.com>
 <576C045A.3070701@baylibre.com>
Message-ID: <CABb+yY0Oa7TNHsnt1HRAz1NUQ1QA_gR0-B-ki6qkuT332CnrmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-#define INTR_STAT_OFS  0x0
-#define INTR_SET_OFS   0x8
-#define INTR_CLR_OFS   0x10
-
-#define MHU_LP_OFFSET  0x0
-#define MHU_HP_OFFSET  0x20
-#define MHU_SEC_OFFSET 0x200
-#define TX_REG_OFFSET  0x100
+#define INTR_SET_OFS   0x0
+#define INTR_STAT_OFS  0x4
+#define INTR_CLR_OFS   0x8

-#define MHU_CHANS      3
+#define MHU_LP_OFFSET  0x10
+#define MHU_HP_OFFSET  0x1c
+
+#define TX_REG_OFFSET  0x24
+
+#define MHU_CHANS      2

^^^^^^^^ this is precisely the difference if we ignore cosmetic
differences. So the IP is essentially the same.

[snip]

> -------------------------------------------------------------------------------------------
> From: Neil Armstrong <narmstrong@baylibre.com>
> Subject: [PATCH] mailbox: arm_mhu: Add support for Amlogic Meson MHU
>
Is there some version of MHU specified anywhere in manuals? It seems
weird Amlogic took the IP and only rearranged the registers. Maybe the
order is specific to non-Amba version of the IP?  Lets call it that.


> To achieve this integration, add support for generic probe from amba
> or platform.
> Move all register offsets to a data structure passed in either amba id or
> platform dt id match table.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/mailbox/arm_mhu.c | 217 ++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 181 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/mailbox/arm_mhu.c b/drivers/mailbox/arm_mhu.c
> index 99befa7..d7fb843 100644
> --- a/drivers/mailbox/arm_mhu.c
> +++ b/drivers/mailbox/arm_mhu.c
> @@ -22,45 +22,68 @@
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/amba/bus.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
>  #include <linux/mailbox_controller.h>
>
> -#define INTR_STAT_OFS  0x0
> -#define INTR_SET_OFS   0x8
> -#define INTR_CLR_OFS   0x10
> +#define MHU_INTR_STAT_OFS      0x0
> +#define MHU_INTR_SET_OFS       0x8
> +#define MHU_INTR_CLR_OFS       0x10
>
>  #define MHU_LP_OFFSET  0x0
>  #define MHU_HP_OFFSET  0x20
>  #define MHU_SEC_OFFSET 0x200
> -#define TX_REG_OFFSET  0x100
> +#define MHU_TX_REG_OFFSET      0x100
>
> -#define MHU_CHANS      3
> +#define MESON_INTR_SET_OFS     0x0
> +#define MESON_INTR_STAT_OFS    0x4
> +#define MESON_INTR_CLR_OFS     0x8
> +
> +#define MESON_MHU_LP_OFFSET    0x10
> +#define MESON_MHU_HP_OFFSET    0x1c
> +#define MESON_MHU_TX_OFFSET    0x24
> +
> +#define MAX_MHU_CHANS  3
>
MHU_CHANS always 3 doesn't hurt. Lets keep it unchanged.

>  struct mhu_link {
>         unsigned irq;
> -       void __iomem *tx_reg;
> -       void __iomem *rx_reg;
> +       void __iomem *tx_stat_reg;
> +       void __iomem *tx_set_reg;
> +       void __iomem *tx_clr_reg;
> +       void __iomem *rx_stat_reg;
> +       void __iomem *rx_set_reg;
> +       void __iomem *rx_clr_reg;
>  };

Yeah, this is OK.


>
>  struct arm_mhu {
>         void __iomem *base;
> -       struct mhu_link mlink[MHU_CHANS];
> -       struct mbox_chan chan[MHU_CHANS];
> +       struct mhu_link mlink[MAX_MHU_CHANS];
> +       struct mbox_chan chan[MAX_MHU_CHANS];
>         struct mbox_controller mbox;
>  };
just leave it MHU_CHANS

>
> +struct arm_mhu_data {
> +       unsigned int channels;
> +       int rx_offsets[MAX_MHU_CHANS];
> +       int tx_offsets[MAX_MHU_CHANS];
> +       unsigned int intr_stat_offs;
> +       unsigned int intr_set_offs;
> +       unsigned int intr_clr_offs;
> +};
This is unnecessary. Please remove it and code will be simpler -
assign rx/tx_regs directly in probe.


> +
>  static irqreturn_t mhu_rx_interrupt(int irq, void *p)
>  {
>         struct mbox_chan *chan = p;
>         struct mhu_link *mlink = chan->con_priv;
>         u32 val;
>
> -       val = readl_relaxed(mlink->rx_reg + INTR_STAT_OFS);
> +       val = readl_relaxed(mlink->rx_stat_reg);
>         if (!val)
>                 return IRQ_NONE;
>
>         mbox_chan_received_data(chan, (void *)&val);
>
> -       writel_relaxed(val, mlink->rx_reg + INTR_CLR_OFS);
> +       writel_relaxed(val, mlink->rx_clr_reg);
>
>         return IRQ_HANDLED;
>  }
> @@ -68,7 +91,7 @@ static irqreturn_t mhu_rx_interrupt(int irq, void *p)
>  static bool mhu_last_tx_done(struct mbox_chan *chan)
>  {
>         struct mhu_link *mlink = chan->con_priv;
> -       u32 val = readl_relaxed(mlink->tx_reg + INTR_STAT_OFS);
> +       u32 val = readl_relaxed(mlink->tx_stat_reg);
>
>         return (val == 0);
>  }
> @@ -78,7 +101,7 @@ static int mhu_send_data(struct mbox_chan *chan, void *data)
>         struct mhu_link *mlink = chan->con_priv;
>         u32 *arg = data;
>
> -       writel_relaxed(*arg, mlink->tx_reg + INTR_SET_OFS);
> +       writel_relaxed(*arg, mlink->tx_set_reg);
>
>         return 0;
>  }
> @@ -89,8 +112,8 @@ static int mhu_startup(struct mbox_chan *chan)
>         u32 val;
>         int ret;
>
> -       val = readl_relaxed(mlink->tx_reg + INTR_STAT_OFS);
> -       writel_relaxed(val, mlink->tx_reg + INTR_CLR_OFS);
> +       val = readl_relaxed(mlink->tx_stat_reg);
> +       writel_relaxed(val, mlink->tx_clr_reg);
>
>         ret = request_irq(mlink->irq, mhu_rx_interrupt,
>                           IRQF_SHARED, "mhu_link", chan);
> @@ -117,52 +140,155 @@ static const struct mbox_chan_ops mhu_ops = {
>         .last_tx_done = mhu_last_tx_done,
>  };
>
> -static int mhu_probe(struct amba_device *adev, const struct amba_id *id)
> +static struct arm_mhu_data arm_mhu_amba_data = {
> +       .channels = 3,
> +       .rx_offsets = {MHU_LP_OFFSET, MHU_HP_OFFSET, MHU_SEC_OFFSET},
> +       .tx_offsets = {MHU_LP_OFFSET + MHU_TX_REG_OFFSET,
> +                      MHU_HP_OFFSET + MHU_TX_REG_OFFSET,
> +                      MHU_SEC_OFFSET + MHU_TX_REG_OFFSET},
> +       .intr_stat_offs = MHU_INTR_STAT_OFS,
> +       .intr_set_offs = MHU_INTR_SET_OFS,
> +       .intr_clr_offs = MHU_INTR_CLR_OFS,
> +};
> +
> +static const struct arm_mhu_data meson_mhu_data = {
> +       .channels = 2,
> +       .rx_offsets = {MESON_MHU_LP_OFFSET, MESON_MHU_HP_OFFSET},
> +       .tx_offsets = {MESON_MHU_LP_OFFSET + MESON_MHU_TX_OFFSET,
> +                      MESON_MHU_HP_OFFSET + MESON_MHU_TX_OFFSET},
> +       .intr_stat_offs = MESON_INTR_STAT_OFS,
> +       .intr_set_offs = MESON_INTR_SET_OFS,
> +       .intr_clr_offs = MESON_INTR_CLR_OFS,
> +};
> +
These could be directly set in amba vs platform probes ?

Thanks.
