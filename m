Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFD9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:01:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E009620700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y31XdfHX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E009620700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SIZpNn03TM1IrznlZdo81YnUiQMpKoeCK25vT0xV9Rc=; b=Y31XdfHXtMyCAH
	Pc5EFjIdfbOgaS5v3pyBOg/oVBMsATAb0hZa6M+j63Ynmw+caT4+TVuq0KECzhDposnAiq6SiDjJi
	ZspeYidEqtu5PknwVC3ro/nh+2L0sjA8EF1XUcJgAjT9R4uu/yn67pXizd38xy36V8BlqNAqO/qOc
	KKBVMHcTI6Yf+oLA0+M1Pndyx8D5BQFJYmVLsGNArHzup6SVOt797qDeO7zLbBEDwCbJEKfnL9BPF
	iIFDzwydc6aR1RRZslLC+U540Ia763LQn5FG9uYuV5bBmi5X9va2DyKuKqcFlNI1qeBeK1b4qOSWR
	GXoGBL3JaN40tLlbX80w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx7do-0004RK-Pe; Fri, 22 Feb 2019 10:01:12 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx7dm-0004Qu-9f
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 10:01:11 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B915D80D;
 Fri, 22 Feb 2019 02:01:09 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE8B33F703;
 Fri, 22 Feb 2019 02:01:07 -0800 (PST)
Date: Fri, 22 Feb 2019 10:01:03 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH] KVM: arm64: Fix architecturally invalid reset value for
 FPEXC32_EL2
Message-ID: <20190222100103.03fb773d@why.wild-wind.fr.eu.org>
In-Reply-To: <1550749352-2315-1-git-send-email-Dave.Martin@arm.com>
References: <1550749352-2315-1-git-send-email-Dave.Martin@arm.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_020110_337943_F43F81DC 
X-CRM114-Status: GOOD (  13.08  )
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
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Julien Thierry <julien.thierry@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, stable@vger.kernel.org,
 James Morse <james.morse@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 21 Feb 2019 11:42:32 +0000
Dave Martin <Dave.Martin@arm.com> wrote:

> Due to what looks like a typo dating back to the original addition
> of FPEXC32_EL2 handling, KVM currently initialises this register to
> an architecturally invalid value.
> 
> As a result, the VECITR field (RES1) in bits [10:8] is initialised
> with 0, and the two reserved (RES0) bits [6:5] are initialised with
> 1.  (In the Common VFP Subarchitecture as specified by ARMv7-A,
> these two bits were IMP DEF.  ARMv8-A removes them.)
> 
> This patch changes the reset value from 0x70 to 0x700, which
> reflects the architectural constraints and is presumably what was
> originally intended.
> 
> Cc: <stable@vger.kernel.org> # 4.12.x-
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Fixes: 62a89c44954f ("arm64: KVM: 32bit handling of coprocessor traps")
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Applied to -next.

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
