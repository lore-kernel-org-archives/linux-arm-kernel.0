From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 01 Feb 2017 13:47:46 +0100
Subject: [PATCH 06/10] soc/qbman: Add ARM equivalent for
 flush_dcache_range()
In-Reply-To: <20170130151933.GA27312@n2100.armlinux.org.uk>
References: <1484779180-1344-1-git-send-email-roy.pledge@nxp.com>
 <CAK8P3a1Gd4bd7GjEp_a9WXc_mTPk0XmP7DH8aPWhbn2K3MMuDQ@mail.gmail.com>
 <20170130151933.GA27312@n2100.armlinux.org.uk>
Message-ID: <123833427.MmK6vFAXzK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, January 30, 2017 3:19:33 PM CET Russell King - ARM Linux wrote:
> On Fri, Jan 27, 2017 at 05:41:10PM +0100, Arnd Bergmann wrote:
> > On Thu, Jan 26, 2017 at 6:08 AM, Scott Wood <scott.wood@nxp.com> wrote:
> > > And even if we did all that, there would still be other manual cache
> > > manipulation left in this driver, to deal with its cacheable register
> > > interface.
> > 
> > I thought we had concluded that "cacheable register" is something
> > that cannot work reliably on ARM at all when this came up before.
> > Any updates on that?
> 
> There's a big comment in arch/arm/include/asm/io.h which explains
> everything.  Nothing there is likely to change.

Ah right, so since there is no interface to map as "device writeback",
the driver would likely end up with an MMIO register in a
"normal writeback", with these properties (among others listed there):

 * - writes can be repeated (in certain cases) with no side effects
 * - writes can be merged before accessing the target
 * - unaligned accesses can be supported
 * - ordering is not guaranteed without explicit dependencies or barrier
 *   instructions
 * - writes may be delayed before they hit the endpoint memory

I think the ordering is the most critical here, as IIRC the driver
expects a whole cache line to be written into the MMIO register
in a single bus cycle specifically when we issue the flush from the
driver, but we can actually have partial writebacks at any time.

	Arnd
