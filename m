From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 5 Dec 2013 01:20:48 -0800
Subject: [PATCH 0/4] mtd: spi-nor: add a new framework for SPI NOR
In-Reply-To: <20131205075901.GA20407@shlinux2.ap.freescale.net>
References: <1385447575-23773-1-git-send-email-b32955@freescale.com>
 <20131127043253.GA9468@ld-irv-0074.broadcom.com>
 <5298AA23.7080404@st.com>
 <1386082273.18201.61.camel@shinybook.infradead.org>
 <20131204184405.GE9468@ld-irv-0074.broadcom.com>
 <20131205071224.GA8936@shlinux2.ap.freescale.net>
 <20131205081101.GA4636@norris.computersforpeace.net>
 <20131205075901.GA20407@shlinux2.ap.freescale.net>
Message-ID: <20131205092048.GE4636@norris.computersforpeace.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 05, 2013 at 03:59:02PM +0800, Huang Shijie wrote:
> On Thu, Dec 05, 2013 at 12:11:01AM -0800, Brian Norris wrote:
> > On Thu, Dec 05, 2013 at 03:12:25PM +0800, Huang Shijie wrote:
> > > On Wed, Dec 04, 2013 at 10:44:05AM -0800, Brian Norris wrote:
> > > > 
> > > > I mostly bring this up, though, because it is an example of hardware
> > > > that
> > > > 
> > > >    (a) can operate as a true SPI device (hardware (1) can handle generic
> > > >        SPI transfers), but
> > > >    (b) requires knowledge of the details of SPI flash in order to get
> > > >        optimal usage out of the acceleration from (2).
> > > > 
> > > > In my book, point (a) and (b) hold some bearing over the question of
> > > > "where should this SPI NOR framework live", because it is reasonable
> > > > that a single driver for this hardware should be able to handle either
> > > > true SPI devices or accelerated SPI-NOR flash.
> > > 
> > > We have add a @read_id hook for the spi-nor layer, you can use it to read out
> > > more info (such as the Device Geometry Definition) for your spi-nor controller driver.
> > > 
> > > Is it okay?
> > 
> > I'm not sure which @read_id hook you're talking about, as I've only
> > skimmed the most recent thread, and it's not in the last patch series I
> > have from you, I don't think. But that is not a response at all to the
> > points I brought up. My statements have nothing to do with device
> > geometry detection.
> 
> My meaning is You can write a new driver for the (b) with the new spi-nor layer,

Yes, I can do that.

> In the new driver you can implement the @read_id yourself, and read out the
> the necessary info, and implement other hooks for the so-called peculiarities.

Without giving a full judgment on the framework yet (I haven't followed
as closely as I'd like), I expect that the SPI NOR API will cover the
needs of my SPI NOR hardware.

> > 
> > What I was actually addressing:
> > 
> > Your framework aligns with Mark's original suggestion: that the "SPI
> > NOR" framework should be a separate layer held entirely within the MTD
> > subsystem, and that any given driver is *either* a "SPI NOR" driver *or*
> > a "true SPI" driver, not both.
> You can only use a SPI-NOR driver, and you can abandon the "true SPI" driver.
> 
> Is there some limits that prevent we just code a SPI-NOR driver for your hardware?

SPI is not used only for SPI NOR; it is useful for other things, like
communicating with off-chip peripherals or microcontrollers, supporting
touchscreens, LEDs, media controllers, etc. So with a SPI NOR framework
living only in the MTD subsystem, I have to write two drivers: one
(under drivers/spi/) to use only-(a) for controlling non-flash SPI
devices, and one (under drivers/mtd/) to manage (a)+(b) on SPI NOR
flash.

If, however, we can define a spi_nor_transfer like Angus suggested, and
if we take that a step further and make it a first-class (but optional)
citizen of the SPI framework, then we could have drivers that support
SPI-only, SPI-NOR-only, or both.

Now, I'm not sure how exactly that sort of proposal would work yet, but
I wanted to test the waters to see
  - if this is a complete distortion of what Angus or David may have
    suggested;
  - if Mark thinks this is reasonable, or if he thinks I'm spouting
    nonsense; and
  - if there is some obvious alternate way to support what I describe
    without moving the SPI-NOR layer into the SPI subsystem.

Brian
