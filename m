From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 01 Aug 2014 18:21:09 +0100
Subject: [PATCH 5/5] platform: Make platform_bus device a platform device
In-Reply-To: <20140726201351.GC21870@kroah.com>
References: <1406298233-27876-1-git-send-email-pawel.moll@arm.com>
 <1406298233-27876-5-git-send-email-pawel.moll@arm.com>
 <20140726201351.GC21870@kroah.com>
Message-ID: <1406913669.22529.44.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2014-07-26 at 21:13 +0100, Greg Kroah-Hartman wrote:
> > @@ -946,12 +946,20 @@ int __init platform_bus_init(void)
> >  
> >  	early_platform_cleanup();
> >  
> > -	error = device_register(&platform_bus);
> > +	dev_set_name(&platform_bus.dev, "%s", platform_bus.name);
> > +	error = device_register(&platform_bus.dev);
> >  	if (error)
> >  		return error;
> >  	error =  bus_register(&platform_bus_type);
> > -	if (error)
> > -		device_unregister(&platform_bus);
> > +	if (!error) {
> > +#ifdef CONFIG_OF
> > +		platform_bus.dev.of_node = of_allnodes;
> > +#endif
> 
> Why are you doing this?  The original code didn't do it and all was
> fine, right?  What changes here?

You mean the #ifdef? It wasn't there, but Olof figured out that it
breaks !CONFIG_OF builds:

http://article.gmane.org/gmane.linux.ports.tegra/18473

as of_allnodes is only defined when CONFIG_OF. I had a choice of
#ifdefing the assignment above or providing a dummy symbol. The latter
doesn't seem sensibly, as there should be no other users for it (the
symbol).

Pawel
