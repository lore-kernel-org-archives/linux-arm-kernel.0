Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C6FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 00:21:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D742820856
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 00:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nHkrXdzW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D742820856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uK6N0O64bl/VR9Q+l5uVQQiSRxoyFuFy335eEAddPys=; b=nHkrXdzWywAKNB
	yrYNQ6bW02erXoQdkDG/udFAmAo6HQqEflo/TQA/sX3D2SMWONsNsiXIGxYQblOPIDeY4+Kusglr7
	qWLBNFWauU0L4y7hf/1Bfp2qt9Z7oIMzAmhob3H2mM30KtM7lKNH7wzq/3+z3k7mmHg8xy7Fg4hNT
	YcZ6hqTgAftGYbIYrnvTZSJ47ILy3M/GcqDlLJ5tUI+ML8Jf+gFyZNk5Q/sbaAlqOhZPFq6YoWymW
	t5tH0OxhtMlvwx8HJm69MLbdJDC6qJNfJnC6gvOsuboYJh8H8IXdPIwr9pk78igKhlaGSA8xX2qHg
	m4TKoaxmnJ4xAWxEuKrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcfu8-0001pb-60; Fri, 28 Dec 2018 00:21:32 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcfu3-0001oo-OK
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 00:21:29 +0000
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id 60DF314E0980C;
 Thu, 27 Dec 2018 16:21:08 -0800 (PST)
Date: Thu, 27 Dec 2018 16:21:07 -0800 (PST)
Message-Id: <20181227.162107.1305791820546855924.davem@davemloft.net>
To: kjlu@umn.edu
Subject: Re: [PATCH] net: stmicro: fix a missing check of clk_prepare
From: David Miller <davem@davemloft.net>
In-Reply-To: <20181226025714.72643-1-kjlu@umn.edu>
References: <20181226025714.72643-1-kjlu@umn.edu>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Thu, 27 Dec 2018 16:21:08 -0800 (PST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_162127_792500_5718E7BA 
X-CRM114-Status: UNSURE (   5.79  )
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
Cc: alexandre.torgue@st.com, maxime.ripard@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, wens@csie.org, joabreu@synopsys.com,
 mcoquelin.stm32@gmail.com, pakki001@umn.edu, peppe.cavallaro@st.com,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Kangjie Lu <kjlu@umn.edu>
Date: Tue, 25 Dec 2018 20:57:14 -0600

> clk_prepare() could fail, so let's check its status, and if it fails,
> return its error code upstream.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Applied.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
