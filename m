From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 15 Oct 2013 16:55:08 +0100
Subject: arm64 ioremap question
In-Reply-To: <20131015155216.GD25034@n2100.arm.linux.org.uk>
References: <1381850404.27955.9.camel@deneb.redhat.com>
 <20131015155216.GD25034@n2100.arm.linux.org.uk>
Message-ID: <20131015155508.GD1591@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 15, 2013 at 04:52:16PM +0100, Russell King - ARM Linux wrote:
> On Tue, Oct 15, 2013 at 11:20:04AM -0400, Mark Salter wrote:
> > ioremap() has a test to prevent RAM from being remapped:
> > 
> > 	/*
> > 	 * Don't allow RAM to be mapped.
> > 	 */
> > 	if (WARN_ON(pfn_valid(__phys_to_pfn(phys_addr))))
> > 		return NULL;
> > 
> > 
> > Is this really necessary even for reserved pages which are not being
> > used for anything else?
> 
> It helps to stop the abuse of using ioremap() on normal memory, which has
> happened soo much in Aarch32 for years.  Unfortuantely, bad habbits die
> hard.
> 
> "Reserved pages not being used for anything else" are still mapped, and
> still subject to speculative fetches.

Indeed. The architecture does not guarantee the semantics of the
ioremap-returned memory (e.g. Device) as long as there are other aliases
with different memory attributes.

-- 
Catalin
