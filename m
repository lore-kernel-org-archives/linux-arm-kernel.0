From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Sat, 2 Sep 2017 13:07:50 +0530
Subject: [PATCH 1/3] driver: mailbox: add support for Hi3660
In-Reply-To: <1502097434-11136-1-git-send-email-zhongkaihua@huawei.com>
References: <1502097434-11136-1-git-send-email-zhongkaihua@huawei.com>
Message-ID: <CABb+yY1gbA8tXz4u_7s6=jo7s0HTEWcisXxKe_yhdZR2tPPEUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 7, 2017 at 2:47 PM, Zhong Kaihua <zhongkaihua@huawei.com> wrote:
> From: Kaihua Zhong <zhongkaihua@huawei.com>
>
> Add mailbox driver for Hi3660.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Ruyi Wang <wangruyi@huawei.com>
> Tested-by: Kaihua Zhong <zhongkaihua@huawei.com>
>
> ---
>  drivers/mailbox/Kconfig          |   6 +
>  drivers/mailbox/Makefile         |   2 +
>  drivers/mailbox/hi3660-mailbox.c | 688 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 696 insertions(+)
>  create mode 100644 drivers/mailbox/hi3660-mailbox.c
>
> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index ee1a3d9..778ba85 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -116,6 +116,12 @@ config HI6220_MBOX
>           between application processors and MCU. Say Y here if you want to
>           build Hi6220 mailbox controller driver.
>
> +config HI3660_MBOX
> +       tristate "Hi3660 Mailbox"
> +       depends on ARCH_HISI
> +       help
> +         Mailbox implementation for Hi3660.
> +
>  config MAILBOX_TEST
>         tristate "Mailbox Test Client"
>         depends on OF
> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
> index e2bcb03..f1c2fc4 100644
> --- a/drivers/mailbox/Makefile
> +++ b/drivers/mailbox/Makefile
> @@ -28,6 +28,8 @@ obj-$(CONFIG_XGENE_SLIMPRO_MBOX) += mailbox-xgene-slimpro.o
>
>  obj-$(CONFIG_HI6220_MBOX)      += hi6220-mailbox.o
>
> +obj-$(CONFIG_HI3660_MBOX)      += hi3660-mailbox.o
> +
>  obj-$(CONFIG_BCM_PDC_MBOX)     += bcm-pdc-mailbox.o
>
>  obj-$(CONFIG_BCM_FLEXRM_MBOX)  += bcm-flexrm-mailbox.o
> diff --git a/drivers/mailbox/hi3660-mailbox.c b/drivers/mailbox/hi3660-mailbox.c
> new file mode 100644
> index 0000000..14f469d
> --- /dev/null
> +++ b/drivers/mailbox/hi3660-mailbox.c
> @@ -0,0 +1,688 @@
> +/*
> + * Hisilicon's Hi3660 mailbox driver
> + *
> + * Copyright (c) 2017 Hisilicon Limited.
> + * Copyright (c) 2017 Linaro Limited.
> + *
> + * Author: Leo Yan <leo.yan@linaro.org>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kfifo.h>
> +#include <linux/mailbox_controller.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +
> +#include "mailbox.h"
> +
> +#define MBOX_CHAN_MAX                  32
> +
> +#define MBOX_TX                                0x1
> +
> +/* Mailbox message length: 2 words */
> +#define MBOX_MSG_LEN                   2
> +
> +#define MBOX_OFF(m)                    (0x40 * (m))
> +#define MBOX_SRC_REG(m)                        MBOX_OFF(m)
> +#define MBOX_DST_REG(m)                        (MBOX_OFF(m) + 0x04)
> +#define MBOX_DCLR_REG(m)               (MBOX_OFF(m) + 0x08)
> +#define MBOX_DSTAT_REG(m)              (MBOX_OFF(m) + 0x0C)
> +#define MBOX_MODE_REG(m)               (MBOX_OFF(m) + 0x10)
> +#define MBOX_IMASK_REG(m)              (MBOX_OFF(m) + 0x14)
> +#define MBOX_ICLR_REG(m)               (MBOX_OFF(m) + 0x18)
> +#define MBOX_SEND_REG(m)               (MBOX_OFF(m) + 0x1C)
> +#define MBOX_DATA_REG(m, i)            (MBOX_OFF(m) + 0x20 + ((i) << 2))
> +
> +#define MBOX_CPU_IMASK(cpu)            (((cpu) << 3) + 0x800)
> +#define MBOX_CPU_IRST(cpu)             (((cpu) << 3) + 0x804)
> +#define MBOX_IPC_LOCK                  (0xA00)
> +
How is this controller different than the PL320?

Thanks.
