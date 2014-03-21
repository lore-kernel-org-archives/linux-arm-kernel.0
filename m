From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 21 Mar 2014 16:27:50 +0000
Subject: [PATCH] ARM: Use 64-bit DMA addresses for LPAE+VirtIO-MMIO
In-Reply-To: <1395250522-30031-1-git-send-email-cov@codeaurora.org>
References: <1395250522-30031-1-git-send-email-cov@codeaurora.org>
Message-ID: <20140321162750.GI13596@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 19, 2014 at 05:35:19PM +0000, Christopher Covington wrote:
> On an LPAE system, the physical addresses used by VirtIO-MMIO may
> be larger than 32 bits, even if the header and configuration space
> addresses fit into 32 bits. For example with the Versatile Express
> memory map using 4G memory, the following error occured when trying
> to use a VirtIO-MMIO block device.
> 
> EXT2-fs (vda): error: ext2_check_page: bad entry in directory #2: :
> unaligned directory entry - offset=0, inode=3755990991, rec_len=57311,
> name_len=223
> 
> To fix this, select ARCH_DMA_ADDR_T_64BIT when both LPAE and
> VIRTIO_MMIO are selected.
> 
> Signed-off-by: Christopher Covington <cov@codeaurora.org>
> ---
>  arch/arm/mm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 1f8fed9..a62bcc9 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -617,6 +617,7 @@ config ARM_LPAE
>  	bool "Support for the Large Physical Address Extension"
>  	depends on MMU && CPU_32v7 && !CPU_32v6 && !CPU_32v5 && \
>  		!CPU_32v4 && !CPU_32v3
> +	select ARCH_DMA_ADDR_T_64BIT if VIRTIO_MMIO

That's the wrong place to enable ARCH_DMA_ADDR_T_64BIT. Do you have a
platform with >32-bit physical address space? If yes, it should be
selected there.

-- 
Catalin
