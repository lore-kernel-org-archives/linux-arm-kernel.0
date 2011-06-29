From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 29 Jun 2011 12:06:58 +0200
Subject: [PATCH v7 1/3] MTD : add the common code for GPMI-NFC
	controller driver
In-Reply-To: <1309335878-16678-2-git-send-email-b32955@freescale.com>
References: <1309335878-16678-1-git-send-email-b32955@freescale.com>
	<1309335878-16678-2-git-send-email-b32955@freescale.com>
Message-ID: <20110629100658.GE1992@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Huang,

On Wed, Jun 29, 2011 at 04:24:36PM +0800, Huang Shijie wrote:
> These files contain the common code for the GPMI-NFC driver.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>

Thanks for the update. Good news, the DMA problem is gone now.
I am just running the mtd-stresstest-suite...

> ---
>  drivers/mtd/nand/gpmi-nfc/gpmi-nfc.c | 2484 ++++++++++++++++++++++++++++++++++
>  drivers/mtd/nand/gpmi-nfc/gpmi-nfc.h |  495 +++++++
>  2 files changed, 2979 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/mtd/nand/gpmi-nfc/gpmi-nfc.c
>  create mode 100644 drivers/mtd/nand/gpmi-nfc/gpmi-nfc.h
> 
> diff --git a/drivers/mtd/nand/gpmi-nfc/gpmi-nfc.c b/drivers/mtd/nand/gpmi-nfc/gpmi-nfc.c
> new file mode 100644
> index 0000000..187b4a3
> --- /dev/null
> +++ b/drivers/mtd/nand/gpmi-nfc/gpmi-nfc.c
> @@ -0,0 +1,2484 @@
> +/*
> + * Freescale GPMI NFC NAND Flash Driver
> + *
> + * Copyright (C) 2010-2011 Freescale Semiconductor, Inc.
> + * Copyright (C) 2008 Embedded Alley Solutions, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +#include "gpmi-nfc.h"

Usually in the kernel, every file includes the stuff it needs for
itself.

> +
> +/* add our owner bbt descriptor */
> +static uint8_t scan_ff_pattern[] = { 0xff };
> +static struct nand_bbt_descr gpmi_bbt_descr = {
> +	.options	= 0,
> +	.offs		= 0,
> +	.len		= 1,
> +	.pattern	= scan_ff_pattern
> +};
> +
> +/* debug control */
> +int gpmi_debug;
> +module_param(gpmi_debug, int, S_IRUGO | S_IWUSR);
> +MODULE_PARM_DESC(gpmi_debug, "print out the debug infomation.");
> +
> +/* enable the gpmi-nfc. */
> +static bool enable_gpmi_nand;

Hmm, disabled by default? I somehow have the impression that it was not
exactly _this_ patch you tested ;) Should go, of course; probably debug
cruft?

> +static int __devinit acquire_interrupt(struct gpmi_nfc_data *this,
> +			const char *resource_name,
> +			irq_handler_t interrupt_handler, int *lno, int *hno)
> +{
> +	struct platform_device *pdev = this->pdev;
> +	struct resource *r;
> +	int err;
> +
> +	r = platform_get_resource_byname(pdev, IORESOURCE_IRQ, resource_name);
> +	if (!r) {
> +		pr_info("Can't get resource for %s\n", resource_name);
> +		return -ENXIO;
> +	}
> +
> +	BUG_ON(r->start != r->end);
> +	err = request_irq(r->start, interrupt_handler, 0, resource_name, this);
> +	if (err) {
> +		pr_info("Can't own %s\n", resource_name);
> +		return err;
> +	}
> +
> +	*lno = r->start;
> +	*hno = r->end;
> +	return 0;
> +}

This will not work if max_chip_count > 1, because the irq is already
taken. (Also, I am not convinced of the resource handling, but I need to
delve into the code more, first.)

Back to testing, thanks for the update,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110629/a898b0d1/attachment.sig>
