From: balbi@ti.com (Felipe Balbi)
Date: Fri, 28 Dec 2012 00:59:50 +0200
Subject: [PATCH 2/2] i2c-exynos5: add debugfs support for registers
In-Reply-To: <1356434755-13702-2-git-send-email-ch.naveen@samsung.com>
References: <1354021236-28596-2-git-send-email-ch.naveen@samsung.com>
 <1356434755-13702-1-git-send-email-ch.naveen@samsung.com>
 <1356434755-13702-2-git-send-email-ch.naveen@samsung.com>
Message-ID: <20121227225950.GC12665@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 25, 2012 at 04:55:55PM +0530, Naveen Krishna Chatradhi wrote:
> This patch replaces the dev_vdbg with debugfs function calls
> in i2c-exynos5.c driver.
> 
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> ---
> Changes since v1:
> The debugfs implementation is a suggestion by Felipe Balbi.
> Its not tested, Implemented only for review purpose..
> 
>  drivers/i2c/busses/i2c-exynos5.c |  140 +++++++++++++++++++++++++++++---------
>  1 file changed, 109 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
> index 7614f60..2d2da22 100644
> --- a/drivers/i2c/busses/i2c-exynos5.c
> +++ b/drivers/i2c/busses/i2c-exynos5.c
> @@ -12,6 +12,7 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/debugfs.h>
>  
>  #include <linux/i2c.h>
>  #include <linux/init.h>
> @@ -55,6 +56,7 @@ struct exynos5_i2c {
>  
>  	int			bus_num;
>  	int			speed_mode;
> +	struct dentry		*debugfs_root;
>  };
>  
>  static const struct of_device_id exynos5_i2c_match[] = {
> @@ -63,39 +65,112 @@ static const struct of_device_id exynos5_i2c_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, exynos5_i2c_match);
>  
> -/* TODO: Should go to debugfs */
> -static inline void dump_i2c_register(struct exynos5_i2c *i2c)
> +static int exynos5_i2c_regs_show(struct seq_file *s, void *data)
>  {
> -	dev_vdbg(i2c->dev, "Register dump(%d) :\n %x\n %x\n %x\n %x\n"
> -		" %x\n %x\n %x\n %x\n %x\n"
> -		" %x\n %x\n %x\n %x\n %x\n"
> -		" %x\n %x\n %x\n %x\n %x\n"
> -		" %x\n %x\n %x\n %x\n %x\n",
> -		i2c->suspended,
> -		readl(i2c->regs + HSI2C_CTL),
> -		readl(i2c->regs + HSI2C_FIFO_CTL),
> -		readl(i2c->regs + HSI2C_TRAILIG_CTL),
> -		readl(i2c->regs + HSI2C_CLK_CTL),
> -		readl(i2c->regs + HSI2C_CLK_SLOT),
> -		readl(i2c->regs + HSI2C_INT_ENABLE),
> -		readl(i2c->regs + HSI2C_INT_STATUS),
> -		readl(i2c->regs + HSI2C_ERR_STATUS),
> -		readl(i2c->regs + HSI2C_FIFO_STATUS),
> -		readl(i2c->regs + HSI2C_TX_DATA),
> -		readl(i2c->regs + HSI2C_RX_DATA),
> -		readl(i2c->regs + HSI2C_CONF),
> -		readl(i2c->regs + HSI2C_AUTO_CONF),
> -		readl(i2c->regs + HSI2C_TIMEOUT),
> -		readl(i2c->regs + HSI2C_MANUAL_CMD),
> -		readl(i2c->regs + HSI2C_TRANS_STATUS),
> -		readl(i2c->regs + HSI2C_TIMING_HS1),
> -		readl(i2c->regs + HSI2C_TIMING_HS2),
> -		readl(i2c->regs + HSI2C_TIMING_HS3),
> -		readl(i2c->regs + HSI2C_TIMING_FS1),
> -		readl(i2c->regs + HSI2C_TIMING_FS2),
> -		readl(i2c->regs + HSI2C_TIMING_FS3),
> -		readl(i2c->regs + HSI2C_TIMING_SLA),
> +	struct exynos5_i2c *i2c = (struct exynos5_i2c *)s->private;
> +
> +	if (i2c->suspended) {
> +		seq_printf(s, "i2c suspended, can't read registers\n");
> +		return 0;
> +	}
> +
> +	pm_runtime_get_sync(i2c->dev);
> +
> +	seq_printf(s, "CTL:\t\t0x%08x\n",
> +		readl(i2c->regs + HSI2C_CTL));

BTW, there is a generic regdump debugfs interface nowadays, please use
that instead (look for debugfs_create_regset32)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121228/a500c17b/attachment.sig>
