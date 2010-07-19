From: joe@perches.com (Joe Perches)
Date: Mon, 19 Jul 2010 08:58:34 -0700
Subject: [PATCH v2] davinci: Add MityDSP-L138/MityARM-1808 SOM support
In-Reply-To: <4C4454AF.4000801@criticallink.com>
References: <4C4454AF.4000801@criticallink.com>
Message-ID: <1279555114.5434.27.camel@Joe-Laptop.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-07-19 at 09:35 -0400, Michael Williamson wrote:
> +        pr_warning("%s: mmcsd0 mux setup failed:" " %d\n", __func__,ret);

Isn't this easier to read as a single string?

	pr_warning("%s: mmcsd0 mux setup failed: %d\n", __func__, ret);

Also, if you want __func__ to prefix every printk you could use:

#define pr_fmt(fmt) "%s: " fmt, __func__

and use:

	pr_warning("mmcsd0 mux setup failed: %d\n", ret);

> +    ret = da8xx_register_mmcsd0(&da850_mmc_config);
> +    if (ret)
> +        pr_warning("%s: mmcsd0 registration failed:", __func__, " %d\n", ret);

Compile tested?  Perhaps you mean:

	pr_warning("%s: mmcsd0 registration failed: %d\n", __func__, ret);

[]

> +    pr_info("EMAC = %02X:%02X:%02X:%02X:%02X:%02X\n",
> +        peripheral_config.ENETConfig.MACAddr[0],
> +        peripheral_config.ENETConfig.MACAddr[1],
> +        peripheral_config.ENETConfig.MACAddr[2],
> +        peripheral_config.ENETConfig.MACAddr[3],
> +        peripheral_config.ENETConfig.MACAddr[4],
> +        peripheral_config.ENETConfig.MACAddr[5]);

There's are extensions to printk/vsnprintf that is used for
various things like MAC and IP addresses. (see: lib/vsprintf.c)

This should be:

	pr_info("EMAC = %pM\n", peripheral_config.ENETConfig.MACAddr);
