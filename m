Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11087C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:42:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4FDC20872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NvcNvpU7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4FDC20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5dfoK0KAGjPt/PTplvK8vVq+StMKve+/p1u9kHZqNGQ=; b=NvcNvpU79VM3VM
	SQ2EPkfQ7oNHtxuSBel3Ng35QXUdAzWjsxZKcaEYdwt4Nzy3jF6LgWEQhBJCM/yekJVVS0icwGKAT
	PxHi32GlM0uiH2PxCo5R70ZK4yhgk3GKyjeffBRQEYkvCEc7fUAFO6guyY7D3aNWly8Sb0clzgu8F
	bYgujXRGm2ggxQs7zv33rlNI3lWbE9TwJszfXd5XVx35QlyC7WWcsNfx9k9hWPis3TUcXF3N32t6n
	rR1N1Ajt2G51Yq4cA4/Wa8hvN8UUDOhcriLecNYTXk1V2egu0OPaC8i5pire/g+b9RuJMVQm2bNxl
	I9kEpeYh3aoeo5jAoyMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghuGp-0006S7-QI; Fri, 11 Jan 2019 10:42:35 +0000
Received: from cloudserver094114.home.pl ([79.96.170.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghuGn-0006Rh-Dw
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 10:42:34 +0000
Received: from 79.184.254.168.ipv4.supernova.orange.pl (79.184.254.168) (HELO
 aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id fa1851b8fa0d84f8; Fri, 11 Jan 2019 11:42:31 +0100
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Sudeep Holla <sudeep.holla@arm.com>,
 Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH] cpufreq: scmi: Fix frequency invariance in slow path
Date: Fri, 11 Jan 2019 11:41:45 +0100
Message-ID: <1742153.atePz3IjTa@aspire.rjw.lan>
In-Reply-To: <20190109105945.GA18034@e107155-lin>
References: <20190109104236.6532-1-quentin.perret@arm.com>
 <20190109105945.GA18034@e107155-lin>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_024233_628918_014CE08F 
X-CRM114-Status: UNSURE (   9.77  )
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
Cc: linux-pm@vger.kernel.org, viresh.kumar@linaro.org,
 linux-kernel@vger.kernel.org, qais.yousef@arm.com, dietmar.eggemann@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wednesday, January 9, 2019 11:59:45 AM CET Sudeep Holla wrote:
> On Wed, Jan 09, 2019 at 10:42:36AM +0000, Quentin Perret wrote:
> > The scmi-cpufreq driver calls the arch_set_freq_scale() callback on
> > frequency changes to provide scale-invariant load-tracking signals to
> > the scheduler. However, in the slow path, it does so while specifying
> > the current and max frequencies in different units, hence resulting in a
> > broken freq_scale factor.
> > 
> > Fix this by passing all frequencies in KHz, as stored in the CPUFreq
> > frequency table.
> > 
> > Fixes: 99d6bdf33877 ("cpufreq: add support for CPU DVFS based on SCMI
> > message protocol")
> 
> Good find.
> 
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Applied, thanks!


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
