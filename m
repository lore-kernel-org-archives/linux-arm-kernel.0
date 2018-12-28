Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5119AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:37:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19E2020861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J+Q/R0YM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1Xhbc6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E2020861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:In-Reply-To:From:Subject:
	References:Message-ID:To:MIME-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=szxBMi9lwCrM+RCbyhcLASeKsFFl4Th6i5Ws0DNkHRI=; b=J+Q/R0YMxDmuiO
	+5wk0MiIe2dPqfGjG7Fe/iztg1Gl0MGuILCWcVrY4WtCQt70W83gDTQJ6QTOB50yPPmrKy7Mxfc5U
	IP4qDBaVUaWVkW3bOngBGhO5ZDtKujq6y0xzl0W/DFZp0zJgykaItgCL9kTTLbYvcKBCLUmiNmGY8
	6Y2LBaaQ7PmtJF6wRC3OEhEJXn5P9xfrBBZINni1/tNXHWKOaeB62z9NMm71x4Pwn/5wObpEjqN2a
	k/pW6tqpOQCqgqpTLyGtA5mGE23M7by698lmjh5/ah6bgePi0bVojG2KeX3vVvrpr7zNQ79E9E5SQ
	FXMq6ZokpQfJHnirOp7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcxwj-0000PG-2Z; Fri, 28 Dec 2018 19:37:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcxwg-0000NP-7d
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 19:37:23 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D2E3C20861;
 Fri, 28 Dec 2018 19:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546025831;
 bh=hWeuHkNMhjXGzVysfSCEvEiy2xj+fKZtovoQ7jH2J+E=;
 h=To:References:Subject:Cc:From:In-Reply-To:Date:From;
 b=Y1Xhbc6xLoOCnqHk8gmTGBGy9avBQBlRGGUbStVZ+7LY2BRb6aK/SIClECxnfT3Oc
 dK294lEN2Vkjpbf7vHk1XDMTBNEvrCrcEQSItYLlACKFK5Ho2eFZipLq415oZ6hRK+
 kgDP6nm7QCGjoZgRcW82hqN/j/4FmZO/36yrgKZ4=
MIME-Version: 1.0
To: Yangtao Li <tiny.windzz@gmail.com>, fabio.estevam@nxp.com,
 kernel@pengutronix.de, linux-imx@nxp.com, mturquette@baylibre.com,
 s.hauer@pengutronix.de, shawnguo@kernel.org
Message-ID: <154602583106.179992.17980601036225187687@swboyd.mtv.corp.google.com>
References: <20181226135716.5972-1-tiny.windzz@gmail.com>
Subject: Re: [PATCH] clk: imx7d: fix refcount leak in imx7d_clocks_init()
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
In-Reply-To: <20181226135716.5972-1-tiny.windzz@gmail.com>
Date: Fri, 28 Dec 2018 11:37:11 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_113722_285723_11C8F5D1 
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

Quoting Yangtao Li (2018-12-26 05:57:16)
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
