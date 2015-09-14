From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Sep 2015 17:31:55 +0100
Subject: [PATCH] arm: dma-mapping: fix build warning with new
 DMA_ERROR_CODE definition
In-Reply-To: <1442247198-12435-1-git-send-email-andre.przywara@arm.com>
References: <1442247198-12435-1-git-send-email-andre.przywara@arm.com>
Message-ID: <20150914163155.GO21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 14, 2015 at 05:13:18PM +0100, Andre Przywara wrote:
> Commit 96231b2686b5: ("ARM: 8419/1: dma-mapping: harmonize definition
> of DMA_ERROR_CODE") changed the definition of DMA_ERROR_CODE to use
> dma_addr_t, which makes the compiler barf on assigning this to an
> "int" variable on ARM with LPAE enabled:
> -------------------
> In file included from /src/linux/include/linux/dma-mapping.h:86:0,
>                  from /src/linux/arch/arm/mm/dma-mapping.c:21:
> /src/linux/arch/arm/mm/dma-mapping.c: In function '__iommu_create_mapping':
> /src/linux/arch/arm/include/asm/dma-mapping.h:16:24: warning:
> overflow in implicit constant conversion [-Woverflow]
>  #define DMA_ERROR_CODE (~(dma_addr_t)0x0)
>                         ^
> /src/linux/arch/arm/mm/dma-mapping.c:1252:15: note: in expansion of
> macro DMA_ERROR_CODE'
>   int i, ret = DMA_ERROR_CODE;
>                ^

It's absolutely right to barf on this.  DMA_ERROR_CODE is _supposed_
to be a dma_addr_t cookie.  It isn't an int.

> Remove the actually unneeded initialization of "ret" in
> __iommu_create_mapping() and move the variable declaration inside the
> for-loop to make the scope of this variable more clear.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm/mm/dma-mapping.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Hi Russell,
> 
> I hope that hasn't turned up before, but this triggers with my config.
> Please apply for 4.3.

The patch looks correct, please put it in the patch system, thanks.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
