Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EFDC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:33:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA2E821872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Wwgid1KK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA2E821872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YJf7wt/VNEl37lSJFkmycWzthmqYAObMovhsVhSaXLk=; b=Wwgid1KKrqxutN
	v3mHjyY0f73T/o2Nn3QixdQxj4od4io5yIhic1nnzt4W97blGWMOcIsAj7zOmnjouQ+IW94Sh2xEm
	36Y+srMp0+PX/tEA9lJ2EIBPbIc6go7WstJdKJYhWkiYNkM18z7g5uYWRzk3jnXHXi+3dftdM/Pdv
	UHA/z+YG7NMZvc6M52eShJAIFCjUwWYHd9JwbBbuwKMu82AN3jB0YDh3H0F2fEg34tum6IhgEGX09
	GSE/NBvPpPgwX31Xmcc94STax9xvOTzv2km11Y50qd02bMQP/PErRTaY8V4kzFWCm8GIosD6YgRTl
	zNfGTqs8P+WVAOMCSKXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmNKs-0005dw-58; Wed, 23 Jan 2019 18:33:14 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmNKo-0005dD-W7
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 18:33:12 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CB57EBD;
 Wed, 23 Jan 2019 10:33:07 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6D073F237;
 Wed, 23 Jan 2019 10:33:04 -0800 (PST)
Subject: Re: [PATCH v7 20/25] ACPI / APEI: Use separate fixmap pages for arm64
 NMI-like notifications
To: Borislav Petkov <bp@alien8.de>
References: <20181203180613.228133-1-james.morse@arm.com>
 <20181203180613.228133-21-james.morse@arm.com>
 <20190121172743.GN29166@zn.tnic>
From: James Morse <james.morse@arm.com>
Message-ID: <bee87ef4-60ae-d4a4-2855-159543072fc5@arm.com>
Date: Wed, 23 Jan 2019 18:33:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190121172743.GN29166@zn.tnic>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_103311_042456_841DEEA6 
X-CRM114-Status: GOOD (  19.01  )
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
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Tony Luck <tony.luck@intel.com>,
 Fan Wu <wufan@codeaurora.org>, linux-mm@kvack.org,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Xie XiuQi <xiexiuqi@huawei.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Dongjiu Geng <gengdongjiu@huawei.com>, linux-acpi@vger.kernel.org,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Boris,

On 21/01/2019 17:27, Borislav Petkov wrote:
> On Mon, Dec 03, 2018 at 06:06:08PM +0000, James Morse wrote:
>> Now that ghes notification helpers provide the fixmap slots and
>> take the lock themselves, multiple NMI-like notifications can
>> be used on arm64.
>>
>> These should be named after their notification method as they can't
>> all be called 'NMI'. x86's NOTIFY_NMI already is, change the SEA
>> fixmap entry to be called FIX_APEI_GHES_SEA.
>>
>> Future patches can add support for FIX_APEI_GHES_SEI and
>> FIX_APEI_GHES_SDEI_{NORMAL,CRITICAL}.
>>
>> Because all of ghes.c builds on both architectures, provide a
>> constant for each fixmap entry that the architecture will never
>> use.

>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 849da0d43a21..6cbf9471b2a2 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -85,6 +85,14 @@
>>  	((struct acpi_hest_generic_status *)				\
>>  	 ((struct ghes_estatus_node *)(estatus_node) + 1))
>>  
>> +/* NMI-like notifications vary by architecture. Fill in the fixmap gaps */
>> +#ifndef CONFIG_HAVE_ACPI_APEI_NMI
>> +#define FIX_APEI_GHES_NMI	-1
>> +#endif
>> +#ifndef CONFIG_ACPI_APEI_SEA
>> +#define FIX_APEI_GHES_SEA	-1
> 
> I'm guessing those -1 are going to cause __set_fixmap() to fail, right?

It shouldn't be possible, these are just to give the compiler something int
shaped to work with, until it prunes all the callers.

But for arm64, yes if would fail. -1 shouldn't alias an existing entry, and it
will get caught by:
| BUG_ON(idx <= FIX_HOLE || idx >= __end_of_fixed_addresses);

I wanted BUILD_BUG_ON() here, as any user of these should be optimised out, but
the compiler choked on that.

__end_of_fixed_addresses would be a better arch-agnostic invalid value. It has
to be defined as the last value in the enum for core code's fix_to_virt() to work.


These two look like something left behind from when we had different #ifdeffery.
The users of these two are now behind arch specific #ifdefs that since patch 12
of this series, can't be turned off, so I can remove these.

We do need them for SDEI, as it is relying on IS_ENABLED() and the compiler's
dead code elimination. But the compiler wants that symbol to have the right type
before it gets that far.


|#define FIX_APEI_GHES_SDEI_NORMAL      (BUILD_BUG(), -1)

Was the best I had, but this trips the BUILD_BUG() too early.
With it, x86 BUILD_BUG()s. With just the -1 the path gets pruned out, and there
are no 'sdei' symbols in the object file.

...at this point, I stopped caring!


> I'm wondering if we could catch that situation in ghes_map() already to
> protect ourselves against future changes in the fixmap code...

We already skip registering notifiers if the kconfig option wasn't selected.

We can't catch this at compile time, as the dead-code elimination seems to
happen in multiple passes.

I'll switch the SDEI ones to __end_of_fixed_addresses, as both architectures
BUG() when they see this.


Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
