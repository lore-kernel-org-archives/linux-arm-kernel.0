From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 12 Jan 2010 10:41:41 +0100
Subject: [PATCH] MXC: Add AUDMUXv2 register decode to debugfs
In-Reply-To: <1263227598-27498-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1263227598-27498-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <20100112094141.GC6923@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2010 at 04:33:18PM +0000, Mark Brown wrote:
> Since AUDMUX configuration appears to be one of the common stumbling
> blocks for people setting up i.MX audio try to provide some diagnostic
> information describing the current setup to assisist people in working
> out what's going on.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Ok, applied for -rc.

Sascha

> ---
>  arch/arm/plat-mxc/audmux-v2.c |  137 +++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 137 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/audmux-v2.c b/arch/arm/plat-mxc/audmux-v2.c
> index 6f21096..b06954a 100644
> --- a/arch/arm/plat-mxc/audmux-v2.c
> +++ b/arch/arm/plat-mxc/audmux-v2.c
> @@ -23,6 +23,7 @@
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/clk.h>
> +#include <linux/debugfs.h>
>  #include <mach/audmux.h>
>  #include <mach/hardware.h>
>  
> @@ -32,6 +33,140 @@ static void __iomem *audmux_base;
>  #define MXC_AUDMUX_V2_PTCR(x)		((x) * 8)
>  #define MXC_AUDMUX_V2_PDCR(x)		((x) * 8 + 4)
>  
> +#ifdef CONFIG_DEBUG_FS
> +static struct dentry *audmux_debugfs_root;
> +
> +static int audmux_open_file(struct inode *inode, struct file *file)
> +{
> +	file->private_data = inode->i_private;
> +	return 0;
> +}
> +
> +/* There is an annoying discontinuity in the SSI numbering with regard
> + * to the Linux number of the devices */
> +static const char *audmux_port_string(int port)
> +{
> +	switch (port) {
> +	case MX31_AUDMUX_PORT1_SSI0:
> +		return "imx-ssi.0";
> +	case MX31_AUDMUX_PORT2_SSI1:
> +		return "imx-ssi.1";
> +	case MX31_AUDMUX_PORT3_SSI_PINS_3:
> +		return "SSI3";
> +	case MX31_AUDMUX_PORT4_SSI_PINS_4:
> +		return "SSI4";
> +	case MX31_AUDMUX_PORT5_SSI_PINS_5:
> +		return "SSI5";
> +	case MX31_AUDMUX_PORT6_SSI_PINS_6:
> +		return "SSI6";
> +	default:
> +		return "UNKNOWN";
> +	}
> +}
> +
> +static ssize_t audmux_read_file(struct file *file, char __user *user_buf,
> +				size_t count, loff_t *ppos)
> +{
> +	ssize_t ret;
> +	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
> +	int port = (int)file->private_data;
> +	u32 pdcr, ptcr;
> +
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	if (audmux_clk)
> +		clk_enable(audmux_clk);
> +
> +	ptcr = readl(audmux_base + MXC_AUDMUX_V2_PTCR(port));
> +	pdcr = readl(audmux_base + MXC_AUDMUX_V2_PDCR(port));
> +
> +	if (audmux_clk)
> +		clk_disable(audmux_clk);
> +
> +	ret = snprintf(buf, PAGE_SIZE, "PDCR: %08x\nPTCR: %08x\n",
> +		       pdcr, ptcr);
> +
> +	if (ptcr & MXC_AUDMUX_V2_PTCR_TFSDIR)
> +		ret += snprintf(buf + ret, PAGE_SIZE - ret,
> +				"TxFS output from %s, ",
> +				audmux_port_string((ptcr >> 27) & 0x7));
> +	else
> +		ret += snprintf(buf + ret, PAGE_SIZE - ret,
> +				"TxFS input, ");
> +
> +	if (ptcr & MXC_AUDMUX_V2_PTCR_TCLKDIR)
> +		ret += snprintf(buf + ret, PAGE_SIZE - ret,
> +				"TxClk output from %s",
> +				audmux_port_string((ptcr >> 22) & 0x7));
> +	else
> +		ret += snprintf(buf + ret, PAGE_SIZE - ret,
> +				"TxClk input");
> +
> +	ret += snprintf(buf + ret, PAGE_SIZE - ret, "\n");
> +
> +	if (ptcr & MXC_AUDMUX_V2_PTCR_SYN) {
> +		ret += snprintf(buf + ret, PAGE_SIZE - ret,
> +				"Port is symmetric");
> +	} else {
> +		if (ptcr & MXC_AUDMUX_V2_PTCR_RFSDIR)
> +			ret += snprintf(buf + ret, PAGE_SIZE - ret,
> +					"RxFS output from %s, ",
> +					audmux_port_string((ptcr >> 17) & 0x7));
> +		else
> +			ret += snprintf(buf + ret, PAGE_SIZE - ret,
> +					"RxFS input, ");
> +
> +		if (ptcr & MXC_AUDMUX_V2_PTCR_RCLKDIR)
> +			ret += snprintf(buf + ret, PAGE_SIZE - ret,
> +					"RxClk output from %s",
> +					audmux_port_string((ptcr >> 12) & 0x7));
> +		else
> +			ret += snprintf(buf + ret, PAGE_SIZE - ret,
> +					"RxClk input");
> +	}
> +
> +	ret += snprintf(buf + ret, PAGE_SIZE - ret,
> +			"\nData received from %s\n",
> +			audmux_port_string((pdcr >> 13) & 0x7));
> +
> +	ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
> +
> +	kfree(buf);
> +
> +	return ret;
> +}
> +
> +static const struct file_operations audmux_debugfs_fops = {
> +	.open = audmux_open_file,
> +	.read = audmux_read_file,
> +};
> +
> +static void audmux_debugfs_init(void)
> +{
> +	int i;
> +	char buf[20];
> +
> +	audmux_debugfs_root = debugfs_create_dir("audmux", NULL);
> +	if (!audmux_debugfs_root) {
> +		pr_warning("Failed to create AUDMUX debugfs root\n");
> +		return;
> +	}
> +
> +	for (i = 1; i < 8; i++) {
> +		snprintf(buf, sizeof(buf), "ssi%d", i);
> +		if (!debugfs_create_file(buf, 0444, audmux_debugfs_root,
> +					 (void *)i, &audmux_debugfs_fops))
> +			pr_warning("Failed to create AUDMUX port %d debugfs file\n",
> +				   i);
> +	}
> +}
> +#else
> +static inline void audmux_debugfs_init(void)
> +{
> +}
> +#endif
> +
>  int mxc_audmux_v2_configure_port(unsigned int port, unsigned int ptcr,
>  		unsigned int pdcr)
>  {
> @@ -68,6 +203,8 @@ static int mxc_audmux_v2_init(void)
>  	if (cpu_is_mx31() || cpu_is_mx35())
>  		audmux_base = IO_ADDRESS(AUDMUX_BASE_ADDR);
>  
> +	audmux_debugfs_init();
> +
>  	return 0;
>  }
>  
> -- 
> 1.6.6
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
