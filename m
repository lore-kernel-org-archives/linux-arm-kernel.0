Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46E8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:39:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4930A213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cLgAqLgb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4930A213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QId3TaSN+SiMYNDIOYo0sQKXtOFqu9FJmKwtOij6yg0=; b=cLgAqLgbYc5ams
	Yy2/on/Z5sH9xf5DsuLG2Hvb92pxqN8AeD+vCKr8OM48HQHtziRKp7dykVncHzHyRnOlsZJTSVco7
	FYM+7PnQXK1B2UIryuhA7rxJ7tsZTm788REQ5k+7acfVH8T3uuiBKbK9vfaOuwgDcMlHw5op8xkwM
	IQH91n61VZ7rPKmV6cRf4un08mRw7Um6GBqZJSo6BLtE/AjqB/tBFTGCZMivLwgpk7sIMxY1k83np
	t47blfowa/Lh47FPBrb9GXdkLNLo/0JDMbg7MObonhyGtQTKjJeY1asT15FQ6BGSmaeOBIZ42MQyu
	WTtX4ZkBXP/zVJE9peag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz0MT-0002ZB-FM; Wed, 27 Feb 2019 14:39:05 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz0MQ-0002Yl-82
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 14:39:03 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E527374;
 Wed, 27 Feb 2019 06:38:59 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DCC63F703;
 Wed, 27 Feb 2019 06:38:57 -0800 (PST)
Date: Wed, 27 Feb 2019 14:38:55 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Julien Grall <julien.grall@arm.com>
Subject: Re: [PATCH v5 13/26] KVM: arm64/sve: System register context switch
 and access support
Message-ID: <20190227143854.GF3567@e103592.cambridge.arm.com>
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
 <1550519559-15915-14-git-send-email-Dave.Martin@arm.com>
 <8a0e6089-b77b-151b-eacd-34ad13f39ac6@arm.com>
 <20190226170105.GB3567@e103592.cambridge.arm.com>
 <5a7dc2f4-a6e7-28bb-64d7-4f64424eb5c2@arm.com>
 <20190227135030.GE3567@e103592.cambridge.arm.com>
 <f39f69a2-18fe-578e-916d-030a4c07e0fd@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f39f69a2-18fe-578e-916d-030a4c07e0fd@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_063902_291527_8C8EDAA8 
X-CRM114-Status: GOOD (  20.12  )
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
Cc: Okamoto Takayuki <tokamoto@jp.fujitsu.com>,
 Christoffer Dall <cdall@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Zhang Lei <zhang.lei@jp.fujitsu.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 27, 2019 at 02:17:06PM +0000, Julien Grall wrote:
> Hi Dave,
> 
> On 2/27/19 1:50 PM, Dave Martin wrote:
> >On Wed, Feb 27, 2019 at 12:02:46PM +0000, Julien Grall wrote:
> >>Hi Dave,
> >>
> >>On 2/26/19 5:01 PM, Dave Martin wrote:

[...]

> >>>The access_id_aa64zfr0_el1() should still be reachable, since we don't
> >>>have REG_NO_GUEST for this.
> >>
> >>__access_id_reg is taking a boolean to tell whether the register is RAZ or
> >>not. So you probably could re-use it passing !vcpu_has_sve(vcpu).
> >>
> >>It feels to me we would introduce a new restriction to tell whether the
> >>register should be RAZ. Anyway, the new restriction is probably for a
> >>follow-up patch.
> >
> >It's true that we should be able to handle these as regular ID regs in
> >the get()/set() case, when SVE is enabled for the vcpu.  I'll have a
> >think about how to reduce the amount of special-case code here maybe
> >we can indeed get of some of these accessors entitely now that access
> >is rejected earlier, in a more generic way.
> >
> >The access() case for this register still has to be custom though; I
> >don't see a trivial solution for that.
> 
> I believe you can implement access_id_aa64zfr0_el1 in one line:
> 
> return __access_id_reg(vcpu, p, r, !vcpu_has_sve(vcpu));

Could maybe do that -- I'll take a look.

> Another possibility is to introduce REG_GUEST_RAZ and use the restrictions
> callback to set it when the vCPU is not using SVE.

This is possible, though I'm reluctant to introduce this for a one-off
special case.

Depending on how many registers follow the same pattern in the future,
we could add it later on.

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
