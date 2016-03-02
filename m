From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 2 Mar 2016 12:31:42 +0000
Subject: [PATCH 1/2] iommu/io-pgtable: Add MTK 4GB mode in Short-descriptor
In-Reply-To: <1456268552-16635-2-git-send-email-yong.wu@mediatek.com>
References: <1456268552-16635-1-git-send-email-yong.wu@mediatek.com>
 <1456268552-16635-2-git-send-email-yong.wu@mediatek.com>
Message-ID: <56D6DD2E.4030207@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yong,

On 23/02/16 23:02, Yong Wu wrote:
> Mediatek extend bit9 in the lvl1 and lvl2 pgtable descriptor of the
> Short-descriptor as the 4GB mode in which the dram size will be
> over 4GB.
>
> We add a special quirk for this MTK-4GB mode, And in the standard
> spec, Bit9 in the lvl1 is "IMPLEMENTATION DEFINED", while it's AP[2]
> in the lvl2, therefore if this quirk is enabled, NO_PERMS is also
> expected.

Would you be able to explain exactly what this "4GB mode" actually is? 
I've been trying to make sense of it from the original M4U patches and 
the patch for the I2C driver, but it has me completely baffled.

Is it simply used as an extra physical address bit (although surely that 
would make it "8GB mode"?), or does it do something crazier like 
toggling an interconnect remap that shifts the output addresses up by 
1GB to be relative to the base of DRAM, like a dma_pfn_offset?

I guess from the look of these patches that it doesn't change anything 
between the masters and the M4U, so input addresses are still 32 bits 
and we don't need extended tables, right? Furthermore, what about the 
TTBRs? Does the level 1 table still have to be below 4GB?

> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> In arm_v7s_init_pte, We add bit9 if the 4GB mode is enabled no matter
> the current pa is over 4GB or not.

Either way I can't comprehend how it could be fine to just enable 
unconditionally without doing _something_ with the actual addresses.

>   drivers/iommu/io-pgtable-arm-v7s.c | 14 +++++++++++++-
>   drivers/iommu/io-pgtable.h         |  6 ++++++
>   2 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index 9fcceb1..bf6a6f0 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -121,6 +121,8 @@
>   #define ARM_V7S_TEX_MASK		0x7
>   #define ARM_V7S_ATTR_TEX(val)		(((val) & ARM_V7S_TEX_MASK) << ARM_V7S_TEX_SHIFT)
>
> +#define ARM_V7S_ATTR_MTK_4GB		BIT(9) /* MTK extend it for 4GB mode */
> +
>   /* *well, except for TEX on level 2 large pages, of course :( */
>   #define ARM_V7S_CONT_PAGE_TEX_SHIFT	6
>   #define ARM_V7S_CONT_PAGE_TEX_MASK	(ARM_V7S_TEX_MASK << ARM_V7S_CONT_PAGE_TEX_SHIFT)
> @@ -364,6 +366,9 @@ static int arm_v7s_init_pte(struct arm_v7s_io_pgtable *data,
>   	if (lvl == 1 && (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS))
>   		pte |= ARM_V7S_ATTR_NS_SECTION;
>
> +	if (cfg->quirks & IO_PGTABLE_QUIRK_MTK_4GB_EXT)
> +		pte |= ARM_V7S_ATTR_MTK_4GB;
> +
>   	if (num_entries > 1)
>   		pte = arm_v7s_pte_to_cont(pte, lvl);
>
> @@ -625,9 +630,16 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
>
>   	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS |
>   			    IO_PGTABLE_QUIRK_NO_PERMS |
> -			    IO_PGTABLE_QUIRK_TLBI_ON_MAP))
> +			    IO_PGTABLE_QUIRK_TLBI_ON_MAP |
> +			    IO_PGTABLE_QUIRK_MTK_4GB_EXT))
>   		return NULL;
>
> +	/* If MTK_4GB_EXT is enabled, the NO_PERMS is also expected. */
> +	if (cfg->quirks & IO_PGTABLE_QUIRK_MTK_4GB_EXT) {
> +		if (!(cfg->quirks & IO_PGTABLE_QUIRK_NO_PERMS))

Ha, I wasn't expecting to see Will's argument against generic 
quirk-checking be vindicated quite so soon :)

Anyway, no need for braces and nested ifs:

	if (cfg->quirks & IO_PGTABLE_QUIRK_MTK_4GB_EXT &&
	    !(cfg->quirks & IO_PGTABLE_QUIRK_NO_PERMS))

> +			return NULL;
> +	}
> +
>   	data = kmalloc(sizeof(*data), GFP_KERNEL);
>   	if (!data)
>   		return NULL;
> diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
> index d4f5027..a84a60a 100644
> --- a/drivers/iommu/io-pgtable.h
> +++ b/drivers/iommu/io-pgtable.h
> @@ -60,10 +60,16 @@ struct io_pgtable_cfg {
>   	 * IO_PGTABLE_QUIRK_TLBI_ON_MAP: If the format forbids caching invalid
>   	 *	(unmapped) entries but the hardware might do so anyway, perform
>   	 *	TLB maintenance when mapping as well as when unmapping.
> +	 *
> +	 * IO_PGTABLE_QUIRK_MTK_4GB_EXT: Mediatek extend bit9 in the lvl1 and
> +	 *	lvl2 descriptor of the Short-descriptor as the 4GB mode.
> +	 *	Note that: Bit9 in the lvl1 is "IMPLEMENTATION DEFINED", while
> +	 *	it is AP[2] in the lvl2.

Unfortunately that comment doesn't really explain anything - I'd be 
happy to suggest a more helpful wording, If only I understood what it 
actually did.

Robin.

>   	 */
>   	#define IO_PGTABLE_QUIRK_ARM_NS		BIT(0)
>   	#define IO_PGTABLE_QUIRK_NO_PERMS	BIT(1)
>   	#define IO_PGTABLE_QUIRK_TLBI_ON_MAP	BIT(2)
> +	#define IO_PGTABLE_QUIRK_MTK_4GB_EXT	BIT(3)
>   	unsigned long			quirks;
>   	unsigned long			pgsize_bitmap;
>   	unsigned int			ias;
>
