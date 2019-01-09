Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B420C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:11:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AFF521738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F7daKiUe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AFF521738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=rxVxc1/W/BdWJ4JN1zk8BAXuF0lYm1B97Hdk04BfydU=; b=F7daKiUeRLgTjDq6f+MHZogQAC
	vn5gzFleimK6KGNoGMVTCTXzYvf1G26Ih1bCDH8nAxadQ8XB00bfFyL/kCM/jfsw7jZTPLAVkz4Ll
	InZjZqlCz3WAquloLifxCchS8nR0K7A+kUpad01oFnGSDlWGWv89UqssnOWx0DLYf+0gNzYZM6F69
	MwnibcLYyalNIPHhf94O+syGLCZ0m4TR/NdDMBaxkeryDV/2bsgu2n005kBeoOV8h8f4/uAo7CPoh
	oKv6I/uzDp+SnQo12vmG+dNefTrn+obxX1EIcbRdX/QvCgSaV3Xsp3Jy6eK8loKsugDP1VXlvM25/
	yivWlWEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghApf-0006t8-TJ; Wed, 09 Jan 2019 10:11:31 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghApd-0006sh-7S
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 10:11:30 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0F6780D;
 Wed,  9 Jan 2019 02:11:28 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 577BF3F70D;
 Wed,  9 Jan 2019 02:11:28 -0800 (PST)
Subject: Re: arm64: some question about default_idle_call flow
To: yoma sophian <sophian.yoma@gmail.com>, linux-arm-kernel@lists.infradead.org
References: <CADUS3om=GzsVaVHvcAChivp1cTFYq-5YC_mQr-Yw3ANxbn4k+Q@mail.gmail.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <a5660bda-c4b1-1907-93e4-d9ce9d6f84d5@arm.com>
Date: Wed, 9 Jan 2019 10:11:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CADUS3om=GzsVaVHvcAChivp1cTFYq-5YC_mQr-Yw3ANxbn4k+Q@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_021129_274379_CE811303 
X-CRM114-Status: GOOD (  12.29  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Yoma,

On 09/01/2019 09:03, yoma sophian wrote:
> hi all:
> In "default_idle_call", if
> a) "NOT" current_clr_polling_and_test
> then  arch_cpu_idle will call cpu_do_idle().
> (And below is excerpted from arch/arm64/mm/proc.S)
> ENTRY(cpu_do_idle)
>         dsb     sy                              // WFI may enter a
> low-power mode
>         wfi
>         ret
> ENDPROC(cpu_do_idle)
> 
> But before calling default_idle_call, the local interrupt has been disabled.
> Who or what kind of even will wake up this CPU after it runs wfi?
> 

The subtlety is that when interrupts are disabled (i.e. PSTATE.I == 1),
the CPU still receives interrupts, but it does not take them (i.e. does
not jump to the vector entry corresponding to irqs).

For WFI, having an interrupt pending an a CPU is a wake up event as
stated in section D1.17.2 "Wait For interrupt", subsection "WFI wake-up
events":

"The following are WFI wake-up events:
- Any physical SError interrupt, IRQ interrupt, or FIQ interrupt
received by the PE, that is marked as A, B or A/B in the tables in
Asynchronous exception masking on page D1-2202, regardless of the value
of the corresponding PSTATE.{A, I, F} mask bit.
- In EL1 or EL0, any virtual SError interrupt, IRQ interrupt, or FIQ
interrupt received by the PE, that is marked as B in Table D1-19 on page
D1-2205 in Virtual interrupts on page D1-2204, regardless of the value
of the corresponding PSTATE.{A, I, F} mask bit."


A note in the same section adds:
"WFI wake-up events are never disabled by EDSCR.INTdis, and are never
masked by the PSTATE.{A, I, F} mask bits. If wake-up is invoked by an
interrupt that is disabled or masked the interrupt is not taken."

Cheers,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
