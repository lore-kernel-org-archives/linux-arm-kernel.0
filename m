From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 01 Dec 2010 16:38:54 +0900
Subject: [PATCH V2] ARM: SAMSUNG: Add support for clock debugging through
	debug-fs interface
In-Reply-To: <1290759545-2995-1-git-send-email-amit.daniel@samsung.com>
References: <1290759545-2995-1-git-send-email-amit.daniel@samsung.com>
Message-ID: <001b01cb912a$d1381a80$73a84f80$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Amit Daniel Kachhap wrote:
> 
> This patch adds support for clock information exposed to debug-fs
interface.
> 
> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> ---
> Code modified for V2 version are,
> a)Inserted the debug-fs code inside macro CONFIG_PM_DEBUG as suggested by
> yong.shen at linaro.org.

Could you please let me know why?

> b)Removed macro CONFIG_PLAT_SAMSUNG and implemented other coding standards
> as suggested by kgene.kim at samsung.com
> 
>  arch/arm/plat-samsung/clock.c              |   91
> ++++++++++++++++++++++++++++
>  arch/arm/plat-samsung/include/plat/clock.h |    3 +
>  2 files changed, 94 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-samsung/clock.c b/arch/arm/plat-samsung/clock.c
> index e8d20b0..029a49d 100644
> --- a/arch/arm/plat-samsung/clock.c
> +++ b/arch/arm/plat-samsung/clock.c
> @@ -39,6 +39,9 @@
>  #include <linux/clk.h>
>  #include <linux/spinlock.h>
>  #include <linux/io.h>
> +#if defined(CONFIG_DEBUG_FS)
> +#include <linux/debugfs.h>
> +#endif
> 
>  #include <mach/hardware.h>
>  #include <asm/irq.h>
> @@ -447,3 +450,91 @@ int __init s3c24xx_register_baseclocks(unsigned long
> xtal)
>  	return 0;
>  }
> 
> +#if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)

Hmm...please let me know the reason...

> +/* debugfs support to trace clock tree hierarchy and attributes */
> +
> +static struct dentry *clk_debugfs_root;
> +
> +static int clk_debugfs_register_one(struct clk *c)
> +{
> +	int err;
> +	struct dentry *d, *child, *child_tmp;
> +	struct clk *pa = c->parent;
> +	char s[255];
> +	char *p = s;
> +
> +	p += sprintf(p, "%s", c->name);
> +	/*Append id field with name also*/

No need above comment. If required, please add other comments also.

> +	if (c->id >= 0)
> +		sprintf(p, ":%d", c->id);
> +
> +	d = debugfs_create_dir(s, pa ? pa->dent : clk_debugfs_root);
> +	if (!d)
> +		return -ENOMEM;
> +
> +	c->dent = d;
> +
> +	d = debugfs_create_u8("usecount", S_IRUGO, c->dent, (u8
*)&c->usage);
> +	if (!d) {
> +		err = -ENOMEM;
> +		goto err_out;
> +	}

1 empty line would be helpful to read.

> +	d = debugfs_create_u32("rate", S_IRUGO, c->dent, (u32 *)&c->rate);
> +	if (!d) {
> +		err = -ENOMEM;
> +		goto err_out;
> +	}
> +	return 0;
> +
> +err_out:
> +	d = c->dent;
> +	list_for_each_entry_safe(child, child_tmp, &d->d_subdirs,
d_u.d_child)
> +		debugfs_remove(child);
> +	debugfs_remove(c->dent);
> +	return err;
> +}
> +
> +static int clk_debugfs_register(struct clk *c)
> +{
> +	int err;
> +	struct clk *pa = c->parent;
> +
> +	if (pa && !pa->dent) {
> +		err = clk_debugfs_register(pa);
> +		if (err)
> +			return err;
> +	}
> +
> +	if (!c->dent) {
> +		err = clk_debugfs_register_one(c);
> +		if (err)
> +			return err;
> +	}
> +	return 0;
> +}
> +
> +static int __init clk_debugfs_init(void)
> +{
> +	struct clk *c;
> +	struct dentry *d;
> +	int err;
> +
> +	d = debugfs_create_dir("clock", NULL);
> +	if (!d)
> +		return -ENOMEM;
> +	clk_debugfs_root = d;
> +
> +	list_for_each_entry(c, &clocks, list) {
> +		err = clk_debugfs_register(c);
> +		if (err)
> +			goto err_out;
> +	}
> +	return 0;
> +err_out:
> +	debugfs_remove_recursive(clk_debugfs_root);
> +	return err;
> +}
> +late_initcall(clk_debugfs_init);
> +
> +#endif /* defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS) */
> +

No need last one empty line.

> diff --git a/arch/arm/plat-samsung/include/plat/clock.h b/arch/arm/plat-
> samsung/include/plat/clock.h
> index 0fbcd0e..9a82b88 100644
> --- a/arch/arm/plat-samsung/include/plat/clock.h
> +++ b/arch/arm/plat-samsung/include/plat/clock.h
> @@ -47,6 +47,9 @@ struct clk {
> 
>  	struct clk_ops		*ops;
>  	int		    (*enable)(struct clk *, int enable);
> +#if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
> +	struct dentry		*dent;	/* For visible tree hierarchy */
> +#endif
>  };
> 
>  /* other clocks which may be registered by board support */
> --


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
