From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 20 Jun 2012 17:46:17 +0200
Subject: [PATCH] ARM: Orion5x - Restore parts of io.h
In-Reply-To: <201206201514.37618.arnd@arndb.de>
References: <1340172410-11229-1-git-send-email-andrew@lunn.ch>
 <201206201514.37618.arnd@arndb.de>
Message-ID: <20120620154617.GU4799@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2012 at 03:14:37PM +0000, Arnd Bergmann wrote:
> On Wednesday 20 June 2012, Andrew Lunn wrote:
> > Commit 4d5fc58dbe34b78157c05b319669bb3e064ba8bd remove the orion5x
> > io.h. Unfortunetely, this is still needed for the definition of
> > IO_SPACE_LIMIT which overrides the default 64K. All Orion based
> > systems have 1Mbyte of IO space per PCI[e] bus, and try to
> > request_resource() this size.
> 
> > diff --git a/arch/arm/mach-orion5x/include/mach/io.h b/arch/arm/mach-orion5x/include/mach/io.h
> > new file mode 100644
> > index 0000000..f017fe2
> > --- /dev/null
> > +++ b/arch/arm/mach-orion5x/include/mach/io.h
> > @@ -0,0 +1,14 @@
> > +/*
> > + * arch/arm/mach-orion5x/include/mach/io.h
> > + *
> > + * This file is licensed under the terms of the GNU General Public
> > + * License version 2.  This program is licensed "as is" without any
> > + * warranty of any kind, whether express or implied.
> > + */
> > +
> > +#ifndef __ASM_ARCH_IO_H
> > +#define __ASM_ARCH_IO_H
> > +
> > +#define IO_SPACE_LIMIT		0xffffffff
> > +#define __io(a)			__typesafe_io(a)
> > +#endif
> 
> So if you need 1 MB per bus, why do you make the limit 4GB? Also,
> the __io function does not actually point to the IO window at all,
> which also appears to be horribly wrong.
> 
> My guess is that you actually want this to be
> 
> #define IO_SPACE_LIMIT SZ_2MB
> #define __io(a)	((void __iomem *)ORION5X_PCI_IO_VIRT_BASE + a)
> 
> Your patch otherwise would make the kernel build again, but has
> no chance of doing the right thing.

My patch simply puts back what was removed. Please see:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commitdiff;h=4d5fc58dbe34b78157c05b319669bb3e064ba8bd#patch20

It was probably broken before. It is probably broken now. It probably
never did the right thing. However, we don't have any hardware to test
with and we think it is probably never used in real life.

Is it worth doing more than putting back the original code?

   Andrew
