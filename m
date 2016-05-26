From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 26 May 2016 20:48:05 +0200
Subject: [PATCH V3 1/2] i2c: qup: Fix broken dma when CONFIG_DEBUG_SG is
 enabled
In-Reply-To: <1464164212-11377-2-git-send-email-sricharan@codeaurora.org>
References: <1464164212-11377-1-git-send-email-sricharan@codeaurora.org>
 <1464164212-11377-2-git-send-email-sricharan@codeaurora.org>
Message-ID: <20160526184805.GC1614@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> sg_set_buf expects that the buf parameter passed in should be from
> lowmem and a valid pageframe. This is not true for pages from
> dma_alloc_coherent which can be carveouts, hence the check fails.

OK, given you mean dma_pool_alloc here, the check fails for the
pageframe because of the pool? Is my understanding correct?

> Change allocation of sg buffers from dma_coherent memory to kzalloc
> to fix the issue.

But why can you drop the coherency?

> @@ -1268,6 +1260,8 @@ static int qup_i2c_xfer_v2(struct i2c_adapter *adap,
>  		}
>  	}
>  
> +	idx = 0;
> +

This looks like an unrelated change.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160526/fc8f1e78/attachment.sig>
