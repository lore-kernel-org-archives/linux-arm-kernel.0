Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545BFC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:10:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 244112146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rBXJhGPf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244112146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ie3M+eA11SFJmN6J2irPkqCfSoITrPkgWBwYqHsNHaY=; b=rBXJhGPfRqixwf
	0xcpnQ3NzZgL5OpSajeU/iOQF1ULg3d5v/PfvudthQ1H/XnYlnsurAH2Ps4O9z2Li+0ctWgluMG1c
	/2oJNuT9AhZ0RTQOoPR0BWohG2gU84AbyMc/bZmYgXxO5uR984yVkd4pS1OHde6GNXbqQJiP8gHDr
	URdRWIOlZKH0btqNG+zTUdH6Kb96/olxo+UyKNpEm5+zZxBpt9CZM8gNJB6PU56/faCXn3Pf7boL1
	vxKRy5jL4cmiN3wowcI6kn7X1W92uzdJE5oRwfVPlEvnbz4TPoNNo6entLduN+sSLCQBSGGVwsWrA
	LBzK6THppX7WYwUb0T8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwSaL-0007Es-IB; Wed, 20 Feb 2019 14:10:53 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwSaI-0007EW-RB
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 14:10:52 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35BEAEBD;
 Wed, 20 Feb 2019 06:10:50 -0800 (PST)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E0F83F690;
 Wed, 20 Feb 2019 06:10:47 -0800 (PST)
Subject: Re: [PATCH 06/13] mm: pagewalk: Add 'depth' parameter to pte_hole
To: William Kucharski <william.kucharski@oracle.com>
References: <20190215170235.23360-1-steven.price@arm.com>
 <20190215170235.23360-7-steven.price@arm.com>
 <52690905-1755-46BD-940B-1EE4CEA5F795@oracle.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <76ce9f9b-eb0d-6ad5-9f57-ff3a8fa6b074@arm.com>
Date: Wed, 20 Feb 2019 14:10:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <52690905-1755-46BD-940B-1EE4CEA5F795@oracle.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_061050_882407_151CE32A 
X-CRM114-Status: GOOD (  16.17  )
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
 Catalin Marinas <catalin.marinas@arm.com>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Will Deacon <will.deacon@arm.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 James Morse <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 20/02/2019 11:35, William Kucharski wrote:
> 
> 
>> On Feb 15, 2019, at 10:02 AM, Steven Price <Steven.Price@arm.com> wrote:
>>
>> The pte_hole() callback is called at multiple levels of the page tables.
>> Code dumping the kernel page tables needs to know what at what depth
>> the missing entry is. Add this is an extra parameter to pte_hole().
>> When the depth isn't know (e.g. processing a vma) then -1 is passed.
>>
>> Note that depth starts at 0 for a PGD so that PUD/PMD/PTE retain their
>> natural numbers as levels 2/3/4.
> 
> Nit: Could you add a comment noting this for anyone wondering how to
> calculate the level numbers in the future?

Good point! I'll expand the comment in the header file.

Thanks,

Steve

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
