Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6E7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:16:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9A5A21479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GBHmSLE9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9A5A21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Al+cS2n70VvE98pSUK0zgKN5ZpUjNCDt9t3Qdu9ajKY=; b=GBHmSLE9Xl0uNf
	Y/rbrSGaZW+yXACh9j+iEzQS0dj/Cb66QLF8kqa+NcOIsLiyzFW95mKjOeH02FiZlwz+U3fbJbZdJ
	WGlOdOhqAoZOjayuXXwBkbPhLW7ZHjsy8R4iAjNtB+XTQzvSeEFSpBuho5p7BBHIUYb49K4JALzxN
	ucDDn0wpGqPJ6oKvjd73XaCbv8ZsVgUHC8IiCb8C5lcdIcwNX26qZyA6sTAa9uMjYwZgFpI6hpqgs
	uFPA6IoOj2xsPqNhpOz2CmcHd8kDRHk+Z6aPKrQ5bYEFouQfhKTCOVdSHL6Y1iopPQ4WSrAal/F1G
	go21ivjQaSgQlpRha8HQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwDgM-0006Hg-Nf; Tue, 19 Feb 2019 22:16:06 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwDgJ-0006HH-JU
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 22:16:04 +0000
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id D77ED1086DDEC;
 Tue, 19 Feb 2019 14:15:57 -0800 (PST)
Date: Tue, 19 Feb 2019 14:15:57 -0800 (PST)
Message-Id: <20190219.141557.284906726764572414.davem@davemloft.net>
To: colin.king@canonical.com
Subject: Re: [PATCH][next] ptp_qoriq: don't pass a large struct by value
 but instead pass it by reference
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190219142120.11347-1-colin.king@canonical.com>
References: <20190219142120.11347-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Tue, 19 Feb 2019 14:15:58 -0800 (PST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_141603_643196_522C299A 
X-CRM114-Status: UNSURE (   7.23  )
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
Cc: netdev@vger.kernel.org, richardcochran@gmail.com,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 leoyang.li@nxp.com, claudiu.manoil@nxp.com, yangbo.lu@nxp.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Colin King <colin.king@canonical.com>
Date: Tue, 19 Feb 2019 14:21:20 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> Passing the struct ptp_clock_info caps by parameter is passing over 130 bytes
> of data by value on the stack. Optimize this by passing it by reference instead.
> Also shinks the object code size:
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   12596	   2160	     64	  14820	   39e4	drivers/ptp/ptp_qoriq.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>   12567	   2160	     64	  14791	   39c7	drivers/ptp/ptp_qoriq.o
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Looks good, applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
