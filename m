From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Dec 2010 10:07:24 +0000
Subject: [PATCH 04/11] ARM: PL08x: don't assume that the LLI pointer has the
	bus bit clear
In-Reply-To: <20101224100550.GB20587@n2100.arm.linux.org.uk>
References: <20101224100550.GB20587@n2100.arm.linux.org.uk>
Message-ID: <E1PW4YW-0006DS-8X@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We only want use the address of the LLI pointer when locating the
corresponding structure in memory, so clear the master bus selection
bit.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 53ca6a9..c6a8283 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -349,7 +349,7 @@ static u32 pl08x_getbytes_chan(struct pl08x_dma_chan *plchan)
 	if (ch && txd) {
 		struct lli *llis_va = txd->llis_va;
 		struct lli *llis_bus = (struct lli *) txd->llis_bus;
-		u32 clli = readl(ch->base + PL080_CH_LLI);
+		u32 clli = readl(ch->base + PL080_CH_LLI) & ~PL080_LLI_LM_AHB2;
 
 		/* First get the bytes in the current active LLI */
 		bytes = get_bytes_in_cctl(readl(ch->base + PL080_CH_CONTROL));
-- 
1.6.2.5
