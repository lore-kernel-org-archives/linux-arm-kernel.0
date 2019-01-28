Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92843C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:27:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EEFC20879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dxL99Thm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="doMtwnE/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EEFC20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lxgC+EyvFxGUuHi9GM8Hh/FF8FU4Nx9uSRjKJc1oPF4=; b=dxL99ThmIkpSGv
	U0lDxalciXa4OiiypaAMBos2kcAxupxgIdhBXPRLtLMtqh9P5mH3a7MUYAhqDpeLpBvzgAFXECYpe
	7y+i9mFba5OYMyPMUBbZhRkLuCyDolikFbpJptjacXSKxZRAj7wl8kFKGrIE+yj4twvUx8kQZZ/4B
	4y1xP6Z9GdGiYrzD2adxZj23mYPMYoMbkxsloLXRI2UfQv9q5LSPqowzTyAkP0xF4iBOhoTtQ/yKS
	KWDU/vcQIaJ++2LDS6w2lJhT3mOWVXkUCjvj656/yDLpzvDYRrF+ZpTnLxZLWQGBzgQIqHQaNvZxE
	rzsPxHgsKnJO4S73X4Ng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go9kf-0000dg-5c; Mon, 28 Jan 2019 16:27:13 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go9kb-0000cn-Ml
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 16:27:11 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 976132171F;
 Mon, 28 Jan 2019 16:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548692829;
 bh=7vmwSnSkoSBlPJpO4xiuEwisQFItDkXoMXOIAveCiZQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=doMtwnE/L/E7BhYPadr66rdGa/L2ACXFA0D57pnc2G1581zcfl2AS/ZUfHTlU7Jao
 zhfFZIsPBQX+loUnw/QVHWiQpZ0Bw0SRW8lfY09P+xXxiyJ57lvDSQj692UVs5SGSw
 46RKcQTkT3jUBho0G78BZxRt9YS0/JgKeLuwJ62g=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 28/61] cpuidle: big.LITTLE: fix refcount leak
Date: Mon, 28 Jan 2019 11:25:50 -0500
Message-Id: <20190128162623.59854-28-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128162623.59854-1-sashal@kernel.org>
References: <20190128162623.59854-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_082709_765324_8792214B 
X-CRM114-Status: GOOD (  10.92  )
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
Cc: Yangtao Li <tiny.windzz@gmail.com>, Sasha Levin <sashal@kernel.org>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Yangtao Li <tiny.windzz@gmail.com>

[ Upstream commit 9456823c842f346c74265fcd98d008d87a7eb6f5 ]

of_find_node_by_path() acquires a reference to the node
returned by it and that reference needs to be dropped by its caller.
bl_idle_init() doesn't do that, so fix it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpuidle/cpuidle-big_little.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
index fbc00a1d3c48..355dc3d9cb35 100644
--- a/drivers/cpuidle/cpuidle-big_little.c
+++ b/drivers/cpuidle/cpuidle-big_little.c
@@ -175,6 +175,7 @@ static int __init bl_idle_init(void)
 {
 	int ret;
 	struct device_node *root = of_find_node_by_path("/");
+	const struct of_device_id *match_id;
 
 	if (!root)
 		return -ENODEV;
@@ -182,7 +183,11 @@ static int __init bl_idle_init(void)
 	/*
 	 * Initialize the driver just for a compliant set of machines
 	 */
-	if (!of_match_node(compatible_machine_match, root))
+	match_id = of_match_node(compatible_machine_match, root);
+
+	of_node_put(root);
+
+	if (!match_id)
 		return -ENODEV;
 	/*
 	 * For now the differentiation between little and big cores
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
