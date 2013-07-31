From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 31 Jul 2013 10:33:50 +0900
Subject: [PATCH 2/4] shdma: fixup sh_dmae_get_partial() calculation error
In-Reply-To: <cover.1375234088.git.horms+renesas@verge.net.au>
References: <cover.1375234088.git.horms+renesas@verge.net.au>
Message-ID: <3c4d9276626c93477af0b0b9d46b4dcb37e2eed2.1375234088.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

sh_desc->hw.tcr is controlling real data size,
and, register TCR is controlling data transfer count
which was xmit_shifted value of hw.tcr.
Current sh_dmae_get_partial() is calculating in different unit.
This patch fixes it.

This bug has been present since c014906a870ce70e009def0c9d170ccabeb0be63
("dmaengine: shdma: extend .device_terminate_all() to record partial
transfer"), which was added in 2.6.34-rc1.

Cc: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/dma/sh/shdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/shdma.c b/drivers/dma/sh/shdma.c
index b67f45f..5039fbc 100644
--- a/drivers/dma/sh/shdma.c
+++ b/drivers/dma/sh/shdma.c
@@ -400,8 +400,8 @@ static size_t sh_dmae_get_partial(struct shdma_chan *schan,
 						    shdma_chan);
 	struct sh_dmae_desc *sh_desc = container_of(sdesc,
 					struct sh_dmae_desc, shdma_desc);
-	return (sh_desc->hw.tcr - sh_dmae_readl(sh_chan, TCR)) <<
-		sh_chan->xmit_shift;
+	return sh_desc->hw.tcr -
+		(sh_dmae_readl(sh_chan, TCR) << sh_chan->xmit_shift);
 }
 
 /* Called from error IRQ or NMI */
-- 
1.8.3.2
