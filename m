From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Oct 2013 16:52:16 +0100
Subject: arm64 ioremap question
In-Reply-To: <1381850404.27955.9.camel@deneb.redhat.com>
References: <1381850404.27955.9.camel@deneb.redhat.com>
Message-ID: <20131015155216.GD25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 15, 2013 at 11:20:04AM -0400, Mark Salter wrote:
> ioremap() has a test to prevent RAM from being remapped:
> 
> 	/*
> 	 * Don't allow RAM to be mapped.
> 	 */
> 	if (WARN_ON(pfn_valid(__phys_to_pfn(phys_addr))))
> 		return NULL;
> 
> 
> Is this really necessary even for reserved pages which are not being
> used for anything else?

It helps to stop the abuse of using ioremap() on normal memory, which has
happened soo much in Aarch32 for years.  Unfortuantely, bad habbits die
hard.

"Reserved pages not being used for anything else" are still mapped, and
still subject to speculative fetches.
