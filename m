From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 18 Dec 2014 09:28:44 +0000
Subject: [PATCH 5/8] watchdog: bindings: Provide ST bindings for ST's LPC
 Watchdog device
In-Reply-To: <1554161.vPuSVrZM0j@wuerfel>
References: <1418834727-1602-1-git-send-email-lee.jones@linaro.org>
 <2894129.AmAkgPJPNf@wuerfel> <20141218090404.GU13885@x1>
 <1554161.vPuSVrZM0j@wuerfel>
Message-ID: <20141218092844.GB4525@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Dec 2014, Arnd Bergmann wrote:

> On Thursday 18 December 2014 09:04:04 Lee Jones wrote:
> > We 
> > On Thu, 18 Dec 2014, Arnd Bergmann wrote:
> > 
> > > On Thursday 18 December 2014 08:13:34 Lee Jones wrote:
> > > > On Wed, 17 Dec 2014, Arnd Bergmann wrote:
> > > > 
> > > > > On Wednesday 17 December 2014 16:45:24 Lee Jones wrote:
> > > > > > +- compatible   : Must be one of: "st,stih407-lpc" "st,stih416-lpc"
> > > > > > +                                 "st,stih415-lpc" "st,stid127-lpc"
> > > > > > +- reg          : LPC registers base address + size
> > > > > > +- interrupts    : LPC interrupt line number and associated flags
> > > > > > +- clocks       : Clock used by LPC device (See: ../clock/clock-bindings.txt)
> > > > > > +- st,lpc-mode  : The LPC can run either one of two modes ST_LPC_MODE_RTC [0] or
> > > > > > +                 ST_LPC_MODE_WDT [1].  One (and only one) mode must be
> > > > > > +                 selected.
> > > > > > 
> > > > > 
> > > > > I'm glad you got it to work with two drivers for the same device.
> > > > > 
> > > > > With this binding, I'm still a bit unhappy about the st,lpc-mode property,
> > > > > in particular since you rely on a shared include file for something that
> > > > > can only be set in one way or another and always has to be present.
> > > > > 
> > > > > Why not just use a boolean property that enforces one mode when present
> > > > > and another mode when absent?
> > > > 
> > > > There is nothing stopping me from doing that, and it was a
> > > > consideration.  I concluded that this method would be more explicit
> > > > however.  Both when describing our choices in DT and at a functional
> > > > level within each of the drivers.
> > > > 
> > > > Let me know if you fundamentally disagree and I can fix-up.
> > > 
> > > I generally don't like  header files that define interfaces between C code
> > > and DT nodes. There are cases where it's the least ugly solution, but I don't
> > > think this is one of them.
> > > 
> > > If you want to be more explicit about the modes, how about having one
> > > boolean property per mode? That would also allow devices that could be
> > > driven in either mode, e.g. if you have only one instance of this device.
> > 
> > Isn't this was you suggested above?
> 
> My first suggestion was to just have one boolean property, and use one
> driver if that is absent. The second one was to have two (or three) separate
> boolean properties that each refer to whether a particular driver is allowed
> to use this device or not.
> 
> > But as I briefly mentioned to you elsewhere, there are actually 3
> > devices (Watchdog, RTC and Global Timer).  How would you like to
> > handle that with a Boolean property when we introduce this new driver?
> 
> Right, this would require having more than one property, but I still think
> it's better than the header file.

I'll put my point across just once and then become subservient once
more.  I don't agree that defining 3 properties is better than
creating just 1.  We have lots of properties containing indexes and
flags.  Just because we've decided to #define them in order to read
them easily shouldn't detract from the fact that it's a better setup.

  st,lpc-mode <1|2|3>;

Must be better than:

    st,lpc-globaltimer-mode;
    st,lpc-watchdog-mode;
    st,lpc-rtc-mode;

If each of the drivers only checks for it's own property and fails to
probe if it's not present how will we detect and warn about a lack of
any of the 3 properties without a central, all-knowing (MFD) driver? 

This is likely to cause someone [why isn't my driver probing] issues
and subsequently waste valuable engineering time in the future.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
