From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 Jan 2014 09:49:57 +0000
Subject: [RFC 2/2] arm: Get rid of meminfo
In-Reply-To: <1389765322-28582-3-git-send-email-lauraa@codeaurora.org>
References: <1389765322-28582-1-git-send-email-lauraa@codeaurora.org>
 <1389765322-28582-3-git-send-email-lauraa@codeaurora.org>
Message-ID: <20140115094957.GL15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 09:55:22PM -0800, Laura Abbott wrote:
> memblock is now fully integrated into the kernel and is the prefered
> method for tracking memory. Rather than reinvent the wheel with
> meminfo, migrate to using memblock directly instead of meminfo as
> an intermediate.

The reason I never killed meminfo was that for some of the functions here
is that meminfo has a slightly different property to memblock.

With meminfo, each sparsemem section mapping or discontigmem node must be
specified as a separate bank of memory, even if it is contiguous with the
previous block.  This is so that the functions which walk the page arrays
can do so efficiently (without having to convert from a PFN to a struct
page for every page in the system, which is very inefficient.)

Memblock appends contiguous blocks together, so it reports only one block.
This means that if we take the struct page for the start of the block, and
the struct page for the end of the block, these may be different struct
page arrays, and we can't walk it by just incrementing the struct page
pointer.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
