From: will.deacon@arm.com (Will Deacon)
Date: Thu, 15 Nov 2018 17:48:03 +0000
Subject: [PATCH v1] arch: arm64: add ARM64 specific fucntions required
 for ehci fsl driver
In-Reply-To: <20181115092357.1556-1-yinbo.zhu@nxp.com>
References: <20181115092357.1556-1-yinbo.zhu@nxp.com>
Message-ID: <20181115174802.GB3087@brain-police>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2018 at 05:23:57PM +0800, Yinbo Zhu wrote:
> From: Rajesh Bhagat <rajesh.bhagat@nxp.com>
> 
> Add set/clear bits functions for ARM platform which are used by ehci fsl
> driver
> 
> Signed-off-by: Rajesh Bhagat <rajesh.bhagat@nxp.com>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> ---
>  arch/arm64/include/asm/io.h |   29 +++++++++++++++++++++++++++++
>  1 files changed, 29 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
> index e97b861..0dc4334 100644
> --- a/arch/arm64/include/asm/io.h
> +++ b/arch/arm64/include/asm/io.h
> @@ -185,6 +185,35 @@ extern void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size);
>  #define iowrite32be(v,p)	({ __iowmb(); __raw_writel((__force __u32)cpu_to_be32(v), p); })
>  #define iowrite64be(v,p)	({ __iowmb(); __raw_writeq((__force __u64)cpu_to_be64(v), p); })
>  
> +/* access ports */
> +#define setbits32(_addr, _v) iowrite32be(ioread32be(_addr) |  (_v), (_addr))
> +#define clrbits32(_addr, _v) iowrite32be(ioread32be(_addr) & ~(_v), (_addr))
> +
> +#define setbits16(_addr, _v) iowrite16be(ioread16be(_addr) |  (_v), (_addr))
> +#define clrbits16(_addr, _v) iowrite16be(ioread16be(_addr) & ~(_v), (_addr))
> +
> +#define setbits8(_addr, _v) iowrite8(ioread8(_addr) |  (_v), (_addr))
> +#define clrbits8(_addr, _v) iowrite8(ioread8(_addr) & ~(_v), (_addr))

Why isn't this defined in the driver? Adding it to the arch-code leads to
duplication of the definitions and encourages other drivers to start using
this weird interface.

So no, I don't want this in the arch code.

Will
