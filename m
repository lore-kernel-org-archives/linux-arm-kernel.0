From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Feb 2017 23:16:49 +0000
Subject: [PATCH 06/10] soc/qbman: Add ARM equivalent for
 flush_dcache_range()
In-Reply-To: <123833427.MmK6vFAXzK@wuerfel>
References: <1484779180-1344-1-git-send-email-roy.pledge@nxp.com>
 <CAK8P3a1Gd4bd7GjEp_a9WXc_mTPk0XmP7DH8aPWhbn2K3MMuDQ@mail.gmail.com>
 <20170130151933.GA27312@n2100.armlinux.org.uk>
 <123833427.MmK6vFAXzK@wuerfel>
Message-ID: <20170201231649.GR27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2017 at 01:47:46PM +0100, Arnd Bergmann wrote:
> Ah right, so since there is no interface to map as "device writeback",
> the driver would likely end up with an MMIO register in a
> "normal writeback", with these properties (among others listed there):

It's not about there being no _interface_, there's no support in the
architecture for it.  The use of the "device" memory type does not
allow for any form of cache hints to be specified.

>  * - writes can be repeated (in certain cases) with no side effects
>  * - writes can be merged before accessing the target
>  * - unaligned accesses can be supported
>  * - ordering is not guaranteed without explicit dependencies or barrier
>  *   instructions
>  * - writes may be delayed before they hit the endpoint memory
> 
> I think the ordering is the most critical here, as IIRC the driver
> expects a whole cache line to be written into the MMIO register
> in a single bus cycle specifically when we issue the flush from the
> driver, but we can actually have partial writebacks at any time.

I don't think that's achievable, unless your data bus is as wide as
a cache line (iow, for a 32-byte cache line, your data bus all the
way to the peripheral would need to be 256 bits wide to write the
cache line in a single bus cycle.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
