From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 04 Sep 2014 10:09:19 +0530
Subject: [PATCH v2] mfd: syscon: Decouple syscon interface from platform
 devices
In-Reply-To: <6034841.GFrG3XCMdb@wuerfel>
References: <1409668935-10667-1-git-send-email-pankaj.dubey@samsung.com>
 <6034841.GFrG3XCMdb@wuerfel>
Message-ID: <002601cfc7fa$39413580$abc3a080$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tuesday, September 02, 2014 Arnd Bergmann wrote,
> To: Pankaj Dubey
> Cc: linux-arm-kernel at lists.infradead.org;
linux-samsung-soc at vger.kernel.org; linux-
> kernel at vger.kernel.org; lee.jones at linaro.org; kgene.kim at samsung.com;
> linux at arm.linux.org.uk; vikas.sajjan at samsung.com; joshi at samsung.com;
> naushad at samsung.com; thomas.ab at samsung.com; chow.kim at samsung.com;
> tomasz.figa at gmail.com; Tomasz Figa; Alexander Shiyan; Michal Simek
> Subject: Re: [PATCH v2] mfd: syscon: Decouple syscon interface from
platform
> devices
> 
> On Tuesday 02 September 2014 20:12:15 Pankaj Dubey wrote:
> > Currently a syscon entity can only be registered directly through a
> > platform device that binds to a dedicated syscon driver. However in
> > certain cases it is required to bind a device with it's dedicated
> > driver rather than binding with syscon driver.
> >
> > For example, certain SoCs (e.g. Exynos) contain system controller
> > blocks which perform various functions such as power domain control,
> > CPU power management, low power mode control, but in addition contain
> > certain IP integration glue, such as various signal masks, coprocessor
> > power control, etc. In such case, there is a need to have a dedicated
> > driver for such system controller but also share registers with other
> > drivers. The latter is where the syscon interface is helpful.
> >
> > This patch decouples syscon object from syscon platform driver, and
> > allows to create syscon objects first time when it is required by
> > calling of syscon_regmap_lookup_by APIs and keeps a list of such
> > syscon objects along with syscon provider device_nodes and regmap
handles.
> >
> > Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> > Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> > ---
> > V1 of this patchset [1] and related discussion can be found here [1].
> >
> > Changes since v1:
> >  - Removed of_syscon_unregister function.
> >  - Modified of_syscon_register function and it will be used by syscon.c
> >    to create syscon objects whenever required.
> >  - Removed platform device support from syscon.
> >  - Removed syscon_regmap_lookup_by_pdevname API support.
> >  - As there are significant changes w.r.t patchset v1, I am taking over
> >    author for this patchset from Tomasz Figa.
> 
> Note that you got the Signed-off-by: list wrong, you should never have any
people
> listed as Signed-off-by after your own name, and they should be listed
before your
> name only when you are forwarding their patches.
> 

Sorry, I was not aware of this. I will take care in future.

> > Note: Current kernel has clps711x user of
> > syscon_regmap_lookup_by_pdevname and will be broken after this patch.
> > As per discussion over here [1], patches for making these drivers DT
> > based are ready and once that is done they can use
> syscon_regmap_lookup_by_phandle or syscon_regmap_lookup_by_compatible.
> >
> > [1]: https://lkml.org/lkml/2014/8/22/81
> 
> Adding Alexander Shiyan to Cc here, so we can make sure this is well
coordinated.
> 
> I'm also adding Michal Simek, since here was involved in earlier
discussions about
> doing this.
> 

Thanks.

> >  drivers/mfd/syscon.c       |  143
+++++++++++++-------------------------------
> >  include/linux/mfd/syscon.h |    1 +
> >  2 files changed, 44 insertions(+), 100 deletions(-)
> 
> I certainly like the diffstat ;-)
> 
> >  struct syscon {
> > +	struct device_node *np;
> >  	struct regmap *regmap;
> > +	struct list_head list;
> >  };
> 
> Right
> 
> > @@ -68,27 +72,6 @@ struct regmap
> > *syscon_regmap_lookup_by_compatible(const char *s)  }
> > EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_compatible);
> >
> > -static int syscon_match_pdevname(struct device *dev, void *data) -{
> > -	return !strcmp(dev_name(dev), (const char *)data);
> > -}
> > -
> > -struct regmap *syscon_regmap_lookup_by_pdevname(const char *s) -{
> > -	struct device *dev;
> > -	struct syscon *syscon;
> > -
> > -	dev = driver_find_device(&syscon_driver.driver, NULL, (void *)s,
> > -				 syscon_match_pdevname);
> > -	if (!dev)
> > -		return ERR_PTR(-EPROBE_DEFER);
> > -
> > -	syscon = dev_get_drvdata(dev);
> > -
> > -	return syscon->regmap;
> > -}
> > -EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_pdevname);
> 
> I think this can actually be left intact if that helps with clps71xx.
> It could be done in a hacky way using bus_find_device_by_name() to keep it
simple,
> or in a somewhat nicer way by keeping the syscon platform_driver around
for the
> non-DT case.
> 

Ok as per our last discussion you mentioned that clps71xx will be soon
migrating to DT.
So if that is not going to happen sooner, I would also prefer better keep
syscon_regmap_lookup_by_pdevname and syscon platform_driver for non-DT case,
so that this issue should not block this patch.

So please let's make final call to keep syscon platform_driver for non-DT
case which eventually
can be dropped once clps71xx driver migrates to DT based. So that I can
prepare next patchset
keeping syscon platform_driver support  and syscon_regmap_lookup_by_pdevname
API support
for non-DT case and send across for review. 


> 
> > +	regmap = regmap_init_mmio(NULL, base, &syscon_regmap_config);
> > +	if (IS_ERR(regmap)) {
> > +		pr_err("regmap init failed\n");
> > +		return ERR_CAST(regmap);
> > +	}
> 
> The last time I looked over this code, I think it was not safe to
> call regmap_init_mmio() with a NULL device pointer, and we decided
> that should be fixed. Have you checked whether it is ok now?
> 

At least we could not see any issues with this. We have tested it one
Exynos5250 board
where syscon object is getting created first time when other drivers (USB,
SATA Phy, Watchdog)
are calling helper function syscon_regmap_lookup_by_phandle and able to
access regmap handle
and able to use regmap_read/write APIs.

> 	Arnd
