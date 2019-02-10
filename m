Return-Path: <SRS0=5+Aw=QR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A64FC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:43:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46CEF2146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Nu7VQ4b4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46CEF2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MkiXVro4wbInBUctFX7s24Ln1K50QFHwnkPe8Wvc0UE=; b=Nu7VQ4b4cq04jt
	ehprI5umqKMbhevgHb1DGUoGdKrBWF+zLP59fgD4YYIrLxsLRNqBOLQkC8h3GqgDtfwLwtFOrXdS0
	1DDxqQqADEDT6ODO85jo6RSxnrRvYmzrtQDcc2BQigICzcQT9HnJiCvSlf9XqVtN+868m8KIWj7su
	NRk02xIKSxxvJWiPSy+rmMsjO+uv/DOK+i1HuJlzxW2fWZkxVKUvxe64AprHSTEww4ltfijwtz/G/
	MBoE6AuO2a2Lj2SOZCOmb15vE/dJ4zklT24B6zz1bQijLDxdfj1oOiF2blZcJVgyG8wRC81ZC93W9
	x+mQ9z/bykvLrKvms31g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsvwm-000102-Jq; Sun, 10 Feb 2019 20:43:28 +0000
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsvwj-0000zg-Gf
 for linux-arm-kernel@lists.infradead.org; Sun, 10 Feb 2019 20:43:27 +0000
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
 by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
 (Exim 4.80) (envelope-from <tglx@linutronix.de>)
 id 1gsvwd-0000ws-BL; Sun, 10 Feb 2019 21:43:19 +0100
Date: Sun, 10 Feb 2019 21:43:18 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 1/5] perf/arm-cci: Fix CPU hotplug race avoidance
In-Reply-To: <606ff8c3f7f35ccdcb4b52a49f692fb20e27359c.1549299188.git.robin.murphy@arm.com>
Message-ID: <alpine.DEB.2.21.1902102140080.8784@nanos.tec.linutronix.de>
References: <cover.1549299188.git.robin.murphy@arm.com>
 <606ff8c3f7f35ccdcb4b52a49f692fb20e27359c.1549299188.git.robin.murphy@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
 SHORTCIRCUIT=-0.0001
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190210_124325_696468_8D91E5D2 
X-CRM114-Status: UNSURE (   8.56  )
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
Cc: mark.rutland@arm.com, suzuki.poulose@arm.com, peterz@infradead.org,
 bigeasy@linutronix.de, will.deacon@arm.com, linux-kernel@vger.kernel.org, "Li,
 Meng" <Meng.Li@windriver.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 4 Feb 2019, Robin Murphy wrote:
> +
> +	cpus_read_lock();
> +	cci_pmu->cpu = smp_processor_id();

That wants to be raw_smp_processor_id() because this is preemptible
context and debug_smp_processor_id() will complain. 

Thanks,

	tglx

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
