From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Feb 2017 17:43:11 +0000
Subject: [RFC] ARM: l2c:  Adding L310_AUX_CTRL_FULL_LINE_ZERO broke my
 system
In-Reply-To: <SG2PR06MB11657BAF8CFC0BCA9D07D0648A4D0@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <SG2PR06MB11657BAF8CFC0BCA9D07D0648A4D0@SG2PR06MB1165.apcprd06.prod.outlook.com>
Message-ID: <20170201174310.GO27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2017 at 03:57:26PM +0000, Chris Brandt wrote:
> It basically boils down to these lines in the commit:
> 
> +		if (!(aux & L310_AUX_CTRL_FULL_LINE_ZERO) && !outer_cache.write_sec) {
> +			aux |= L310_AUX_CTRL_FULL_LINE_ZERO;
> +			pr_info("L2C-310 full line of zeros enabled for Cortex-A9\n");
> +		}

... which is correct.  It's saying

"If this is a Cortex-A9, FLZ was not enabled, and write_sec function is
not present, then enable FLZ.

> As reference, going into this line I have the following variable values:
> 
>   acr = 0x00000000
>   aux = 0x42020000
>   aux_cur = 0x00000000
>   outer_cache.write_sec = (null)
> 
> Also as reference from cache-l2x0.h:
> 
> #define L310_AUX_CTRL_FULL_LINE_ZERO            BIT(0)  /* R2P0+ */

Which is probably what everyone has.  This is not a feature that can be
enabled by the boot loader or firmware, it can only be done once the MMU
and caches are up and running.

> According to the PL310 documentation:
> 
> Full line of zero write
>  
> To enable this feature, perform the following steps:
> 1. enable Full line of zero feature in the L2C-310
> 2. turn on L2C-310
> 3. enable Full line of zero feature in A9.

... which we follow.

> However, in the code snippet from the patch, the "!" in the if statement
> is saying:
> 
>   "if you didn't want this feature, then we are turning it on"

No.  There's no "want this feature".  The bit is almost certainly
guaranteed to be zero there - the bit isn't there to request the
feature.

> Of course changing this line to the following works fine because zero fill
> will not get enabled.
> 
> +		if (aux & L310_AUX_CTRL_FULL_LINE_ZERO && !outer_cache.write_sec) {
> +			aux |= L310_AUX_CTRL_FULL_LINE_ZERO;
> +			pr_info("L2C-310 full line of zeros enabled for Cortex-A9\n");
> +		}

And so results with it always being off everywhere.

> So here's my questions:
> 
> (1) I see that the PL310 is enabled on multiple platforms, so how as this not
> broken any systems since it was introduced in 2014? What am I missing?
> 
> I see that only 2 platforms explicitly set this aux bit (both have CA9):
>   mach-tegra/tegra.c:	.l2c_aux_val	= 0x3c400001,
>   mach-exynos/exynos.c:	.l2c_aux_val	= 0x3c400001,

I think a better question is:

 * Why does enabling FLZ break your system.

It can only be that your system doesn't wire the L2C-310 up to the Cortex
A9 correctly, missing the out-of-band signals that inform the L2C-310 that
the Cortex A9 wants it to zero a full cache line.

BTW, the bit in the auxilary control register merely _enables_ the
reception of that signal at the L2C-310.  If the signal is permanently
deasserted, the L2C-310 does nothing with it, and the bit is a no-op.

Where it does matter is at the Cortex-A9.  That changes the behaviour of
the Cortex-A9 from issuing multiple bus cycles zeroing the cache line
word by word, to merely signalling that it wants the L2C-310 to zero the
cache line.

So, if _merely_ enabling the FLZ bit in the 310's auxiliary control
register _without_ setting the bit in the Cortex-A9 as well leads to
memory corruption, it definitely means the 310 in your SoC is miswired,
and we need a DT property to reflect that.

> (2) Bits 1 and 2 of the Auxiliary Control Register are "L1 Prefetch enable"
> and " L2 Prefetch hint enable". So if I want those enabled, it looks like
> I have to enable full-line-zero, correct?

Prefetching is entirely separate from FLZ.

> It seems the issue on my SoC is that when I enable FULL_LINE_ZERO in the CA9,
> it doesn't seem to work very well.

That will definitely lead to data corruption.  The Cortex-A9 must _never_
have FLZ enabled on the CPU without (a) a compatible L2 cache controller
and (b) the feature _already_ enabled on the L2 cache controller and (c)
the cache controller is correctly wired to the Cortex-A9.

It sounds to me like you have a rare (the only?) system where (c) is
false.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
