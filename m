From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 27 Jul 2015 16:09:06 +0200
Subject: [PATCH 00/18] Clean up exposure of arch-internal code
In-Reply-To: <20150727122824.GH7557@n2100.arm.linux.org.uk>
References: <20150727122824.GH7557@n2100.arm.linux.org.uk>
Message-ID: <20150727140905.GA16858@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 27, 2015 at 01:28:24PM +0100, Russell King - ARM Linux wrote:
> This series of patches attempts to clean up the use of architecture
> internal functions in drivers, and removes some functions from view
> in the asm/ headers.  I'm also considering whether we need to add
> some linker magic to hide symbols when building the built-in.o files.
> 
> This was triggered by 3rd party drivers "going under the covers" of
> the DMA API and calling the dmac_*() functions directly, a practice
> which I have always refused to allow.  This also breaks module
> building (which is the big hint that they're doing something wrong.)
> 
> However, it also came to light that various drivers are using
> __cpuc_* functions directly, which are non-portable, and is another
> instance of "going under the covers" and tinkering with what should
> be kept as architecture implementation details.
> 
> This series addresses some of these points.  It:
> 
> (a) moves dmac_map_area() and dmac_unmap_area() prototypes out of
>     asm/cacheflush.h and into arch/arm/mm.
> (b) provide a secure_flush() call for the Qualcomm secure monitor
>     code.
> (c) stop tegra smmu driver(s) from using __cpuc_flush_dcache_area,
>     something which necessitates additional complexity to deal with
>     the ARM vs ARM64 differences.  It should be using the DMA API.
>     However, the Tegra SMMU driver is in really bad shape, and this
>     isn't a simple conversion - it requires a lot of additional
>     fixes to bring the code up to scratch.

Out of curiosity, did you have any hardware to test this on? I've given
it a quick spin and haven't seen anything out of the ordinary. I have a
couple of nitpicks towards the end of the series, but other than that,
very nice work.

What's the plan for merging this? Should it all go in through Joerg's
tree so that potentially other driver conversions can go in on top of
this, or would you prefer to take it through the ARM tree?

> It leaves the Rockchip IOMMU driver for the time being, but that is also
> something which needs cleaning up in the same way as the Tegra SMMU
> driver.

>From a cursory look, MSM, OMAP and Exynos are in the same boat as well.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150727/e1d4912f/attachment-0001.sig>
