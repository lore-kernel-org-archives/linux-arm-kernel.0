Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D088AC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:09:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A23A22081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fEql5Wpo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A23A22081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cPBdbHYpmVQ6ypZ7TxRHeevvZiusfTMvNYu/jsL3Keo=; b=fEql5WpooWdJAd
	XD2YMskUv6IXVyy+9ZHKrE6Bm6eJSXFAdiMichXRtIURou5ICWZJXCaBBnwkeaLiR1mFY5qE/cWCe
	fNj8fKNacVqxz52OmGf8JHluxjNFuoNX2OdMJwiWC5sn1jsZobaPaR7VuP0/QrgrZGSq6GsS1pysn
	IFvsm1Cqj9QeGn8X2w3ZDhXNbj5TEwC179oit755GhbZy1DdanC34c8RcnotVCdG5QouHkEO+zca+
	Fchv4M4oqJAJUomlTmJ7B3pVJnBH63ifZrp1GSU8m/gzjTEUEOf7H7KW2ejuxSuGLgb+X2j163Ea2
	HKynqgAXzFb1+LjsCdnQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUF8a-0003Dj-Jx; Tue, 04 Dec 2018 18:09:36 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUF8X-00031s-Ap
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 18:09:34 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD485A78;
 Tue,  4 Dec 2018 10:09:22 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 BD2453F59C; Tue,  4 Dec 2018 10:09:20 -0800 (PST)
Date: Tue, 4 Dec 2018 18:09:18 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v6 21/24] arm64: Handle serror in NMI context
Message-ID: <20181204180917.GE19210@arrakis.emea.arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
 <1542023835-21446-22-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1542023835-21446-22-git-send-email-julien.thierry@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_100933_415569_104464FC 
X-CRM114-Status: GOOD (  12.51  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, daniel.thompson@linaro.org,
 marc.zyngier@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 christoffer.dall@arm.com, james.morse@arm.com, joel@joelfernandes.org,
 Dave Martin <dave.martin@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Nov 12, 2018 at 11:57:12AM +0000, Julien Thierry wrote:
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 5f4d9ac..66344cd 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -897,13 +897,17 @@ bool arm64_is_fatal_ras_serror(struct pt_regs *regs, unsigned int esr)
>  
>  asmlinkage void do_serror(struct pt_regs *regs, unsigned int esr)
>  {
> -	nmi_enter();
> +	const bool was_in_nmi = in_nmi();
> +
> +	if (!was_in_nmi)
> +		nmi_enter();
>  
>  	/* non-RAS errors are not containable */
>  	if (!arm64_is_ras_serror(esr) || arm64_is_fatal_ras_serror(regs, esr))
>  		arm64_serror_panic(regs, esr);
>  
> -	nmi_exit();
> +	if (!was_in_nmi)
> +		nmi_exit();
>  }

Do we actually need nmi_enter/exit in the outer do_serror() function?
Could we just move it to arm64_serror_panic()?

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
