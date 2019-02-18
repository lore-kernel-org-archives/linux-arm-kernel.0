Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A822FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:33:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78FAA2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Wa/hpVvs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78FAA2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=szR8eeo/exfMX8cWdCI8u0X0Dl3D1wHMh5owO0KwmGQ=; b=Wa/hpVvsPOIPx0S2+KcCnROJ3
	0fQHUzDHARzB2R7DciTXqLf9MZOie3QKpMCo0t+jOdn8nD5LRF0qdaMRvmH2DVdvtVzw7QKIv99YT
	3AQ313kEuB+q5pPJfSS1i4gEHV5yclOATvsjvR3p4TTMySEuL+AEGxWZT+s+aLz1j+LdP6d4sjSCb
	Q+w8WAkrDnB1gzgQnqIamuqL5VLYcNAav1xm903Tq8Bvh6g3T9+pRjWvySquK0NAxLy+DnFggkEv6
	utc2+SxttUzklQCa9oDRxW+gW4M4fwIJRqrUrXOkizl1gcLAcFo+GaCVSxWX0wbucDPL3HeRsQ6s3
	nTQQwjwkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvjzQ-0005UB-Mq; Mon, 18 Feb 2019 14:33:48 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvjzN-0005Tp-VB
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 14:33:47 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06046A78;
 Mon, 18 Feb 2019 06:33:45 -0800 (PST)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95D9E3F589;
 Mon, 18 Feb 2019 06:33:38 -0800 (PST)
Subject: Re: [RFC PATCH] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20190208165513.8435-1-julien.grall@arm.com>
 <20190213143029.ad2kzg7vtuo3zpjk@linutronix.de>
From: Julien Grall <julien.grall@arm.com>
Message-ID: <205c0b3a-d905-544f-31c3-1bb6ab68bb5b@arm.com>
Date: Mon, 18 Feb 2019 14:33:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190213143029.ad2kzg7vtuo3zpjk@linutronix.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_063346_016301_6B5A62A7 
X-CRM114-Status: GOOD (  27.70  )
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
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 Dave.Martin@arm.com, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Sebastian,

On 13/02/2019 14:30, Sebastian Andrzej Siewior wrote:
> On 2019-02-08 16:55:13 [+0000], Julien Grall wrote:
>> When the kernel is compiled with CONFIG_KERNEL_MODE_NEON, some part of
>> the kernel may be able to use FPSIMD/SVE. This is for instance the case
>> for crypto code.
>>
>> Any use of FPSIMD/SVE in the kernel are clearly marked by using the
>> function kernel_neon_{begin, end}. Furthermore, this can only be used
>> when may_use_simd() returns true.
> 
> This is equal what x86 is currently doing. The naming is slightly
> different, there is irq_fpu_usable().
The idea behind the patch was taken from x86. On x86, softirq does not seem to 
be disabled when context switching the FPUs registers.

> 
>> The current implementation of may_use_simd() allows softirq to use
>> FPSIMD/SVE unless it is currently in used (i.e kernel_neon_busy is true).
>> When in used, softirqs usually fallback to a software method.
>>
>> At the moment, as a softirq may use FPSIMD/SVE, softirqs are disabled
>> when touching the FPSIMD/SVE context. This has the drawback to disable
>> all softirqs even if they are not using FPSIMD/SVE.
> 
> Is this bad? This means also that your crypto code will not be
> interrupted by a softirq. Also if you would get rid of it, you could
> avoid the software fallback in case may_use_simd() says false.

There seem to have some misunderstanding about the purpose of this patch. Any 
use of crypto in the kernel is only protected by preempt_disable(). softirqs are 
only disabled when context switching the FPU register between two userspace tasks.

 From the commit log cb84d11e1625 "arm64: neon: Remove support for nested or 
hardirq kernel-mode NEON" this was done to protect against rare softirqs use 
crypto. It seems to me this is a bit overkill to increase softirq latency if 
they barely use FPSIMD/SVE. Indeed, the SVE context can be quite large, 
therefore it can take some times to save/restore it.

[...]

>> For RT-linux, it might be possible to use migrate_{enable, disable}. I
>> am quite new with RT and have some trouble to understand the semantics
>> of migrate_{enable, disable}. So far, I am still unsure if it is possible
>> to run another userspace task on the same CPU while getting preempted
>> when the migration is disabled.
> 
> In RT:
> - preemt_disable() is the same as !RT. A thread can not be suspend. An
>    interrupt may interrupt. However on RT we have threaded interrupts so
>    the interrupt is limited to the first-level handler (not the threaded
>    handler).
> 
> - migrate_disable() means that the thread can not be moved to another
>    CPU. It can be suspended.
> 
> - local_bh_disable() disables the BH: No softirq can run. In RT
>    local_bh_disable() does not inherit preempt_disable(). Two different
>    softirqs can be executed in parallel.
>    The BH is usually invoked at the end of the threaded interrupt
>    (because the threaded interrupt handler raises the softirq). It can
>    also run in the ksoftirqd.
> 
> Usually you should not get preempted in a migrate_disable() section. A
> SCHED_OTHER task should not interrupt another SCHED_OTHER task in a
> migrate_disable() section. A task with a higher priority (a RT/DL task)
> will. Since threaded interrupts run with a RT priority of 50, they will
> interrupt your task in a migrate_disable() section.

Thank you for the explanation!

Cheers,

-- 
Julien Grall

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
