From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Thu, 15 Oct 2015 09:35:12 +0800
Subject: [PATCH v6 01/10] DMA: pl330: support burst mode for dev-to-mem and
 mem-to-dev transmit
In-Reply-To: <1444872865-2169-1-git-send-email-shawn.lin@rock-chips.com>
References: <1444872865-2169-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <1444872912-2215-1-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boojin Kim <boojin.kim@samsung.com>

This patch adds to support burst mode for dev-to-mem and
mem-to-dev transmit.

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
cc: Heiko Stuebner <heiko@sntech.de>
cc: Doug Anderson <dianders@chromium.org>
cc: Olof Johansson <olof@lixom.net>

Reviewed-by: Sonny Rao <sonnyrao@chromium.org>
---

Changes in v6: None
Changes in v5:
- add Mark's tag for spi changes
- remove unnecessary whitespace change
- use switch statement for i2s quirk

Changes in v4:
- remove spi & i2s dts changes and query quirk from dmaengine API
  suggeseted by Mark.
- fix typo
- Add dmaengine_get_quirk hook and implement it for pl330

Changes in v3:
- add Sunny's tag
- add more rockchip drivers' changes in this patchset

Changes in v2:
- amend the author
- reorder the patches suggested by Doug
- add Reviewed-by: Doug Anderson <dianders@chromium.org> for
  rk3288.dtsi patch and arm-pl330.txt patch

Changes in v1:
- rename broken-no-flushp to "arm,pl330-broken-no-flushp" suggested
  by Krzysztof.
- add From original author.
- remove Sunny's tag

 drivers/dma/pl330.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 17ee758..7cdf8d4 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -1141,10 +1141,13 @@ static inline int _ldst_devtomem(unsigned dry_run, u8 buf[],
 		const struct _xfer_spec *pxs, int cyc)
 {
 	int off = 0;
+	enum pl330_cond cond;
+
+	cond = (pxs->desc->rqcfg.brst_len == 1) ? SINGLE : BURST;
 
 	while (cyc--) {
-		off += _emit_WFP(dry_run, &buf[off], SINGLE, pxs->desc->peri);
-		off += _emit_LDP(dry_run, &buf[off], SINGLE, pxs->desc->peri);
+		off += _emit_WFP(dry_run, &buf[off], cond, pxs->desc->peri);
+		off += _emit_LDP(dry_run, &buf[off], cond, pxs->desc->peri);
 		off += _emit_ST(dry_run, &buf[off], ALWAYS);
 		off += _emit_FLUSHP(dry_run, &buf[off], pxs->desc->peri);
 	}
@@ -1156,11 +1159,14 @@ static inline int _ldst_memtodev(unsigned dry_run, u8 buf[],
 		const struct _xfer_spec *pxs, int cyc)
 {
 	int off = 0;
+	enum pl330_cond cond;
+
+	cond = (pxs->desc->rqcfg.brst_len == 1) ? SINGLE : BURST;
 
 	while (cyc--) {
-		off += _emit_WFP(dry_run, &buf[off], SINGLE, pxs->desc->peri);
+		off += _emit_WFP(dry_run, &buf[off], cond, pxs->desc->peri);
 		off += _emit_LD(dry_run, &buf[off], ALWAYS);
-		off += _emit_STP(dry_run, &buf[off], SINGLE, pxs->desc->peri);
+		off += _emit_STP(dry_run, &buf[off], cond, pxs->desc->peri);
 		off += _emit_FLUSHP(dry_run, &buf[off], pxs->desc->peri);
 	}
 
@@ -1199,7 +1205,7 @@ static inline int _loop(unsigned dry_run, u8 buf[],
 	struct _arg_LPEND lpend;
 
 	if (*bursts == 1)
-		return _bursts(dry_run, buf, pxs, 1);
+		return _bursts(pl330, dry_run, buf, pxs, 1);
 
 	/* Max iterations possible in DMALP is 256 */
 	if (*bursts >= 256*256) {
@@ -2560,7 +2566,7 @@ static struct dma_async_tx_descriptor *pl330_prep_dma_cyclic(
 
 		desc->rqtype = direction;
 		desc->rqcfg.brst_size = pch->burst_sz;
-		desc->rqcfg.brst_len = 1;
+		desc->rqcfg.brst_len = pch->burst_len;
 		desc->bytes_requested = period_len;
 		fill_px(&desc->px, dst, src, period_len);
 
@@ -2705,7 +2711,7 @@ pl330_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		}
 
 		desc->rqcfg.brst_size = pch->burst_sz;
-		desc->rqcfg.brst_len = 1;
+		desc->rqcfg.brst_len = pch->burst_len;
 		desc->rqtype = direction;
 		desc->bytes_requested = sg_dma_len(sg);
 	}
-- 
2.3.7
