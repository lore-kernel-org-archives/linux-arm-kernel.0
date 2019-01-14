Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFA6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:08:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21FA82086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SPhFJHMx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21FA82086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AXdOvnO57SeHfWzxF6iuuKz9h8tf6Q72ravVj0vztWM=; b=SPhFJHMx6OqE9V
	mWyds92LTA4z9eSEM0B0jJPrVcBZUBhDW9A/jMf/u6sLSvkwT/hLORFrFHBdejvaD8/kmTLr+r0lC
	VdHukOEjbBKdBkShyyh6Ag157o6YORUIkhdC3MofRFFzjbVL0lgmp2ayXvE5rNX3rI2Zf1rCJAtFH
	jD8wFrxjl5Zn7QocO1iYcRf+7yEKyjNc18svr6SDTF+WCyBIxS58HPZ4RXL6qb+v1uHsVMf05q6th
	lKL/dIConREBuqAfY8mWfguBr9Z34dUCo2PyG/H9iFUCWu0rGLCTXnaiazQLbCVp1ZojNTWTaxN7U
	Cr4qxj8dqSQJohrTHP7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj4mY-0004Zs-W0; Mon, 14 Jan 2019 16:08:10 +0000
Received: from relay.sw.ru ([185.231.240.75])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj4mV-0004ZO-De
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 16:08:09 +0000
Received: from [172.16.25.12] by relay.sw.ru with esmtp (Exim 4.91)
 (envelope-from <aryabinin@virtuozzo.com>)
 id 1gj4mK-0004Ut-5L; Mon, 14 Jan 2019 19:07:56 +0300
Subject: Re: [PATCH] kasan: Remove use after scope bugs detection.
To: Dmitry Vyukov <dvyukov@google.com>
References: <20190111185842.13978-1-aryabinin@virtuozzo.com>
 <CACT4Y+YV+jjcXE1oa=Gf031KAgEy40Nq83x3_nj3TwQpw3b+Ug@mail.gmail.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <296f2311-0a11-f4bd-b665-70c3ffad2124@virtuozzo.com>
Date: Mon, 14 Jan 2019 19:08:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+YV+jjcXE1oa=Gf031KAgEy40Nq83x3_nj3TwQpw3b+Ug@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_080807_454934_816CD426 
X-CRM114-Status: GOOD (  14.48  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 kasan-dev <kasan-dev@googlegroups.com>, Linux-MM <linux-mm@kvack.org>,
 Qian Cai <cai@lca.pw>, Alexander Potapenko <glider@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/14/19 4:24 PM, Dmitry Vyukov wrote:
> On Fri, Jan 11, 2019 at 7:58 PM Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>>
>> Use after scope bugs detector seems to be almost entirely useless
>> for the linux kernel. It exists over two years, but I've seen only
>> one valid bug so far [1]. And the bug was fixed before it has been
>> reported. There were some other use-after-scope reports, but they
>> were false-positives due to different reasons like incompatibility
>> with structleak plugin.
>>
>> This feature significantly increases stack usage, especially with
>> GCC < 9 version, and causes a 32K stack overflow. It probably
>> adds performance penalty too.
>>
>> Given all that, let's remove use-after-scope detector entirely.
>>
>> While preparing this patch I've noticed that we mistakenly enable
>> use-after-scope detection for clang compiler regardless of
>> CONFIG_KASAN_EXTRA setting. This is also fixed now.
> 
> Hi Andrey,
> 
> I am on a fence. On one hand removing bug detection sucks and each
> case of a missed memory corruption leads to a splash of assorted bug
> reports by syzbot. On the other hand everything you said is true.
> Maybe support for CONFIG_VMAP_STACK will enable stacks larger then
> PAGE_ALLOC_COSTLY_ORDER?
> 

Yes, with vmap stacks higher order won't be a problem, since vmalloc() does only 0-order 
allocations. But even with vmap stacks use-after-scope won't become useful,
thus I don't see the point of re-enabling it with vmap stacks.
If feature doesn't detect bugs, but waste resources, than it's bad for detecting bugs.
We wasting our limited resources for useless checks, instead of using these resources
for doing more useful checks, running tests faster hence detecting more bugs per-time. 





_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
