From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 26 Oct 2017 15:54:13 +0100
Subject: A case for ZONE_DMA32 (or similar) on LPAE?
In-Reply-To: <4c9a447c06cf47cdb5b07d3774ea7e5d@HICGWSMB03.ad.harman.com>
References: <4c9a447c06cf47cdb5b07d3774ea7e5d@HICGWSMB03.ad.harman.com>
Message-ID: <20171026145413.4765xxcfwvigwtff@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 23, 2017 at 06:07:51PM +0000, McFarland, Brian wrote:
> Using the TI's 6AM.1.3 release for DRA7x I have an oom-killer problem
> that only occurs with LPAE enabled.
> 
> That is to say - I have a baseline system runs without oom-killer on a
> non-LPAE kernel, but recently enabled LPAE to allow access to 4GB of
> RAM (my baseline HW 2G). When doing so, I see oom-killer issues early
> and often.
> 
> I believe I've narrowed down the problem to  an issue with the
> SGX/PowerVR driver, pvrsrvkm (open source-ish but built out-of-tree).
> When LPAE is disabled, the driver allocates using GFP_HIGHMEM because
> all memory is "32-bit safe", making it accessible to the SGX core. 
> 
> When LPAE is enabled, instead the driver uses GFP_DMA32, which on
> arch's where the zone does not exists - falls back to ZONE_NORMAL or
> ZONE_DMA, which are constricted to the first approx 768MB.  
[...]
> This all leads me to believe I need another zone.  A zone that spans
> from arm_lowmem_limit to the end of 32-bit space, which in the case of
> dra7x is nominally about 1.3GB.
> 
> This appears to be the general idea behind ZONE_DMA32 but the zone has
> comes in & out of multiple arch's and I cannot find any clear
> information on the exact intention of said zone.  It used to be on
> arm64 but was since removed. As far as I can tell, no one ever used it
> on arm32+LPAE.

The way the Linux page allocator behaves won't help you even with a
ZONE_DMA32. Basically it expects that zones do not overlap and also
expects a fallback allocation: e.g. when ZONE_NORMAL allocation
fails, it can try the lower index zone which is currently ZONE_DMA for
arch/arm. Since ZONE_NORMAL must end at 32-bit virtual address range
(where ZONE_HIGHMEM begins), you can't have it fall back to a lower
index ZONE_DMA32 which would go beyond the 4G virtual address space (see
include/linux/gfp.h for the fallback order).

The quickest solution for you is to rebuild the kernel with a 2:2 memory
split so that ZONE_DMA is bigger (around 1.7GB).

An alternative might be to invent a new zone, something like
ZONE_HIGHMEM32, which is highmem but still within 32-bit physical
address space. However, it will take some effort to justify and upstream
it.

-- 
Catalin
