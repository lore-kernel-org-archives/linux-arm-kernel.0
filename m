Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2BCC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:26:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7175820892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mlgpve0h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7175820892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K5fe7OSZgCqghuEhTpchA8x/UxMOhKtEIaXN6SG23vw=; b=Mlgpve0h6A3moM
	I+V0JwY64n8RVaA10pi81fgmOUjtcmHcSu4o9pdcyBnuOmP23p0GBwf2tNhO2LG6wbIy4ih9lpDxT
	xsRja+6iHAGY2ntOeXp/9gKnf8ta6gcvJlOiFM/eDS2B/HhddRXBfvDukg5GZJsk5yF9tmnL3B19J
	/DrRPj2u/ig6V+sc1Y5LNIjB7EwrGb2rcLe0q2oYxgAi1ghqd+IHWvbyKo2ot7OWi4mLZV6lBDbJ0
	OJa5FTIMP7TWWBx35J7WFmvK29qErotqd7g5/mfdXs63K8KXRHh+aQ6Lm8cghV96crGL50r6Z4PYG
	L18XO8cVGeet/JiYstBQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUyLj-0004J3-Sx; Thu, 06 Dec 2018 18:26:11 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUyLh-0004I3-0C
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 18:26:10 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 144F780D;
 Thu,  6 Dec 2018 10:25:56 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 8CF083F5AF; Thu,  6 Dec 2018 10:25:54 -0800 (PST)
Date: Thu, 6 Dec 2018 18:25:52 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v2 2/2] arm64: uaccess: Implement unsafe accessors
Message-ID: <20181206182551.GB37411@arrakis.emea.arm.com>
References: <1543845318-24543-1-git-send-email-julien.thierry@arm.com>
 <1543845318-24543-3-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543845318-24543-3-git-send-email-julien.thierry@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_102609_050014_8F1529B3 
X-CRM114-Status: GOOD (  14.16  )
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
Cc: peterz@infradead.org, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 mingo@redhat.com, james.morse@arm.com, hpa@zytor.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 01:55:18PM +0000, Julien Thierry wrote:
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> index 07c3408..cabfcae 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -233,6 +233,23 @@ static inline void uaccess_enable_not_uao(void)
>  	__uaccess_enable(ARM64_ALT_PAN_NOT_UAO);
>  }
>  
> +#define unsafe_user_region_active	uaccess_region_active
> +static inline bool uaccess_region_active(void)
> +{
> +	if (system_uses_ttbr0_pan()) {
> +		u64 ttbr;
> +
> +		ttbr = read_sysreg(ttbr1_el1);
> +		return ttbr & TTBR_ASID_MASK;

Nitpick: could write this in 1-2 lines.

> +	} else if (cpus_have_const_cap(ARM64_ALT_PAN_NOT_UAO)) {
> +		return (read_sysreg(sctlr_el1) & SCTLR_EL1_SPAN) ?
> +				false :
> +				!read_sysreg_s(SYS_PSTATE_PAN);
> +	}

ARM64_ALT_PAN_NOT_UAO implies ARM64_HAS_PAN which implies SCTLR_EL1.SPAN
is 0 at run-time. Is this to cope with the case of being called prior to
cpu_enable_pan()?

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
