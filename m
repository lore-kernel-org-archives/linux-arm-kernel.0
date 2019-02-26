Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFECC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:17:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBCDC2173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="loJgs50f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBCDC2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Jx/3d6NbtYKtjvXUBEJ90PGI93MlH0nTHIHxRY+d1Xs=; b=loJgs50faBfFA+
	vsZ+SqvJXWoqfcL66bHLEIEiYk+jhsJ/e3x9n4RYdUzviY03QbXp7ooWtswga3k5J/4dUMMk0tTFK
	jrGYkcOe2bolIoFoTJD8ai6ZYFxJFdyye2D5MseGGYvVR8rkDA4bORF2YxaubdqveayPSn3oLqP+b
	HdElbWSRMLkeSDwfadIieElrVbQaCFN9Cp8bkaV3W4EmwpawtLfxUEdSbUHn71iipuKiWiJ5xTojE
	vPwfPaPp3X5KHN207705UZ7fw6KOwPrvi3+QdeIgU4AZodHRNrKjE8Ruq8UwdVAAgUrPGM2HCYokc
	65FDqUmPVE+Zuv52l/EQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyYrk-00056I-CH; Tue, 26 Feb 2019 09:17:32 +0000
Received: from 8bytes.org ([81.169.241.247] helo=theia.8bytes.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyYrg-00055r-KD
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 09:17:30 +0000
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id B493F41A; Tue, 26 Feb 2019 10:17:17 +0100 (CET)
Date: Tue, 26 Feb 2019 10:17:15 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [PATCH] iommu/io-pgtable-arm-v7s: only kmemleak_ignore L2 tables
Message-ID: <20190226091715.GA19617@8bytes.org>
References: <20190128094301.151252-1-drinkcat@chromium.org>
 <20190130182137.GN18558@fuggles.cambridge.arm.com>
 <CANMq1KAsZHZ42Kt98eSy8Lmh+87S9cob2uSNWjZtLDrWmEEk3w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANMq1KAsZHZ42Kt98eSy8Lmh+87S9cob2uSNWjZtLDrWmEEk3w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_011728_816415_4B588721 
X-CRM114-Status: UNSURE (   6.41  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, lkml <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 25, 2019 at 08:21:46AM +0800, Nicolas Boichat wrote:
> Joerg: Just to make sure, is this patch in your queue? Thanks.

It is now, thanks.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
