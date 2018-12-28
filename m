Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728DEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:41:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EE1A20861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c8W9KPu7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6QgBe20"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE1A20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:In-Reply-To:From:Subject:
	References:Message-ID:To:MIME-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SI8KVY2L14qj9V/5j6lbNNEffzOQY0Cgxwxbgn7UXYw=; b=c8W9KPu7xlkCnG
	206vtqeiTWu3Wi5TfjAACIEmDCab3hC8I9I/OYx66m4+TMtfRbU7DTaUscT29Rar+ox4TJ7puZWur
	/Gi7XkDuCB/+bWVIsR7yf6Lss0aQdrRuHtZNC8BR2mStAUSDW7AzZw97s+mjlUTVbAShT+/6ko+ho
	M26czeozoXI+v1anhhA9yKzYnCUx/iOiG1Cw14s6mhPsckA+t0q9IK/LkQF3jYbYq0CVuquy77ZHS
	vF4ogXPCdCo2dir4qoNu+nTMyO2E+7E2oSlNt/9blvv1bpiNZJARBMLQ/F1Kz73YbRbXrUO/KAlZv
	SOwvr+Qu+lrz5cR6EazA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcy0u-00026H-IH; Fri, 28 Dec 2018 19:41:44 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcy0r-00025d-IL
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 19:41:42 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1934720861;
 Fri, 28 Dec 2018 19:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546026091;
 bh=4sgQjtBuVaUW2wJD0Sc8/z+ZaxQvKCYPeuCbQzPDMgY=;
 h=To:References:Subject:Cc:From:In-Reply-To:Date:From;
 b=u6QgBe20a87FRI4YEOeXCet/TMRA/58pUw1IwewFwB91eDRzNX6CUSSMXhAo1+MRd
 VVYpPQj8RDK/aJSDnMSm4fZE13IKWQcN83nunLePJW1yeSHOW85HUhuw1DaH4oVJpG
 sb/31ZnV6RLiicH9TxaLYPuajpERVDU73tDWROdY=
MIME-Version: 1.0
To: Yangtao Li <tiny.windzz@gmail.com>, fabio.estevam@nxp.com,
 kernel@pengutronix.de, linux-imx@nxp.com, mturquette@baylibre.com,
 s.hauer@pengutronix.de, shawnguo@kernel.org
Message-ID: <154602609026.179992.8277021671264365569@swboyd.mtv.corp.google.com>
References: <20181226135936.6102-1-tiny.windzz@gmail.com>
Subject: Re: [PATCH] clk: vf610: fix refcount leak in vf610_clocks_init()
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
In-Reply-To: <20181226135936.6102-1-tiny.windzz@gmail.com>
Date: Fri, 28 Dec 2018 11:41:30 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_114141_623387_4AAB0413 
X-CRM114-Status: UNSURE (   6.58  )
X-CRM114-Notice: Please train this message.
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
Cc: Yangtao Li <tiny.windzz@gmail.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Yangtao Li (2018-12-26 05:59:36)
> The of_find_compatible_node() returns a node pointer with refcount
> incremented, but there is the lack of use of the of_node_put() when
> done. Add the missing of_node_put() to release the refcount.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
