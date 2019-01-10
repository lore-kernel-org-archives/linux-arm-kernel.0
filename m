Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0152C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:21:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 891F620675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XGs0u1YX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 891F620675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:Subject:From:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dzdy+MqvbUAbqCgwudQPYcyI/Lw3t2dnj47KOPTk5dk=; b=XGs0u1YXAp/WCm
	kea4krrKreQ8v2TO9pTrXoAPyZs3eBSebYEvHsZMHiIPFolBQGduu6N2+W0T5+YsvBomGvKuhxjGS
	4V3QfSEqTEmgdE/rmuFzAtI2DczenswX+qw76LPMUHncuZECR0S1CSjT/xaf5Al3ZCVZWTgDDVtla
	hKsGrAW3hZe2KUSFqLpzS1cKUGhZnuAdDJSR6hfjpqt8GxwCG1yyr5/djepsF8HWvrcjZ/smaOSJD
	7hOfTs4CoAH2U19bE2XhoW6Xn3Ylv0V9ZoY9tD897i+oyFBuXSGqhbmHf5Is5TbDchDqLeZTyQn0o
	xrJFOV4uGmdTViUIPOuQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghexN-0004N5-Sk; Thu, 10 Jan 2019 18:21:29 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghexJ-0004MW-L4
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 18:21:28 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67010A78;
 Thu, 10 Jan 2019 10:21:25 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D43DF3F694;
 Thu, 10 Jan 2019 10:21:22 -0800 (PST)
From: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v7 09/25] ACPI / APEI: Generalise the estatus queue's
 notify code
To: Borislav Petkov <bp@alien8.de>
References: <20181203180613.228133-1-james.morse@arm.com>
 <20181203180613.228133-10-james.morse@arm.com>
 <20181211174449.GM27375@zn.tnic>
Message-ID: <3f0f9005-f383-8a03-c7f9-15b50c099f94@arm.com>
Date: Thu, 10 Jan 2019 18:21:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181211174449.GM27375@zn.tnic>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_102125_696249_433603E1 
X-CRM114-Status: GOOD (  16.45  )
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

On 11/12/2018 17:44, Borislav Petkov wrote:
> On Mon, Dec 03, 2018 at 06:05:57PM +0000, James Morse wrote:
>> Refactor the estatus queue's pool notification routine from
>> NOTIFY_NMI's handlers. This will allow another notification
>> method to use the estatus queue without duplicating this code.
>>
>> This patch adds rcu_read_lock()/rcu_read_unlock() around the list
> 
> s/This patch adds/Add/
> 
>> list_for_each_entry_rcu() walker. These aren't strictly necessary as
>> the whole nmi_enter/nmi_exit() window is a spooky RCU read-side
>> critical section.
>>
>> _in_nmi_notify_one() is separate from the rcu-list walker for a later
>> caller that doesn't need to walk a list.

>> +static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
>> +{
>> +	int ret = NMI_DONE;
>> +
>> +	if (!atomic_add_unless(&ghes_in_nmi, 1, 1))
>> +		return ret;
>> +
>> +	if (!ghes_estatus_queue_notified(&ghes_nmi))
>> +		ret = NMI_HANDLED;
> 
> So this reads kinda the other way around, at least to me:
> 
> 	"if the queue was *not* notified, the NMI was handled."
> 
> Maybe rename to this:
> 
> 	err = process_queue(&ghes_nmi);
> 	if (!err)
> 		ret = NMI_HANDLED;
> 
> to make it clearer...

(yup, that's clearer).

But now we've opened pandora's box of naming-things: This thing isn't really
processing anything, its walking a list of 'maybe it was one of these' and
copying anything it finds into the estatus-queue to be handled later.

I've evidently overloaded 'notified' to mean this.
__process_error() doesn't process anything either, it does the add-to-queue.

'spool' is the word that best conveys what's going on here, I should probably
use that 'in_nmi' prefix more to make it clear this has to be nmi safe.

Something like:
ghes_notify_nmi() -> in_nmi_spool_from_list(list) -> in_nmi_queue_one_entry(ghes).



Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
