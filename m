From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Dec 2015 15:32:02 +0000
Subject: memcpy alignment
In-Reply-To: <5670309D.1040309@redhat.com>
References: <566F92D6.8060103@redhat.com>
 <20151215093406.GC19244@e104818-lin.cambridge.arm.com>
 <5670309D.1040309@redhat.com>
Message-ID: <20151215153202.GC8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 15, 2015 at 10:24:13AM -0500, Jon Masters wrote:
> On 12/15/2015 04:34 AM, Catalin Marinas wrote:
> > On Mon, Dec 14, 2015 at 11:11:02PM -0500, Jon Masters wrote:
> >> What's supposed to happen if the natural alignment of the pointers dst
> >> and src is not the same? We don't seem to handle that case today, and
> >> instead will base our access data type on the source alignment only.
> > 
> > The hardware takes care of the other one. The memcpy behaviour in the
> > kernel is the same as the glibc one (the Cortex Strings library).
> 
> Not if you're dealing with Device memory. I accept that one could always
> ensure that there's a non-Device mapping (I got the other replies) but I
> don't think it's unreasonable to expect a memcpy to work in the presence
> of misaligned addresses either.

Using memcpy() on memory returned from functions which setup IO/MMIO
mappings has always been outlawed.  It's the whole reason we have
things like memcpy_toio(), memcpy_fromio() and memset_io(), which
date back a few decades now, and they exist for exactly these kinds
of reasons.

If you get an __iomem pointer, then you must respect that it
essentially can not be non-dereferenced, and you must use one of the
standard kernel accessors (read[bwl]/ioread*/write[bwl]/iowrite*/
memcpy_fromio/memcpy_toio/memset_io) to access it.  That's the API
contract you implicitly signed up to by using something like ioremap()
or other mapping which gives you an iomem mapping.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
