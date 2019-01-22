Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A25C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:50:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1995321721
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="djqm4/Mh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1995321721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5lDgYwFrgX+lGqBSymGQB5x7k93ilk9DdkGuCa7RNHc=; b=djqm4/MhHBxXkm
	vU2dJG0smkeTZ0ebue7+KOkpvoAav9xKlG5AHnOuv5IF5J7ivMUX3xNj3znHKasWRouwMIraDZbC2
	pWZnbNCHTvH1pWn+dqnI9QE1oXSiNyWgLP3tDnFhmLYbw2cx+2DAEAP5Rl5c/MLkrYJL5KIpK/SMD
	t81YcwpAQxzSfsLTopnydAtcNooglBN+2n/eH3vS42WwBlLDjwg3ZiOYz3ListhhzlCqf9ioo16xE
	G1b8ARfCIxprz0/VN7cxY5Kvf2eAOnnqzr6RWxLNenl6bHOKxuCP3x4iedb+EK/mtuUOGM3mBtM87
	Kw4E0L69STMP2YH5BDNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glwRB-0004Jg-UP; Tue, 22 Jan 2019 13:49:57 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glwR9-0004J0-2l
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 13:49:56 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73030EBD;
 Tue, 22 Jan 2019 05:49:54 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1229B3F614;
 Tue, 22 Jan 2019 05:49:51 -0800 (PST)
Subject: Re: [PATCH v7 2/3] arm64: implement ftrace with regs
To: Torsten Duwe <duwe@lst.de>
References: <20190118163736.6A99268CEB@newverein.lst.de>
 <20190118163908.E338E68D93@newverein.lst.de>
 <bdcbdda9-d9e8-20e5-429e-35473ade56cc@arm.com>
 <20190122132832.GB16778@lst.de>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <72a3bb44-60d6-daba-0c9b-099eab2d05e7@arm.com>
Date: Tue, 22 Jan 2019 13:49:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190122132832.GB16778@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_054955_126007_7BE6036B 
X-CRM114-Status: GOOD (  13.92  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, "Singh,
 Balbir" <bsingharora@gmail.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, Ingo Molnar <mingo@redhat.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 Amit Daniel Kachhap <amit.kachhap@arm.com>, live-patching@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 22/01/2019 13:28, Torsten Duwe wrote:
> On Tue, Jan 22, 2019 at 10:18:17AM +0000, Julien Thierry wrote:
>> Hi Torsten,
>>
>> A few suggestions below.
>>
>>> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>>> +#define ARCH_SUPPORTS_FTRACE_OPS 1
>>> +#define REC_IP_BRANCH_OFFSET AARCH64_INSN_SIZE
>>> +/* All we need is some magic value. Simply use "_mCount:" */
>>
>> Nit: Should the casing be "_mcount" ?
> 
> No! The string makes it clear what it's supposed to be and the peculiar
> casing makes it unique and leaves no doubt were it came from. So whenever
> you see this register value in a crash dump you don't have to wonder about
> weird linkage errors, as it surely did not originate from a symtab.
> 

Right, I had missed the point that the value below is actually the
binary representation of that string. Things make more sense now, thanks.

>>> +#define MCOUNT_ADDR		(0x5f6d436f756e743a)
>>> +#else
>>> +#define REC_IP_BRANCH_OFFSET 0
>>> +#define MCOUNT_ADDR		((unsigned long)_mcount)
>>> +#endif
>>> +


-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
