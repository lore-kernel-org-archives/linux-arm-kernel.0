From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Jan 2017 16:22:18 +0000
Subject: [PATCH] Replacement for Arm initrd memblock reserve and free
 inconsistency.
In-Reply-To: <592F4D3D062D79449F140027567F70E8FE081234@exchmbx03>
References: <592F4D3D062D79449F140027567F70E8FE080A79@exchmbx03>
 <20161110174645.GB1041@n2100.armlinux.org.uk>
 <592F4D3D062D79449F140027567F70E8FE0810D3@exchmbx03>
 <20161116234741.GE1041@n2100.armlinux.org.uk>
 <592F4D3D062D79449F140027567F70E8FE081234@exchmbx03>
Message-ID: <20170116162218.GA27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2016 at 10:41:19AM +0000, william.helsby at stfc.ac.uk wrote:
> My understanding of your proposed patch is that it rounds the area to be reserved for the initrd image to page
> boundaries. It then checks that this rounding does not grow the initrd to overlap other areas.
> 
> If it does not overlap, all is well. The kernel will not kmalloc anything within the partial pages 
> at the beginning and end of the initrd image. When the initrd image is freed, complete pages are 
> released and there is no wasted memory.
> However, if it does overlap other regions, it disables the initrd image and the kernel panics with no root file system.

As best I can do when replying to this... (due to the stupidly long lines)...

Yes, that's what will happen.  The kernel memory allocator deals with
things on a per-page basis, and that's not going to change.  If someone
wants to place objects on a non-page aligned basis into memory, then
they're intentionally making life hard for the kernel.

You talk about kmalloc() above, but kmalloc() is not really relevant
here - kmalloc() should be thought as a sub-page memory allocator (even
though it's capable of larger allocations.)  It sources its memory from
page_alloc(), which not surprisingly deals with page-sized objects, and
those are either "in-use" or "free".  There's no finer granularity there.

So, if you have a page partially in-use, as far as the kernel's normal
allocators are concerned, the whole page is in use.

Boot time is slightly different until the normal allocators are
initialised - we have memblock, which doesn't really know about stuff
like pages.  It only knows about ranges of addresses.  However, during
initialisation, when memblock hands over to the normal allocators, any
page that is partially reserved is treated as wholely reserved because
- as I say above - the normal allocators can't deal with that level of
information.

Rounding the initrd up/down when reserving it in memblock is the right
thing to do to ensure that when memory is requested from memblock,
memblock doesn't allocate the overlapping pages - because we want to
free that memory later.

So, I don't think your idea of trying to cover all the cases of part-used
pages is really worth it - and the boot loader has to understand that the
kernel operates on a page-basis, and expects objects to be aligned to the
size of a page.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
