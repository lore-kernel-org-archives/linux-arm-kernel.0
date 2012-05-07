From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 7 May 2012 16:02:52 +0200
Subject: [PATCH 1/2] mfd: max8925: request resource region
In-Reply-To: <201205071319.48768.arnd@arndb.de>
References: <1336360249-29963-1-git-send-email-haojian.zhuang@gmail.com>
 <201205071121.53302.arnd@arndb.de>
 <20120507112956.GJ4415@opensource.wolfsonmicro.com>
 <201205071319.48768.arnd@arndb.de>
Message-ID: <20120507140252.GB25020@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Mon, May 07, 2012 at 01:19:48PM +0000, Arnd Bergmann wrote:
> On Monday 07 May 2012, Mark Brown wrote:
> > On Mon, May 07, 2012 at 11:21:53AM +0000, Arnd Bergmann wrote:
> > 
> > > Can you explain why you need this kind of arbitration to start with?
> > > Can't you just ensure that each client of the max8925 only sees a fixed
> > > set of nonconflicting registers, and provide a higher-level abstractions
> > > for the registers that are indeed shared between clients?
> > 
> > This is nothing to do with arbitration or sharing.  It's for the case
> > where you have a set of IP blocks on the chip (and possibly over a
> > series of different chips) all with the same register map within the IP
> > block - you need a way to tell the function driver for the IP block
> > where it is in the chip register map.  A similar thing happens (without
> > issue) for the interrupts within the chip.
> > 
> > You'd never expect any collisions to need arbitrating, it's purely about
> > telling the function driver where to find the IP without having to open
> > code this.  Anything which is actually shared would be handled in the
> > MFD core for the device normally, or with some other API like genirq.
> 
> The patch that we are discussing adds a call to 'request_region' --
> that is the arbitration interface and that is what is causing the
> conflicts.
> 
> Using a 'struct resource' of type IORESOURCE_IO to pass information
> about non-PIO registers to child devices is inconsistent, ugly and
> confusing, but I agree it doesn't actually result in bugs. The problems
> start when you use those resources in combination with request_region,
> request_resource and ioport_map.
I agree with the latter and decided to not push this patch forward.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
