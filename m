From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 6 Oct 2015 17:05:58 +0530
Subject: [PATCH 2/3] mailbox: rockchip: Add Rockchip mailbox driver
In-Reply-To: <1442228798-15191-3-git-send-email-wxt@rock-chips.com>
References: <1442228798-15191-1-git-send-email-wxt@rock-chips.com>
 <1442228798-15191-3-git-send-email-wxt@rock-chips.com>
Message-ID: <CABb+yY3K+fZH5cBK3YvD6r_amZHq2d5xaaDR5_xuiNxWXTFPvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 14, 2015 at 4:36 PM, Caesar Wang <wxt@rock-chips.com> wrote:
> This driver is found on RK3368 SoCs.
>
> The Mailbox module is a simple APB peripheral that allows both
> the Cortex-A53 MCU system to communicate by writing operation to
> generate interrupt.
> The registers are accessible by both CPU via APB interface.
>
> The Mailbox has the following main features:
>
> @ Support dual-core system: Cortex-A53 and MCU.
> @ Support APB interface.
> @ Support four mailbox elements, each element includes one data word, one
>   command word register and one flag bit that can represent one interrupt.
> @ Four interrupts to Cortex-A53.
> @ Four interrupts to MCU.
> @ Provide 32 lock registers for software to use to indicate whether mailbox
>   is occupied.
>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> ---
>
>  drivers/mailbox/Kconfig            |   9 ++
>  drivers/mailbox/Makefile           |   2 +
>  drivers/mailbox/rockchip-mailbox.c | 317 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 328 insertions(+)
>  create mode 100644 drivers/mailbox/rockchip-mailbox.c
>
> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index bbec500..a548d700 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -43,6 +43,15 @@ config OMAP_MBOX_KFIFO_SIZE
>           This can also be changed at runtime (via the mbox_kfifo_size
>           module parameter).
>
> +config ROCKCHIP_MBOX
> +       bool "Rockchip Soc Intergrated Mailbox Support"
> +       depends on ARCH_ROCKCHIP
> +       help
> +         This driver provides support for inter-processor communication
> +         between CPU cores and MCU processor on Some Rockchip SOCs.
> +         Please check it that the Soc you use have Mailbox hardware.
> +         Say Y here if you want to use the Rockchip Mailbox support.
> +
>  config PCC
>         bool "Platform Communication Channel Driver"
>         depends on ACPI
> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
> index 8e6d822..730cb5d 100644
> --- a/drivers/mailbox/Makefile
> +++ b/drivers/mailbox/Makefile
> @@ -8,6 +8,8 @@ obj-$(CONFIG_PL320_MBOX)        += pl320-ipc.o
>
>  obj-$(CONFIG_OMAP2PLUS_MBOX)   += omap-mailbox.o
>
> +obj-$(CONFIG_ROCKCHIP_MBOX)    += rockchip-mailbox.o
> +
>  obj-$(CONFIG_PCC)              += pcc.o
>
>  obj-$(CONFIG_ALTERA_MBOX)      += mailbox-altera.o
> diff --git a/drivers/mailbox/rockchip-mailbox.c b/drivers/mailbox/rockchip-mailbox.c
> new file mode 100644
> index 0000000..715ab96
> --- /dev/null
> +++ b/drivers/mailbox/rockchip-mailbox.c
> @@ -0,0 +1,317 @@
> +/*
> + * Copyright (c) 2015, Fuzhou Rockchip Electronics Co., Ltd
> + *
> + * Authors:    Addy Ke <addy.ke@rock-chips.com>
> + *             Caesar Wang <wxt@rock-chips.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/mailbox_controller.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +
> +#define MAILBOX_A2B_INTEN              0x00
> +#define MAILBOX_A2B_STATUS             0x04
> +#define MAILBOX_A2B_CMD(x)             (0x08 + (x) * 8)
> +#define MAILBOX_A2B_DAT(x)             (0x0c + (x) * 8)
> +
> +#define MAILBOX_B2A_INTEN              0x28
> +#define MAILBOX_B2A_STATUS             0x2C
> +#define MAILBOX_B2A_CMD(x)             (0x30 + (x) * 8)
> +#define MAILBOX_B2A_DAT(x)             (0x34 + (x) * 8)
> +
> +#define MAILBOX_ATOMIC_LOCK(x)         (0x100 + (x) * 8)
> +
> +/* A2B: 0 - 2k */
> +#define A2B_BUF(size, idx)             ((idx) * (size))
> +
> +/* B2A: 2k - 4k */
> +#define B2A_BUF(size, idx)             (((idx) + 4) * (size))
> +
> +struct rockchip_mbox_msg {
> +       u32 cmd;
> +       int tx_size;
> +       void *tx_buf;
> +       int rx_size;
> +       void *rx_buf;
> +       void *cl_data;
> +};
> +
> +struct rockchip_mbox_data {
> +       int num_chans;
> +};
> +
> +struct rockchip_mbox_chan {
> +       int idx;
> +       int irq;
> +       struct rockchip_mbox_msg *msg;
> +       struct rockchip_mbox *mb;
> +};
> +
> +struct rockchip_mbox {
> +       struct mbox_controller mbox;
> +       struct clk *pclk;
> +       void __iomem *mbox_base;
> +
> +       /* The base address of share memory to transfer data */
> +       void __iomem *buf_base;
> +
> +       /* The maximum size of buf for each channel */
> +       u32 buf_size;
> +
> +       struct rockchip_mbox_chan *chans;
> +};
> +
> +static inline int chan_to_idx(struct rockchip_mbox *mb,
> +                             struct mbox_chan *chan)
> +{
> +       return (chan - mb->mbox.chans);
> +}
perhaps you intended rockchip_mbox_chan.idx for this purpose?


> +static int rockchip_mbox_send_data(struct mbox_chan *chan, void *data)
> +{
> +       struct rockchip_mbox *mb = dev_get_drvdata(chan->mbox->dev);
> +       struct rockchip_mbox_msg *msg = data;
> +       int idx = chan_to_idx(mb, chan);
> +
> +       if (!msg)
> +               return -EINVAL;
> +
> +       if ((msg->tx_size > mb->buf_size) ||
> +           (msg->rx_size > mb->buf_size)) {
> +               dev_err(mb->mbox.dev, "Transmit size over buf size(%d)\n",
> +                       mb->buf_size);
> +               return -EINVAL;
> +       }
> +
> +       dev_dbg(mb->mbox.dev, "Chan[%d]: A2B message, cmd 0x%08x\n",
> +               idx, msg->cmd);
> +
> +       mb->chans[idx].msg = msg;
> +
> +       if (msg->tx_buf)
> +               memcpy(mb->buf_base + A2B_BUF(mb->buf_size, idx),
> +                      msg->tx_buf, msg->tx_size);
> +
as I said on the bindings patch, this should be done by client driver
in tx_prepare() callback.

> +       writel_relaxed(msg->cmd, mb->mbox_base + MAILBOX_A2B_CMD(idx));
> +       writel_relaxed(msg->rx_size, mb->mbox_base + MAILBOX_A2B_DAT(idx));
> +
Usually length of payload is not specified via mailbox registers but
we have to live with what your protocol does... so maybe keep rx_size
in rockchip_mbox_msg but remove  tx_size, tx_buf, void *rx_buf, and
cl_data


> +       return 0;
> +}
> +
> +static int rockchip_mbox_startup(struct mbox_chan *chan)
> +{
> +       return 0;
> +}
maybe request the channel irq in startup and release in shutdown ?
