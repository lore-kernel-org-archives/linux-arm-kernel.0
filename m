Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DF8C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:31:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A05B20673
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Lfvr5epB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A05B20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T5nKEpU9Y/Zb/f/I38FqM0EP3cwAWxDvLgSYphpQDm0=; b=Lfvr5epBPHJA7c
	/95baH4K6axNYjiSvS5SJJvL3M7abo7l/m6dmxYt+szN89cjfE6TQwbs/YaVH3WoS3AdNmyWZ3kTn
	5JxaCXYumAERrbzDzkwQnHBOw8XQOvk4KyV5tf2FTVTMqOqleOmh01dmHF63mc7xnsQ/np1vpuxmn
	l9/98H+mV1iwLBvDiDBZurOHPJ10ZM5eg7CT7slbpzJ8O+NlIXxnSm5JI5UcF0+mLStCoCj1A15uG
	+ua1Z3KDXHHC98fMn0BfbxhqIrgfm05vMzEAnZR4LGAde6+ocXmW5SZyHfntxbC8l58ETUIkfgD1N
	k9EQzyL7/WUXeCuMLgig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSnZf-0003M6-2p; Fri, 30 Nov 2018 18:31:35 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSnZb-0003Lg-Fp
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 18:31:32 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EA23165C;
 Fri, 30 Nov 2018 10:31:16 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74F533F575;
 Fri, 30 Nov 2018 10:31:15 -0800 (PST)
Subject: Re: [PATCH] firmware: arm_sdei: fix wrong of_node_put() in init
 function
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
References: <20181126121536.28739-1-nsaenzjulienne@suse.de>
From: James Morse <james.morse@arm.com>
Message-ID: <08d6b9e6-7aa0-9342-193b-1ce6e0417f77@arm.com>
Date: Fri, 30 Nov 2018 18:31:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181126121536.28739-1-nsaenzjulienne@suse.de>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_103131_535684_7BA57663 
X-CRM114-Status: GOOD (  17.66  )
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
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Nicolas,

On 26/11/2018 12:15, Nicolas Saenz Julienne wrote:
> After finding a "firmware" dt node arm_sdei tries to match it's
> compatible string with it. To do so it's calling of_find_matching_node()
> which already takes care of decreasing the refcount on the "firmware"
> node. We are then incorrectly decreasing the refcount on that node
> again.
> 
> This patch removes the unwarranted call to of_node_put().
> 
> Fixes: ad6eb31ef903 ("firmware: arm_sdei: Add driver for Software Delegated Exceptions")
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>


Thanks!, I agree this is unwarranted.
Is there a tool that picks these up? I remember sparse giving me a headache, but
I don't remember this one... I probably cargo-culted it from somewhere else.

Acked-by: James Morse <james.morse@arm.com>


Thanks,

James


> ---
>  drivers/firmware/arm_sdei.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
> index 1ea71640fdc2..dffb47c6b480 100644
> --- a/drivers/firmware/arm_sdei.c
> +++ b/drivers/firmware/arm_sdei.c
> @@ -1017,7 +1017,6 @@ static bool __init sdei_present_dt(void)
>  		return false;
>  
>  	np = of_find_matching_node(fw_np, sdei_of_match);
> -	of_node_put(fw_np);
>  	if (!np)
>  		return false;
>  
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
