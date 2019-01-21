Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D09C7112F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:25:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E69A62084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EsQN54Zl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E69A62084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cW8juTl9+EPzMHhBJC25aGu5DbHqCqjL2VdKDDfAoIs=; b=EsQN54ZlO2a0TZ
	Tzvew6afuBbYrQgCN0WSu3gGGXk7KqDIu2pQ9fxBflalm6SoAXx4DzEGi0EJc5hjIGFdTU3qLqPcq
	wWRQTNSwLdXe2ABlXW/TjTWcISeUulZKubWrEkS/rgWGOKJijZ5odQHNzZ6EajblWvaP6NAqCwyo0
	Q4cAhyiXozW+0kaB4ZzbF+ervMRagTNm1ruq7M0cq6UsYoaFJfZ6UqmXhz2ai18XefWQQhpun4pxc
	VeQBfaiaEuObB3Y97KZRcB5xMqt0FfKBqOnCfccOg7Bu/TsG8huNnrW9M7huWTUPr0ec0e7s9rW69
	YYtDWHQpQ1ws3uSEWxQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glYdM-0004yk-VY; Mon, 21 Jan 2019 12:24:57 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glYbR-0003Ev-24; Mon, 21 Jan 2019 12:23:12 +0000
X-UUID: a3943978879f4e9c803843450d017265-20190121
X-UUID: a3943978879f4e9c803843450d017265-20190121
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
 (envelope-from <min.guo@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1556417745; Mon, 21 Jan 2019 04:22:55 -0800
Received: from MTKMBS31N2.mediatek.inc (172.27.4.87) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 21 Jan 2019 04:22:53 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 21 Jan 2019 20:22:51 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 21 Jan 2019 20:22:50 +0800
From: <min.guo@mediatek.com>
To: Bin Liu <b-liu@ti.com>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 5/6] usb: musb: Add musb_clearb/w() interface
Date: Mon, 21 Jan 2019 20:22:30 +0800
Message-ID: <1548073351-13739-6-git-send-email-min.guo@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1548073351-13739-1-git-send-email-min.guo@mediatek.com>
References: <1548073351-13739-1-git-send-email-min.guo@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_042257_391994_23963776 
X-CRM114-Status: GOOD (  12.87  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 hdegoede@redhat.com, tony@atomide.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Alan Stern <stern@rowland.harvard.edu>, Min Guo <min.guo@mediatek.com>,
 chunfeng.yun@mediatek.com, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Min Guo <min.guo@mediatek.com>

Delete the const attribute of addr parameter in readb/w/l hooks, these
changes are for implementing clearing W1C registers.
Replace musb_readb/w with musb_clearb/w to clear the interrupt status.

Signed-off-by: Min Guo <min.guo@mediatek.com>
---
new patch based on v3:
---
 drivers/usb/musb/musb_core.c | 32 +++++++++++++++++++++++---------
 drivers/usb/musb/musb_core.h |  8 ++++++--
 drivers/usb/musb/musb_io.h   |  8 +++++---
 drivers/usb/musb/musbhsdma.c |  3 +++
 drivers/usb/musb/sunxi.c     |  4 ++--
 drivers/usb/musb/tusb6010.c  |  2 +-
 6 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 2fe5225..5ef8848 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -246,7 +246,7 @@ static u32 musb_default_busctl_offset(u8 epnum, u16 offset)
 	return 0x80 + (0x08 * epnum) + offset;
 }
 
-static u8 musb_default_readb(const void __iomem *addr, unsigned offset)
+static u8 musb_default_readb(void __iomem *addr, unsigned offset)
 {
 	u8 data =  __raw_readb(addr + offset);
 
@@ -260,7 +260,7 @@ static void musb_default_writeb(void __iomem *addr, unsigned offset, u8 data)
 	__raw_writeb(data, addr + offset);
 }
 
-static u16 musb_default_readw(const void __iomem *addr, unsigned offset)
+static u16 musb_default_readw(void __iomem *addr, unsigned offset)
 {
 	u16 data = __raw_readw(addr + offset);
 
@@ -396,19 +396,25 @@ static void musb_default_read_fifo(struct musb_hw_ep *hw_ep, u16 len, u8 *dst)
 /*
  * Old style IO functions
  */
-u8 (*musb_readb)(const void __iomem *addr, unsigned offset);
+u8 (*musb_readb)(void __iomem *addr, unsigned offset);
 EXPORT_SYMBOL_GPL(musb_readb);
 
 void (*musb_writeb)(void __iomem *addr, unsigned offset, u8 data);
 EXPORT_SYMBOL_GPL(musb_writeb);
 
-u16 (*musb_readw)(const void __iomem *addr, unsigned offset);
+u8 (*musb_clearb)(void __iomem *addr, unsigned int offset);
+EXPORT_SYMBOL_GPL(musb_clearb);
+
+u16 (*musb_readw)(void __iomem *addr, unsigned offset);
 EXPORT_SYMBOL_GPL(musb_readw);
 
 void (*musb_writew)(void __iomem *addr, unsigned offset, u16 data);
 EXPORT_SYMBOL_GPL(musb_writew);
 
-u32 musb_readl(const void __iomem *addr, unsigned offset)
+u16 (*musb_clearw)(void __iomem *addr, unsigned int offset);
+EXPORT_SYMBOL_GPL(musb_clearw);
+
+u32 musb_readl(void __iomem *addr, unsigned offset)
 {
 	u32 data = __raw_readl(addr + offset);
 
@@ -1047,7 +1053,6 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
 static void musb_disable_interrupts(struct musb *musb)
 {
 	void __iomem	*mbase = musb->mregs;
-	u16	temp;
 
 	/* disable interrupts */
 	musb_writeb(mbase, MUSB_INTRUSBE, 0);
@@ -1057,9 +1062,9 @@ static void musb_disable_interrupts(struct musb *musb)
 	musb_writew(mbase, MUSB_INTRRXE, 0);
 
 	/*  flush pending interrupts */
-	temp = musb_readb(mbase, MUSB_INTRUSB);
-	temp = musb_readw(mbase, MUSB_INTRTX);
-	temp = musb_readw(mbase, MUSB_INTRRX);
+	musb_clearb(mbase, MUSB_INTRUSB);
+	musb_clearw(mbase, MUSB_INTRTX);
+	musb_clearw(mbase, MUSB_INTRRX);
 }
 
 static void musb_enable_interrupts(struct musb *musb)
@@ -2284,10 +2289,19 @@ static void musb_deassert_reset(struct work_struct *work)
 		musb_readb = musb->ops->readb;
 	if (musb->ops->writeb)
 		musb_writeb = musb->ops->writeb;
+	if (musb->ops->clearb)
+		musb_clearb = musb->ops->clearb;
+	else
+		musb_clearb = musb_readb;
+
 	if (musb->ops->readw)
 		musb_readw = musb->ops->readw;
 	if (musb->ops->writew)
 		musb_writew = musb->ops->writew;
+	if (musb->ops->clearw)
+		musb_clearw = musb->ops->clearw;
+	else
+		musb_clearw = musb_readw;
 
 #ifndef CONFIG_MUSB_PIO_ONLY
 	if (!musb->ops->dma_init || !musb->ops->dma_exit) {
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 9f5a69c..0d9a35f 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -120,8 +120,10 @@ enum musb_g_ep0_state {
  * @fifo_offset: returns the fifo offset
  * @readb:	read 8 bits
  * @writeb:	write 8 bits
+ * @clearb:	could be clear-on-readb or W1C
  * @readw:	read 16 bits
  * @writew:	write 16 bits
+ * @clearw:	could be clear-on-readw or W1C
  * @read_fifo:	reads the fifo
  * @write_fifo:	writes to fifo
  * @get_toggle:	platform specific get toggle function
@@ -164,10 +166,12 @@ struct musb_platform_ops {
 	u16	fifo_mode;
 	u32	(*fifo_offset)(u8 epnum);
 	u32	(*busctl_offset)(u8 epnum, u16 offset);
-	u8	(*readb)(const void __iomem *addr, unsigned offset);
+	u8	(*readb)(void __iomem *addr, unsigned offset);
 	void	(*writeb)(void __iomem *addr, unsigned offset, u8 data);
-	u16	(*readw)(const void __iomem *addr, unsigned offset);
+	u8	(*clearb)(void __iomem *addr, unsigned int offset);
+	u16	(*readw)(void __iomem *addr, unsigned offset);
 	void	(*writew)(void __iomem *addr, unsigned offset, u16 data);
+	u16	(*clearw)(void __iomem *addr, unsigned int offset);
 	void	(*read_fifo)(struct musb_hw_ep *hw_ep, u16 len, u8 *buf);
 	void	(*write_fifo)(struct musb_hw_ep *hw_ep, u16 len, const u8 *buf);
 	u16	(*get_toggle)(struct musb_qh *qh, int is_out);
diff --git a/drivers/usb/musb/musb_io.h b/drivers/usb/musb/musb_io.h
index 8179334..7200596 100644
--- a/drivers/usb/musb/musb_io.h
+++ b/drivers/usb/musb/musb_io.h
@@ -37,11 +37,13 @@ struct musb_io {
 };
 
 /* Do not add new entries here, add them the struct musb_io instead */
-extern u8 (*musb_readb)(const void __iomem *addr, unsigned offset);
+extern u8 (*musb_readb)(void __iomem *addr, unsigned offset);
 extern void (*musb_writeb)(void __iomem *addr, unsigned offset, u8 data);
-extern u16 (*musb_readw)(const void __iomem *addr, unsigned offset);
+extern u8 (*musb_clearb)(void __iomem *addr, unsigned int offset);
+extern u16 (*musb_readw)(void __iomem *addr, unsigned offset);
 extern void (*musb_writew)(void __iomem *addr, unsigned offset, u16 data);
-extern u32 musb_readl(const void __iomem *addr, unsigned offset);
+extern u16 (*musb_clearw)(void __iomem *addr, unsigned int offset);
+extern u32 musb_readl(void __iomem *addr, unsigned offset);
 extern void musb_writel(void __iomem *addr, unsigned offset, u32 data);
 
 #endif
diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index b2394a7..7bf91cb 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -286,6 +286,9 @@ irqreturn_t dma_controller_irq(int irq, void *private_data)
 
 	int_hsdma = musb_readb(mbase, MUSB_HSDMA_INTR);
 
+	/* clear pending interrupts by manual */
+	musb_clearb(musb->mregs, MUSB_HSDMA_INTR);
+
 	if (!int_hsdma) {
 		musb_dbg(musb, "spurious DMA irq");
 
diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
index 832a41f..2c1bbaa 100644
--- a/drivers/usb/musb/sunxi.c
+++ b/drivers/usb/musb/sunxi.c
@@ -407,7 +407,7 @@ static u32 sunxi_musb_busctl_offset(u8 epnum, u16 offset)
 	return SUNXI_MUSB_TXFUNCADDR + offset;
 }
 
-static u8 sunxi_musb_readb(const void __iomem *addr, unsigned offset)
+static u8 sunxi_musb_readb(void __iomem *addr, unsigned offset)
 {
 	struct sunxi_glue *glue;
 
@@ -520,7 +520,7 @@ static void sunxi_musb_writeb(void __iomem *addr, unsigned offset, u8 data)
 		(int)(addr - sunxi_musb->mregs));
 }
 
-static u16 sunxi_musb_readw(const void __iomem *addr, unsigned offset)
+static u16 sunxi_musb_readw(void __iomem *addr, unsigned offset)
 {
 	if (addr == sunxi_musb->mregs) {
 		/* generic control or fifo control reg access */
diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index 3945328..cfb94f9 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -142,7 +142,7 @@ static void tusb_ep_select(void __iomem *mbase, u8 epnum)
 /*
  * TUSB6010 doesn't allow 8-bit access; 16-bit access is the minimum.
  */
-static u8 tusb_readb(const void __iomem *addr, unsigned offset)
+static u8 tusb_readb(void __iomem *addr, unsigned offset)
 {
 	u16 tmp;
 	u8 val;
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
