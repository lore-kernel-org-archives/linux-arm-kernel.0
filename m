From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 26 Feb 2012 10:01:49 +0000
Subject: [PATCH v2] USB: Support for LPC32xx SoC
In-Reply-To: <Pine.LNX.4.44L0.1202251033550.4173-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.1202251033550.4173-100000@netrider.rowland.org>
Message-ID: <201202261001.49937.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 25 February 2012, Alan Stern wrote:
> You are talking about two separate issues.  One is the way the various
> bus-glue files get built into the driver, and the other is the way it
> #includes .c files.
> 
> I don't view the second as a big deal.  A few people have complained
> about it, but I don't see the point.  Sure, it has the disadvantage
> that you have to recompile the entire driver any time one of the files
> is changed.
> I can live with that.  It has the advantage that symbols
> shared among the source files can be static; they don't have to get
> merged into the overall kernel namespace when the driver isn't build as
> a module.

Right, I don't really object that part (including .c files), with
conditional includes I was referring to the inclusion of hw-specific
glues into the driver.

> The first issue is more serious.  There are long-term plans to
> restructure both of those drivers so that the bus glue resides in a
> separate module from the main core of the driver.  However I have not
> started to work on that yet; there are other more pressing matters to
> do first.

Ok.

> It doesn't seem extremely urgent.  Things are working the way they are.  
> The main advantage to restructuring is that it would allow distributors
> to build bus glue for multiple platforms in a single distribution
> image.  Currently that's not possible (except that any one of the
> platform glues can be enabled along with the PCI glue).

We are doing a major rework of the ARM architecture tree right now
to allow building multiple SoC platforms together, which has not
been possible traditionally. The "PLATFORM_DRIVER" macro in ohci
and ehci is one of many things standing in the way still and will have
to be dealt with at some point.

> A little progress has been made already.  We just received a submission
> for a "generic" platform bus glue file that will be able to take over
> the jobs of several of the existiing files.  If anyone wants to take
> this further I won't object, but I don't plan to work on it myself
> soon.

Ok, good to know. The approach of a generic glue is exactly what I
was going to suggest. As we get to ARM platforms that are currently
using PLATFORM_DRIVER, I will then ask people to convert the ohci
glue to use that generic glue instead of adding another *_DRIVER
macro to ohci/ehci.

I'm not sure about what we should do for lpc32xx. Is that
generic glue going into v3.4? If so, we could convert the
pnx4008 driver to use that and abstract it in a way that works
nicely for pnx4008 and lpc32xx. OTOH, we might just let this
one go in as before and ask people to do it right for the next
one.

	Arnd
