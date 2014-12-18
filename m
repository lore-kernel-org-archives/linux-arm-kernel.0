From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Dec 2014 10:15:24 +0100
Subject: [PATCH 5/8] watchdog: bindings: Provide ST bindings for ST's LPC
 Watchdog device
In-Reply-To: <20141218090404.GU13885@x1>
References: <1418834727-1602-1-git-send-email-lee.jones@linaro.org>
 <2894129.AmAkgPJPNf@wuerfel> <20141218090404.GU13885@x1>
Message-ID: <1554161.vPuSVrZM0j@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 December 2014 09:04:04 Lee Jones wrote:
> We 
> On Thu, 18 Dec 2014, Arnd Bergmann wrote:
> 
> > On Thursday 18 December 2014 08:13:34 Lee Jones wrote:
> > > On Wed, 17 Dec 2014, Arnd Bergmann wrote:
> > > 
> > > > On Wednesday 17 December 2014 16:45:24 Lee Jones wrote:
> > > > > +- compatible   : Must be one of: "st,stih407-lpc" "st,stih416-lpc"
> > > > > +                                 "st,stih415-lpc" "st,stid127-lpc"
> > > > > +- reg          : LPC registers base address + size
> > > > > +- interrupts    : LPC interrupt line number and associated flags
> > > > > +- clocks       : Clock used by LPC device (See: ../clock/clock-bindings.txt)
> > > > > +- st,lpc-mode  : The LPC can run either one of two modes ST_LPC_MODE_RTC [0] or
> > > > > +                 ST_LPC_MODE_WDT [1].  One (and only one) mode must be
> > > > > +                 selected.
> > > > > 
> > > > 
> > > > I'm glad you got it to work with two drivers for the same device.
> > > > 
> > > > With this binding, I'm still a bit unhappy about the st,lpc-mode property,
> > > > in particular since you rely on a shared include file for something that
> > > > can only be set in one way or another and always has to be present.
> > > > 
> > > > Why not just use a boolean property that enforces one mode when present
> > > > and another mode when absent?
> > > 
> > > There is nothing stopping me from doing that, and it was a
> > > consideration.  I concluded that this method would be more explicit
> > > however.  Both when describing our choices in DT and at a functional
> > > level within each of the drivers.
> > > 
> > > Let me know if you fundamentally disagree and I can fix-up.
> > 
> > I generally don't like  header files that define interfaces between C code
> > and DT nodes. There are cases where it's the least ugly solution, but I don't
> > think this is one of them.
> > 
> > If you want to be more explicit about the modes, how about having one
> > boolean property per mode? That would also allow devices that could be
> > driven in either mode, e.g. if you have only one instance of this device.
> 
> Isn't this was you suggested above?

My first suggestion was to just have one boolean property, and use one
driver if that is absent. The second one was to have two (or three) separate
boolean properties that each refer to whether a particular driver is allowed
to use this device or not.

> But as I briefly mentioned to you elsewhere, there are actually 3
> devices (Watchdog, RTC and Global Timer).  How would you like to
> handle that with a Boolean property when we introduce this new driver?

Right, this would require having more than one property, but I still think
it's better than the header file.

	Arnd
