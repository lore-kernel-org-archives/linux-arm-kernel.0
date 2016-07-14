From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Thu, 14 Jul 2016 19:38:25 -0400
Subject: [PATCH v10 2/4] CMDQ: Mediatek CMDQ driver
In-Reply-To: <1468495733-12178-3-git-send-email-hs.liao@mediatek.com>
References: <1468495733-12178-1-git-send-email-hs.liao@mediatek.com>
 <1468495733-12178-3-git-send-email-hs.liao@mediatek.com>
Message-ID: <CAP=VYLqPhZLYFmsWE45kRdfbjUTzMT+eGNVZnGjK8VD7+fQgBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 14, 2016 at 7:28 AM, HS Liao <hs.liao@mediatek.com> wrote:
> This patch is first version of Mediatek Command Queue(CMDQ) driver. The
> CMDQ is used to help write registers with critical time limitation,
> such as updating display configuration during the vblank. It controls
> Global Command Engine (GCE) hardware to achieve this requirement.
> Currently, CMDQ only supports display related hardwares, but we expect
> it can be extended to other hardwares for future requirements.
>
> Signed-off-by: HS Liao <hs.liao@mediatek.com>
> Signed-off-by: CK Hu <ck.hu@mediatek.com>
> ---
>  drivers/soc/mediatek/Kconfig    |  11 +
>  drivers/soc/mediatek/Makefile   |   1 +
>  drivers/soc/mediatek/mtk-cmdq.c | 948 ++++++++++++++++++++++++++++++++++++++++
>  include/soc/mediatek/cmdq.h     | 179 ++++++++
>  4 files changed, 1139 insertions(+)
>  create mode 100644 drivers/soc/mediatek/mtk-cmdq.c
>  create mode 100644 include/soc/mediatek/cmdq.h
>
> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> index 0a4ea80..50869e4 100644
> --- a/drivers/soc/mediatek/Kconfig
> +++ b/drivers/soc/mediatek/Kconfig
> @@ -1,6 +1,17 @@
>  #
>  # MediaTek SoC drivers
>  #
> +config MTK_CMDQ
> +       bool "MediaTek CMDQ Support"
> +       depends on ARM64 && ( ARCH_MEDIATEK || COMPILE_TEST )
> +       select MAILBOX
> +       select MTK_INFRACFG
> +       help
> +         Say yes here to add support for the MediaTek Command Queue (CMDQ)
> +         driver. The CMDQ is used to help read/write registers with critical
> +         time limitation, such as updating display configuration during the
> +         vblank.
> +
>  config MTK_INFRACFG
>         bool "MediaTek INFRACFG Support"
>         depends on ARCH_MEDIATEK || COMPILE_TEST
> diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> index 12998b0..f7397ef 100644
> --- a/drivers/soc/mediatek/Makefile
> +++ b/drivers/soc/mediatek/Makefile
> @@ -1,3 +1,4 @@
> +obj-$(CONFIG_MTK_CMDQ) += mtk-cmdq.o
>  obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
>  obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
>  obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
> diff --git a/drivers/soc/mediatek/mtk-cmdq.c b/drivers/soc/mediatek/mtk-cmdq.c
> new file mode 100644
> index 0000000..d032603
> --- /dev/null
> +++ b/drivers/soc/mediatek/mtk-cmdq.c
> @@ -0,0 +1,948 @@
> +/*
> + * Copyright (c) 2015 MediaTek Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/completion.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/errno.h>
> +#include <linux/interrupt.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/kthread.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/mailbox_controller.h>
> +#include <linux/module.h>

Please don't use module.h and MODULE_* stuff in a driver that has
a bool Kconfig.  Either make it tristate if that has a sensible use case
or get rid of the modular stuff.

Thanks,
Paul.
--

> +#include <linux/mutex.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/suspend.h>
> +#include <linux/timer.h>
> +#include <soc/mediatek/cmdq.h>
> +
> +#define CMDQ_THR_MAX_COUNT             3 /* main, sub, general(misc) */
> +#define CMDQ_INST_SIZE                 8 /* instruction is 64-bit */
> +#define CMDQ_TIMEOUT_MS                        1000
> +#define CMDQ_IRQ_MASK                  0xffff
> +#define CMDQ_NUM_CMD(t)                        (t->cmd_buf_size / CMDQ_INST_SIZE)
> +
> +#define CMDQ_CURR_IRQ_STATUS           0x10
> +#define CMDQ_THR_SLOT_CYCLES           0x30
> +
> +#define CMDQ_THR_BASE                  0x100
> +#define CMDQ_THR_SIZE                  0x80
