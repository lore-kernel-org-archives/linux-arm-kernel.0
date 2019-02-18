Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F93C10F01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:22:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8659E217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gzZRts1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8659E217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kwWFOm5r+yCLtrb6DwpnzCVry2mn0EQ6C4nqzS80tPQ=; b=gzZRts1p0sj+et
	MiQGgIGlMx/KBE3UYVpl2qIIqCJvqR1DkV+ieq+0RqwbJhIWlG0nNFvvyE3o86IBWkeHsHqwtlZOS
	N/jxZWjJZgwiHyqbDnXPpirzlpXiWnys9D+llI/42sk3d+cDEtTGAkhdRRoiuS/CbrKGKoeUQz7Ob
	SUflspmu8zQphal1hcCUoRzyHvw1zSQGp6RaIjUm/3lIr82rJGq/Nah8J8uf+m1BeV+7DCNXlAor7
	nNqf0IfoGHFpkkf2uABV1LR/36cOU9Z2XEGrWFHF4WR39nBGFiWL78aAkQNNvx+QNbKXs7/doCp/i
	nXwIeNqdTngRp4L1Wdag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvmd0-0006Pt-S8; Mon, 18 Feb 2019 17:22:50 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvmcp-0006Ay-Q7
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 17:22:44 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70A19A78;
 Mon, 18 Feb 2019 09:22:36 -0800 (PST)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CA853F675;
 Mon, 18 Feb 2019 09:22:33 -0800 (PST)
Subject: Re: [PATCH 01/13] arm64: mm: Add p?d_large() definitions
To: Mark Rutland <mark.rutland@arm.com>
References: <20190215170235.23360-1-steven.price@arm.com>
 <20190215170235.23360-2-steven.price@arm.com>
 <20190218112922.GT32477@hirez.programming.kicks-ass.net>
 <fe36ed1c-b90d-8062-f7a9-e52d940733c4@arm.com>
 <20190218142951.GA10145@lakrids.cambridge.arm.com>
 <20190218150657.GU32494@hirez.programming.kicks-ass.net>
 <eb7e0203-db08-743b-dbed-a7032b352ded@arm.com>
 <20190218170451.GB10145@lakrids.cambridge.arm.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <c27d9f26-0213-3706-8bd9-ca71d20fbf06@arm.com>
Date: Mon, 18 Feb 2019 17:22:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190218170451.GB10145@lakrids.cambridge.arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_092241_574467_2C2A9D62 
X-CRM114-Status: GOOD (  16.32  )
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
 Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 James Morse <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 18/02/2019 17:04, Mark Rutland wrote:
> On Mon, Feb 18, 2019 at 03:30:38PM +0000, Steven Price wrote:
>> On 18/02/2019 15:06, Peter Zijlstra wrote:
>>> On Mon, Feb 18, 2019 at 02:29:52PM +0000, Mark Rutland wrote:
>>>> I think that Peter means p?d_huge(x) should imply p?d_large(x), e.g.
>>>>
>>>> #define pmd_large(x) \
>>>> 	(pmd_sect(x) || pmd_huge(x) || pmd_trans_huge(x))
>>>>
>>>> ... which should work regardless of CONFIG_HUGETLB_PAGE.
>>>
>>> Yep, that.
>>
>> I'm not aware of a situation where pmd_huge(x) is true but pmd_sect(x)
>> isn't. Equally for pmd_huge(x) and pmd_trans_huge(x).
>>
>> What am I missing?
> 
> Having dug for a bit, I think you're right in asserting that pmd_sect()
> should cover those.
> 
> I had worried that wouldn't cater for contiguous pmd entries, but those
> have to be contiguous section entries, so they get picked up.
> 
> That said, do we have any special handling for contiguous PTEs? We use
> those in kernel mappings regardless of hugetlb support, and I didn't
> spot a pte_large() helper.

There's no special handling for contiguous PTEs because the page walk
code doesn't care - each PTE is valid individually even if it is part of
a contiguous group. So the walker can descend all levels in this case.
pte_large() if it existed would therefore always return 0.

The pte_entry() callback obviously might go looking for the contiguous
bit so that it can annotate the output correctly but that's different
from a 'large' page. The code in arch/arm64/mm/dump.c simply looks for
the PTE_CONT bit being set to do this annotation.

Steve

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
