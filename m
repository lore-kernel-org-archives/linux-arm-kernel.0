Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A31FC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:03:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D329B20881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q3ehMioh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D329B20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oilC/bssiLnsvneADMm2I65CGEi5EFUsOykcXIa8VtI=; b=Q3ehMiohZc3XS+
	sG4wvu0IGoQQzi6oJ9P/xnfl/rMFKV7NtuEyQkE4EjE+WhOf3HBrRPWmm6lNAqYdG0bmkKGCMZinD
	1YmqEr5wTpOd8b34qh7iZmGhv2Ge8YeDYTg7HboCm1iaY48zKkc5nQs8PFfNww35CCpvTs4e56HjX
	3Y1asNqxtl6XNUrtYUfEukUGNbXh2OZFkBAtHTok372M7KgyBhq86uf6y55BJYqH29FWc/kiQRu3j
	bRBoeHBSqVagKdmsR+9TM0F+jOJx1ypyh95UKRZ6gOnXZSw52fPoAT3gLMJeawAKwsySJ46RNn3NE
	pZWmtLdfTfiWHQEYmh1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpC0T-0004eV-KK; Thu, 31 Jan 2019 13:03:49 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpC0L-0004dt-As
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 13:03:46 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FE98A78;
 Thu, 31 Jan 2019 05:03:40 -0800 (PST)
Received: from [10.1.25.162] (e121487-lin.cambridge.arm.com [10.1.25.162])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDB283F589;
 Thu, 31 Jan 2019 05:03:39 -0800 (PST)
Subject: Re: [PATCH] ARM: NOMMU: Limit visibility for
 CONFIG_FLASH_{MEM_BASE,SIZE}
To: Arnd Bergmann <arnd@arndb.de>
References: <1548843431-8162-1-git-send-email-vladimir.murzin@arm.com>
 <CAK8P3a0oBCXbgp17bYK9hfH1k8RkygsJkYFTd7SdETzzsXDtKQ@mail.gmail.com>
From: Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <f37700cf-d320-cb98-2156-6ed08e720fbd@arm.com>
Date: Thu, 31 Jan 2019 13:03:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0oBCXbgp17bYK9hfH1k8RkygsJkYFTd7SdETzzsXDtKQ@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_050341_382254_F8A16458 
X-CRM114-Status: GOOD (  17.43  )
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
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/30/19 9:25 PM, Arnd Bergmann wrote:
> On Wed, Jan 30, 2019 at 11:17 AM Vladimir Murzin
> <vladimir.murzin@arm.com> wrote:
>>
>> It looks like usage of CONFIG_FLASH_{MEM_BASE,SIZE} is limited with:
>>
>> arch/arm/mm/proc-arm740.S
>> arch/arm/mm/proc-arm940.S
>> arch/arm/mm/proc-arm946.S
>>
>> So it might look confusing to see the option for anything except these.
>>
>> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> 
> This looks correct,
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks!

> 
> On a related note though, there is an old problem that we don't
> actually allow any platform to enable those three CPUs: the only
> supported machine that has it is integrator, and for the past five
> years since commit 68f3b875f784 ("ARM: integrator: make the
> Integrator multiplatform"), it has not been possible to build it
> for NOMMU.

Thant true, yet some people keep out of tree patches to undo multiplatform,
not only for NOMMU, but for XIP as well.

Cheers
Vladimir

> 
>      Arnd
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
