Return-Path: <SRS0=5+Aw=QR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B71C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:44:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 636272146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CamIXmyZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 636272146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OxYYN/Izxu1HWnp/Q5qZaIFT9493sUB39hfkzB/cuFU=; b=CamIXmyZRsqxYv
	/mEUa/KEupK5/zcl3OnpVqhow3QdWTT7vc/MYM3N7Df6NFUunKEG8h44WWhuFWZnXLD4V8MKAJXx1
	syBbOk/9bPz3S/vq2+DASr0FlgfMDGcedKwKCgj9lRJporUiZBog/wutn6Pmy4jYRwHwMpaJMBw2R
	asVDCfPcUky0d5iSU/urWqALD3bcBaDaVYgoRkAwLSJXhNu9tQcb4UicH8h4UCZ7FkWiwZSGWg0Nr
	vp7/AXVm4wdT8HI0OhbxSsMYBVg7XyNZP0DIadEnKuZHAqN95J/NmtP6qCSoeDBc01bVxK09gx2vh
	9kzSczQrc9nMN+nkYFxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsvxV-0001He-5P; Sun, 10 Feb 2019 20:44:13 +0000
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsvxR-0001HB-MB
 for linux-arm-kernel@lists.infradead.org; Sun, 10 Feb 2019 20:44:10 +0000
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
 by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
 (Exim 4.80) (envelope-from <tglx@linutronix.de>)
 id 1gsvxO-0000xu-QD; Sun, 10 Feb 2019 21:44:07 +0100
Date: Sun, 10 Feb 2019 21:44:06 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 3/5] perf/arm-ccn: Fix CPU hotplug race avoidance
In-Reply-To: <d1118e5694694ee40d2e784b2af8745f2d1dce0a.1549299188.git.robin.murphy@arm.com>
Message-ID: <alpine.DEB.2.21.1902102143290.8784@nanos.tec.linutronix.de>
References: <cover.1549299188.git.robin.murphy@arm.com>
 <d1118e5694694ee40d2e784b2af8745f2d1dce0a.1549299188.git.robin.murphy@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
 SHORTCIRCUIT=-0.0001
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190210_124409_864774_BBD59458 
X-CRM114-Status: UNSURE (   9.62  )
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
 bigeasy@linutronix.de, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 4 Feb 2019, Robin Murphy wrote:
>  	/* Pick one CPU which we will use to collect data from CCN... */
> -	cpumask_set_cpu(get_cpu(), &ccn->dt.cpu);
> +	cpus_read_lock();
> +	ccn->dt.cpu = smp_processor_id();

Again raw_smp_processor_id()

Thanks,

	tglx

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
