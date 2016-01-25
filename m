From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Mon, 25 Jan 2016 10:42:21 +0200
Subject: [PATCH 07/15] dmaengine: dw: revisit data_width property
In-Reply-To: <1453663322-14474-8-git-send-email-mans@mansr.com>
References: <1453663322-14474-1-git-send-email-mans@mansr.com>
 <1453663322-14474-8-git-send-email-mans@mansr.com>
Message-ID: <1453711341.2521.206.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2016-01-24 at 19:21 +0000, Mans Rullgard wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> There are several changes are done here:
> 
> ?- Convert the property to be in bytes
> 
> ???Much more convenient than keeping encoded value.
> 
> ?- Use one value for all AHB masters for now
> 
> ???It seems in practice we have no controllers where masters have
> different
> ???data bus width, we still might return to distinct values when
> there is a use
> ???case.
> 
> ?- Rename data_width to data-width in the device tree bindings.
> 
> ?- While here, replace dwc_fast_ffs() by __ffs().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
> This patch changes the DT binding, so it should probably be amended
> for
> compatibility with old device trees.??I've included it as is since I
> think
> the change as such is good.

So, since all users have at least one master defined, we may easily to
use similar line for old DT variable

if (!of_property_read_u32(np, "data_width", &tmp)) /* removeme: old */
	
pdata->data_width = tmp;
else if (!of_property_read_u32(np, "data-
width", &tmp)) /* removeme: new */
	pdata->data_width = tmp;

I any case Viresh might comment on this since it was his code regarding
to support SPEAr SoCs.

> ---
> ?Documentation/devicetree/bindings/dma/snps-dma.txt |??5 ++-
> ?arch/arc/boot/dts/abilis_tb10x.dtsi????????????????|??2 +-
> ?arch/arm/boot/dts/spear13xx.dtsi???????????????????|??4 +--
> ?drivers/dma/dw/core.c??????????????????????????????| 40 +++---------
> ----------
> ?drivers/dma/dw/platform.c??????????????????????????|??8 ++---
> ?drivers/dma/dw/regs.h??????????????????????????????|??2 +-
> ?include/linux/platform_data/dma-dw.h???????????????|??5 ++-
> ?7 files changed, 16 insertions(+), 50 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/snps-dma.txt
> b/Documentation/devicetree/bindings/dma/snps-dma.txt
> index c99c1ffac199..fe7f7710a6b4 100644
> --- a/Documentation/devicetree/bindings/dma/snps-dma.txt
> +++ b/Documentation/devicetree/bindings/dma/snps-dma.txt
> @@ -13,8 +13,7 @@ Required properties:
> ?- chan_priority: priority of channels. 0 (default): increase from
> chan 0->n, 1:
> ???increase from chan n->0
> ?- block_size: Maximum block size supported by the controller
> -- data_width: Maximum data width supported by hardware per AHB
> master
> -??(0 - 8bits, 1 - 16bits, ..., 5 - 256bits)
> +- data-width: Maximum data width supported by hardware (in bytes)
> ?
> ?
> ?Optional properties:
> @@ -38,7 +37,7 @@ Example:
> ?		chan_allocation_order = <1>;
> ?		chan_priority = <1>;
> ?		block_size = <0xfff>;
> -		data_width = <3 3>;
> +		data-width = <8>;
> ?	};
> ?
> ?DMA clients connected to the Designware DMA controller must use the
> format
> diff --git a/arch/arc/boot/dts/abilis_tb10x.dtsi
> b/arch/arc/boot/dts/abilis_tb10x.dtsi
> index cfb5052239a1..2f53bedb0cde 100644
> --- a/arch/arc/boot/dts/abilis_tb10x.dtsi
> +++ b/arch/arc/boot/dts/abilis_tb10x.dtsi
> @@ -112,7 +112,7 @@
> ?			chan_allocation_order = <0>;
> ?			chan_priority = <1>;
> ?			block_size = <0x7ff>;
> -			data_width = <2>;
> +			data-width = <4>;
> ?			clocks = <&ahb_clk>;
> ?			clock-names = "hclk";
> ?		};
> diff --git a/arch/arm/boot/dts/spear13xx.dtsi
> b/arch/arm/boot/dts/spear13xx.dtsi
> index 14594ce8c18a..474b66fa6a32 100644
> --- a/arch/arm/boot/dts/spear13xx.dtsi
> +++ b/arch/arm/boot/dts/spear13xx.dtsi
> @@ -117,7 +117,7 @@
> ?			chan_priority = <1>;
> ?			block_size = <0xfff>;
> ?			dma-masters = <2>;
> -			data_width = <3 3>;
> +			data-width = <8>;
> ?		};
> ?
> ?		dma at eb000000 {
> @@ -133,7 +133,7 @@
> ?			chan_allocation_order = <1>;
> ?			chan_priority = <1>;
> ?			block_size = <0xfff>;
> -			data_width = <3 3>;
> +			data-width = <8>;
> ?		};
> ?
> ?		fsmc: flash at b0000000 {
> diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> index 140ea59ec882..28278e4c77ad 100644
> --- a/drivers/dma/dw/core.c
> +++ b/drivers/dma/dw/core.c
> @@ -168,21 +168,6 @@ static void dwc_initialize(struct dw_dma_chan
> *dwc)
> ?
> ?/*----------------------------------------------------------------
> ------*/
> ?
> -static inline unsigned int dwc_fast_ffs(unsigned long long v)
> -{
> -	/*
> -	?* We can be a lot more clever here, but this should take
> care
> -	?* of the most common optimization.
> -	?*/
> -	if (!(v & 7))
> -		return 3;
> -	else if (!(v & 3))
> -		return 2;
> -	else if (!(v & 1))
> -		return 1;
> -	return 0;
> -}
> -
> ?static inline void dwc_dump_chan_regs(struct dw_dma_chan *dwc)
> ?{
> ?	dev_err(chan2dev(&dwc->chan),
> @@ -712,7 +697,6 @@ dwc_prep_dma_memcpy(struct dma_chan *chan,
> dma_addr_t dest, dma_addr_t src,
> ?	size_t			offset;
> ?	unsigned int		src_width;
> ?	unsigned int		dst_width;
> -	unsigned int		data_width;
> ?	u32			ctllo;
> ?
> ?	dev_vdbg(chan2dev(chan),
> @@ -726,10 +710,7 @@ dwc_prep_dma_memcpy(struct dma_chan *chan,
> dma_addr_t dest, dma_addr_t src,
> ?
> ?	dwc->direction = DMA_MEM_TO_MEM;
> ?
> -	data_width = dw->data_width[dwc->m_master];
> -
> -	src_width = dst_width = min_t(unsigned int, data_width,
> -				??????dwc_fast_ffs(src | dest |
> len));
> +	src_width = dst_width = __ffs(dw->data_width | src | dest |
> len);
> ?
> ?	ctllo = DWC_DEFAULT_CTLLO(chan)
> ?			| DWC_CTLL_DST_WIDTH(dst_width)
> @@ -792,7 +773,6 @@ dwc_prep_slave_sg(struct dma_chan *chan, struct
> scatterlist *sgl,
> ?	dma_addr_t		reg;
> ?	unsigned int		reg_width;
> ?	unsigned int		mem_width;
> -	unsigned int		data_width;
> ?	unsigned int		i;
> ?	struct scatterlist	*sg;
> ?	size_t			total_len = 0;
> @@ -818,8 +798,6 @@ dwc_prep_slave_sg(struct dma_chan *chan, struct
> scatterlist *sgl,
> ?		ctllo |= sconfig->device_fc ?
> DWC_CTLL_FC(DW_DMA_FC_P_M2P) :
> ?			DWC_CTLL_FC(DW_DMA_FC_D_M2P);
> ?
> -		data_width = dw->data_width[dwc->m_master];
> -
> ?		for_each_sg(sgl, sg, sg_len, i) {
> ?			struct dw_desc	*desc;
> ?			u32		len, dlen, mem;
> @@ -827,8 +805,7 @@ dwc_prep_slave_sg(struct dma_chan *chan, struct
> scatterlist *sgl,
> ?			mem = sg_dma_address(sg);
> ?			len = sg_dma_len(sg);
> ?
> -			mem_width = min_t(unsigned int,
> -					??data_width,
> dwc_fast_ffs(mem | len));
> +			mem_width = __ffs(dw->data_width | mem |
> len);
> ?
> ?slave_sg_todev_fill_desc:
> ?			desc = dwc_desc_get(dwc);
> @@ -874,8 +851,6 @@ slave_sg_todev_fill_desc:
> ?		ctllo |= sconfig->device_fc ?
> DWC_CTLL_FC(DW_DMA_FC_P_P2M) :
> ?			DWC_CTLL_FC(DW_DMA_FC_D_P2M);
> ?
> -		data_width = dw->data_width[dwc->m_master];
> -
> ?		for_each_sg(sgl, sg, sg_len, i) {
> ?			struct dw_desc	*desc;
> ?			u32		len, dlen, mem;
> @@ -883,8 +858,7 @@ slave_sg_todev_fill_desc:
> ?			mem = sg_dma_address(sg);
> ?			len = sg_dma_len(sg);
> ?
> -			mem_width = min_t(unsigned int,
> -					??data_width,
> dwc_fast_ffs(mem | len));
> +			mem_width = __ffs(dw->data_width | mem |
> len);
> ?
> ?slave_sg_fromdev_fill_desc:
> ?			desc = dwc_desc_get(dwc);
> @@ -1531,10 +1505,7 @@ int dw_dma_probe(struct dw_dma_chip *chip,
> struct dw_dma_platform_data *pdata)
> ?		/* Get hardware configuration parameters */
> ?		pdata->nr_channels = (dw_params >> DW_PARAMS_NR_CHAN
> & 7) + 1;
> ?		pdata->nr_masters = (dw_params >>
> DW_PARAMS_NR_MASTER & 3) + 1;
> -		for (i = 0; i < pdata->nr_masters; i++) {
> -			pdata->data_width[i] =
> -				(dw_params >>
> DW_PARAMS_DATA_WIDTH(i) & 3) + 2;
> -		}
> +		pdata->data_width = 4 << (dw_params >>
> DW_PARAMS_DATA_WIDTH(0) & 3);
> ?		max_blk_size = dma_readl(dw, MAX_BLK_SIZE);
> ?
> ?		/* Fill platform data with the default values */
> @@ -1556,8 +1527,7 @@ int dw_dma_probe(struct dw_dma_chip *chip,
> struct dw_dma_platform_data *pdata)
> ?
> ?	/* Get hardware configuration parameters */
> ?	dw->nr_masters = pdata->nr_masters;
> -	for (i = 0; i < dw->nr_masters; i++)
> -		dw->data_width[i] = pdata->data_width[i];
> +	dw->data_width = pdata->data_width;
> ?
> ?	/* Calculate all channel mask before DMA setup */
> ?	dw->all_chan_mask = (1 << pdata->nr_channels) - 1;
> diff --git a/drivers/dma/dw/platform.c b/drivers/dma/dw/platform.c
> index d3e1abcebd7f..89d0461f5dcc 100644
> --- a/drivers/dma/dw/platform.c
> +++ b/drivers/dma/dw/platform.c
> @@ -102,8 +102,8 @@ dw_dma_parse_dt(struct platform_device *pdev)
> ?{
> ?	struct device_node *np = pdev->dev.of_node;
> ?	struct dw_dma_platform_data *pdata;
> -	u32 tmp, arr[DW_DMA_MAX_NR_MASTERS];
> ?	u32 nr_channels;
> +	u32 tmp;
> ?
> ?	if (!np) {
> ?		dev_err(&pdev->dev, "Missing DT data\n");
> @@ -138,10 +138,8 @@ dw_dma_parse_dt(struct platform_device *pdev)
> ?		pdata->nr_masters = tmp;
> ?	}
> ?
> -	if (!of_property_read_u32_array(np, "data_width", arr,
> -				pdata->nr_masters))
> -		for (tmp = 0; tmp < pdata->nr_masters; tmp++)
> -			pdata->data_width[tmp] = arr[tmp];
> +	if (!of_property_read_u32(np, "data-width", &tmp))
> +		pdata->data_width = tmp;
> ?
> ?	return pdata;
> ?}
> diff --git a/drivers/dma/dw/regs.h b/drivers/dma/dw/regs.h
> index e4b277565165..87bc97fca084 100644
> --- a/drivers/dma/dw/regs.h
> +++ b/drivers/dma/dw/regs.h
> @@ -285,7 +285,7 @@ struct dw_dma {
> ?
> ?	/* hardware configuration */
> ?	unsigned char		nr_masters;
> -	unsigned char		data_width[DW_DMA_MAX_NR_MASTER
> S];
> +	unsigned char		data_width;
> ?};
> ?
> ?static inline struct dw_dma_regs __iomem *__dw_regs(struct dw_dma
> *dw)
> diff --git a/include/linux/platform_data/dma-dw.h
> b/include/linux/platform_data/dma-dw.h
> index b881b978e486..4120a3eb71ca 100644
> --- a/include/linux/platform_data/dma-dw.h
> +++ b/include/linux/platform_data/dma-dw.h
> @@ -42,8 +42,7 @@ struct dw_dma_slave {
> ? * @chan_priority: Set channel priority increasing from 0 to 7 or 7
> to 0.
> ? * @block_size: Maximum block size supported by the controller
> ? * @nr_masters: Number of AHB masters supported by the controller
> - * @data_width: Maximum data width supported by hardware per AHB
> master
> - *		(0 - 8bits, 1 - 16bits, ..., 5 - 256bits)
> + * @data_width: Maximum data width supported by hardware (in bytes)
> ? */
> ?struct dw_dma_platform_data {
> ?	unsigned int	nr_channels;
> @@ -57,7 +56,7 @@ struct dw_dma_platform_data {
> ?	unsigned char	chan_priority;
> ?	unsigned short	block_size;
> ?	unsigned char	nr_masters;
> -	unsigned char	data_width[DW_DMA_MAX_NR_MASTERS];
> +	unsigned char	data_width;
> ?};
> ?
> ?#endif /* _PLATFORM_DATA_DMA_DW_H */

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
