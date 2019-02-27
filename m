Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7A1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:17:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3FBC2133D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hue6kyU/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3FBC2133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gnd65rM3om6c6ROXIGKNNyaUvu+G2VJdaZlMJdbf7Ow=; b=hue6kyU/SKyCia0pXmp5krxdj
	xUjXbzo9bHUlTQv/3CcAzMv4Pu6EnbnOKa/uk/ew8/1vA2JosH/IKX9a9o0Gcnnc1ZlV/2gTyPRPO
	bZZ2VzNbt9jg6HancRCnMN6uXEEEBVc4s/B16/Mbb+/2U5D0uw2loOkVdjxoEpW0xcFm9cCr9VTqg
	DruQQPyRiRLcZor8mUdxTellB69wN7/EapeY9U2DI138dwaCMbQEhsw3HjzYgCN8+cKA71ZW34Jim
	K4EOcqmu2HRB3p4eWfHsSzGeKPNvJb4qErmq1WIHCYVahJh7azKLq45BL35q+F+iDCXssri/2caWi
	HAop1OC6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz01N-00018R-8i; Wed, 27 Feb 2019 14:17:17 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz01J-000187-Pb
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 14:17:15 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64B6E374;
 Wed, 27 Feb 2019 06:17:11 -0800 (PST)
Received: from [10.37.12.68] (unknown [10.37.12.68])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBD4F3F5C1;
 Wed, 27 Feb 2019 06:17:08 -0800 (PST)
Subject: Re: [PATCH v5 13/26] KVM: arm64/sve: System register context switch
 and access support
To: Dave Martin <Dave.Martin@arm.com>
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
 <1550519559-15915-14-git-send-email-Dave.Martin@arm.com>
 <8a0e6089-b77b-151b-eacd-34ad13f39ac6@arm.com>
 <20190226170105.GB3567@e103592.cambridge.arm.com>
 <5a7dc2f4-a6e7-28bb-64d7-4f64424eb5c2@arm.com>
 <20190227135030.GE3567@e103592.cambridge.arm.com>
From: Julien Grall <julien.grall@arm.com>
Message-ID: <f39f69a2-18fe-578e-916d-030a4c07e0fd@arm.com>
Date: Wed, 27 Feb 2019 14:17:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190227135030.GE3567@e103592.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_061713_837182_11AA579F 
X-CRM114-Status: GOOD (  20.49  )
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

On 2/27/19 1:50 PM, Dave Martin wrote:
> On Wed, Feb 27, 2019 at 12:02:46PM +0000, Julien Grall wrote:
>> Hi Dave,
>>
>> On 2/26/19 5:01 PM, Dave Martin wrote:
>>> On Tue, Feb 26, 2019 at 04:32:30PM +0000, Julien Grall wrote:
>>>> On 18/02/2019 19:52, Dave Martin wrote:
>>>> We seem to already have code for handling invariant registers as well as
>>>> reading ID register. I guess the only reason you can't use them is because
>>>> of the check the vcpu is using SVE.
>>>>
>>>> However, AFAICT the restrictions callback would prevent you to enter the
>>>> {get, set}_id if the vCPU does not support SVE. So the check should not be
>>>> reachable.
>>>
>>> Hmmm, those checks were inherited from before this refactoring.
>>>
>>> You're right: the checks are now done a common place, so the checks in
>>> the actual accessors should be redundant.
>>>
>>> I could demote them to WARN(), but it may make sense simply to delete
>>> them.
>>
>> I think removing the WARN() would be best as it would avoid to introduce
>> most of the wrappers for the registers.
>>
>>>
>>> The access_id_aa64zfr0_el1() should still be reachable, since we don't
>>> have REG_NO_GUEST for this.
>>
>> __access_id_reg is taking a boolean to tell whether the register is RAZ or
>> not. So you probably could re-use it passing !vcpu_has_sve(vcpu).
>>
>> It feels to me we would introduce a new restriction to tell whether the
>> register should be RAZ. Anyway, the new restriction is probably for a
>> follow-up patch.
> 
> It's true that we should be able to handle these as regular ID regs in
> the get()/set() case, when SVE is enabled for the vcpu.  I'll have a
> think about how to reduce the amount of special-case code here maybe
> we can indeed get of some of these accessors entitely now that access
> is rejected earlier, in a more generic way.
> 
> The access() case for this register still has to be custom though; I
> don't see a trivial solution for that.

I believe you can implement access_id_aa64zfr0_el1 in one line:

return __access_id_reg(vcpu, p, r, !vcpu_has_sve(vcpu));

Another possibility is to introduce REG_GUEST_RAZ and use the 
restrictions callback to set it when the vCPU is not using SVE.

Cheers,

-- 
Julien Grall

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
