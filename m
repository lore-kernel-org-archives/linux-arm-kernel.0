Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77405C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:37:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4482F21872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="me+jIt8i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4482F21872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tntvOYh6l1jy430AySXwOdUKRPKAo7BR0CfhiDX9SjM=; b=me+jIt8ioJ1LJu
	O8lZmpZGj3AyldEZL72KnsUj3WDZI3o7xttwqjK+AwS8eTISKzsvKWeOZRlWLn43M4ZpHWKnNJsFz
	Tz96S7XbzazZwcv2dF599V2eQ1M+1YPWLWHY4ebZcdj3pFJASVrG6MBnAY7Ot5QV2VIuG1FVjFNiZ
	CF9v1ezqmEG206odxLbK+nPfeG9vcC5Im4iU0wkgfoYBSNnNNKtiyPjx2n93DqdgOYFdqW0inoG+A
	XyEm3uS/KhtTZFrTGjF6JRiDWoD/8zy/4ucEGFCsrxR0sg5KTGrdTroEzRzP7Q/o4BQ846UK1yVzl
	/q1v9ZiGXi03hWY4s/0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmNPB-0000G9-Ef; Wed, 23 Jan 2019 18:37:41 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmNP7-0000Fk-Mg
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 18:37:39 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D907BEBD;
 Wed, 23 Jan 2019 10:37:36 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 130B53F237;
 Wed, 23 Jan 2019 10:37:33 -0800 (PST)
Subject: Re: [PATCH v7 22/25] ACPI / APEI: Kick the memory_failure() queue for
 synchronous errors
To: Borislav Petkov <bp@alien8.de>
References: <20181203180613.228133-1-james.morse@arm.com>
 <20181203180613.228133-23-james.morse@arm.com>
 <9d153a07-aa7a-6e0c-3bd3-994a66f9639a@huawei.com>
 <5c775aa9-ea57-dea7-6083-c1e3fc160b29@arm.com>
 <20190122105143.GB26587@zn.tnic>
From: James Morse <james.morse@arm.com>
Message-ID: <ae892690-fdf7-b326-1c76-5bf39c2c9bb5@arm.com>
Date: Wed, 23 Jan 2019 18:37:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190122105143.GB26587@zn.tnic>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_103737_747950_5DDD6F56 
X-CRM114-Status: GOOD (  17.25  )
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
 Fan Wu <wufan@codeaurora.org>, linux-acpi@vger.kernel.org,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Xie XiuQi <xiexiuqi@huawei.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Dongjiu Geng <gengdongjiu@huawei.com>,
 Wang Xiongfeng <wangxiongfeng2@huawei.com>, linux-mm@kvack.org,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Boris,

On 22/01/2019 10:51, Borislav Petkov wrote:
> On Mon, Dec 10, 2018 at 07:15:13PM +0000, James Morse wrote:
>> What happens if we miss MF_ACTION_REQUIRED?
> 
> AFAICU, the logic is to force-send a signal to the user process, i.e.,
> force_sig_info() which cannot be ignored. IOW, an "enlightened" process
> would know how to do recovery action from a memory error.
> 
> VS the action optional thing which you can handle at your leisure.

> So the question boils down to what kind of severity do the errors
> reported through SEA have? I mean, if the hw would go the trouble to do
> the synchronous reporting, then something important must've happened and
> it wants us to know about it and handle it.

Before v8.2 we assumed these were fatal for the thread, it couldn't make progress.
Since v8.2 we get a value from the CPU, the severity values are, (the flippant
summary is obviously mine!):
* Recoverable: "You're about to step in it, fix it or die"
* Uncontainable: "It was here, but it escaped, we dont know where it went, panic!"
* Restartable/Corrected: "its fine, pretend this didn't happen"

Firmware should duplicate these values into the CPER severity fields.


>> Surely the page still gets unmapped as its PG_Poisoned, an AO signal
>> may be pending, but if user-space touches the page it will get an AR
>> signal. Is this just about removing an extra AO signal to user-space?

If we miss MF_ACTION_REQUIRED, the page still gets unmapped from user-space, and
user-space gets an AO signal. With this patch it takes that signal before it
continues. If it ignores it, the access gets a translation-fault->EHWPOISON->AR
signal from the arch code.

... so missing the flag gives us an extra signal. I'm not convinced this results
in any observable difference.


>> If we do need this, I'd like to pick it up from the CPER records, as x86's
>> NOTIFY_NMI looks like it covers both AO/AR cases. (as does NOTIFY_SDEI). The
>> Master/Target abort or Invalid-address types in the memory-error-section CPER
>> records look like the best bet.
> 
> Right, and we do all kinds of severity mapping there aka ghes_severity()
> so that'll be a good start, methinks.

The options are those 'aborts' in the memory error. These must have been a
result of some request. If we get a CPU error structure as part of the same
block, it may have a cache/bus error structure, which has a precise bit that
tells us whether this is a co-incidence. (but linux doesn't support any of those
structures today)



Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
