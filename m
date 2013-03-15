From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 15 Mar 2013 13:40:55 -0400 (EDT)
Subject: [RFC] USB: EHCI: hot-fix OMAP and Orion multiplatform config
In-Reply-To: <201303151700.27231.arnd@arndb.de>
Message-ID: <Pine.LNX.4.44L0.1303151335470.1414-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Mar 2013, Arnd Bergmann wrote:

> On Friday 15 March 2013, Alan Stern wrote:
> > Roger just submitted my patch to split out ehci-omap.
> 
> Ok, if we can merge that for 3.9, the main issue will be resolved, because
> an OMAP+Orion config is much more interesting in practice than adding
> VT8500 to the mix.

I don't know if the patch will get into 3.9.  That's up to Greg; IIRC 
Roger did not ask for it.

> An alternative for VT8500 would be to remove drivers/usb/host/ehci-vt8500.c
> completely and use the generic ehci-platform.c bus glue with added DT
> support, as the patch below that I just hacked up. Not sure if that
> anyone would prefer that over the hot-fix for 3.9, but it's possibly
> a better solution in the long run.

Getting rid of driver files is always worthwhile.

> @@ -89,12 +90,17 @@ static int ehci_platform_probe(struct platform_device *dev)
>  		return -ENXIO;
>  	}
>  
> -	if (pdata->power_on) {
> +	if (pdata && pdata->power_on) {
>  		err = pdata->power_on(dev);
>  		if (err < 0)
>  			return err;
>  	}

Instead of adding these tests for non-NULL pdata all over the place, 
you could define a static structure with default settings and store a 
pointer to it if pdata wasn't set initially.

Alan Stern
