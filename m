From: balbi@ti.com (Felipe Balbi)
Date: Mon, 14 Oct 2013 17:50:39 -0500
Subject: [PATCH v2 3/3] usb: musb: dsps, debugfs files
In-Reply-To: <1381758639-30300-4-git-send-email-mpa@pengutronix.de>
References: <1381758639-30300-1-git-send-email-mpa@pengutronix.de>
 <1381758639-30300-4-git-send-email-mpa@pengutronix.de>
Message-ID: <20131014225039.GC7446@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Oct 14, 2013 at 03:50:39PM +0200, Markus Pargmann wrote:
> debugfs files to show the contents of important dsps registers.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  drivers/usb/musb/musb_dsps.c | 87 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
> 
> diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
> index 189e52c..43b22ab 100644
> --- a/drivers/usb/musb/musb_dsps.c
> +++ b/drivers/usb/musb/musb_dsps.c
> @@ -46,6 +46,8 @@
>  #include <linux/of_irq.h>
>  #include <linux/usb/of.h>
>  
> +#include <linux/debugfs.h>
> +
>  #include "musb_core.h"
>  
>  static const struct of_device_id musb_dsps_of_match[];
> @@ -121,6 +123,61 @@ struct dsps_glue {
>  	unsigned long last_timer;    /* last timer data for each instance */
>  };
>  
> +#if IS_ENABLED(CONFIG_DEBUG_FS)
> +
> +struct musb_register_map {
> +	char			*name;
> +	unsigned		offset;
> +};
> +
> +static const struct musb_register_map musb_regmap[] = {
> +	{ "revision",		0x00 },
> +	{ "control",		0x14 },
> +	{ "status",		0x18 },
> +	{ "eoi",		0x24 },
> +	{ "intr0_stat",		0x30 },
> +	{ "intr1_stat",		0x34 },
> +	{ "intr0_set",		0x38 },
> +	{ "intr1_set",		0x3c },
> +	{ "txmode",		0x70 },
> +	{ "rxmode",		0x74 },
> +	{ "autoreq",		0xd0 },
> +	{ "srpfixtime",		0xd4 },
> +	{ "tdown",		0xd8 },
> +	{ "phy_utmi",		0xe0 },
> +	{ "mode",		0xe8 },
> +	{  }	/* Terminating Entry */
> +};
> +
> +static int musb_regdump_show(struct seq_file *s, void *unused)
> +{
> +	struct musb		*musb = s->private;
> +	unsigned		i;
> +
> +	seq_puts(s, "MUSB (M)HDRC dsps Register Dump\n");
> +
> +	for (i = 0; i < ARRAY_SIZE(musb_regmap); i++) {
> +		u32 val = musb_readl(musb->ctrl_base, musb_regmap[i].offset);
> +		seq_printf(s, "%-12s: %08x\n", musb_regmap[i].name, val);
> +	}
> +
> +	return 0;
> +}
> +
> +static int musb_regdump_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, musb_regdump_show, inode->i_private);
> +}
> +
> +static const struct file_operations musb_regdump_fops = {
> +	.open			= musb_regdump_open,
> +	.read			= seq_read,
> +	.llseek			= seq_lseek,
> +	.release		= single_release,
> +};
> +
> +#endif /* IS_ENABLED(CONFIG_DEBUG_FS) */
> +
>  /**
>   * dsps_musb_enable - enable interrupts
>   */
> @@ -348,6 +405,31 @@ out:
>  	return ret;
>  }
>  
> +#if IS_ENABLED(CONFIG_DEBUG_FS)
> +static int dsps_musb_dbg_init(struct musb *musb)
> +{
> +	struct dentry *root;
> +	struct dentry *file;
> +	char buf[128];
> +
> +	sprintf(buf, "%s.dsps", dev_name(musb->controller));
> +	root = debugfs_create_dir(buf, NULL);
> +	if (!root)
> +		return -ENOMEM;
> +
> +	file = debugfs_create_file("regdump", S_IRUGO, root, musb,
> +			&musb_regdump_fops);

there is a generic regdump utility for debugfs, please use that instead.
At least drivers/usb/dwc3/debugfs is using it.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131014/2004655a/attachment-0001.sig>
