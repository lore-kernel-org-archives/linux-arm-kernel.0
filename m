From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Mar 2015 12:20:12 +0000
Subject: [PATCH] net: smc91x: improve neponset hack
In-Reply-To: <5754481.gFE9BvLjh0@wuerfel>
References: <5763365.j5Nvv4LgM3@wuerfel>
 <20150219003549.GY8656@n2100.arm.linux.org.uk>
 <5754481.gFE9BvLjh0@wuerfel>
Message-ID: <20150309122012.GJ8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 20, 2015 at 04:47:06PM +0100, Arnd Bergmann wrote:
> On Thursday 19 February 2015 00:35:49 Russell King - ARM Linux wrote:
> > On Wed, Feb 18, 2015 at 08:47:30PM +0100, Arnd Bergmann wrote:
> > > The smc91x driver tries to support multiple platforms at compile
> > > time, but they are mutually exclusive at runtime, and not clearly
> > > defined.
> > 
> > I'd prefer to rework this to fix that properly.  From what I remember,
> > the whole SA11x0 stuff in this driver was a mess.
> 
> I guess that's reasonable. I've looked through the driver and it seems we
> did most of the multiplatform work but left a few things alone that should
> have been converted a long time ago.
> 
> Can you check if the approach below makes sense to you?

I don't know who's carrying what patches, but this is still broken.

arch/arm/mach-sa1100/neponset.c: In function 'neponset_probe':
arch/arm/mach-sa1100/neponset.c:271:12: error: 'smc91c_platdata' undeclared (first use in this function)
drivers/net/ethernet/smsc/smc91x.c: In function 'smc_drv_probe':
drivers/net/ethernet/smsc/smc91x.c:2363:2: error: implicit declaration of function 'machine_has_neponset' [-Werror=implicit-function-declaration]

This is from building Linus' tree as of Saturday plus arm-soc.

Let's revert all this crap and start again, this time testing it better?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
