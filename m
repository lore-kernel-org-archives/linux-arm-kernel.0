Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B5BC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:24:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13799222B2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nyDS9d58"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13799222B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RX9/KfMmb2KsnRMGGjd2A7c3LaEo/n1zzCNtJeNHf4A=; b=nyDS9d58tHhL8L
	zpTLSYDpVpPBKvBYKHrrd4VRTDwHV1sa3tQZWfbktiDuEcfMcTmezKPJWz0SMhh5fzMD8OAtSftxy
	Azi11f2EJq3mGjMuhXTvhKUt8sEYDsOFovILW8DPquByqA3ZE6b5p1qf+fjnJrVzkN4fW5bSL80Pt
	dyPNFF3AFczEixVWuphCEmRRva1N7H28f6rfYlFuWvJrH1pan9O1ASA3jE9UHNN0K1AQwa9Vs9E7F
	TyT0sChBporNC/lh5sX0TA3ngb35Mg0XEZEGsIGJEGH8//CgEGXt6KwTkwIeJq9wjgDnSiDRcKY/T
	usdiuyGLa5bY5sKd7sUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtvSt-0000s3-H4; Wed, 13 Feb 2019 14:24:43 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtvSr-0000rf-18
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 14:24:42 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B6B280D;
 Wed, 13 Feb 2019 06:24:39 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D0193F557;
 Wed, 13 Feb 2019 06:24:36 -0800 (PST)
Subject: Re: [PATCH v3 3/4] uaccess: Check no rescheduling function is called
 in unsafe region
To: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>
References: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
 <1547560709-56207-4-git-send-email-julien.thierry@arm.com>
 <20190211134527.GA121589@gmail.com>
 <20190211135159.GC32511@hirez.programming.kicks-ass.net>
 <a23fdd84-8c4b-0c1f-d877-24d946cff6d0@arm.com>
 <20190213103553.GO32494@hirez.programming.kicks-ass.net>
 <1c2429a4-9df9-40a3-98e0-51577de4bd6a@arm.com>
 <20190213131720.GU32494@hirez.programming.kicks-ass.net>
 <20190213140025.GB6346@brain-police>
 <20190213141712.GV32494@hirez.programming.kicks-ass.net>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <e8ff5f65-b8df-0296-e9e7-ba627a4ef1a4@arm.com>
Date: Wed, 13 Feb 2019 14:24:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190213141712.GV32494@hirez.programming.kicks-ass.net>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_062441_079744_7266CA61 
X-CRM114-Status: GOOD (  14.62  )
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
Cc: catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
 valentin.schneider@arm.com, mingo@redhat.com, james.morse@arm.com,
 hpa@zytor.com, Ingo Molnar <mingo@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 13/02/2019 14:17, Peter Zijlstra wrote:
> On Wed, Feb 13, 2019 at 02:00:26PM +0000, Will Deacon wrote:
>>> This; how is getting preempted fundamentally different from scheduling
>>> ourselves?
>>
>> The difference is because getting preempted in the sequence above is
>> triggered off the back of an interrupt. On arm64, and I think also on x86,
>> the user access state (SMAP or PAN) is saved and restored across exceptions
>> but not across context switch. Consequently, taking an irq in a
>> user_access_{begin,end} section and then scheduling is fine, but calling
>> schedule directly within such a section is not.
> 
> So how's this then:
> 
> 	if (user_access_begin()) {
> 
> 		preempt_disable();
> 
> 		<IRQ>
> 			set_need_resched();
> 		</IRQ no preempt>
> 
> 		preempt_enable()
> 		  __schedule();
> 
> 		user_access_end();
> 	}
> 
> That _should_ work just fine but explodes with the proposed nonsense.

AFAICT, This does not work properly because when you schedule out this
task, you won't be saving the EFLAGS.AF/PSTATE.PAN bit on the stack, and
next time you schedule the task back in, it might no longer have the
correct flag value (so an unsafe_get/put_user() will fail even though
you haven't reached user_access_end()).

One solution is to deal with this in task switching code, but so far
I've been told that calling schedule() in such a context is not expected
to be supported.

Cheers,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
