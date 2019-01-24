Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3F4C282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:17:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8730C218CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="euIe0snU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XArJqzAk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8730C218CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:Message-ID:In-Reply-To:From:
	References:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P9BcUMY1YD8nSmrMgEBK7pO7thknXz8chextXS2LX+4=; b=euIe0snUO5cR/f
	EzPuaTWFu4Sfdl+hJamCCNy58MT+qyNoxUIEHF6nhCzQ8yHcDEC0+xIU9HpG6h7PNSp31gcoIf2TD
	l4FJj9pclJusKSYABc7ataWKLE5QyFrcSCvteC410N3Z3Tl64+rf/bFkXjVS8Bp7znbkjMREk/Me/
	e3cwbsqhbByr7EeUAezUsqeIItYVl/Wski4pp8m+yDr8WNJA9RAR+hQNERRE0ezUGfukfXnFMGM4Q
	j11NJb9/AsG0BAfHGoVQEojMxifvRY1UTZG/iLHk1WRFBAthlYBmAYHgJ1ljuVhglTziIoaboaqQV
	ZqIu+4G12jZOLX7ID7mg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmkVg-0005CP-BB; Thu, 24 Jan 2019 19:17:56 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmkVc-0004y4-IF
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 19:17:53 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8AEEB218CD;
 Thu, 24 Jan 2019 19:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548357470;
 bh=Gw8FbC78s5xGN5V2QLypEKWZqs/MWcF2o6A7Wbcgkek=;
 h=Subject:References:Cc:From:In-Reply-To:To:Date:From;
 b=XArJqzAkeWWW/4gfu09LtQY9SH6dOiKbr9YjG6wRfA3X2XH0a0UwqR1zdTJXtkwnB
 RfuhPnUd2poDhghnnASTT83D0HK22MiqYbDy+OaxgfGFPaE3qAb55uHfJDGHTdMlua
 YkUmr3Fa2y4JgkhDMBAH24J4zebNDfnDYcFpVXxk=
MIME-Version: 1.0
Subject: Re: [PATCH] clk: imx: Fix fractional clock set rate computation
References: <1547816041-14200-1-git-send-email-abel.vesa@nxp.com>
User-Agent: alot/0.8
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1547816041-14200-1-git-send-email-abel.vesa@nxp.com>
Message-ID: <154835746984.136743.9264573972712062567@swboyd.mtv.corp.google.com>
To: Abel Vesa <abel.vesa@nxp.com>, Lucas Stach <l.stach@pengutronix.de>
Date: Thu, 24 Jan 2019 11:17:49 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_111752_617395_8A2A2080 
X-CRM114-Status: UNSURE (   5.31  )
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
Cc: Abel Vesa <abel.vesa@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Abel Vesa (2019-01-18 04:54:13)
> Before multiplying by PLL_FRAC_DENOM, the temp64 needs to be
>  temp64 = rate * 2 - divfi * parent_rate * 8, instead of:
>  temp64 = (rate * 2 - divfi) * parent_rate
> 
> Fixes: 6209624b9a5c1e ("clk: imx: Add fractional PLL output clock")
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---

Applied to clk-fixes


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
