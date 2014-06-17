From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 17 Jun 2014 22:13:47 +0200
Subject: [PATCH] regmap: Add Kconfig option for debugfs register writes
In-Reply-To: <alpine.DEB.2.02.1406171254540.18156@chino.kir.corp.google.com>
References: <1403033795-9122-1-git-send-email-mpa@pengutronix.de>
 <alpine.DEB.2.02.1406171254540.18156@chino.kir.corp.google.com>
Message-ID: <20140617201347.GA32450@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 17, 2014 at 12:56:54PM -0700, David Rientjes wrote:
> On Tue, 17 Jun 2014, Markus Pargmann wrote:
> 
> > To enable writing of registers through the regmap debugfs interface, it
> > was necessary to alter the regmap-debugfs.c source code. This is not
> > really practical.
> > 
> > As this is a powerful tool for debugging, this patch creates an expert
> > kconfig option for this function. This makes it easier to enable
> > register writing in the kernel.
> > 
> > This patch also fixes the file mode when the regmap debugfs write code is
> > compiled.
> > 
> 
> Forcing users to enable CONFIG_EXPERT for this doesn't seem appropriate, 
> it enables things by default and has really become a separate config of 
> its own.  You might want to consider removing this dependency unless you 
> have a strong reason for keeping it.

I only created the dependency on CONFIG_EXPERT to make it clear that
this option is only for people who know what they are doing. I can
remove that dependency if that is OK for everyone?

Thanks,

Markus

> 
> > Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  drivers/base/regmap/Kconfig          | 14 ++++++++++++++
> >  drivers/base/regmap/regmap-debugfs.c | 16 ++++++++++------
> >  2 files changed, 24 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
> > index 4251570610c9..ce86600dbe75 100644
> > --- a/drivers/base/regmap/Kconfig
> > +++ b/drivers/base/regmap/Kconfig
> > @@ -23,3 +23,17 @@ config REGMAP_MMIO
> >  
> >  config REGMAP_IRQ
> >  	bool
> > +
> > +config REGMAP_ALLOW_WRITE_DEBUGFS
> > +	default n
> > +	depends on DEBUG_FS
> > +	depends on EXPERT
> > +	depends on REGMAP
> > +	bool "Regmap, allow direct register writes through debugfs"
> > +	help
> > +	  This option enables regmap debugfs write support. If this is enabled,
> > +	  you can directly write registers using the registers file in the
> > +	  regmap debugfs.
> > +
> > +	  This is potentially dangerous. Do not enable this option unless you
> > +	  know what you are doing.
> > diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
> > index 45d812c0ea77..12906f2bdf00 100644
> > --- a/drivers/base/regmap/regmap-debugfs.c
> > +++ b/drivers/base/regmap/regmap-debugfs.c
> > @@ -261,13 +261,10 @@ static ssize_t regmap_map_read_file(struct file *file, char __user *user_buf,
> >  				   count, ppos);
> >  }
> >  
> > -#undef REGMAP_ALLOW_WRITE_DEBUGFS
> > -#ifdef REGMAP_ALLOW_WRITE_DEBUGFS
> > +#if IS_ENABLED(CONFIG_REGMAP_ALLOW_WRITE_DEBUGFS)
> >  /*
> >   * This can be dangerous especially when we have clients such as
> > - * PMICs, therefore don't provide any real compile time configuration option
> > - * for this feature, people who want to use this will need to modify
> > - * the source code directly.
> > + * PMICs, therefore this function can only be selected in expert kconfig mode.
> >   */
> >  static ssize_t regmap_map_write_file(struct file *file,
> >  				     const char __user *user_buf,
> > @@ -512,7 +509,14 @@ void regmap_debugfs_init(struct regmap *map, const char *name)
> >  			    map, &regmap_reg_ranges_fops);
> >  
> >  	if (map->max_register || regmap_readable(map, 0)) {
> > -		debugfs_create_file("registers", 0400, map->debugfs,
> > +		unsigned int registers_mode;
> > +
> > +		if (IS_ENABLED(CONFIG_REGMAP_ALLOW_WRITE_DEBUGFS))
> > +			registers_mode = 0600;
> > +		else
> > +			registers_mode = 0400;
> > +
> > +		debugfs_create_file("registers", registers_mode, map->debugfs,
> >  				    map, &regmap_map_fops);
> >  		debugfs_create_file("access", 0400, map->debugfs,
> >  				    map, &regmap_access_fops);
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140617/6811b4a4/attachment.sig>
