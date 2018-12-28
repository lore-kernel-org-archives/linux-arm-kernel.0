Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB37AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:36:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8691820861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o6S2r1zq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXysDoEd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8691820861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:In-Reply-To:From:Subject:
	References:Message-ID:To:MIME-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xYgGOBWfDlo/4v6RM/m6iDXqleqWnH5pR/i6A/40f6w=; b=o6S2r1zq64E1WQ
	BZUJA0xKeLT7JQm4I0PZSjJ0Pm1eOrHt83XbuUZZd4/FlD1hBRQNjbsueUacyc2QxhOtvQOD8lOlo
	B8tUdTv8db+GliYq9Q7S4fJJaM+ZpuvrpRdAjDTbE0zBlTs79Wq6UbZLnXcJYo2c+Yk8YqbAyXUux
	AtfbgejVb8E8nsvMJshGpyDlAJaQ7jRaY89FJbK69MZ94DFt37mV/GHDhFVSykjyg7COhHI6JHnDs
	uhAJinjhMLAUoja6fyV/mIWijSZpcfL1hZoWlQLjNHmYBGsijDd9gLeE1WOcaVXigi7WcFK2Gosqr
	oKZGFYiy0JKw/pSpMrng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcxvi-0008LH-Ka; Fri, 28 Dec 2018 19:36:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcxvf-0008Kg-0r
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 19:36:20 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9FC7420861;
 Fri, 28 Dec 2018 19:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546025768;
 bh=HI0MlmzvQaNx/p+epLEZS4z9ohv5lyMuIwJbvWPMrBo=;
 h=To:References:Subject:Cc:From:In-Reply-To:Date:From;
 b=TXysDoEdicttPwLvir3cJI4Czn3qI6jcgV/PLtlnEzudToAcY9m2LUabZzUvyRLYR
 isO2SMgUhdukiuqMYHHEaeLvVQc3dDq5MZPvbi3KMFT6OjmwFxPof7PRbc1GS49Bza
 XhFPiswi/nGqRsdbS1z323KDnhJAJ1hSJBbODIBs=
MIME-Version: 1.0
To: Yangtao Li <tiny.windzz@gmail.com>, fabio.estevam@nxp.com,
 kernel@pengutronix.de, linux-imx@nxp.com, mturquette@baylibre.com,
 s.hauer@pengutronix.de, shawnguo@kernel.org
Message-ID: <154602576790.179992.5065715622934818332@swboyd.mtv.corp.google.com>
References: <20181226135300.5710-1-tiny.windzz@gmail.com>
Subject: Re: [PATCH] clk: imx6q: fix refcount leak in imx6q_clocks_init()
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
In-Reply-To: <20181226135300.5710-1-tiny.windzz@gmail.com>
Date: Fri, 28 Dec 2018 11:36:07 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_113619_077502_600E252F 
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

Quoting Yangtao Li (2018-12-26 05:53:00)
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
