From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 24 Nov 2014 17:17:49 +0000
Subject: [RFC PATCH v1] arm64:mm: An optimization about kernel direct
 sapce mapping
In-Reply-To: <1416406915-10939-1-git-send-email-zhichang.yuan@linaro.org>
References: <1416406915-10939-1-git-send-email-zhichang.yuan@linaro.org>
Message-ID: <20141124171749.GA12895@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm trying to make some sense of this patch, so questions below:

On Wed, Nov 19, 2014 at 02:21:55PM +0000, zhichang.yuan at linaro.org wrote:
> From: "zhichang.yuan" <zhichang.yuan@linaro.org>
> 
> This patch make the processing of map_mem more common and support more
> discrete memory layout cases.
> 
> In current map_mem, the processing is based on two hypotheses:
> 1) no any early page allocations occur before the first PMD or PUD regime
> where the kernel image locate is successfully mapped;

No because we use the kernel load offset to infer the start of RAM
(PHYS_OFFSET). This would define which memory you can allocate.

> 2) there are sufficient available pages in the PMD or PUD regime to satisfy
> the need of page tables from other memory ranges mapping.

I don't fully understand this. Can you be more specific?

> The current SOC or hardware platform designs had not broken this constraint.
> But we can make the software more versatile.

We need to have code readability in mind ;).

> In addition, for the 4K page system, to comply with the constraint No.1, the
> start address of some memory ranges is forced to align at PMD boundary, it
> will make some marginal pages of that ranges are skipped to build the PTE. It
> is not reasonable.

It is reasonable to ask for the start of RAM to be on a PMD (2MB)
boundary.

> This patch will relieve the system from those constraints. You can load the
> kernel image in any memory range, the memory range can be small, can start at
> non-alignment boundary, and so on.

I guess you still depend on the PAGE_OFFSET, TEXT_OFFSET, so it's not
random.

I'm not sure what the end goal is with this patch but my plan is to
entirely decouple TEXT_OFFSET from PAGE_OFFSET (with a duplicate mapping
for the memory covering the kernel text). This would allow us to load
the kernel anywhere in RAM (well, with some sane alignment to benefit
from section mapping) and the PHYS_OFFSET detected from DT at run-time.
Once that's done, I don't think your patch is necessary.

Thanks.

-- 
Catalin
