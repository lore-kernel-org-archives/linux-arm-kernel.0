From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 13 Apr 2018 09:32:33 +0530
Subject: [PATCH v2 2/2] dmaengine: stm32-mdma: Fix incomplete Hw
 descriptors allocator
In-Reply-To: <1523457879-9869-3-git-send-email-pierre-yves.mordret@st.com>
References: <1523457879-9869-1-git-send-email-pierre-yves.mordret@st.com>
 <1523457879-9869-3-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <20180413040233.GJ6014@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2018 at 04:44:39PM +0200, Pierre-Yves MORDRET wrote:

>  struct stm32_mdma_desc {
>  	struct virt_dma_desc vdesc;
>  	u32 ccr;
> -	struct stm32_mdma_hwdesc *hwdesc;
> -	dma_addr_t hwdesc_phys;
>  	bool cyclic;
>  	u32 count;
> +	struct stm32_mdma_desc_node node[];

some ppl use node[0] for this but i think either is fine..

>  static void stm32_mdma_dump_hwdesc(struct stm32_mdma_chan *chan,
> -				   struct stm32_mdma_hwdesc *hwdesc)
> +				   struct stm32_mdma_desc_node *node)
>  {
> -	dev_dbg(chan2dev(chan), "CTCR:    0x%08x\n", hwdesc->ctcr);

> +	dev_dbg(chan2dev(chan), "CTCR:    0x%08x\n", node->hwdesc->ctcr);

this is noise for this patch and IIUC you should be able to pass
node->hwdesc and keep fn same?

-- 
~Vinod
