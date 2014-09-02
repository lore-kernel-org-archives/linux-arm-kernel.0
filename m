From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Tue, 02 Sep 2014 19:42:52 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2Ml0gbWZkOiBzeXNjb246IERlY291cGxlIHN5c2NvbiBp?=
 =?UTF-8?B?bnRlcmZhY2UgZnJvbSBwbGF0Zm9ybSBkZXZpY2Vz?=
In-Reply-To: <6034841.GFrG3XCMdb@wuerfel>
References: <1409668935-10667-1-git-send-email-pankaj.dubey@samsung.com>
 <6034841.GFrG3XCMdb@wuerfel>
Message-ID: <1409672572.303525842@f75.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tue, 02 Sep 2014 17:20:03 +0200 ?? Arnd Bergmann <arnd@arndb.de>:
> On Tuesday 02 September 2014 20:12:15 Pankaj Dubey wrote:
> > Currently a syscon entity can only be registered directly through a
> > platform device that binds to a dedicated syscon driver. However in
> > certain cases it is required to bind a device with it's dedicated
> > driver rather than binding with syscon driver.
> > 
> > For example, certain SoCs (e.g. Exynos) contain system controller
> > blocks which perform various functions such as power domain control,
> > CPU power management, low power mode control, but in addition contain
> > certain IP integration glue, such as various signal masks,
> > coprocessor power control, etc. In such case, there is a need to have
> > a dedicated driver for such system controller but also share registers
> > with other drivers. The latter is where the syscon interface is helpful.
> > 
> > This patch decouples syscon object from syscon platform driver, and
> > allows to create syscon objects first time when it is required by
> > calling of syscon_regmap_lookup_by APIs and keeps a list of such syscon
> > objects along with syscon provider device_nodes and regmap handles.
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
> Note that you got the Signed-off-by: list wrong, you should never have
> any people listed as Signed-off-by after your own name, and they should
> be listed before your name only when you are forwarding their patches.
> 
> > Note: Current kernel has clps711x user of syscon_regmap_lookup_by_pdevname and 
> > will be broken after this patch. As per discussion over here [1], patches 
> > for making these drivers DT based are ready and once that is done they can use
> > syscon_regmap_lookup_by_phandle or syscon_regmap_lookup_by_compatible.
> > 
> > [1]: https://lkml.org/lkml/2014/8/22/81
...
> > -struct regmap *syscon_regmap_lookup_by_pdevname(const char *s)
> > -{
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
> It could be done in a hacky way using bus_find_device_by_name()
> to keep it simple, or in a somewhat nicer way by keeping the 
> syscon platform_driver around for the non-DT case.

It will not work anyway because the patch involves the use of
of_device_is_compatible(), of_iomap() etc...

---
