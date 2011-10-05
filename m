From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 4 Oct 2011 20:24:48 -0500
Subject: [PATCH 11/11] ARM: common/vic: use proper __iomem annotations
In-Reply-To: <1317496920-7764-12-git-send-email-arnd@arndb.de>
References: <1317496920-7764-1-git-send-email-arnd@arndb.de>
	<1317496920-7764-12-git-send-email-arnd@arndb.de>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F39DCFE6DF@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, October 01, 2011 12:22 PM, Arnd Bergmann wrote:
> 
> In vic_init, we pass addr into readl, so it needs to be a
> pointer, not a u32 address.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/common/vic.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
> index 7aa4262..adccf6d 100644
> --- a/arch/arm/common/vic.c
> +++ b/arch/arm/common/vic.c
> @@ -347,7 +347,8 @@ void __init vic_init(void __iomem *base, unsigned int irq_start,
>  
>  	/* Identify which VIC cell this one is, by reading the ID */
>  	for (i = 0; i < 4; i++) {
> -		u32 addr = ((u32)base & PAGE_MASK) + 0xfe0 + (i * 4);
> +		void __iomem *addr;
> +		addr = (void __iomem *)((u32)base & PAGE_MASK) + 0xfe0 + (i * 4);
>  		cellid |= (readl(addr) & 0xff) << (8 * i);
>  	}
>  	vendor = (cellid >> 12) & 0xff;

Arnd,

This has already been fixed by Patch 7028/2 in Russell's patch tracking system.

Regards,
Hartley
