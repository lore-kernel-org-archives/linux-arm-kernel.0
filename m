From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Feb 2012 12:45:53 +0000
Subject: RFC: what do we do with system controllers?
In-Reply-To: <CACRpkdY1W-RGE0JL4Sx5UcPY-EGieu8vo7H0fp9xyXtegpaaKw@mail.gmail.com>
References: <CACRpkdY1W-RGE0JL4Sx5UcPY-EGieu8vo7H0fp9xyXtegpaaKw@mail.gmail.com>
Message-ID: <201202291245.54038.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 February 2012, Linus Walleij wrote:

> 
> * Reset or shut down the system
> * Reset individual ASIC blocks
> * Control some core voltage domains
> * Control system frequency
> * Select clocking of indvidual ASIC IP blocks:
> * Provide some versioning numbers for the entire system
> * Enable and reset external buses such as PCI
> * (De)protect flash memory
> * Provide a communication channel to another control unit
> * Set some clock divisors for misc units
> * LEDs, GPIO etc communication channel
> * USB transciever control:
> * Get OTP (one-time-programmable) bits:
> * Set up DDR control registers:
> * Pin control:

Nice list, thanks for putting that together.

> The current way to split this problem is to:
> 
> - Push each subfunctionality into a specialized subsystem
>   PLL and clocks to drivers/clk using the new framework
>   RealSoonNow for example, pin control we have in place
>   regulators can handle domain switches...
> 
> - Put in place an arbitration hub-like mechanism using MFD

Right.

> This can be done in two ways:
> 
> - Permanently map the register range and let subdrivers
>   poke directly into the registers they're interested in.
> 
> - Map the register range in a hub driver (often MFD) and
>   write accessor functions for all subfunctionality.

Generally, I would always prefer the second of these ways,
because it allows one to keep the necessary locking local to
the implementation of the system controller driver.

> As far as the drivers are small and nice the heterogeneous
> character of these device register ranges are not much
> of a problem. Some will argue to not fix what ain't broken
> and not move these out of arch/arm/* at all.

That argument certainly has its merits, after all the way that
the system controller works is one of the central aspects
of a platform/subarchitecture.

> What we need to discuss is if this is how we go about
> taking care of these devices going forward - what shall be
> the preferred design pattern?
> 
> My current assumption is that we need to get these things
> out of arch/arm/* and into proper subsystems, using
> drivers/mfd/* as an arbitration point. However I am not
> sure that everyone really agrees on this. Right now it's
> more a modus operandi and following what someone else
> does than a conscious decision to do this.
> 
> We have discussed creating drivers/scm/* (system controller
> modules) but I'm pretty unsure of what the definition of
> such creatures would be, and the border toward MFD
> would be pretty blurred.

Agreed.

> x86 have conveniently put some of their equivalents under
> drivers/platform/x86 but if I understood Arnd correctly
> creating drivers/platform/arm would break the intentions
> of that directory.

The problem I have with using drivers/platform for this is that
it encourages grouping of drivers by their host-side connection
rather than by their functionality. We're moving away from
that model in most other places in the kernel, and we should
try to discourage it for new code. The drivers/platform/x86
directory contains stuff like rfkill, input, backlight, etc
drivers, all of which have (or should have) other places for
them to live in already.

I don't mind having a new location for system controllers
outside of (or below) drivers/mfd, but I would try to avoid
naming it "platform" because I fear that leads people to stuff
all sorts of drivers in there because they happen to be
implemented as 'platform_driver'.

	Arnd
