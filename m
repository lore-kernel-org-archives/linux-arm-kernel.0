From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Jul 2015 10:03:06 +0100
Subject: [PATCH v5] arm DMA: Fix allocation from CMA for coherent DMA
In-Reply-To: <20150701111251.GA21981@e104818-lin.cambridge.arm.com>
References: <1435699746-21395-1-git-send-email-lorenx4@gmail.com>
 <20150701111251.GA21981@e104818-lin.cambridge.arm.com>
Message-ID: <20150703090305.GR7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 01, 2015 at 12:12:51PM +0100, Catalin Marinas wrote:
> On Tue, Jun 30, 2015 at 11:29:06PM +0200, Lorenzo Nava wrote:
> > This patch allows the use of CMA for DMA coherent memory allocation.
> > At the moment if the input parameter "is_coherent" is set to true
> > the allocation is not made using the CMA, which I think is not the
> > desired behaviour.
> > 
> > Signed-off-by: Lorenzo Nava <lorenx4@gmail.com>
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> If Russell doesn't have any objections, you can send the patch to
> his patch system. See here for more information:

I'm left wondering whether this patch is really want Lorenzo wants.
>From my reading of it, while this has the effect of allocating from
CMA for coherent devices, it's no different from the non-coherent
case, because by calling __alloc_from_contiguous(), we end up
remapping the allocated memory, removing the cacheability status
from the allocated pages.

This brings up an interesting point: presumably, it's been tested, and
people are happy with the performance it's giving, inspite of it not
returning cacheable memory... or maybe it hasn't been tested that much?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
