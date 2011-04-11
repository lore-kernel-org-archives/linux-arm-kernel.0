From: joe@perches.com (Joe Perches)
Date: Mon, 11 Apr 2011 16:44:32 -0700
Subject: [RFC][PATCH V3] axi: add AXI bus driver
In-Reply-To: <1302557114-7880-1-git-send-email-zajec5@gmail.com>
References: <1302557114-7880-1-git-send-email-zajec5@gmail.com>
Message-ID: <1302565473.2163.28.camel@Joe-Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-04-11 at 23:25 +0200, Rafa? Mi?ecki wrote:

>   Proper pr_* usage
 
Just trivia...

> diff --git a/drivers/axi/axi_private.h b/drivers/axi/axi_private.h
> new file mode 100644
> index 0000000..1c995f5
> --- /dev/null
> +++ b/drivers/axi/axi_private.h
> @@ -0,0 +1,45 @@
> +#ifndef LINUX_AXI_PRIVATE_H_
> +#define LINUX_AXI_PRIVATE_H_
> +
> +#include <linux/axi/axi.h>
> +#include <linux/device.h>
> +#include <linux/list.h>
> +#include <linux/types.h>
> +#include <linux/spinlock.h>
> +#include <linux/pci.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/types.h>

Duplicate include of linux/types.h

> +
> +#ifndef pr_fmt
> +#define pr_fmt(fmt)		"axi: " fmt
> +#endif

This needs to be before any include that includes kernel.h
and I believe
#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
is the same output and more normally used style.

Right now, you've got no prefix for any format string.
Try '$ strings built-in.o | grep "^<.>"' and see.

> +void axi_pmu_workarounds(struct axi_drv_cc *cc)
> +{
> +	struct axi_bus *bus = cc->core->bus;
> +
> +	switch (bus->chipinfo.id) {
> +	case 0x4313:

Probably better to use defines.

> +		axi_chipco_chipctl_maskset(cc, 0, ~0, 0x7);
> +		break;
> +	case 0x4331:
> +		axi_err("Enabling Ext PA lines not implemented\n");

You should still remove axi_err/info/debug and
just use pr_<level>.


> +		break;
> +	case 43224:
> +		if (bus->chipinfo.rev == 0) {
> +			axi_err("Workarounds for 43224 rev 0 not fully "
> +					"implemented\n");

I suggest you don't bother splitting and wrapping
format strings > 80 chars.  Splitting makes grep
a bit harder.

			pr_err("Workarounds for 43224 rev 0 not fully implemented\n");

Some hex and some decimal cases?
Maybe some comments for that?
