Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F48C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:40:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BFA121872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cn4EhRnm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BFA121872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=B8+Y4thNCWPJGA/KwIQu0/xJXjrbZOG7jFg+qvugRrI=; b=cn4EhRnmuk24t3
	LcaAmgMc16ITM774EGE+RGfj9fFzvcRxDL/m4SGQTAQVm+wrEhet8SU7/LmzPjOjBc74f2VaeQbki
	rZsb/pM9RJN2nC9/9/zlxf+EyhtbUIBimXAlqQDbMrUkh4zp4NBASh/gg6Wn80RAA7GC+oUE63WoU
	mSe8DnJhrC/mS0ZGLoafhu3i1pYx41FM+uP1xFD6/0QeStISCvkGJUVba5uvD9h3+KEWzPcScwT7s
	vP5XPqj0dZ9vyZnQ+nZensJCxD5K5RTJBBCESfCfa7mBJRlICy35dYfh58M6NriwlJ/sHuZP0dmsw
	V6Crl2Dy4ZNZ3DT/JeIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmNRg-0003ey-Jg; Wed, 23 Jan 2019 18:40:16 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmNRd-0003eR-Ps
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 18:40:15 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1258FEBD;
 Wed, 23 Jan 2019 10:40:13 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A0F23F237;
 Wed, 23 Jan 2019 10:40:09 -0800 (PST)
Subject: Re: [PATCH v7 22/25] ACPI / APEI: Kick the memory_failure() queue for
 synchronous errors
To: Borislav Petkov <bp@alien8.de>
References: <20181203180613.228133-1-james.morse@arm.com>
 <20181203180613.228133-23-james.morse@arm.com>
 <20190121175850.GO29166@zn.tnic>
From: James Morse <james.morse@arm.com>
Message-ID: <58053f17-5f03-8408-7252-a38ed3d448a9@arm.com>
Date: Wed, 23 Jan 2019 18:40:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190121175850.GO29166@zn.tnic>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_104013_854782_F3264609 
X-CRM114-Status: GOOD (  26.60  )
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

On 21/01/2019 17:58, Borislav Petkov wrote:
> On Mon, Dec 03, 2018 at 06:06:10PM +0000, James Morse wrote:
>> memory_failure() offlines or repairs pages of memory that have been
>> discovered to be corrupt. These may be detected by an external
>> component, (e.g. the memory controller), and notified via an IRQ.
>> In this case the work is queued as not all of memory_failure()s work
>> can happen in IRQ context.
>>
>> If the error was detected as a result of user-space accessing a
>> corrupt memory location the CPU may take an abort instead. On arm64
>> this is a 'synchronous external abort', and on a firmware first
>> system it is replayed using NOTIFY_SEA.
>>
>> This notification has NMI like properties, (it can interrupt
>> IRQ-masked code), so the memory_failure() work is queued. If we
>> return to user-space before the queued memory_failure() work is
>> processed, we will take the fault again. This loop may cause platform
>> firmware to exceed some threshold and reboot when Linux could have
>> recovered from this error.
>>
>> If a ghes notification type indicates that it may be triggered again
>> when we return to user-space, use the task-work and notify-resume
>> hooks to kick the relevant memory_failure() queue before returning
>> to user-space.

>> ---

>> I assume that if NOTIFY_NMI is coming from SMM it must suffer from
>> this problem too.
> 
> Good question.
> 
> I'm guessing all those things should be queued on a normal struct
> work_struct queue, no?

ghes_notify_nmi() does this today with its:
|	irq_work_queue(&ghes_proc_irq_work);

Once its in IRQ context, the irq_work pokes memory_failure_queue(), which
schedule_work_on()s.

Finally we schedule() in process context, and can unmap the affected memory.


The problem is between each of these steps we might return to user-space and run
the instruction that tripped all this to begin with.


My SMM comment was because the CPU must jump from user-space->SMM, which injects
an NMI into the kernel. The kernel's EIP must point into user-space, so
returning from the NMI without doing the memory_failure() work puts us back the
same position we started in.


> Now, memory_failure_queue() does that and can run from IRQ context so
> you need only an irq_work which can queue from NMI context. We do it
> this way in the MCA code:
> 

(was there something missing here?)

> We queue in an irq_work in NMI context and work through the items in
> process context.

How are you getting from NMI to process context in one go?

This patch causes the IRQ->process transition.
The arch specific bit of this gives the irq work queue a kick if returning from
the NMI would unmask IRQs. This makes it look like we moved from NMI to IRQ
context without returning to user-space.

Once ghes_handle_memory_failure() runs in IRQ context, it task_work_add()s the
call to ghes_kick_memory_failure().

Finally on the way out of the kernel to user-space that task_work runs and the
memory_failure() work happens in process context.

During all this the user-space program counter can point at a poisoned location,
but we don't return there until the memory_failure() work has been done.


>> @@ -407,7 +447,22 @@ static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int
>>  
>>  	if (flags != -1)
>>  		memory_failure_queue(pfn, flags);
>> -#endif
>> +
>> +	/*
>> +	 * If the notification indicates that it was the interrupted
>> +	 * instruction that caused the error, try to kick the
>> +	 * memory_failure() queue before returning to user-space.
>> +	 */
>> +	if (ghes_is_synchronous(ghes) && current->mm != &init_mm) {
>> +		callback = kzalloc(sizeof(*callback), GFP_ATOMIC);
> 
> Can we avoid that GFP_ATOMIC allocation and kfree() in
> ghes_kick_memory_failure()?
> 
> I mean, that struct ghes_memory_failure_work is small enough and we
> already do lockless allocation:
> 
> 	estatus_node = (void *)gen_pool_alloc(ghes_estatus_pool, node_len);
> 
> so I guess we could add that ghes_memory_failure_work struct to that
> estatus_node, hand it into ghes_do_proc() and then free it.

I forget estatus_node is a linux thing, not an ACPI-spec thing!

Hmmm, ghes_handle_memory_failure() runs for POLLED and irq error sources too,
they don't have an estatus_node. We don't care about this ret_to_user() problem
as they are all asynchronous, this is why we have ghes_is_synchronous()...

It feels like there should be a way to do this, let me have a go...


Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
