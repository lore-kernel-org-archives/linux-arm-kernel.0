From: greg@kroah.com (Greg KH)
Date: Mon, 26 Oct 2009 09:58:52 -0700
Subject: [WARNING] pxamci: 'pxa2xx-mci.0' does not have a release()
	function.
In-Reply-To: <20091023101806.GB19437@n2100.arm.linux.org.uk>
References: <20091023003631.1331a60a.ospite@studenti.unina.it>
	<20091022225758.GA9106@n2100.arm.linux.org.uk>
	<20091023115028.59ed7f74.ospite@studenti.unina.it>
	<20091023101806.GB19437@n2100.arm.linux.org.uk>
Message-ID: <20091026165852.GC18218@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 23, 2009 at 11:18:06AM +0100, Russell King - ARM Linux wrote:
> On Fri, Oct 23, 2009 at 11:50:28AM +0200, Antonio Ospite wrote:
> > On Thu, 22 Oct 2009 23:57:58 +0100
> > Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > 
> > > On Fri, Oct 23, 2009 at 12:36:31AM +0200, Antonio Ospite wrote:
> > > > Hi,
> > > > 
> > > > I get this warning on shutdown. How to fix it properly?
> > > > 
> > > > FYI, in my setup pxa2xx_spi is the parent for pxamci, set using
> > > > this patch:
> > > > http://git.openezx.org/openezx.git?a=commitdiff;h=0ffd85ad8faea3456d4ecf5f63ae65aca26fff21
> > > 
> > > This sounds like it's the cause of the problem - from the backtrace, it
> > > looks like SPI expects the children of the SPI device to be its own
> > > responsibility to maintain.
> > > 
> > > Hence, because you've made pxamci a child of SPI, SPI is trying to
> > > unregister and release the pxamci device.
> > 
> > A little more background: we need pxamci to be a child of SPI because
> > our PMIC is connected via SPI, and a PMIC regulator is used for mmc
> > powering; enforcing this hierarchy is needed to make pxamci suspend and
> > resume properly.
> 
> I don't think this is the right solution - and I don't know what the
> right solution would be given that the interfaces I suspect you need
> aren't public.
> 
> I don't think you can reverse the order of SPI and MMC initialization
> because that'd mean MMC could try to use SPI before it exists.
> 
> Maybe the right answer is for SPI to stop thinking it owns all child
> devices, and only unregister devices which it owns (iow, are of some
> SPI bus-type.)
> 
> Adding Greg for comment.

Um, why not ask the SPI maintainer?  I don't know what the SPI code is
doing, sorry.

thanks,

greg k-h
