From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 24 Feb 2012 07:27:37 +1100
Subject: [PATCH] arm/io.h: add macros to read/write big/little endian
 register
In-Reply-To: <201202231335.04923.arnd@arndb.de>
References: <734349b4b6a4548703c723583d8ee1253184df37.1329988640.git.viresh.kumar@st.com>
 <201202231233.05622.arnd@arndb.de>
 <20120223125044.GW22562@n2100.arm.linux.org.uk>
 <201202231335.04923.arnd@arndb.de>
Message-ID: <1330028857.20389.36.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-02-23 at 13:35 +0000, Arnd Bergmann wrote:
> 
> This would mean going through an indirect function call for platforms
> where PCI is fundamentally different in hardware. We already do this
> for CONFIG_PPC_INDIRECT_PCI, but I'd hope we can avoid this on ARM.

On PPC we do it a bit more sneakily using a bit in the address. It
causes the inline accessor to be a big bigger but avoids the cost of the
indirect call for the "normal" case.

> Since devices that can bei either PCI or not are relatively rare, I'd
> rather put them in the same category as those that can either use
> PCI I/O space or some form of memory space and require that the
> drivers use the "I don't care what you are, just do what I want"
> accessors in the ioread/iowrite family that are already going through
> an indirect function call on most architectures.
> 
> Also, the PCI aware readl/writel functions are already more
> heavyweight
> on most architectures (not on x86 though) than we want them to be,
> because they have to do extra synchronizing operations against DMA
> and/or spinlocks on weakly ordered architectures. We now have
> the readl_relaxed family here, but I believe they are only used
> for on-chip components at the moment.

On-chip have the same issue vs. DMA and we wouldn't want the defaults to
let them leak out of locks etc...

Cheers,
Ben.
