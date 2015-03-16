From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon, 16 Mar 2015 11:52:43 +0000
Subject: [PATCH 1/3] dmaengine: pl330: fix issues with big-endian armv7
In-Reply-To: <1426506765-10085-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1426506765-10085-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1426506765-10085-2-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When running Xilinx Zynq in big-endian mode the pl330 driver
fails to pass the dmatest suite. To fix this, ensure all non
byte values are written in little endian.

As a note, the documentation does not mention if it will do
big-endian descriptor fetches, only that it will swap the
data in flight.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
Vinod Koul <vinod.koul@intel.com>
Dan Williams <dan.j.williams@intel.com>
DMA List <dmaengine@vger.kernel.org>
Maxime Ripard <maxime.ripard@free-electrons.com>
Jassi Brar <jassisinghbrar@gmail.com>
Liviu Dudau <Liviu.Dudau@arm.com>
Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
---
 drivers/dma/pl330.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 0e1f567..f76c94c 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -556,7 +556,7 @@ static inline u32 _emit_ADDH(unsigned dry_run, u8 buf[],
 
 	buf[0] = CMD_DMAADDH;
 	buf[0] |= (da << 1);
-	*((u16 *)&buf[1]) = val;
+	*((__le16 *)&buf[1]) = cpu_to_le16(val);
 
 	PL330_DBGCMD_DUMP(SZ_DMAADDH, "\tDMAADDH %s %u\n",
 		da == 1 ? "DA" : "SA", val);
@@ -710,7 +710,7 @@ static inline u32 _emit_MOV(unsigned dry_run, u8 buf[],
 
 	buf[0] = CMD_DMAMOV;
 	buf[1] = dst;
-	*((u32 *)&buf[2]) = val;
+	*((__le32 *)&buf[2]) = cpu_to_le32(val);
 
 	PL330_DBGCMD_DUMP(SZ_DMAMOV, "\tDMAMOV %s 0x%x\n",
 		dst == SAR ? "SAR" : (dst == DAR ? "DAR" : "CCR"), val);
@@ -888,7 +888,7 @@ static inline u32 _emit_GO(unsigned dry_run, u8 buf[],
 
 	buf[1] = chan & 0x7;
 
-	*((u32 *)&buf[2]) = addr;
+	*((__le32 *)&buf[2]) = cpu_to_le32(addr);
 
 	return SZ_DMAGO;
 }
@@ -928,7 +928,7 @@ static inline void _execute_DBGINSN(struct pl330_thread *thrd,
 	}
 	writel(val, regs + DBGINST0);
 
-	val = *((u32 *)&insn[2]);
+	val = le32_to_cpu(*((__le32 *)&insn[2]));
 	writel(val, regs + DBGINST1);
 
 	/* If timed out due to halted state-machine */
-- 
2.1.4
