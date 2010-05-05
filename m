From: svenkatr@ti.com (Venkatraman S)
Date: Wed, 5 May 2010 17:20:15 +0530
Subject: [PATCH v8 1/2] sDMA: descriptor autoloading feature
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C52D16D1@dbde02.ent.ti.com>
References: <l2i618f0c911004291035ja334efb0o5016c5cb70c4b5bc@mail.gmail.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C52D16D1@dbde02.ent.ti.com>
Message-ID: <k2l618f0c911005050450t75968621m61e3ff39e90d20ad@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Long sections have been trimmed to the context of the discussion]
On Wed, May 5, 2010 at 3:02 PM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
>> -----Original Message-----
>> +static int dma_sglist_set_phy_params(struct omap_dma_sglist_node *sghead,
>> + ? ? ? ? ? ? dma_addr_t phyaddr, int nelem)
>> +{
>> + ? ? struct omap_dma_sglist_node *sgcurr, *sgprev;
>> + ? ? dma_addr_t elem_paddr = phyaddr;
>> +
>> + ? ? for (sgprev = sghead;
>> + ? ? ? ? ? ? sgprev < sghead + nelem;
>> + ? ? ? ? ? ? sgprev++) {
>> +
>> + ? ? ? ? ? ? sgcurr = sgprev + 1;
>> + ? ? ? ? ? ? sgprev->next = sgcurr;
>> + ? ? ? ? ? ? elem_paddr += (int)sizeof(*sgcurr);
>> + ? ? ? ? ? ? sgprev->next_desc_add_ptr = elem_paddr;
>> +
>> + ? ? ? ? ? ? switch (sgcurr->desc_type) {
>> + ? ? ? ? ? ? case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE1:
>> + ? ? ? ? ? ? ? ? ? ? omap_dma_list_set_ntype(sgprev, 1);
>> + ? ? ? ? ? ? ? ? ? ? break;
>> +
>> + ? ? ? ? ? ? case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2a:
>> + ? ? ? ? ? ? /* intentional no break */
>> + ? ? ? ? ? ? case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2b:
>> + ? ? ? ? ? ? ? ? ? ? omap_dma_list_set_ntype(sgprev, 2);
>> + ? ? ? ? ? ? ? ? ? ? break;
>> +
>> + ? ? ? ? ? ? case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3a:
>> + ? ? ? ? ? ? ? ? ? ? /* intentional no break */
>> + ? ? ? ? ? ? case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3b:
>> + ? ? ? ? ? ? ? ? ? ? omap_dma_list_set_ntype(sgprev, 3);
>> + ? ? ? ? ? ? ? ? ? ? break;
>> +
>> + ? ? ? ? ? ? default:
>> + ? ? ? ? ? ? ? ? ? ? return -EINVAL;
>> +
>> + ? ? ? ? ? ? }
> Are we supporting all the descriptor types. I think only type2a is
> supported. In that case please add FIXME, or WARN message here.
