Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F8CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:32:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 770B5205F4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UGmhbUC1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 770B5205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=V36bVJiJVN43U96VV7yIYOgZhEK4V67i+ZERcLIkiPA=; b=UGmhbUC1ZIgcgH1/xDixwlWqj
	6j+H1OIulsuWXmtWz9nTbGTtct1BcQd9nyGWnYWN8Xl09Q/6KrfWCdKwDTRwFDyI1aaMowkkjp2w+
	vtDOLo2I+qTsWvL4DNCZvXG0NT+Pmlkh2EcHAKr9XJDJrNfLrZe8nCCJM/tzX/W5azWQ7wpxSBxIL
	zqJ/4uAIZT677uIJQTFHKTWwq61W8c6bnAYxIZcofCdvm8mrwB/RA0mdoEguQT+AnTNwzFgd1gjpp
	b/orAE3+PJV0b5Ro1NP+BKHTXMTkm2XlbmhO6K/In1YZZuzYijdmpB7ZLc0Xkj9AD6RnJcQb1ycqj
	pbFB4VTsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj0TT-0003KQ-QU; Mon, 14 Jan 2019 11:32:11 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj0TQ-0003Jr-DW
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 11:32:09 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B20880D;
 Mon, 14 Jan 2019 03:32:07 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 606D93F5BD;
 Mon, 14 Jan 2019 03:32:05 -0800 (PST)
Subject: Re: [PATCH v3 3/7] arm64: kpti: move check for non-vulnerable CPUs to
 a function
To: jeremy.linton@arm.com, linux-arm-kernel@lists.infradead.org
References: <20190109235544.2992426-1-jeremy.linton@arm.com>
 <20190109235544.2992426-4-jeremy.linton@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <553c4f17-b504-a7a2-51cf-9c0d6c5d7797@arm.com>
Date: Mon, 14 Jan 2019 11:32:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190109235544.2992426-4-jeremy.linton@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_033208_464173_62E57ABC 
X-CRM114-Status: GOOD (  18.44  )
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
Cc: stefan.wahren@i2se.com, mlangsdo@redhat.com, julien.thierry@arm.com,
 marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, Steven.Price@arm.com, ykaukab@suse.de,
 dave.martin@arm.com, shankerd@codeaurora.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Jeremy,

On 09/01/2019 23:55, Jeremy Linton wrote:
> From: Mian Yousaf Kaukab <ykaukab@suse.de>
> 
> Add is_meltdown_safe() which is a whitelist of known safe cores.
> 
> Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> [Moved location of function]
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>   arch/arm64/kernel/cpufeature.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 4f272399de89..ab784d7a0083 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -947,8 +947,7 @@ has_useable_cnp(const struct arm64_cpu_capabilities *entry, int scope)
>   #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>   static int __kpti_forced; /* 0: not forced, >0: forced on, <0: forced off */
>   
> -static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
> -				int scope)
> +static bool is_cpu_meltdown_safe(void)
>   {
>   	/* List of CPUs that are not vulnerable and don't need KPTI */
>   	static const struct midr_range kpti_safe_list[] = {
> @@ -962,6 +961,15 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
>   		MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
>   		{ /* sentinel */ }
>   	};
> +	if (is_midr_in_range_list(read_cpuid_id(), kpti_safe_list))

nit: Does it make sense to rename the list to "meltdown_safe_list", to match the
function name ?

Also also, you may do :

	return is_midr_in_range_list(read_cpuid_id(), kpti_safe_list);

Either way

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
