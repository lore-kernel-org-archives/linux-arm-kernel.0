Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD36C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:43:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B7DE21019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R8Zvx3fT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B7DE21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8vVOqBJzZ28gTIBaqFAf6g/OgjU6cjYODxE5T5cgCKU=; b=R8Zvx3fTnlvFq6
	ufuIgwnhZQe5Gmtu8M1Q1/vm0uE4oNmYP5EPijjkKktVknSPCFcOpG5nYBSwd0iFsuxMjJNQ6+dno
	bz02BrP0H79QoTciRYMB2/ovMVw01JVxs/85B45limTTX9yWgv8iYv5C8BRx3KmH3YELJlxy7+S38
	mkkKxwJaujeKdHMtjLCWPh7+ITi+iAtOhUYSqNnCrt93o7eGNOQ9SeLJ1cK/8I8Zv2n1eJf6ATD4D
	+PdGBTD+TjQiBlxN5moGPuQKfmVBch89DVfpGsrY0IHpq/eXXwbUNXUK4lcypNyO3i4Z+6KXhPZUs
	XlTVdjg4urRPm6Q8rCyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glxGa-0007q0-Te; Tue, 22 Jan 2019 14:43:05 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glxFw-0007Kg-2T
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 14:42:54 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2268A78;
 Tue, 22 Jan 2019 06:42:21 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8788B3F589;
 Tue, 22 Jan 2019 06:42:20 -0800 (PST)
Subject: Re: [PATCH] arm64 memory accesses may cause undefined fault on
 Fujitsu-A64FX
To: "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
References: <8898674D84E3B24BA3A2D289B872026A6A29FA8F@G01JPEXMBKW03>
 <20190118141758.GC12256@lakrids.cambridge.arm.com>
 <8898674D84E3B24BA3A2D289B872026A6A2A2F44@G01JPEXMBKW03>
From: James Morse <james.morse@arm.com>
Message-ID: <d8a8107c-cd31-2517-79df-2ebfbbedb7da@arm.com>
Date: Tue, 22 Jan 2019 14:42:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <8898674D84E3B24BA3A2D289B872026A6A2A2F44@G01JPEXMBKW03>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_064224_454253_05EEFF5D 
X-CRM114-Status: GOOD (  16.04  )
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
Cc: 'Mark Rutland' <mark.rutland@arm.com>,
 "'catalin.marinas@arm.com'" <catalin.marinas@arm.com>,
 "'will.deacon@arm.com'" <will.deacon@arm.com>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
 "'linux-arm-kernel@lists.infradead.org'"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

On 22/01/2019 02:05, Zhang, Lei wrote:
> Mark Rutland wrote:
>> * How often does this fault occur?
> In my test, this fault occurs once every several times
> in the OS boot sequence, and after the completion of OS boot,
> this fault have never occurred.
> In my opinion, this fault rarely occurs
> after the completion of OS boot.

Can you share anything about why this is? You mention a hardware-condition
that is reset at exception entry....


>> I'm a bit surprised by the single retry. Is there any guarantee that a
>> thread will eventually stop delivering this fault code?

> I guarantee that a thread will stop delivering this 
> fault code by the this patch.
> The hardware condition which cause this fault is 
> reset at exception entry, therefore execution of at 
> least one instruction is guaranteed by this single retry.

... so its possible to take this fault during kernel_entry when we've taken an irq?

This will overwrite the ELR and SPSR, (and possibly the FAR and ESR), meaning we've
 lost that information and can't return to the point in the kernel that took the
irq.

If we try, we might end up spinning through the irq handler, as the ELR might
now point
to el1_irq's kernel_entry.

We can spot we took an exception from the entry text ... but all we can do then
is panic().
I'm not sure its worth working around this if its just a matter of time before this
happens. (you mention its less likely after boot, it would be good to know why...)


Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
