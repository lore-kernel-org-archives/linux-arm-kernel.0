From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 01 Sep 2014 17:05:33 +0530
Subject: [PATCH] mfd: syscon: Decouple syscon interface from syscon devices
In-Reply-To: <4121644.3haxjiIdIo@wuerfel>
References: <1408694991-21615-1-git-send-email-pankaj.dubey@samsung.com>
 <20140901074918.GB6226@lee--X1> <4121644.3haxjiIdIo@wuerfel>
Message-ID: <000c01cfc5d9$03866c30$0a934490$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Monday, September 01, 2014 4:07 PM
> To: Lee Jones
> Cc: Pankaj Dubey; linux-arm-kernel at lists.infradead.org; linux-samsung-
> soc at vger.kernel.org; linux-kernel at vger.kernel.org; kgene.kim at samsung.com;
> linux at arm.linux.org.uk; vikas.sajjan at samsung.com; joshi at samsung.com;
> naushad at samsung.com; thomas.ab at samsung.com; chow.kim at samsung.com;
> Tomasz Figa; broonie at kernel.org
> Subject: Re: [PATCH] mfd: syscon: Decouple syscon interface from syscon
devices
> 
> On Monday 01 September 2014 08:49:18 Lee Jones wrote:
> > On Fri, 22 Aug 2014, Pankaj Dubey wrote:
> >
> > > From: Tomasz Figa <t.figa@samsung.com>
> > >
> > > Currently a syscon entity can be only registered directly through a
> > > platform device that binds to a dedicated driver. However in certain
> > > use cases it is desirable to make a device used with another driver
> > > a syscon interface provider. For example, certain SoCs (e.g. Exynos)
> > > contain system controller blocks which perform various functions
> > > such as power domain control, CPU power management, low power mode
> > > control, but in addition contain certain IP integration glue, such
> > > as various signal masks, coprocessor power control, etc. In such
> > > case, there is a need to have a dedicated driver for such system
> > > controller but also share registers with other drivers. The latter
> > > is where the syscon interface is helpful.
> > >
> > > This patch decouples syscon object from syscon driver, so that it
> > > can be registered from any driver in addition to the original
> > > "syscon" platform driver.
> > >
> > > Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> > > Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> > > ---
> > >
> > > RFC patch [1] was posted by Tomasz Figa. This patch addresses some
> > > of comments given by Arnd to RFC patch, and further decouples syscon
> > > from device model. It also gives flexibility of registering with
> > > syscon at early stage using device_node object.
> >
> > It would be helpful if Arnd gave this revision his blessing (Ack).
> 
> I never saw a reason why we don't take this all the way as discussed a few
times:
> Completely remove the dependency of syscon on having a platform driver for
it, and
> make it possible to just call
> syscon_regmap_lookup_by_phandle() without having to register it first.
> 

Please have a look at this thread [1], where we discussed the need of syscon
as platform device.
Looks like still there are users of syscon_regmap_lookup_by_pdevname
(clps711x.c).
So we can't make it completely independent of platform_device. 

[1]
https://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg35708.html


> 	Arnd
