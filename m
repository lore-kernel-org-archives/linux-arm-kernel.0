From: will.deacon@arm.com (Will Deacon)
Date: Fri, 2 May 2014 18:07:45 +0100
Subject: [PATCH] arm64: Clean up the default pgprot setting
In-Reply-To: <1399045919-5615-1-git-send-email-catalin.marinas@arm.com>
References: <1399045919-5615-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <20140502170745.GF20642@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 02, 2014 at 04:51:59PM +0100, Catalin Marinas wrote:
> The primary aim of this patchset is to remove the pgprot_default and
> prot_sect_default global variables and rely strictly on predefined
> values. The original goal was to be able to run SMP kernels on UP
> hardware by not setting the Shareability bit. However, it is unlikely to
> see UP ARMv8 hardware and even if we do, the Shareability bit is no
> longer assumed to disable cacheable accesses.
> 
> A side effect is that the device mappings now have the Shareability
> attribute set. The hardware, however, should ignore it since Device
> accesses are always Outer Shareable.
> 
> Following the removal of the two global variables, there is some PROT_*
> macro reshuffling and cleanup, including the __PAGE_* macros (replaced
> by PAGE_*).

[...]

> +#define PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_TYPE_MASK) | PTE_PROT_NONE | PTE_PXN | PTE_UXN)
> +#define PAGE_SHARED		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_UXN | PTE_WRITE)
> +#define PAGE_SHARED_EXEC	__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_WRITE)
> +#define PAGE_COPY		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_UXN)
> +#define PAGE_COPY_EXEC	__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN)
> +#define PAGE_READONLY		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_UXN)
> +#define PAGE_READONLY_EXEC	__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN)
> +#define PAGE_EXECONLY		__pgprot(_PAGE_DEFAULT | PTE_NG | PTE_PXN)

Could you build the non-exec versions in terms of the exec versions? The
difference is just the addition of PTE_UXN, and it would make this easier to
read.

Otherwise this looks fine,

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
