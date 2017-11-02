From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Nov 2017 13:07:34 +0000
Subject: [PATCH] ARM: NOMMU: work around maybe-uninitialized warning
In-Reply-To: <681a1757-ddbe-c9a7-6945-fa72600cf172@arm.com>
References: <20171102092155.737712-1-arnd@arndb.de>
 <681a1757-ddbe-c9a7-6945-fa72600cf172@arm.com>
Message-ID: <20171102130734.GZ9463@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 02, 2017 at 12:25:47PM +0000, Vladimir Murzin wrote:
> On 02/11/17 09:21, Arnd Bergmann wrote:
> > The reworked MPU code produces a new warning in some configurations,
> > presumably starting with the code move after the compiler now makes
> > different inlining decisions:
> > 
> > arch/arm/mm/pmsa-v7.c: In function 'adjust_lowmem_bounds_mpu':
> > arch/arm/mm/pmsa-v7.c:310:5: error: 'specified_mem_size' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> > 
> > This appears to be harmless, as we know that there is always at
> > least one memblock, and the only way this could get triggered is
> > if the for_each_memblock() loop was never entered.
> > 
> > I could not come up with a better workaround than initializing
> > the specified_mem_size to zero, but at least that is the value
> > that the variable would have in the hypothetical case of no
> > memblocks.
> > 
> > Fixes: 877ec119dbbf ("ARM: 8706/1: NOMMU: Move out MPU setup in separate module")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > Vladimir, if this looks good to you, can you forward it to Russell's
> > patch tracker, or otherwise suggest a different fix?
> 
> Accepted as patch 8719/1. Not sure if Russell will pick it up or not... anyway,
> thanks for the patch!

I'd prefer not to at this stage.  Same things that apply that I said
in the "ARM: early_printk: use printascii() rather than printch()"
thread - I need to ensure that what I have is stable before 4.14 is
released, so I'm not accepting anything further unless it is _really_
urgent.

This isn't urgent.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
