From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Aug 2014 10:04:33 +0200
Subject: [RFC 6/7] bcma: get sprom from devicetree
In-Reply-To: <1408915485-8078-8-git-send-email-hauke@hauke-m.de>
References: <1408915485-8078-1-git-send-email-hauke@hauke-m.de>
 <1408915485-8078-8-git-send-email-hauke@hauke-m.de>
Message-ID: <4882662.VtlSfZ0rSN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 24 August 2014 23:24:44 Hauke Mehrtens wrote:
> +#ifdef CONFIG_OF
> +static int bcma_fill_sprom_with_dt(struct bcma_bus *bus,
> +                                  struct ssb_sprom *out)
> +{
> +       const __be32 *handle;
> +       struct device_node *sprom_node;
> +       struct platform_device *sprom_dev;
> +       struct ssb_sprom *sprom;
> +
> +       if (!bus->host_pdev || !bus->host_pdev->dev.of_node)
> +               return -ENOENT;

You can remove the #ifdef above if you change this into

	if (!IS_ENABLED(CONFIG_OF) || !bus->host_pdev ||
	    !bus->host_pdev->dev.of_node)
		return -ENOENT;

> +       handle = of_get_property(bus->host_pdev->dev.of_node, "sprom", NULL);
> +       if (!handle)
> +               return -ENOENT;
> +
> +       sprom_node = of_find_node_by_phandle(be32_to_cpup(handle));
> +       if (!sprom_node)
> +               return -ENOENT;
> +
> +       sprom_dev = of_find_device_by_node(sprom_node);
> +       if (!sprom_dev)
> +               return -ENOENT;
> +
> +       sprom = platform_get_drvdata(sprom_dev);
> +       if (!sprom)
> +               return -ENOENT;
> +
> +       memcpy(out, sprom, sizeof(*out));
> +
> +       return 0;
> +}

missing of_node_put().

	Arnd
