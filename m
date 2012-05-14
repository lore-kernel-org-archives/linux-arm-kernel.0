From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 14 May 2012 18:44:25 +1000
Subject: linux-next: manual merge of the arm-soc tree with the slave-dma tree
Message-ID: <20120514184425.5747f862e369e2f291bfba69@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/dma/imx-sdma.c between commit 2ccaef0520d1 ("dma: imx-sdma: make
channel0 operations atomic") from the slave-dma tree and commit
7560e3f3581e ("dmaengine i.MX SDMA: do not depend on grouped clocks")
from the arm-soc tree.

Just context changes.  I fixed it up (see below) and can carry the fix as
necessary.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/dma/imx-sdma.c
index a472a29,fddccae..0000000
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@@ -323,8 -322,9 +323,9 @@@ struct sdma_engine 
  	struct sdma_context_data	*context;
  	dma_addr_t			context_phys;
  	struct dma_device		dma_device;
- 	struct clk			*clk;
+ 	struct clk			*clk_ipg;
+ 	struct clk			*clk_ahb;
 -	struct mutex			channel_0_lock;
 +	spinlock_t			channel_0_lock;
  	struct sdma_script_start_addrs	*script_addrs;
  };
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120514/375c2918/attachment.sig>
