Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62D2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:57:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 761C52146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z57R9h5D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 761C52146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=l9ty81/184Yg1NO6qsN98WOBGfu/RNqfwa9AuoYUwV0=; b=Z57R9h5DlpR0/7
	EenBDGvfoMBpPJIA0uwThLBIwQUI6SV1u6zqb3itQliQ8jLPr2Z42WuqP7UjPPbKQEbVNIvJ00oDK
	1OwDf31RXJ2M1PqDZfNJi6nh2TtQBzWKAhMMhPovY6rZR513TLdwM/ivpL3skheQ4gntrhJj3xZrD
	qqprPDpz7dDFgRLwfFsg19CucJFYuVesH8z3SNyXia7sDxchWgjV/0Ble+Wq6uxocu7tzN0BGOYoC
	yC2BR3H6YlD2K2FEn4wBr1FXo8vqH9xTGCSqBtTbJvKfKvOGGi/jjz+nORvcOSxpkZ4h2Cn0xTU6d
	RXBTTWjAFkC9QPWNKdYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwSN3-000084-Lc; Wed, 20 Feb 2019 13:57:09 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwSMy-00007X-Dh
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 13:57:05 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4327DEBD;
 Wed, 20 Feb 2019 05:57:02 -0800 (PST)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42E883F690;
 Wed, 20 Feb 2019 05:56:59 -0800 (PST)
Subject: Re: [PATCH 03/13] mm: Add generic p?d_large() macros
To: "Liang, Kan" <kan.liang@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>
References: <20190215170235.23360-1-steven.price@arm.com>
 <20190215170235.23360-4-steven.price@arm.com>
 <20190218113134.GU32477@hirez.programming.kicks-ass.net>
 <aad21496-a86b-ca91-70b7-0c23ea6fefd3@arm.com>
 <8a74c111-b099-8d18-5fb0-422909a1367a@linux.intel.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <f8bdd4b9-e078-c1fc-9b15-1ed7a844e673@arm.com>
Date: Wed, 20 Feb 2019 13:56:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <8a74c111-b099-8d18-5fb0-422909a1367a@linux.intel.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_055704_462436_2629039B 
X-CRM114-Status: GOOD (  19.83  )
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
Cc: x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, kirill@shutemov.name,
 Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, James Morse <james.morse@arm.com>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 19/02/2019 03:44, Liang, Kan wrote:
> 
> 
> On 2/18/2019 9:19 AM, Steven Price wrote:
>> On 18/02/2019 11:31, Peter Zijlstra wrote:
>>> On Fri, Feb 15, 2019 at 05:02:24PM +0000, Steven Price wrote:
>>>> From: James Morse <james.morse@arm.com>
>>>>
>>>> Exposing the pud/pgd levels of the page tables to walk_page_range()
>>>> means
>>>> we may come across the exotic large mappings that come with large areas
>>>> of contiguous memory (such as the kernel's linear map).
>>>>
>>>> For architectures that don't provide p?d_large() macros, provided a
>>>> does nothing default.
>>>
>>> Kan was going to fix that for all archs I think..
>>
> 
> Yes, I'm still working on a generic function to retrieve page size.
> The generic p?d_large() issue has been fixed. However, I found that the
> pgd_page() is not generic either. I'm still working on it.
> I will update you on the other thread when all issues are fixed.
> 
> 
> 
>> The latest series I can find from Kan is still x86 specific. I'm happy
>> to rebase onto something else if Kan has an implementation already
>> (please point me in the right direction). Otherwise Kan is obviously
>> free to base on these changes.
>>
> 
> My implementation is similar as yours. I'm happy to re-base on your
> changes.
> 
> Could you please also add a generic p4d_large()?

Sure, I'll include that in the next posting.

Thanks,

Steve

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
