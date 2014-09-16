From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Tue, 16 Sep 2014 17:23:55 +0530
Subject: [PATCH v2] mfd: syscon: Decouple syscon interface from platform
 devices
In-Reply-To: <20140905101409.68b14cc3@bbrezillon>
References: <1409668935-10667-1-git-send-email-pankaj.dubey@samsung.com>
 <6034841.GFrG3XCMdb@wuerfel> <20140903151611.260a7218@bbrezillon>
 <4224773.hl3QDeILqz@wuerfel> <20140903161528.05f566e1@bbrezillon>
 <002701cfc7fb$110a7350$331f59f0$@samsung.com>
 <20140905101409.68b14cc3@bbrezillon>
Message-ID: <000b01cfd1a4$f5ae0d20$e10a2760$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,  Lee Jones,


[snip]
> 
> On Thu, 04 Sep 2014 10:15:27 +0530
> Pankaj Dubey <pankaj.dubey@samsung.com> wrote:
> 
> > Hi Boris,
> >
> > On Wednesday, September 03, 2014 Boris BREZILLON wrote,
> > > To: Arnd Bergmann
> > > Cc: Pankaj Dubey; kgene.kim at samsung.com; linux at arm.linux.org.uk;
> > > Alexander Shiyan; naushad at samsung.com; Tomasz Figa;
> > > linux-kernel at vger.kernel.org; joshi at samsung.com;
> > > linux-samsung-soc at vger.kernel.org;
> > thomas.ab at samsung.com;
> > > tomasz.figa at gmail.com; vikas.sajjan at samsung.com;
> > > chow.kim at samsung.com; lee.jones at linaro.org; Michal Simek;
> > > linux-arm-kernel at lists.infradead.org;
> > Mark
> > > Brown
> > > Subject: Re: [PATCH v2] mfd: syscon: Decouple syscon interface from
> > platform
> > > devices
> > >
> > > On Wed, 03 Sep 2014 15:49:04 +0200
> > > Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > > On Wednesday 03 September 2014 15:16:11 Boris BREZILLON wrote:
> > > > > I checked that part, and it appears most of the code is already
> > > > > there (see usage of regmap_attach_dev function here [1]).
> > > > >
> > > > > The only problem I see is that errors are still printed with
> > > > > dev_err, which, AFAIK, will trigger a kernel panic if dev is NULL.
> > > >
> > > > Actually not:
> > > >
> > > > static int __dev_printk(const char *level, const struct device *dev,
> > > >                         struct va_format *vaf) {
> > > >         if (!dev)
> > > >                 return printk("%s(NULL device *): %pV", level,
> > > > vaf);
> > > >
> > > >         return dev_printk_emit(level[1] - '0', dev,
> > > >                                "%s %s: %pV",
> > > >                                dev_driver_string(dev),
> > > > dev_name(dev), vaf); }
> > > >
> > >
> > > My bad then (I don't know where I looked at to think NULL dev was
> > > not
> > gracefully
> > > handled :-)). Thanks for pointing this out.
> > > Given that, I think it should work fine even with a NULL dev.
> > > I'll give it a try on at91 ;-).
> > >
> >
> > We have tested this patch, on Exynos board and found working well.
> > In our use case DT based drivers such as USB Phy, SATA Phy, Watchdog
> > are calling syscon_regmap_lookup_by APIs to get regmap handle to
> > Exynos PMU and it worked well for these drivers.
> >
> > It would be great if after testing you share result here or give a
> > Tested-By.
> >
> 
> I eventually tested it (just required minor modifications to my PMC
> code: see below).
> Still, this patch is not achieving my final goal which is to remove the
global
> at91_pmc_base variable and make use of the syscon regmap to implement at91
cpu
> idle and platform suspend.
> Moreover, I'd like to remove the lock in at91_pmc struct as regmap is
already taking
> care of locking the resources when accessing a register, but this requires
a lot more
> changes.
> 
> Anyway, here is my
> 
> Tested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> 

Any update on this patch. As already it has been tested on two DT based
platforms.

If you think that we can go ahead and break clps711x till it gets migrated
over DT,
then please ack this patch, or else if you have opinion to keep support for
non-DT
based drivers (clps711x) then I can post another patch keeping platform
driver support
for non-DT based platform. 

I would prefer is to keep platform driver support for non-DT based platform
so that this patch set can go in this merge window, as lot of Exynos PMU
patches
(PMU patches of many Exynos SoCs [2,3,4] ) are critically dependent on this
change. 

As per discussion here [1], clps711x SPI and TTY driver patches still has to
be posted
which may take one more merge window, and eventually will drag this patch
also.

[1]:
https://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg36291.html
[2]:
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/275675.html
[3]:
https://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg35701.html
[4]: http://www.spinics.net/lists/arm-kernel/msg358230.html


> 
> 
[snip]

Thanks,
Pankaj Dubey
