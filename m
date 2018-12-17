Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646D4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:31:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34D2720874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Uq/G0NYV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D2720874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9GP8vy0eW0ba24EtzM+SVz3x6sdIFD9Zr7GCnXGkYGQ=; b=Uq/G0NYV0A/JD7
	oTc2PV8Uu4PiGSQLxhzEdEeKRgb2zAsoEQbyB8SbLUA7akxxZgM1u4bRJ9QGgYBYWc/aQt/IS2Ole
	TkFBGF8siRi32SsZuG8N+fbchUvNPYK4BFSEE49VIvKiVjrhHn4hRGmg3HyNH+VDBjE6ipRyoSevj
	uK1WfVkf0sP76fbqlIBgX2y46mnUma0A1/R7X/KQ+ysUf/4hcYFukl7XM8OO5BzKd975lekjatgKR
	TuUx4/5CVoEaWrOXmVC8Mx/3IhOIGYOjbck5tAm+QMSPv4Z97zXPUKLd3rIrUJi+N6Is4Am4eEvTn
	ivcWBDJ2Al80LuLRMhYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYszO-00040K-06; Mon, 17 Dec 2018 13:31:18 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYszK-0003y2-N6
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 13:31:16 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7E10A78;
 Mon, 17 Dec 2018 05:31:00 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B8083F5C0;
 Mon, 17 Dec 2018 05:30:59 -0800 (PST)
Subject: Re: [PATCH 6/6] arm64: Use ftrace_graph_get_ret_stack() instead of
 curr_ret_stack
To: Steven Rostedt <rostedt@goodmis.org>
References: <20181210193007.655970639@goodmis.org>
 <20181210193335.417173167@goodmis.org>
 <f0613902-80ac-5865-26ee-f0aac4d3b906@arm.com>
 <20181214220054.101f9e4c@vmware.local.home>
From: James Morse <james.morse@arm.com>
Message-ID: <1fd00f16-24bf-11f1-a27a-4a7c8f23c11a@arm.com>
Date: Mon, 17 Dec 2018 13:30:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181214220054.101f9e4c@vmware.local.home>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_053114_759736_45F4576A 
X-CRM114-Status: GOOD (  18.09  )
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
Cc: linux-arch@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Steve,

On 15/12/2018 03:00, Steven Rostedt wrote:
> On Thu, 13 Dec 2018 17:09:35 +0000
> James Morse <james.morse@arm.com> wrote:
>> I gave this branch a spin, but I hit the WARN_ON() fairly easily:
> 
> Thanks for testing!
> 
> Can you see if this patch fixes it for you?

> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index d4f04f0ca646..8dfd5021b933 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -246,10 +246,10 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
>  struct ftrace_ret_stack *
>  ftrace_graph_get_ret_stack(struct task_struct *task, int idx)
>  {
> -	idx = current->curr_ret_stack - idx;
> +	idx = task->curr_ret_stack - idx;
>  
>  	if (idx >= 0 && idx <= task->curr_ret_stack)
> -		return &current->ret_stack[idx];
> +		return &task->ret_stack[idx];
>  
>  	return NULL;
>  }
> 

Heh, yes that fixes it:

Tested-by: James Morse <james.morse@arm.com>


Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
