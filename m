From: rdunlap@infradead.org (Randy Dunlap)
Date: Mon, 8 Oct 2018 12:49:13 -0700
Subject: [PATCH v2] Documentation/arm64: HugeTLB page implementation
In-Reply-To: <20181008100355.31820-1-punit.agrawal@arm.com>
References: <97e4e5fb-24ed-0545-414a-6a0c0116e6b8@infradead.org>
 <20181008100355.31820-1-punit.agrawal@arm.com>
Message-ID: <67f4ceb7-d41c-ab7a-4d5e-c147dadf6860@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/8/18 3:03 AM, Punit Agrawal wrote:
> Arm v8 architecture supports multiple page sizes - 4k, 16k and
> 64k. Based on the active page size, the Linux port supports
> corresponding hugepage sizes at PMD and PUD(4k only) levels.
> 
> In addition, the architecture also supports caching larger sized
> ranges (composed of multiple entries) at the PTE and PMD level in the
> TLBs using the contiguous bit. The Linux port makes use of this
> architectural support to enable additional hugepage sizes.
> 
> Describe the two different types of hugepages supported by the arm64
> kernel and the hugepage sizes enabled by each.
> 
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Jonathan Corbet <corbet@lwn.net>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> Hi,
> 
> This version incorporates the feedback on v1.
> 
> Thanks,
> Punit
> 
>  Documentation/arm64/hugetlbpage.txt | 38 +++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/arm64/hugetlbpage.txt
> 
> diff --git a/Documentation/arm64/hugetlbpage.txt b/Documentation/arm64/hugetlbpage.txt
> new file mode 100644
> index 000000000000..cfae87dc653b
> --- /dev/null
> +++ b/Documentation/arm64/hugetlbpage.txt
> @@ -0,0 +1,38 @@
> +HugeTLBpage on ARM64
> +====================
> +
> +Hugepage relies on making efficient use of TLBs to improve performance of
> +address translations. The benefit depends on both -
> +
> +  - the size of hugepages
> +  - size of entries supported by the TLBs
> +
> +The ARM64 port supports two flavours of hugepages.
> +
> +1) Block mappings at the pud/pmd level
> +--------------------------------------
> +
> +These are regular hugepages where a pmd or a pud page table entry points to a
> +block of memory. Regardless of the supported size of entries in TLB, block
> +mappings reduce the depth of page table walk needed to translate hugepage
> +addresses.
> +
> +2) Using the Contiguous bit
> +---------------------------
> +
> +The architecture provides a contiguous bit in the translation table entries
> +(D4.5.3, ARM DDI 0487C.a) that hints to the MMU to indicate that it is one of a
> +contiguous set of entries that can be cached in a single TLB entry.
> +
> +The contiguous bit is used in Linux to increase the mapping size at the pmd and
> +pte (last) level. The number of supported contiguous entries varies by page size
> +and level of the page table.
> +
> +
> +The following hugepage sizes are supported -
> +
> +         CONT PTE    PMD    CONT PMD    PUD
> +         --------    ---    --------    ---
> +  4K:         64K     2M         32M     1G
> +  16K:         2M    32M          1G
> +  64K:         2M   512M         16G
> 


-- 
~Randy
