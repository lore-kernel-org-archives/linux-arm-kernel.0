Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BCAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:56:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0708020818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qsMQ+n/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0708020818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EFGCO4QktjwtE36ZvJGAzAL3N9KDMAnZujgTA8ri4dY=; b=qsMQ+n/3owBVKz
	Xy1zklj2EcEFnONdvNKLe1tpBH5Waq+yIJf0tC9uxq5aCNK5ge55wzD/+h53+t2iFAhtcHEXO+NQO
	jG3vVCdqLbirKztvsaRcXAZHNmZeGvYwuuL08W8hjqzvoQ6c9+6FhbY8BZND6/u0KmhAHyS3Kjpqq
	i8ckPhQ5xwmsFaZuatN3kkYnANBez8QKixEewkyG4scd6qXAz8lxZgNRg2Fci3IXC52zK2uYgB2+e
	3qVVYrJvm/nQlt2AQp9nRscuc4a8YjxFyrIF96Ir4sty3fXwLK6ZTkaCR7AJYOU/yMsozTVwDFiDo
	pbqzxkfuxu4Ehpt6SgSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx8V6-0008Fo-15; Fri, 22 Feb 2019 10:56:16 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx8V2-0008FU-Mc
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 10:56:13 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B55CA78;
 Fri, 22 Feb 2019 02:56:11 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 201EA3F5C1;
 Fri, 22 Feb 2019 02:56:09 -0800 (PST)
Date: Fri, 22 Feb 2019 10:56:07 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH] KVM: arm64: Fix architecturally invalid reset value for
 FPEXC32_EL2
Message-ID: <20190222105604.GB3567@e103592.cambridge.arm.com>
References: <1550749352-2315-1-git-send-email-Dave.Martin@arm.com>
 <20190222100103.03fb773d@why.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190222100103.03fb773d@why.wild-wind.fr.eu.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_025612_744040_637C3358 
X-CRM114-Status: GOOD (  16.03  )
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
Cc: Julien Thierry <julien.thierry@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, stable@vger.kernel.org,
 James Morse <james.morse@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 22, 2019 at 10:01:03AM +0000, Marc Zyngier wrote:
> On Thu, 21 Feb 2019 11:42:32 +0000
> Dave Martin <Dave.Martin@arm.com> wrote:
> 
> > Due to what looks like a typo dating back to the original addition
> > of FPEXC32_EL2 handling, KVM currently initialises this register to
> > an architecturally invalid value.
> > 
> > As a result, the VECITR field (RES1) in bits [10:8] is initialised
> > with 0, and the two reserved (RES0) bits [6:5] are initialised with
> > 1.  (In the Common VFP Subarchitecture as specified by ARMv7-A,
> > these two bits were IMP DEF.  ARMv8-A removes them.)
> > 
> > This patch changes the reset value from 0x70 to 0x700, which
> > reflects the architectural constraints and is presumably what was
> > originally intended.
> > 
> > Cc: <stable@vger.kernel.org> # 4.12.x-
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Christoffer Dall <christoffer.dall@arm.com>
> > Fixes: 62a89c44954f ("arm64: KVM: 32bit handling of coprocessor traps")
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> 
> Applied to -next.
> 
> Thanks,

Thanks.

I have a patch for <= v4.11 which I can send to stable once this patch
reaches torvalds/master.

Is it worth it though, in your opinion?

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
