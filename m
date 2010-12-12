From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 12 Dec 2010 14:11:12 +0000
Subject: [PATCH] dw_mmc: Add Synopsys DesignWare mmc host driver.
In-Reply-To: <AANLkTinMYeWNLu8e7xyBTvjmeFMsJ5sDGtsCesu04d4K@mail.gmail.com>
References: <AANLkTi=KqOa-MRQiptCtZGvoafRCgULfE3QFs=hmGpdi@mail.gmail.com>
	<AANLkTi=PpTi1_JO9Q=ph7w9Jim8iXMf9LbCfmEkWuo-h@mail.gmail.com>
	<20101209064751.GA21128@void.printf.net>
	<AANLkTimMgrawcndvUTYYjq9BGFqs-sbRsZkwVQ0Uvhvb@mail.gmail.com>
	<20101209160157.GA28586@void.printf.net>
	<AANLkTim3Rj2tTbqvT8nM4L=p=Wx8bdOnGq=EDv+cs02g@mail.gmail.com>
	<20101211192320.GA24430@void.printf.net>
	<AANLkTin5aVPz5Y=jS89V00XS=rje3gqeUb2VTYt2A_9=@mail.gmail.com>
	<20101212135224.GA31812@void.printf.net>
	<AANLkTinMYeWNLu8e7xyBTvjmeFMsJ5sDGtsCesu04d4K@mail.gmail.com>
Message-ID: <20101212141112.GF8665@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 12, 2010 at 02:03:52PM +0000, Will Newton wrote:
> On Sun, Dec 12, 2010 at 1:52 PM, Chris Ball <cjb@laptop.org> wrote:
> > Hi Will,
> >
> > On Sun, Dec 12, 2010 at 10:57:44AM +0000, Will Newton wrote:
> >> > drivers/mmc/host/dw_mmc.c: In function ?dw_mci_pull_data64?:
> >> > drivers/mmc/host/dw_mmc.c:998: error: implicit declaration of function ?__raw_readq?
> >> >
> >> > because arch/arm doesn't implement raw versions of these 64-bit accesses.
> >> > I'm surprised that this driver hasn't been compiled on ARM before! ?What
> >>
> >> That particular bit of code has been added since it was last built for
> >> arm. Our architecture can do 64bit accesses so we implement readq.
> >> Unfortunately there doesn't seem to be a sane way to conditionalize
> >> code for architectures that have or don't have readq, so I suspect
> >> I'll have to just remove that branch of the if statement for now.
> >
> > (Russell, thanks for the excellent explanation.)
> >
> > Other drivers (MTD, gpio/basic_mmio_gpio.c, fs/fuse, pcm_oss.c)
> > conditionalize uses of {read,write}q on BITS_PER_LONG >= 64, so
> > something like this:
> 
> I don't think that's going to work, BITS_PER_LONG isn't equivalent to
> "can do 64bit IO accesses", at least it isn't on our architecture. x86
> is in the same situation it would appear, although x86 does explicitly
> #define readq so it may be possible to #ifdef on that?

Maybe invent CONFIG_HAVE_MMIO_64BIT which architectures can select as
appropriate?
