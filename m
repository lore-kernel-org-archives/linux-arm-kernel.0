From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 7 Oct 2010 09:40:12 +0200
Subject: [RFC] tidspbridge: use a parameter to allocate shared memory
In-Reply-To: <1286430336-20204-1-git-send-email-omar.ramirez@ti.com>
References: <1286430336-20204-1-git-send-email-omar.ramirez@ti.com>
Message-ID: <201010070940.14208.laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Omar,

On Thursday 07 October 2010 07:45:36 Omar Ramirez Luna wrote:
> tidspbridge driver uses a block of memory denominated SHared Memory
> to store info & communicate with DSP, this SHM needs to be physically
> contiguous and non-cacheable,

There are non-cacheable mappings, but there's no such thing as non-cacheable 
memory. Does the MPU mapping for that SHM block really needs to be non-
cacheable, your could you instead flush the cache after writing to it 
(performance issues might be involved, I don't know the details about that SHM 
usage) ?

> to achieve the latter the driver ioremaps
> the memory reserved to be SHM, this will trigger a warning if the
> memory is under kernel control (because it creates another set of
> mapping attributes, for the same memory area).
> 
> For now this can be avoided if a portion of memory (6MB) is left out
> of kernel control (using bootarg attribute mem=) where tidspbridge
> driver can make use of the memory and ioremap it without above
> restriction.
> 
> Parameter has precedence over memblock allocator for shared memory.
> 
> i.e.: on a system with 256MB
> 
> set 'bootargs mem=250M ...'
> 
> cat /proc/iomem
> ...
> 80000000-8f9fffff : System RAM
> 
> So driver needs to be installed with:
> 
> insmod bridgedriver.ko phys_mempool_base=0x8FA00000
> 
> Same rationale applies for the menuconfig option.
> 
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>

-- 
Regards,

Laurent Pinchart
