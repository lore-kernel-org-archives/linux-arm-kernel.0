From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 7 Oct 2010 16:01:02 +0200
Subject: [RFC] tidspbridge: use a parameter to allocate shared memory
In-Reply-To: <20101007083242.GB14554@n2100.arm.linux.org.uk>
References: <1286430336-20204-1-git-send-email-omar.ramirez@ti.com>
	<201010070940.14208.laurent.pinchart@ideasonboard.com>
	<20101007083242.GB14554@n2100.arm.linux.org.uk>
Message-ID: <201010071601.04597.laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell

On Thursday 07 October 2010 10:32:42 Russell King - ARM Linux wrote:
> On Thu, Oct 07, 2010 at 09:40:12AM +0200, Laurent Pinchart wrote:
> > Hi Omar,
> > 
> > On Thursday 07 October 2010 07:45:36 Omar Ramirez Luna wrote:
> > > tidspbridge driver uses a block of memory denominated SHared Memory
> > > to store info & communicate with DSP, this SHM needs to be physically
> > > contiguous and non-cacheable,
> > 
> > There are non-cacheable mappings, but there's no such thing as
> > non-cacheable memory. Does the MPU mapping for that SHM block really
> > needs to be non- cacheable, your could you instead flush the cache after
> > writing to it (performance issues might be involved, I don't know the
> > details about that SHM usage) ?
> 
> ARMv6 and above don't like having multiple mappings with different
> memory type/shareability/cache attributes.  It's architecturally
> forbidden.
> 
> So if you want non-cacheable memory and you want to be architecturally
> compliant, you have to exclude it from the kernel's direct-mapped
> memory mapping.

That's why Omar's patch uses 'mem=' to exclude system memory from the kernel 
mappings. That's not ideal though, as that memory will be wasted forever, 
hence my comments regarding whether a non-cacheable mapping was really 
required.

Do we have an infrastructure, or even an embryo thereof, to remove pages from 
the kernel's direct-mapped memory mapping at runtime ? The use of super pages 
probably complicates the matter.

-- 
Regards,

Laurent Pinchart
