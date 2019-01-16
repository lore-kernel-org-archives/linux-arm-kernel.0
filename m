Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06B4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:58:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE875206C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V+i8CdkT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE875206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DiBL5OqCL5+6IIOiNcRy8SitpiybkD9azk/vU6K9aKA=; b=V+i8CdkTNmtIb1
	2BGidQ15q0apYO1dqLeeBf0kYvHM0vXiwfkdG3qy2l5XMEEM82H45My1xccXXfd6Ebis7IGqt8rW9
	QEbMADWhGNBoQnZ15cLVPSirfPEoKPdq2TIPoSSuw7wmjRZW5OCt7kgv+hKhZBU7pYFOQa5Vx4V3G
	bYGnJzdvxH68Mbi/z9fiArJm6wUZpxR6z/X8DVcO6HslE5Q2TAog++bdfGWLCOk9UdwF1XeO1RzDT
	bFziRGw4X5EE7wMOmhWRXO3LI4nzbi/2Z9LTk/yIObUxsreAe0kGB2obUD8zb1A1xQXkkoCEvVvtp
	4598Bhg3Ltf2adfkVmng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjjq0-00075p-Hh; Wed, 16 Jan 2019 11:58:28 +0000
Received: from cloudserver094114.home.pl ([79.96.170.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjjpp-0006m0-8E
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 11:58:21 +0000
Received: from 79.184.255.239.ipv4.supernova.orange.pl (79.184.255.239) (HELO
 aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 0352eca9a8065bb1; Wed, 16 Jan 2019 12:58:05 +0100
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Vincent Guittot <vincent.guittot@linaro.org>,
 Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH] PM/runtime: Do not needlessly call ktime_get
Date: Wed, 16 Jan 2019 12:57:13 +0100
Message-ID: <10417091.Yigb8Rxq05@aspire.rjw.lan>
In-Reply-To: <CAKfTPtCV=PYAqG=LavafTpMxvXdr7W-bfsOkpP+04EtOaicjyg@mail.gmail.com>
References: <20190110095125.GA4491@lenoch>
 <CAKfTPtCV=PYAqG=LavafTpMxvXdr7W-bfsOkpP+04EtOaicjyg@mail.gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_035817_791227_580A0173 
X-CRM114-Status: UNSURE (   6.96  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Linux PM <linux-pm@vger.kernel.org>,
 Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thursday, January 10, 2019 7:56:19 PM CET Vincent Guittot wrote:
> On Thu, 10 Jan 2019 at 10:51, Ladislav Michl <ladis@linux-mips.org> wrote:
> >
> > pm_runtime_autosuspend_expiration calls ktime_get even when
> > its returned value may be unused. Therefore get current time
> > later and remove gotos while there.
> >
> > Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> 
> Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

Patch applied, thanks!


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
