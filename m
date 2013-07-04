From: w@1wt.eu (Willy Tarreau)
Date: Thu, 4 Jul 2013 08:15:30 +0200
Subject: [RFC] Add .dts file for Netgear ReadyNAS 102
In-Reply-To: <8761wrp7y5.fsf@natisbad.org>
References: <87obakho6d.fsf@natisbad.org>
 <20130702174111.GF17110@titan.lakedaemon.net> <87y59ows4n.fsf@natisbad.org>
 <20130702220936.GC10215@1wt.eu> <20130703202105.GE27003@titan.lakedaemon.net>
 <20130703203541.GI16785@1wt.eu> <20130703204451.GF27003@titan.lakedaemon.net>
 <20130703211450.GJ16785@1wt.eu> <20130703222315.GK16785@1wt.eu>
 <8761wrp7y5.fsf@natisbad.org>
Message-ID: <20130704061530.GM16785@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,

On Thu, Jul 04, 2013 at 12:58:10AM +0200, Arnaud Ebalard wrote:
> > Oh last important point, I found it in the 2.6.35.9-LSP-1.0.2_gw patch.
> > If someone finds a more recent one in a more recent kernel, it might be
> > worth comparing them.
> 
> The version in Netgear kernel (a 3.0.56, 25/Apr/2012 KW40 LSP release
> 3.1.0-NQ) is almost identical to the one in mirabox 2.6.35 kernel
> (24/Nov/2011, KW40 LSP release 1.0.2-NQ) if you remove the fixes for
> trailing spaces and tabs: 
> 
> 
> @@ -1618,7 +1618,9 @@
>  		ret = -ENXIO;
>  		goto fail_free_irq;
>  	}
> -	if (mtd_has_partitions()) {
> +
> +
> +#ifdef CONFIG_MTD_CMDLINE_PARTS
>  		if (mtd_has_cmdlinepart()) {
>  			static const char *probes[] = { "cmdlinepart", NULL };
>  			struct mtd_partition *parts;
> @@ -1627,12 +1629,11 @@
>  			nr_parts = parse_mtd_partitions(mtd, probes, &parts, 0);
>  
>  			if (nr_parts)
> -				return add_mtd_partitions(mtd, parts, nr_parts);
> +				return mtd_device_register(mtd, parts, nr_parts);
>  		}
> -		return add_mtd_partitions(mtd, pdata->parts, pdata->nr_parts);
> -	}
> -
> -	return add_mtd_device(mtd) == 1 ? -ENODEV : 0;
> +		return mtd_device_register(mtd, pdata->parts, pdata->nr_parts);
> +#endif
> +		return (mtd_device_register(mtd, pdata->parts, pdata->nr_parts));
>  
>  fail_free_irq:
>  	free_irq(IRQ_AURORA_NFC, info);
> @@ -1661,10 +1662,6 @@
>  
>  	platform_set_drvdata(pdev, NULL);
>  
> -	del_mtd_device(mtd);
> -#ifdef CONFIG_MTD_PARTITIONS
> -	del_mtd_partitions(mtd);
> -#endif
>  	free_irq(IRQ_AURORA_NFC, info);
>  	if (info->use_dma) {
>  		dma_free_writecombine(&pdev->dev, info->data_buff_size,
> @@ -1675,7 +1672,10 @@
>  	clk_disable(info->clk);
>  	clk_put(info->clk);
>  #endif
> -	kfree(mtd);
> +	if (mtd) {
> +		mtd_device_unregister(mtd);
> +		kfree(mtd);
> +	}
>  	return 0;
>  }
 
I had found a 3.5.x version somewhere (don't remember where, maybe an
ubuntu repository) which had the same changes. I had merged the last
hunk above, and other ones were not needed.

Thanks,
Willy
