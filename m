Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD110C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:16:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADD6D20675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C+76MGXs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD6D20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OqpbysEG9CnZ0CUdMn5kh37HgDtujdhDcyQauyVTMRM=; b=C+76MGXsHdEXva
	Hd6TfEiVd9M9DU8xeJzTxcvfAK21qKqxZlXDSm2fF/gx2aTJZMGKwZ+rSgVE4nc9XrT2PfW4tJ8t3
	EpDpK1N+bEBvptu49UrXXDfdz1tjnSGU/bMSfH0y8igoQ1MGTzbCFpZhrE+OAwOY3xDEzEQ57y0pm
	4Y2Iuhjeu/k6xUzo0hO9ZUJ/iWBPXol/JkI4BVJdv4GqpjD61+Lwdde8DzHLw2pMoryUMex+0P2Ix
	rhfZZZwrf2CLu7SmCeGV6lkHJoJTNb1NjrPMwwuA4JnVVuqVuUC8pleNPYRcQa909lF413iisugKN
	v7dRGvzSpwh3q0Jq3fpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxEQu-0005nt-08; Fri, 22 Feb 2019 17:16:20 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxEQq-0005nL-W9
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 17:16:18 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6022374;
 Fri, 22 Feb 2019 09:16:14 -0800 (PST)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B16F23F5C1;
 Fri, 22 Feb 2019 09:16:13 -0800 (PST)
Subject: Re: [PATCH v3 1/2] KVM: arm/arm64: Add save/restore support for
 firmware workaround state
To: Andre Przywara <andre.przywara@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>
References: <20190222121818.30164-1-andre.przywara@arm.com>
 <20190222121818.30164-2-andre.przywara@arm.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <c3dba11e-7f17-d49a-4eac-f3309f836d66@arm.com>
Date: Fri, 22 Feb 2019 17:16:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190222121818.30164-2-andre.przywara@arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_091617_037258_705C5960 
X-CRM114-Status: GOOD (  20.35  )
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
Cc: Dave Martin <dave.martin@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 22/02/2019 12:18, Andre Przywara wrote:
> KVM implements the firmware interface for mitigating cache speculation
> vulnerabilities. Guests may use this interface to ensure mitigation is
> active.
> If we want to migrate such a guest to a host with a different support
> level for those workarounds, migration might need to fail, to ensure that
> critical guests don't loose their protection.
> 
> Introduce a way for userland to save and restore the workarounds state.
> On restoring we do checks that make sure we don't downgrade our
> mitigation level.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm/include/asm/kvm_emulate.h   |  10 +++
>  arch/arm/include/uapi/asm/kvm.h      |  10 +++
>  arch/arm64/include/asm/kvm_emulate.h |  14 ++++
>  arch/arm64/include/uapi/asm/kvm.h    |   9 ++
>  virt/kvm/arm/psci.c                  | 119 +++++++++++++++++++++++----
>  5 files changed, 146 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
> index 8927cae7c966..663a02d7e6f4 100644
> --- a/arch/arm/include/asm/kvm_emulate.h
> +++ b/arch/arm/include/asm/kvm_emulate.h
> @@ -283,6 +283,16 @@ static inline unsigned long kvm_vcpu_get_mpidr_aff(struct kvm_vcpu *vcpu)
>  	return vcpu_cp15(vcpu, c0_MPIDR) & MPIDR_HWID_BITMASK;
>  }
>  
> +static inline bool kvm_arm_get_vcpu_workaround_2_flag(struct kvm_vcpu *vcpu)
> +{
> +	return false;
> +}
> +
> +static inline void kvm_arm_set_vcpu_workaround_2_flag(struct kvm_vcpu *vcpu,
> +						      bool flag)
> +{
> +}
> +
>  static inline void kvm_vcpu_set_be(struct kvm_vcpu *vcpu)
>  {
>  	*vcpu_cpsr(vcpu) |= PSR_E_BIT;
> diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
> index 4602464ebdfb..ba4d2afe65e3 100644
> --- a/arch/arm/include/uapi/asm/kvm.h
> +++ b/arch/arm/include/uapi/asm/kvm.h
> @@ -214,6 +214,16 @@ struct kvm_vcpu_events {
>  #define KVM_REG_ARM_FW_REG(r)		(KVM_REG_ARM | KVM_REG_SIZE_U64 | \
>  					 KVM_REG_ARM_FW | ((r) & 0xffff))
>  #define KVM_REG_ARM_PSCI_VERSION	KVM_REG_ARM_FW_REG(0)
> +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1	KVM_REG_ARM_FW_REG(1)
> +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_AVAIL	0
> +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_AVAIL	1
> +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_UNAFFECTED	2

Thanks for adding the UNAFFECTED state for WORKAROUND_1 - this means the
ABI at least can deal with migration to a host which supports but
doesn't need the workaround. I'm happy for the actual support for this
to be added later if/when it's needed.

Reviewed-by: Steven Price <steven.price@arm.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
