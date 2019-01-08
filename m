Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D628C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:13:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1601206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LUtNFhCk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yFZjEtDs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1601206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=pPlsWh0LAcqTT7bi9g1+7EJoQZ89Ov4Qix752z8td5w=; b=LUtNFhCkjVlRkttzgJIkJ/oJyS
	PeoAv9c+g4eae0ttQP8+E1N1hoI8olGkkDnPT88EN6B1Z92NDz6Q/vS7F0XnfVSnpjvpDCJUMjKdh
	UOxEqvr9EYJYKrJne2/g84d2+LQWUH+tWBn1VR8itXJkaxaw9aSuPqkah3ngrjFlE8KPqDPtanRTL
	ICYdbm+71LqAz9rb9hNgZlTC+ICr6aqCSOCqF/ZNoGaq6Gal+Zf0YYq56MlthxFhqAeOzyCRch0Ik
	IN8TwtjemxcbL+iMeipWjp8QonQquRY4uxJlZ4QoXhcXbcqlSUz4jpd6v+T8NwzHHaAV0Ka45cTZp
	2eTyNryg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggqFu-0001Vz-4V; Tue, 08 Jan 2019 12:13:14 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggqF3-0000gm-1X; Tue, 08 Jan 2019 12:12:22 +0000
Received: from localhost.localdomain (unknown [37.223.143.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A0DF32087E;
 Tue,  8 Jan 2019 12:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546949540;
 bh=es46TivW9Kpxp/jDOK1Lil3w0c11Tvpf4AabeEtZPO4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=yFZjEtDs1AZHXXn7vAbebvOgp5xSSloJB1xI8pzf/dzV4CeNstN8HZulOetH/GTNS
 tUbKqABuYjWE+sThWZA30NwUdhaPzPDxEw35WZdzjqFVVR2W2r/ezWxTdK/sw0gvS6
 Y0yw5lmsg2Lg2ihtWbCHe8EGnBhxZuwhYs+lClZc=
From: matthias.bgg@kernel.org
To: mturquette@baylibre.com, sboyd@kernel.org, kevin-cw.chen@mediatek.com,
 mars.cheng@mediatek.com
Subject: [PATCH v3 2/3] clk: mediatek: Add flags to mtk_gate
Date: Tue,  8 Jan 2019 13:12:07 +0100
Message-Id: <20190108121208.2473-3-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190108121208.2473-1-matthias.bgg@kernel.org>
References: <20190108121208.2473-1-matthias.bgg@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_041221_102145_E719E860 
X-CRM114-Status: GOOD (  11.51  )
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
Cc: sean.wang@mediatek.com, linux-kernel@vger.kernel.org, jasu@njomotys.info,
 matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Jasper Mattsson <jasu@njomotys.info>

This is required to mark gates as CLK_IS_CRITICAL.

Signed-off-by: Jasper Mattsson <jasu@njomotys.info>
Acked-by: Mars Cheng <mars.cheng@mediatek.com>
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/clk/mediatek/clk-gate.c | 4 +++-
 drivers/clk/mediatek/clk-gate.h | 3 ++-
 drivers/clk/mediatek/clk-mtk.c  | 2 +-
 drivers/clk/mediatek/clk-mtk.h  | 1 +
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
index 934bf0e45e26..9628d4e7690b 100644
--- a/drivers/clk/mediatek/clk-gate.c
+++ b/drivers/clk/mediatek/clk-gate.c
@@ -157,7 +157,8 @@ struct clk *mtk_clk_register_gate(
 		int clr_ofs,
 		int sta_ofs,
 		u8 bit,
-		const struct clk_ops *ops)
+		const struct clk_ops *ops,
+		unsigned long flags)
 {
 	struct mtk_clk_gate *cg;
 	struct clk *clk;
@@ -172,6 +173,7 @@ struct clk *mtk_clk_register_gate(
 	init.parent_names = parent_name ? &parent_name : NULL;
 	init.num_parents = parent_name ? 1 : 0;
 	init.ops = ops;
+	init.flags = flags;
 
 	cg->regmap = regmap;
 	cg->set_ofs = set_ofs;
diff --git a/drivers/clk/mediatek/clk-gate.h b/drivers/clk/mediatek/clk-gate.h
index 72ef89b3ad7b..9f766dfe1d57 100644
--- a/drivers/clk/mediatek/clk-gate.h
+++ b/drivers/clk/mediatek/clk-gate.h
@@ -47,6 +47,7 @@ struct clk *mtk_clk_register_gate(
 		int clr_ofs,
 		int sta_ofs,
 		u8 bit,
-		const struct clk_ops *ops);
+		const struct clk_ops *ops,
+		unsigned long flags);
 
 #endif /* __DRV_CLK_GATE_H */
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 9c0ae4278a94..ef410413bb0b 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -130,7 +130,7 @@ int mtk_clk_register_gates(struct device_node *node,
 				gate->regs->set_ofs,
 				gate->regs->clr_ofs,
 				gate->regs->sta_ofs,
-				gate->shift, gate->ops);
+				gate->shift, gate->ops, gate->flags);
 
 		if (IS_ERR(clk)) {
 			pr_err("Failed to register clk %s: %ld\n",
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index daab6ee94788..987ff2855249 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -162,6 +162,7 @@ struct mtk_gate {
 	const struct mtk_gate_regs *regs;
 	int shift;
 	const struct clk_ops *ops;
+	unsigned long flags;
 };
 
 int mtk_clk_register_gates(struct device_node *node,
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
