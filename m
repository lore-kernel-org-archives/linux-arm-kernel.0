Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C126C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:23:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1B30217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QibGtTV0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1B30217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OYNpTSg+uiXFcVs6dCEUWkj5YWSlDbHmzm5Gdtpfuco=; b=QibGtTV0tEbW/m
	KSj+D8AlFHmAIKcuVIbazbNOTaLV70RW93Q05EC4S0H+YYy1SsJoHxEL2sw28G0f/ooFl0gKYdIMm
	9LE/9qTY9wtt5DyzgsPgdNcaN18dJO8Bza1s5yk/4n52KlSdRZdMW6oyC0mAd7Jl9aw+sJ7iXd6Qg
	SIEFrPCV2q9ncT5FumbszvBQMXUN216l6RZlFBmaHGhpYqADmmVx2hhZbHdX0gkVCObapmLinp3Pe
	IgTVQ3eV4e4a82n8+jyvHP7mIwl32dkLloSxCFH6lA/AutTSK+lJYgf+IDKKenRXuQ+M3oOc7dD3p
	Uabu73Q1hvHvHCGYZzKg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvklm-0003pf-P8; Mon, 18 Feb 2019 15:23:46 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvkli-0003oN-LQ
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 15:23:44 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14442A78;
 Mon, 18 Feb 2019 07:23:37 -0800 (PST)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2E1C3F675;
 Mon, 18 Feb 2019 07:23:23 -0800 (PST)
Subject: Re: [PATCH 06/13] mm: pagewalk: Add 'depth' parameter to pte_hole
To: Mark Rutland <Mark.Rutland@arm.com>
References: <20190215170235.23360-1-steven.price@arm.com>
 <20190215170235.23360-7-steven.price@arm.com>
 <20190218112350.GE8036@lakrids.cambridge.arm.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <7b0c6eed-102e-ff79-0f65-16bcec043a09@arm.com>
Date: Mon, 18 Feb 2019 15:23:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190218112350.GE8036@lakrids.cambridge.arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_072342_770256_60EE311E 
X-CRM114-Status: GOOD (  19.67  )
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
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <Catalin.Marinas@arm.com>, "x86@kernel.org" <x86@kernel.org>,
 Will Deacon <Will.Deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 James Morse <James.Morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 18/02/2019 11:23, Mark Rutland wrote:
> On Fri, Feb 15, 2019 at 05:02:27PM +0000, Steven Price wrote:
>> +/* If the p4ds are actually just pgds then we should report a depth
>> + * of 0 not 1 (as a missing entry is really a missing pgd
>> + */
> 
> Nit: comment style violation. This should look like:
> should be:
> 
> /*
>  * If the p4ds are actually just pgds then we should report a depth
>  * of 0 not 1 (as a missing entry is really a missing pgd
>  */
> 
>> +int depth = (PTRS_PER_P4D == 1)?0:1;
> 
> Nit: the ternary should have spacing.
> 
> We don't seem to do this at any other level that could be folded, so why
> does p4d need special care?
> 
> For example, what happens on arm64 when using 64K pages and 3 level
> paging, where puds are folded into pgds?
> 
> Thanks,
> Mark.

Yes, you are entirely correct I've missed the other potential foldings.
I somehow imagined that p4d was special and was folded the opposite
direction (I'm not sure why!).

The best solution I can come up with is a function which will convert
from the level the entry is found at, back to the 'real' level the entry
was missing at. This is needed to produce the correct output in the
debugfs file. Something like:

static int real_depth(int depth)
{
	if (depth == 3 && PTRS_PER_PMD == 1)
		depth = 2;
	if (depth == 2 && PTRS_PER_PUD == 1)
		depth = 1;
	if (depth == 1 && PTRS_PER_P4D == 1)
		depth = 0;
	return depth;
}

This should of course get folded by the compiler and not actually
generate any code.

Thanks,

Steve

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
