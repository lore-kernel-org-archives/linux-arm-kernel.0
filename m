From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 02 Sep 2014 19:40:45 +0200
Subject: [PATCH v2] mfd: syscon: Decouple syscon interface from platform
 devices
In-Reply-To: <1409672572.303525842@f75.i.mail.ru>
References: <1409668935-10667-1-git-send-email-pankaj.dubey@samsung.com>
 <6034841.GFrG3XCMdb@wuerfel> <1409672572.303525842@f75.i.mail.ru>
Message-ID: <3685403.qLrNHfR1Kx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 02 September 2014 19:42:52 Alexander Shiyan wrote:
> > > -struct regmap *syscon_regmap_lookup_by_pdevname(const char *s)
> > > -{
> > > -   struct device *dev;
> > > -   struct syscon *syscon;
> > > -
> > > -   dev = driver_find_device(&syscon_driver.driver, NULL, (void *)s,
> > > -                            syscon_match_pdevname);
> > > -   if (!dev)
> > > -           return ERR_PTR(-EPROBE_DEFER);
> > > -
> > > -   syscon = dev_get_drvdata(dev);
> > > -
> > > -   return syscon->regmap;
> > > -}
> > > -EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_pdevname);
> > 
> > I think this can actually be left intact if that helps with clps71xx.
> > It could be done in a hacky way using bus_find_device_by_name()
> > to keep it simple, or in a somewhat nicer way by keeping the 
> > syscon platform_driver around for the non-DT case.
> 
> It will not work anyway because the patch involves the use of
> of_device_is_compatible(), of_iomap() etc...

What I meant was to have the pdevname stuff keep working the way
it does today. At that point, you essentially have two completely
independent drivers, one that registers a platform driver and
provides syscon_regmap_lookup_by_pdevname, and one that provides
the other interfaces using DT lookup.

	Arnd
