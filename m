Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729A9C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:58:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42DF22184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X7d80a3U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42DF22184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vMg6u+0Ry/oFcBOlCT8/6TXvxoRj2BDZVRpSeqwRnq4=; b=X7d80a3UcHhkoR
	xsi7JbZUv79WH1IZxwEX3d1ETve67ZiVUQZdHBnBO0c2ZlOTM++wNoKaCuxhkTH3Ke79s2TS77mLd
	ix7hDGLjZ610N+yNk8VsUXnL+YsK04jP9bNPMPLopo3J9Rfr0gHb7H4LgS0m6aGk3WfCSUoFmAcv8
	Wqj5efMhWoqJh1a6bB0FXRgh6omoDSPTbYmKImDSwq/D07AYFojJkmH+7dpOgUQkgkBTFZFC1iMT1
	9be7tOqNZBpGNkIjFl06XH1x9HRAkyjlOcSeJN2nSXye1uMmuBGgB4K71khrNhx72AwrjUrvJqAmZ
	mIM+3Fjn5RDtDki5l16Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gotBj-0007VZ-5t; Wed, 30 Jan 2019 16:58:11 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gotBf-0007UE-Mz
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 16:58:09 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81B4880D;
 Wed, 30 Jan 2019 08:58:06 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 064D33F589;
 Wed, 30 Jan 2019 08:58:04 -0800 (PST)
Subject: Re: [PATCH v3 3/4] uaccess: Check no rescheduling function is called
 in unsafe region
To: Julien Thierry <julien.thierry@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
 <1547560709-56207-4-git-send-email-julien.thierry@arm.com>
From: Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <9ba3c7a7-80a8-da29-ffb7-3841ea8548b5@arm.com>
Date: Wed, 30 Jan 2019 16:58:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1547560709-56207-4-git-send-email-julien.thierry@arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_085807_754511_E3819155 
X-CRM114-Status: GOOD (  17.99  )
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
Cc: peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
 mingo@redhat.com, james.morse@arm.com, hpa@zytor.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 15/01/2019 13:58, Julien Thierry wrote:
[...]> @@ -6151,6 +6159,20 @@ void ___might_sleep(const char *file, int line, int preempt_offset)
>  EXPORT_SYMBOL(___might_sleep);
>  #endif
> 
> +#ifdef CONFIG_DEBUG_UACCESS_SLEEP
> +void __might_resched(const char *file, int line)
> +{
> +	if (!unsafe_user_region_active())
> +		return;
> +
> +	printk(KERN_ERR
> +		"BUG: rescheduling function called from user access context at %s:%d\n",
> +			file, line);
> +	dump_stack();

Since I've been staring intensely at ___might_sleep() lately, I was thinking
we could "copy" it a bit more closely (sorry for going back on what I said
earlier).

Coming back to the double warnings (__might_resched() + schedule_debug()),
it might be better to drop the schedule_debug() warning and just have the
one in __might_resched() - if something goes wrong, there'll already be a
"BUG" in the log.

> +}
> +EXPORT_SYMBOL(__might_resched);
> +#endif
> +
>  #ifdef CONFIG_MAGIC_SYSRQ
>  void normalize_rt_tasks(void)
>  {
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index d4df5b2..d030e31 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2069,6 +2069,14 @@ config IO_STRICT_DEVMEM
> 
>  	  If in doubt, say Y.
> 
> +config DEBUG_UACCESS_SLEEP
> +	bool "Check sleep inside a user access region"
> +	depends on DEBUG_KERNEL
> +	help
> +	  If you say Y here, various routines which may sleep will become very
> +	  noisy if they are called inside a user access region (i.e. between
> +	  a user_access_begin() and a user_access_end())

If it does get noisy, we should go for some ratelimiting - it's probably
good practice even if it is not noisy actually.

___might_sleep() has this:

  if (time_before(jiffies, prev_jiffy + HZ) && prev_jiffy)
  	return;
  prev_jiffy = jiffies;

> +
>  source "arch/$(SRCARCH)/Kconfig.debug"
> 
>  endmenu # Kernel hacking
> --
> 1.9.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
