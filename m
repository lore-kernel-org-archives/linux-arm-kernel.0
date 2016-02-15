From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 15 Feb 2016 11:45:05 +0000
Subject: [PATCH] arm64: mark kernel text segment as MEMBLOCK_NOMAP
In-Reply-To: <1455528512-32491-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1455528512-32491-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160215114505.GE13683@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 10:28:32AM +0100, Ard Biesheuvel wrote:
> Commit 752af28bd711 ("arm64: move kernel image to base of vmalloc area")
> moves the mapping of the kernel text and data segments out of the linear
> region, and takes care not to create a writable alias of the read-only
> kernel text segment by checking each memblock against overlap when the
> memblocks are mapped into the linear mapping.
> 
> However, it is more correct, and much simpler, to mark the [_stext, _etext]
> interval as MEMBLOCK_NOMAP. This will also prevent the interval from being
> omitted from the linear region, but this fact will now also be reflected
> in the output of pfn_valid(), and so code that expects any pfn_valid()
> page to be mapped and accessible (which is a reasonable assumption) does
> not get surprised by the text segment being inaccessible via the linear
> mapping.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> 
> This should hopefully address the issue reported by James, but I suppose
> more work is required on the hibernate side to ensure the unmapped text
> region is preserved, since it is no longer covered by the linear mapping.

Ard, I'm about to drop the kernel memory map patches from -next. There
are several issues like KASAN (which may as well be a KASAN bug but I
haven't got to the bottom of it yet), initrd (you have patches but
require additional acks).

I'll keep your stuff on the for-next/kernmap branch and do further
debugging. If it stabilises in the next 1-2 weeks, I'll merge it into
for-next/core for 4.6, otherwise, it will have to wait. I would really
like these patches merged but it looks like they need wider testing.

I have another branch with your kaslr patches but I didn't dare to merge
them into for-next/core until we sort out the first sub-series.

-- 
Catalin
