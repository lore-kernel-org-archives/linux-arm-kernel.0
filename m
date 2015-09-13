From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Mon, 14 Sep 2015 07:48:18 +0800
Subject: [PATCH v5 03/10] DMA: pl330: add quirk for broken no flushp
In-Reply-To: <1442187923-5736-1-git-send-email-shawn.lin@rock-chips.com>
References: <1442187923-5736-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <1442188098-5890-1-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Addy Ke <addy.ke@rock-chips.com>

This patch add "arm,pl330-broken-no-flushp" quirk to avoid execute
DMAFLUSHP if Soc doesn't support it.

Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
cc: Doug Anderson <dianders@chromium.org>
cc: Heiko Stuebner <heiko@sntech.de>
cc: Olof Johansson <olof@lixom.net>

Reviewed-by: Sonny Rao <sonnyrao@chromium.org>
---

Changes in v5: None
Changes in v4: None
Changes in v3:
- add Reviewed-by: Sonny Rao <sonnyrao@chromium.org>

Changes in v2:
- amend the author
- fix Olof's mail address

Changes in v1:
- rename broken-no-flushp to "arm,pl330-broken-no-flushp" suggested
  by Krzysztof.
- remove Sunny's tag

 drivers/dma/pl330.c | 87 ++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 62 insertions(+), 25 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 0d544d2..3b9b426 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -34,6 +34,8 @@
 #define PL330_MAX_IRQS		32
 #define PL330_MAX_PERI		32
 
+#define PL330_QUIRK_BROKEN_NO_FLUSHP BIT(0)
+
 enum pl330_cachectrl {
 	CCTRL0,		/* Noncacheable and nonbufferable */
 	CCTRL1,		/* Bufferable only */
@@ -488,6 +490,17 @@ struct pl330_dmac {
 	/* Peripheral channels connected to this DMAC */
 	unsigned int num_peripherals;
 	struct dma_pl330_chan *peripherals; /* keep at end */
+	int quirks;
+};
+
+static struct pl330_of_quirks {
+	char *quirk;
+	int id;
+} of_quirks[] = {
+	{
+		.quirk = "arm,pl330-broken-no-flushp",
+		.id = PL330_QUIRK_BROKEN_NO_FLUSHP,
+	}
 };
 
 struct dma_pl330_desc {
@@ -1137,53 +1150,68 @@ static inline int _ldst_memtomem(unsigned dry_run, u8 buf[],
 	return off;
 }
 
-static inline int _ldst_devtomem(unsigned dry_run, u8 buf[],
-		const struct _xfer_spec *pxs, int cyc)
+static inline int _ldst_devtomem(struct pl330_dmac *pl330, unsigned dry_run,
+				 u8 buf[], const struct _xfer_spec *pxs,
+				 int cyc)
 {
 	int off = 0;
 	enum pl330_cond cond;
 
-	cond = (pxs->desc->rqcfg.brst_len == 1) ? SINGLE : BURST;
+	if (pl330->quirks & PL330_QUIRK_BROKEN_NO_FLUSHP)
+		cond = BURST;
+	else
+		cond = (pxs->desc->rqcfg.brst_len == 1) ? SINGLE : BURST;
 
 	while (cyc--) {
 		off += _emit_WFP(dry_run, &buf[off], cond, pxs->desc->peri);
 		off += _emit_LDP(dry_run, &buf[off], cond, pxs->desc->peri);
 		off += _emit_ST(dry_run, &buf[off], ALWAYS);
-		off += _emit_FLUSHP(dry_run, &buf[off], pxs->desc->peri);
+
+		if (!(pl330->quirks & PL330_QUIRK_BROKEN_NO_FLUSHP))
+			off += _emit_FLUSHP(dry_run, &buf[off],
+					    pxs->desc->peri);
 	}
 
 	return off;
 }
 
-static inline int _ldst_memtodev(unsigned dry_run, u8 buf[],
-		const struct _xfer_spec *pxs, int cyc)
+static inline int _ldst_memtodev(struct pl330_dmac *pl330,
+				 unsigned dry_run, u8 buf[],
+				 const struct _xfer_spec *pxs, int cyc)
 {
 	int off = 0;
 	enum pl330_cond cond;
 
-	cond = (pxs->desc->rqcfg.brst_len == 1) ? SINGLE : BURST;
+	if (pl330->quirks & PL330_QUIRK_BROKEN_NO_FLUSHP)
+		cond = BURST;
+	else
+		cond = (pxs->desc->rqcfg.brst_len == 1) ? SINGLE : BURST;
+
 
 	while (cyc--) {
 		off += _emit_WFP(dry_run, &buf[off], cond, pxs->desc->peri);
 		off += _emit_LD(dry_run, &buf[off], ALWAYS);
 		off += _emit_STP(dry_run, &buf[off], cond, pxs->desc->peri);
-		off += _emit_FLUSHP(dry_run, &buf[off], pxs->desc->peri);
+
+		if (!(pl330->quirks & PL330_QUIRK_BROKEN_NO_FLUSHP))
+			off += _emit_FLUSHP(dry_run, &buf[off],
+					    pxs->desc->peri);
 	}
 
 	return off;
 }
 
-static int _bursts(unsigned dry_run, u8 buf[],
+static int _bursts(struct pl330_dmac *pl330, unsigned dry_run, u8 buf[],
 		const struct _xfer_spec *pxs, int cyc)
 {
 	int off = 0;
 
 	switch (pxs->desc->rqtype) {
 	case DMA_MEM_TO_DEV:
-		off += _ldst_memtodev(dry_run, &buf[off], pxs, cyc);
+		off += _ldst_memtodev(pl330, dry_run, &buf[off], pxs, cyc);
 		break;
 	case DMA_DEV_TO_MEM:
-		off += _ldst_devtomem(dry_run, &buf[off], pxs, cyc);
+		off += _ldst_devtomem(pl330, dry_run, &buf[off], pxs, cyc);
 		break;
 	case DMA_MEM_TO_MEM:
 		off += _ldst_memtomem(dry_run, &buf[off], pxs, cyc);
@@ -1197,7 +1225,7 @@ static int _bursts(unsigned dry_run, u8 buf[],
 }
 
 /* Returns bytes consumed and updates bursts */
-static inline int _loop(unsigned dry_run, u8 buf[],
+static inline int _loop(struct pl330_dmac *pl330, unsigned dry_run, u8 buf[],
 		unsigned long *bursts, const struct _xfer_spec *pxs)
 {
 	int cyc, cycmax, szlp, szlpend, szbrst, off;
@@ -1220,7 +1248,7 @@ static inline int _loop(unsigned dry_run, u8 buf[],
 	}
 
 	szlp = _emit_LP(1, buf, 0, 0);
-	szbrst = _bursts(1, buf, pxs, 1);
+	szbrst = _bursts(pl330, 1, buf, pxs, 1);
 
 	lpend.cond = ALWAYS;
 	lpend.forever = false;
@@ -1252,7 +1280,7 @@ static inline int _loop(unsigned dry_run, u8 buf[],
 	off += _emit_LP(dry_run, &buf[off], 1, lcnt1);
 	ljmp1 = off;
 
-	off += _bursts(dry_run, &buf[off], pxs, cyc);
+	off += _bursts(pl330, dry_run, &buf[off], pxs, cyc);
 
 	lpend.cond = ALWAYS;
 	lpend.forever = false;
@@ -1275,8 +1303,9 @@ static inline int _loop(unsigned dry_run, u8 buf[],
 	return off;
 }
 
-static inline int _setup_loops(unsigned dry_run, u8 buf[],
-		const struct _xfer_spec *pxs)
+static inline int _setup_loops(struct pl330_dmac *pl330,
+			       unsigned dry_run, u8 buf[],
+			       const struct _xfer_spec *pxs)
 {
 	struct pl330_xfer *x = &pxs->desc->px;
 	u32 ccr = pxs->ccr;
@@ -1285,15 +1314,16 @@ static inline int _setup_loops(unsigned dry_run, u8 buf[],
 
 	while (bursts) {
 		c = bursts;
-		off += _loop(dry_run, &buf[off], &c, pxs);
+		off += _loop(pl330, dry_run, &buf[off], &c, pxs);
 		bursts -= c;
 	}
 
 	return off;
 }
 
-static inline int _setup_xfer(unsigned dry_run, u8 buf[],
-		const struct _xfer_spec *pxs)
+static inline int _setup_xfer(struct pl330_dmac *pl330,
+			      unsigned dry_run, u8 buf[],
+			      const struct _xfer_spec *pxs)
 {
 	struct pl330_xfer *x = &pxs->desc->px;
 	int off = 0;
@@ -1304,7 +1334,7 @@ static inline int _setup_xfer(unsigned dry_run, u8 buf[],
 	off += _emit_MOV(dry_run, &buf[off], DAR, x->dst_addr);
 
 	/* Setup Loop(s) */
-	off += _setup_loops(dry_run, &buf[off], pxs);
+	off += _setup_loops(pl330, dry_run, &buf[off], pxs);
 
 	return off;
 }
@@ -1313,8 +1343,9 @@ static inline int _setup_xfer(unsigned dry_run, u8 buf[],
  * A req is a sequence of one or more xfer units.
  * Returns the number of bytes taken to setup the MC for the req.
  */
-static int _setup_req(unsigned dry_run, struct pl330_thread *thrd,
-		unsigned index, struct _xfer_spec *pxs)
+static int _setup_req(struct pl330_dmac *pl330, unsigned dry_run,
+		      struct pl330_thread *thrd, unsigned index,
+		      struct _xfer_spec *pxs)
 {
 	struct _pl330_req *req = &thrd->req[index];
 	struct pl330_xfer *x;
@@ -1331,7 +1362,7 @@ static int _setup_req(unsigned dry_run, struct pl330_thread *thrd,
 	if (x->bytes % (BRST_SIZE(pxs->ccr) * BRST_LEN(pxs->ccr)))
 		return -EINVAL;
 
-	off += _setup_xfer(dry_run, &buf[off], pxs);
+	off += _setup_xfer(pl330, dry_run, &buf[off], pxs);
 
 	/* DMASEV peripheral/event */
 	off += _emit_SEV(dry_run, &buf[off], thrd->ev);
@@ -1425,7 +1456,7 @@ static int pl330_submit_req(struct pl330_thread *thrd,
 	xs.desc = desc;
 
 	/* First dry run to check if req is acceptable */
-	ret = _setup_req(1, thrd, idx, &xs);
+	ret = _setup_req(pl330, 1, thrd, idx, &xs);
 	if (ret < 0)
 		goto xfer_exit;
 
@@ -1439,7 +1470,7 @@ static int pl330_submit_req(struct pl330_thread *thrd,
 	/* Hook the request */
 	thrd->lstenq = idx;
 	thrd->req[idx].desc = desc;
-	_setup_req(0, thrd, idx, &xs);
+	_setup_req(pl330, 0, thrd, idx, &xs);
 
 	ret = 0;
 
@@ -2784,6 +2815,7 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 	struct resource *res;
 	int i, ret, irq;
 	int num_chan;
+	struct device_node *np = adev->dev.of_node;
 
 	pdat = dev_get_platdata(&adev->dev);
 
@@ -2803,6 +2835,11 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 
 	pl330->mcbufsz = pdat ? pdat->mcbuf_sz : 0;
 
+	/* get quirk */
+	for (i = 0; i < ARRAY_SIZE(of_quirks); i++)
+		if (of_property_read_bool(np, of_quirks[i].quirk))
+			pl330->quirks |= of_quirks[i].id;
+
 	res = &adev->res;
 	pl330->base = devm_ioremap_resource(&adev->dev, res);
 	if (IS_ERR(pl330->base))
-- 
2.3.7
