Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712FBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:25:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3847D2184A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RYRYWm8f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3847D2184A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dciJ7Y70zyFJf3i+gS8tgA14ClqJfycmR8dYnD/NCxE=; b=RYRYWm8fHzPlAu
	tq9WVpj7zNp9y2xAkkPKCGL7FNVjwIxLnK/DRBMfo9QwMZo1J9MIyNRxcuxB9mGtN9jN/5TX51BS/
	86sY78sX8wQBsD8jy5TqdM/gTAqhP0lji/TAh9yrSP0VE6CmTqEcegJDc6B1OWGu4kHLNKmS8g2p3
	rM5lF05hkwxLlnLuKQd4qY8I7G59xLVQc6cX78QhOAFrqwTldKnbuG9ljeGtj7RIlVObYvFpqJMdO
	9e7JDZxoaeKgThgh71uqSR2pqgA2PGmxlh4YztyfWk5lkttAwHBMlxyL5iRLGrWz1GBvMsxAy22Jf
	Pmlg6adlwvDlYYzixRZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi1Un-0005yR-4v; Fri, 11 Jan 2019 18:25:29 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi1Uk-0005y2-Lh
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 18:25:28 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E677B80D;
 Fri, 11 Jan 2019 10:25:25 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 300103F6CF;
 Fri, 11 Jan 2019 10:25:23 -0800 (PST)
Subject: Re: [PATCH v7 10/25] ACPI / APEI: Tell firmware the estatus queue
 consumed the records
To: Borislav Petkov <bp@alien8.de>, Tyler Baicar <baicar.tyler@gmail.com>
References: <20181203180613.228133-1-james.morse@arm.com>
 <20181203180613.228133-11-james.morse@arm.com>
 <20181211183634.GO27375@zn.tnic>
 <56cfa16b-ece4-76e0-3799-58201f8a4ff1@arm.com>
 <CABo9ajArdbYMOBGPRa185yo9MnKRb0pgS-pHqUNdNS9m+kKO-Q@mail.gmail.com>
 <20190111120322.GD4729@zn.tnic>
 <CABo9ajAk5XNBmNHRRfUb-dQzW7-UOs5826jPkrVz-8zrtMUYkg@mail.gmail.com>
 <20190111174532.GI4729@zn.tnic>
From: James Morse <james.morse@arm.com>
Message-ID: <32025682-f85a-58ef-7386-7ee23296b944@arm.com>
Date: Fri, 11 Jan 2019 18:25:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190111174532.GI4729@zn.tnic>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_102526_720566_4ABE9122 
X-CRM114-Status: GOOD (  17.89  )
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
 Dongjiu Geng <gengdongjiu@huawei.com>, Linux ACPI <linux-acpi@vger.kernel.org>,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, kvmarm@lists.cs.columbia.edu,
 arm-mail-list <linux-arm-kernel@lists.infradead.org>,
 Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Boris,

On 11/01/2019 17:45, Borislav Petkov wrote:
> On Fri, Jan 11, 2019 at 10:32:23AM -0500, Tyler Baicar wrote:
>> The kernel would have no way of knowing what to do here.
> 
> What do you mean, there's no way of knowing what to do? It needs to
> clear registers so that the next error can get reported properly.
> 
> Or of the status read failed and it doesn't need to do anything, then it
> shouldn't.

I think we're speaking at cross-purposes. If the error-detecting-hardware has
some state, that's firmware's problem to deal with.
What we're dealing with here is the memory we read the error records from.


> Whatever it is, the kernel either needs to do something in the error
> case to clean up, or nothing if the firmware doesn't need anything done
> in the error case; *or* ack the error in the success case.

We ack it in the corrupt-record case too, because we are done with the memory.


> This should all be written down somewhere in that GHES v2
> spec/doc/writeup whatever, explaining what the OS is supposed to do to
> signal the error has been read by the OS.

I think it is. 18.3.2.8 of ACPI v6.2 (search for Generic Hardware Error Source
version 2", then below the table):
* OSPM detects error (via interrupt/exception or polling the block status)
* OSPM copies the error status block
* OSPM clears the block status field of the error status block
* OSPM acknowledges the error via Read Ack register

The ENOENT case is excluded by 'polling the block status'.
Unsurprisingly the spec doesn't consider the case that firmware generates
corrupt records!


Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
