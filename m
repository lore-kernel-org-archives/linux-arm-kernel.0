Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE11C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:40:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F06D520874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f2HesDUT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F06D520874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=25+4vs4Fxcf/WXoSbT5JVuTFVn0VWURDV//dKizF7Qw=; b=f2HesDUTWCljSP
	o4RyXnRf23cGmJGSA3W5jvIzqm25cGWOHoPVAVfpBfdW6qROwCtsfu0zI9HocPF599W+LpxOBRsYD
	4Tp+6P06XwreF7ICrdZY4LQGwZrGoNZPsJSkphECc/oybWy4GdDnpj4PliAfTFvQvjtZa9EvURVaN
	oimTbL9e6EnKX/hzEPQbtSNs1YrI7TK6JpKgQsKu8NneS8jpRmFTLEMiRA3M3zDCgbz7gMu71MEEL
	vAThNIGgV7f9dGcEDa4On/t3ir3HpJq/e/HF/yjO6HaUvw1dxQPbKgRdn49rHttlSEXxI5zasePQW
	LwOYJhcGSK3Wii/4gfAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghuEk-0004qZ-KB; Fri, 11 Jan 2019 10:40:26 +0000
Received: from cloudserver094114.home.pl ([79.96.170.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghuEh-0004q2-En
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 10:40:24 +0000
Received: from 79.184.254.168.ipv4.supernova.orange.pl (79.184.254.168) (HELO
 aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 8e17ad8caeb986e5; Fri, 11 Jan 2019 11:40:21 +0100
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Tony Lindgren <tony@atomide.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2] PM/runtime: Fix autosuspend_delay on 32bits arch
Date: Fri, 11 Jan 2019 11:39:34 +0100
Message-ID: <6922521.G0BVNVQKqm@aspire.rjw.lan>
In-Reply-To: <20190110164431.GA5544@atomide.com>
References: <1547110840-15396-1-git-send-email-vincent.guittot@linaro.org>
 <20190110164431.GA5544@atomide.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_024023_659432_F96CC30A 
X-CRM114-Status: UNSURE (   8.41  )
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
Cc: ulf.hansson@linaro.org, ladis@linux-mips.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thursday, January 10, 2019 5:44:31 PM CET Tony Lindgren wrote:
> * Vincent Guittot <vincent.guittot@linaro.org> [190110 09:00]:
> > Cast autosuspend_delay in u64 to make sure that the full computation of
> > expires or slack will be done in u64, even on 32bits arch.
> > Otherwise, any delay greater than 2^31 nsec can overflow if signed 32bits
> > is used when moving delay from msec to nsec
> > 
> > Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
> > Reported-by: Tony Lindgren <tony@atomide.com>
> > Tested-by: Tony Lindgren <tony@atomide.com>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> > 
> > Change since v1:
> > - add u64 cast for slack computation
> 
> Still works for me.

Applied, thanks!


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
