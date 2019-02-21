Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67ED4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:46:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 385A320700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OMtOnrQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 385A320700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fm2bY/ZhfukXTQ4ne3nlzQSMZIbcO5Uzb/w4T4As3jk=; b=OMtOnrQgcXinGG
	pvUUDb2q4OjL6ylhp3nBDpQSOxNSKSnuAjM5K0g1lsLadbZ1lS9EXgL1ylwTtFuH4ywYJwneZvnNs
	xj76aFU/qYVsxe+XUdi/fY1/1XqiyTMEVASpEGN15JPKsEc9FEdZ6hup6+J2YpMuyEscRx6v1b1OK
	2YK2pBGE1BAMNlVSxwtIPC+QPbl6O4jYtgrK6P65knX66e/NkQhCQ5FBH34l/sx4w6HZi1iyRJ7E2
	7vpLinKCw+wGmyPH8a6r9oNmngcC7omP70UlG9W34Uj1Q9ZRwsA+e3nEowSU8bD5mvy1F3XhAJ/el
	XTJv9sVVKHkcYt30JbOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwpcL-00062r-TS; Thu, 21 Feb 2019 14:46:29 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwpcI-00062O-GO
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 14:46:27 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A52F3A78;
 Thu, 21 Feb 2019 06:46:23 -0800 (PST)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 305673F690;
 Thu, 21 Feb 2019 06:46:20 -0800 (PST)
Subject: Re: [PATCH v2 03/13] mm: Add generic p?d_large() macros
To: "Kirill A. Shutemov" <kirill@shutemov.name>
References: <20190221113502.54153-1-steven.price@arm.com>
 <20190221113502.54153-4-steven.price@arm.com>
 <20190221142812.oa53lfnnfmsuh6ys@kshutemo-mobl1>
From: Steven Price <steven.price@arm.com>
Message-ID: <a3076d01-41b3-d59b-e98c-a0fd9ba5d3f5@arm.com>
Date: Thu, 21 Feb 2019 14:46:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190221142812.oa53lfnnfmsuh6ys@kshutemo-mobl1>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_064626_552121_73605EE3 
X-CRM114-Status: GOOD (  18.64  )
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
Cc: Mark Rutland <Mark.Rutland@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 James Morse <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, "Liang, Kan" <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 21/02/2019 14:28, Kirill A. Shutemov wrote:
> On Thu, Feb 21, 2019 at 11:34:52AM +0000, Steven Price wrote:
>> From: James Morse <james.morse@arm.com>
>>
>> Exposing the pud/pgd levels of the page tables to walk_page_range() means
>> we may come across the exotic large mappings that come with large areas
>> of contiguous memory (such as the kernel's linear map).
>>
>> For architectures that don't provide p?d_large() macros, provided a
>> does nothing default.
> 
> Nak, sorry.
> 
> Power will get broken by the patch. It has pmd_large() inline function,
> that will be overwritten by the define from this patch.
> 
> I believe it requires more ground work on arch side in general.
> All architectures that has huge page support has to provide these helpers
> (and matching defines) before you can use it in a generic code.

Sorry about that, I had compile tested on power, but obviously not the
right config to actually see the breakage.

I'll do some grepping - hopefully this is just a case of exposing the
functions/defines that already exist for those architectures.

Note that in terms of the new page walking code, these new defines are
only used when walking a page table without a VMA (which isn't currently
done), so architectures which don't use p?d_large currently will work
fine with the generic versions. They only need to provide meaningful
definitions when switching to use the walk-without-a-VMA functionality.

Thanks for reporting the breakage.

Steve

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
