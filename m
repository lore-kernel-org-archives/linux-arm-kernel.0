From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 26 Feb 2016 15:23:53 +0000
Subject: [PATCH] arm64: Remove fixmap include fragility
In-Reply-To: <20160226144457.GD8728@leverpostej>
References: <CAKv+Gu933t2DjBoHEfe=ZNcbrJMHHvT_F3Pug261w0WYTduVTw@mail.gmail.com>
 <20160226144457.GD8728@leverpostej>
Message-ID: <20160226152352.GN4777@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26, 2016 at 02:44:58PM +0000, Mark Rutland wrote:
> The asm-generic fixmap.h depends on each architecture's fixmap.h to pull
> in the definition of PAGE_KERNEL_RO, if this exists. In the absence of
> this, FIXMAP_PAGE_RO will not be defined. In mm/early_ioremap.c the
> definition of early_memremap_ro is predicated on FIXMAP_PAGE_RO being
> defined.
> 
> Currently, the arm64 fixmap.h doesn't include pgtable.h for the
> definition of PAGE_KERNEL_RO, and as a knock-on effect early_memremap_ro
> is not always defined, leading to link-time failures when it is used.
> This has been observed with defconfig on next-20160226.
> 
> Unfortunately, as pgtable.h includes fixmap.h, adding the include
> introduces a circular dependency, which is just as fragile.
> 
> Instead, this patch factors out PAGE_KERNEL_RO and other prot
> definitions into a new pgtable-prot header which can be included by poth
> pgtable.h and fixmap.h, avoiding the  circular dependency, and ensuring
> that early_memremap_ro is alwyas defined where it is used.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Applied. Thanks.

-- 
Catalin
