Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FECC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:32:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49CC021738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ofKBgbcL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49CC021738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Qb4b3p67LM1V1cFsgSe+fbcIfIWOgjNO1P13HXWO+1o=; b=ofKBgbcL1KS3VebATi6KjB0AD
	8Ss0Oza9acY6E/s2xDnmWiOnGBGsPym6FvfL7obAeqNojUWH1rRuAQTZFimnU6pBPZEJ/lrG4cC1I
	/lpeIhqLnIxcoahrHKLYd18BF9OichP7XNOBpOek0G7WqoAq6jXVLS7TZrOooHXlSEqwr+FJiKc4U
	zz/J4yxdRJsKe7tfi6vC5nnXXbUF8z31HP1pOpUKrSStfRJ00T41XF42OEzxGl2hBALWhTA9BQzPA
	rYPFY+CSrCwgXfhe+LVdqK4RE0xvmYbsRzfwZqOXlFzd7/m+N9sN35eu/+J0zQb4hvRr05EtsyAl4
	x42GZlyXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvlqW-00032P-7D; Mon, 18 Feb 2019 16:32:44 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvlqL-0002iF-O7
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 16:32:37 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A2A580D;
 Mon, 18 Feb 2019 08:32:18 -0800 (PST)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA2F03F675;
 Mon, 18 Feb 2019 08:32:15 -0800 (PST)
Subject: Re: [RFC PATCH] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
To: linux-arm-kernel@lists.infradead.org
References: <20190208165513.8435-1-julien.grall@arm.com>
From: Julien Grall <julien.grall@arm.com>
Message-ID: <10464811-e050-5ea1-6763-4362cb1c7c7c@arm.com>
Date: Mon, 18 Feb 2019 16:32:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190208165513.8435-1-julien.grall@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_083234_293583_2EE23A70 
X-CRM114-Status: GOOD (  13.12  )
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
Cc: linux-rt-users@vger.kernel.org, ard.biesheuvel@linaro.org,
 catalin.marinas@arm.com, bigeasy@linutronix.de, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, Dave.Martin@arm.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi all,

On 08/02/2019 16:55, Julien Grall wrote:
> @@ -1094,9 +1113,7 @@ void kernel_neon_begin(void)
>   	/* Invalidate any task state remaining in the fpsimd regs: */
>   	fpsimd_flush_cpu_state();
>   
> -	preempt_disable();
> -
> -	local_bh_enable();
> +	kernel_neon_enable();

I found one error in the patch. We should not re-enable NEON from 
kernel_neon_begin(). I will resend a patch once the thread settle down.

Cheers,

-- 
Julien Grall

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
