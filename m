Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE415C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:32:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D30D20879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KbXvhxO7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D30D20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OrDZfKf1UxBDbyDmGgOixghh5MZvE9zy2nyZwxK+7sE=; b=KbXvhxO78Ks9pl
	Htpv6s0LEAsq6qytsNcPrbu0/nM7GiVRMbHvrLuhFyCEsYUGLErfZGM30F/yEdGt//NJHfcyO86RY
	5+R0+MW5SI+9l/JIKVh1AlfR5nzOFq1Ke/eqXWURgDCImTp9kHiYnoQGnScGUzq0r/D8CIgppRGv6
	vqZEGxa1QXvpBkwB1IACTBt6jL5yY0AdQCjCG12VDpPqiQzaRt4bN7xlI9rOMRlViOuTnyvUnrfpg
	F3dOYHszKvdGgTZUghQCN9qJQMWw6+z2zQ0rP6Exv0e5sBYD1grgDblKdmQRiiOVmxAguFPPzOiKd
	eCJIKQABCVdvypc0I3GQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gluIQ-0000iO-0c; Tue, 22 Jan 2019 11:32:46 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gluIM-0000i0-K5
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 11:32:43 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11136A78;
 Tue, 22 Jan 2019 03:32:42 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBBBA3F6A8;
 Tue, 22 Jan 2019 03:32:40 -0800 (PST)
Subject: Re: [RFC PATCH] arm64: efi: fix chicken-and-egg problem in memreserve
 code
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <20190118174324.24715-1-ard.biesheuvel@linaro.org>
From: James Morse <james.morse@arm.com>
Message-ID: <abe25b84-4327-c927-6d91-629291a62b69@arm.com>
Date: Tue, 22 Jan 2019 11:32:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190118174324.24715-1-ard.biesheuvel@linaro.org>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_033242_665173_44D33CF2 
X-CRM114-Status: GOOD (  17.01  )
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
Cc: mark.rutland@arm.com, linux-efi@vger.kernel.org, marc.zyngier@arm.com,
 catalin.marinas@arm.com, will.deacon@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Ard,

On 18/01/2019 17:43, Ard Biesheuvel wrote:
> Unfortunately, it appears that the recently introduced and repaired
> EFI memreserve code is still broken.
> 
> Originally, we applied all memory reservation passed via the EFI table
> before doing any memblock allocations. However, this turned out to be
> problematic, given that the number of reservations is unbounded, and
> a GICv3 system will reserve a block of memory for each CPU, resulting
> in hundreds of reservations.
> 
> We 'fixed' this by deferring the reservations in the memblock table
> until after we enabled memblock resizing. However, to reach this
> point, we must have mapped DRAM and the kernel, which itself relies
> on some memblock allocations for page tables. Also, memblock resizing
> itself relies on the ability to invoke memblock_alloc() to reallocate
> those tables themselves.
> 
> So this is a nice chicken-and-egg problem which is rather difficult
> to fix cleanly. So instead of a clean solution, I came up with the
> patch below.
> 
> The idea is to set a memblock allocation limit below the lowest
> reservation entry that occurs in the memreserve table. This way,
> we can map DRAM and the kernel and enable memblock resizing without
> running the risk of clobbering those reserved regions. After applying
> all the reservations, the memblock limit restriction is lifted again,
> allowing the boot to proceed normally.

.... how does this interact with kdump? Is it possible the crash-kernel region
is above the lowest reservation entry, meaning there is no usable memory?


> The problem with this approach is that it is not guaranteed that the
> temporary limit will leave enough memory to allocate the page tables
> and resize the memblock reserved array. Since this is only 10s of KBs,
> it is unlikely to break in practice, but some pathological behavior
> may still occur, which is rather nasty :-(

As I understand it, the in-kernel-image memblock_reserved_init_regions is used
early on, because we don't know where the reserved regions of memory are, but
INIT_MEMBLOCK_REGIONS should be big enough to describe them. We trip up when it
isn't big enough, and we can't resize it yet.

... thinking out loud ...

Does reserve_regions() know how big that array needs to be?
(it can count the nomap and persistent reservations, as well as the gaps between
memory banks).

Could we 'allocate' that array to be big enough for everything learnt via EFI in
reserve_regions()? It memblock_remove()s all existing memory, so we know at this
point there aren't existing reservations/allocations.


Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
