Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767E8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:56:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 483E521850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ojObEwyh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 483E521850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=giKpkEjwfsaQxO2fQX1gXN9MJPj3DVWNI217CF2bPiU=; b=ojObEwyhIECwcU5VSbMwh5hTV
	rIDDf1dGmoJjaUTaf95ogk1MHZVTbt+SbQenudNrzhZDUr6L3c85WiN0rlwYPw9vqmTyc3xx0R+Mk
	lcRErK+Dy1Wz71iRQbDudbEXAkcSMWqWAfTejNyoR9U0fRN6jkym+gZwjEjHGCaNi8SeLSzLpHZjC
	Oe1f6rY76N8mF3vlozC00e2rH98NcdgwfA6/WX/OBKETgJgyOyNFKfTzxdvMm4JhaYFu9aESygGja
	WZN+VYu3FwSeOU6OlzfTiGJmtzTlNegOP1pAawRcVtH5lDce6MOF7vlI2t1BTfyGf/OLxnjO8iskl
	XKNdKxK+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyg29-0005pD-Qm; Tue, 26 Feb 2019 16:56:45 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyg25-0005oq-N8
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 16:56:43 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D374A80D;
 Tue, 26 Feb 2019 08:56:39 -0800 (PST)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8BB63F738;
 Tue, 26 Feb 2019 08:56:37 -0800 (PST)
Subject: Re: [PATCH v5 14/26] KVM: arm64/sve: Context switch the SVE registers
To: Dave Martin <Dave.Martin@arm.com>, Julien Thierry <julien.thierry@arm.com>
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
 <1550519559-15915-15-git-send-email-Dave.Martin@arm.com>
 <83fa5587-24a0-5bbb-c113-cddc74571ea2@arm.com>
 <20190226121321.GQ3567@e103592.cambridge.arm.com>
From: Julien Grall <julien.grall@arm.com>
Message-ID: <82b7b947-7e92-15df-5c71-6d562141264e@arm.com>
Date: Tue, 26 Feb 2019 16:56:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190226121321.GQ3567@e103592.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_085641_756663_7270CB38 
X-CRM114-Status: GOOD (  13.41  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Dave,

On 26/02/2019 12:13, Dave Martin wrote:
> On Wed, Feb 20, 2019 at 04:46:57PM +0000, Julien Thierry wrote:
>>
>>
>> On 18/02/2019 19:52, Dave Martin wrote:
>>> In order to give each vcpu its own view of the SVE registers, this
>>> patch adds context storage via a new sve_state pointer in struct
>>> vcpu_arch.  An additional member sve_max_vl is also added for each
>>> vcpu, to determine the maximum vector length visible to the guest
>>> and thus the value to be configured in ZCR_EL2.LEN while the is
>>
>> "While the <guest> is active"?
> 
> Hmmm, yes.  Thanks for deciphering that.  Done.
I think it would be more consistent if you use "vcpu" over "guest". After all 
ZCR_EL2.LEN is per vCPU.

Cheers,

-- 
Julien Grall

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
