From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 10 Apr 2015 13:17:08 +0200
Subject: [PATCH 1/2] crypto: add new driver for Marvell CESA
In-Reply-To: <1428662339.17822.18.camel@x220>
References: <1428591523-1780-1-git-send-email-boris.brezillon@free-electrons.com>
 <1428591523-1780-2-git-send-email-boris.brezillon@free-electrons.com>
 <1428662339.17822.18.camel@x220>
Message-ID: <20150410131708.258b0a99@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Fri, 10 Apr 2015 12:38:59 +0200
Paul Bolle <pebolle@tiscali.nl> wrote:

> (This patch needed a trivial context change in drivers/crypto/Makefile
> to get it applied on top of next-20150409.)

I'll rebase my work on linux-next.

> 
> On Thu, 2015-04-09 at 16:58 +0200, Boris Brezillon wrote:
> > --- a/drivers/crypto/Kconfig
> > +++ b/drivers/crypto/Kconfig
> > @@ -164,8 +164,10 @@ config CRYPTO_DEV_MV_CESA
> >  	depends on PLAT_ORION
> >  	select CRYPTO_ALGAPI
> >  	select CRYPTO_AES
> > +	select CRYPTO_DES
> >  	select CRYPTO_BLKCIPHER2
> >  	select CRYPTO_HASH
> > +	select SRAM
> >  	help
> >  	  This driver allows you to utilize the Cryptographic Engines and
> >  	  Security Accelerator (CESA) which can be found on the Marvell Orion
> 
> > --- a/drivers/crypto/Makefile
> > +++ b/drivers/crypto/Makefile
> 
> > -obj-$(CONFIG_CRYPTO_DEV_MV_CESA) += mv_cesa.o
> > +obj-$(CONFIG_CRYPTO_DEV_MV_CESA) += marvell/
> 
> > --- /dev/null
> > +++ b/drivers/crypto/marvell/Makefile
> > @@ -0,0 +1 @@
> > +obj-$(CONFIG_CRYPTO_DEV_MV_CESA) += cesa.o cipher.o hash.o tdma.o
> 
> For a modular build (which is all I tried) this doesn't do what you
> probably want, as this will generate four modules. Assuming you want to
> keep the mv_cesa name for the module, you could try something like:
>     obj-$(CONFIG_CRYPTO_DEV_MV_CESA) += mv_cesa.o
>     mv_cesa-objs := cesa.o cipher.o hash.o tdma.o
> 
> Does that do what you want?

Yes, I'll fix that in v2.

> 
> > --- /dev/null
> > +++ b/drivers/crypto/marvell/cesa.c
> 
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms of the GNU General Public License version 2 as published
> > + * by the Free Software Foundation.
> 
> This states the license is GPL v2.
> 
> > +static struct platform_driver marvell_cesa = {
> > +	.probe		= mv_cesa_probe,
> > +	.remove		= mv_cesa_remove,
> > +	.driver		= {
> > +		.owner	= THIS_MODULE,
> > +		.name	= "mv_crypto",
> > +		.of_match_table = mv_cesa_of_match_table,
> > +	},
> > +};
> > +MODULE_ALIAS("platform:mv_crypto");
> 
> (It's nicer to make that macro be a part of the block of the other
> MODULE_ macros.)
> 
> > +module_platform_driver(marvell_cesa);
> 
> (And it's nicer to have this directly follow the definition of
> marvell_cesa.)

Absolutely.

> 
> > +MODULE_AUTHOR("Boris Brezillon <boris.brezillon@free-electrons.com>");
> > +MODULE_AUTHOR("Arnaud Ebalard <arno@natisbad.org>");
> > +MODULE_DESCRIPTION("Support for Marvell's cryptographic engine");
> > +MODULE_LICENSE("GPL");
> 
> And this states the license is GPL v2 or later. So either the comment at
> the top of this file or this macro need to be changed.

I'll change the MODULE_LICENSE definition.

Thanks,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
