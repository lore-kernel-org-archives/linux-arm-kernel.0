From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 19 Aug 2011 14:26:18 +0200
Subject: of_iomap() matched with plan iounmap()
In-Reply-To: <20110818.203447.462383652600224162.davem@davemloft.net>
References: <20110818170226.GA16721@huya.qualcomm.com>
	<20110818.203447.462383652600224162.davem@davemloft.net>
Message-ID: <201108191426.19152.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 19 August 2011, David Miller wrote:
> From: David Brown <davidb@codeaurora.org>
> Date: Thu, 18 Aug 2011 10:02:26 -0700
> 
> > The SPARC target contains of_ioremap() and of_iounmap(), which various
> > drivers use (generally inside of CONFIG_SBUS).
> > 
> > include/linux/of_address.h contains a definition for of_iomap(), but
> > not corresponding unmap call.  Code using this calls the regular
> > iounmap().
> > 
> > Is it safe to assume that of_iomap() will always be based on ioremap()
> > and therefore it is safe to use iounmap(), or would it be better to
> > define another name for drivers to use as the inverse of of_iomap().
> > I'm not sure what to call it, since of_iounmap() is already taken by
> > SPARC.
> 
> It's better to define a matching of_iounmap() interface, even if for
> now it is exactly iounmap()

But the problem is that we need conflicting prototypes for of_iounmap.
Sparc currently has

extern void of_iounmap(struct resource *res, void __iomem *base, unsigned long size);
(as the reverse of of_ioremap)

While we would probably want the generic prototype to be
extern void of_iounmap(void __iomem *base);
(as the reverse of of_iomap)

We could of course change all existing users of of_iounmap on sparc to use
the simpler prototype, because it also just calls iounmap.

	Arnd
