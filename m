From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 12 Dec 2010 08:41:36 +0000
Subject: [PATCH] dw_mmc: Add Synopsys DesignWare mmc host driver.
In-Reply-To: <20101211192320.GA24430@void.printf.net>
References: <AANLkTi=0RtvsGX+Q3goL3mdG6oKeNidYtiudTZ8ZTpRP@mail.gmail.com>
	<20101208115510.GD10998@console-pimps.org>
	<AANLkTi=KqOa-MRQiptCtZGvoafRCgULfE3QFs=hmGpdi@mail.gmail.com>
	<AANLkTi=PpTi1_JO9Q=ph7w9Jim8iXMf9LbCfmEkWuo-h@mail.gmail.com>
	<20101209064751.GA21128@void.printf.net>
	<AANLkTimMgrawcndvUTYYjq9BGFqs-sbRsZkwVQ0Uvhvb@mail.gmail.com>
	<20101209160157.GA28586@void.printf.net>
	<AANLkTim3Rj2tTbqvT8nM4L=p=Wx8bdOnGq=EDv+cs02g@mail.gmail.com>
	<20101211192320.GA24430@void.printf.net>
Message-ID: <20101212084135.GC8665@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 11, 2010 at 07:23:20PM +0000, Chris Ball wrote:
> Hi Will,
> 
> On Thu, Dec 09, 2010 at 05:24:26PM +0000, Will Newton wrote:
> > This adds the mmc host driver for the Synopsys DesignWare mmc
> > host controller, found in a number of embedded SoC designs.
> > 
> > Signed-off-by: Will Newton <will.newton@imgtec.com>
> > Reviewed-by: Matt Fleming <matt@console-pimps.org>
> 
> Running a test build on ARM fails:
> 
> drivers/mmc/host/dw_mmc.c: In function ?dw_mci_push_data64?:
> drivers/mmc/host/dw_mmc.c:985: error: implicit declaration of function ?__raw_writeq?
> drivers/mmc/host/dw_mmc.c: In function ?dw_mci_pull_data64?:
> drivers/mmc/host/dw_mmc.c:998: error: implicit declaration of function ?__raw_readq?
> 
> because arch/arm doesn't implement raw versions of these 64-bit accesses.
> I'm surprised that this driver hasn't been compiled on ARM before!  What
> kind of arch are you testing on?  Do you have any ARM hardware (lpc313x?)
> to verify the driver on?

What's the semantics of a 64-bit IO access?  Does the low 32-bit get
written before the high 32-bit, or is it the other way around?  Does
it depend on the endian-ness?  What if some hardware needs the low
32-bit first and other needs the high 32-bit first?

I don't think it's reasonable to expect 32-bit hardware to perform 64-bit
IO accesses.
