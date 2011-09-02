From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 2 Sep 2011 18:28:50 +0100
Subject: [PATCH] af_packet: flush complete kernel cache in packet_sendmsg
In-Reply-To: <1314971179.3092.159.camel@deadeye>
References: <20110505141107.GC30443@orbit.nwl.cc>
	<1314961686-30870-1-git-send-email-phil.sutter@viprinet.com>
	<1314971179.3092.159.camel@deadeye>
Message-ID: <20110902172850.GB6619@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 02, 2011 at 02:46:17PM +0100, Ben Hutchings wrote:
> On Fri, 2011-09-02 at 13:08 +0200, Phil Sutter wrote:
> > This flushes the cache before and after accessing the mmapped packet
> > buffer. It seems like the call to flush_dcache_page from inside
> > __packet_get_status is not enough on Kirkwood (or ARM in general).
> > ---
> > I know this is far from an optimal solution, but it's in fact the only working
> > one I found.
> [...]
> 
> This is ridiculous.  If flush_dcache_page() isn't doing everything it
> should, you need to fix that.

It does do everything it should - which is to perform maintanence on
page cache pages.  It flushes the kernel mapping of the page.  It
also flushes the userspace mappings of the page which it finds by
walking the mmap list via the associated struct page.  It does not
touch vmalloc mappings because it has no way to know whether they
exist or not.

It doesn't do so much for anonymous pages - to do so would only
duplicate what flush_anon_page() does at the very same callsites.
Plus the mmap list isn't available for such pages so there's no
way to find out what userspace addresses to flush.

If the AF_PACKET buffers are created from anonymous pages and it's
using flush_dcache_page(), it's using the wrong interface.
