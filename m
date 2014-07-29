From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Jul 2014 20:55:47 +0100
Subject: Bad Page dump (help)
In-Reply-To: <20140729190700.GN17808@saruman.home>
References: <20140729190700.GN17808@saruman.home>
Message-ID: <20140729195547.GE30282@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 29, 2014 at 02:07:01PM -0500, Felipe Balbi wrote:
> I'm bringing up a new board on today's linux-next but I'm having a bunch
> of bad_page() calls due to _mapcount not being zero (full logs
> attached). What could cause that ? Any hints on how to debug ? It's as
> if page_mapcount_reset() wasn't called for the pages which are causing
> issues.

Hmm... are you using sparsemem?  I suspect sparsemem hasn't been tested
for a while now.
 
> [    0.000000] BUG: Bad page state in process swapper  pfn:8136d
> [    0.000000] page:ee017da0 count:0 mapcount:-1048576 mapping:  (null) index:0x0

So the page pointer was 0xee017da0 for pfn 0x8136d.  The mem map array
starts at 0xedff1000, which makes this index 0x136d, or 4973, which
looks fine.

1520 pages are used for the mem_map, so that covers 0xedff1000 to
0xee5e100.  So, the struct page is well within the allocation for the
mem map array.

The mapcount equates to 0xfff00000, which looks to be a suggestive value,
but it doesn't really help much.

Looking at free_pages_check(), we can say that all the other checks
that the function did succeeded (if any of them had failed, we would
have seen a different reason.)

Hmm.

Can you enable memblock debugging by passing memblock=debug on the kernel
command line please, and re-send the kernel output?

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
