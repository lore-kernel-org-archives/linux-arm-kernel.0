Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E12AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:35:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3D1E217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YCjclZio"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D1E217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hWrjH3IafWx4nCIp/rIUS6QVIcl481q9gEK7X/prIlk=; b=YCjclZioWzT2Ja4q3WVrFaU0y
	zOT7tuR/SJnDApvGOQHJQ02vo5NIzG0ZEVdwmyB9ssyxx3r/tL7c4risFvgtBtosAn9Wvo+PdVFFj
	lN4ss9Ve9nOs209YWtQaxgOGelgpdY6FDaOSwOhkEfxVgbBOGj0jljd5waMtdN61IV0JovKuXi5UN
	vdbpgtRc1JkudroKtd0ow0N5IV4Ogp/VbOt4262KqZnPcRxc3kqCW7m84sb9fMRXivP8ASj/uJxHE
	/rVMBB5Nd1ty68VKXbSYYfcDSSv4erJz8tAYc1y481Na6iJFWB3bH6NLLrnUBesWn/ENZM3fwga1d
	Ws0a+xFWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gybxc-0003O3-Rb; Tue, 26 Feb 2019 12:35:48 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gybxZ-0003Nj-Ub
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 12:35:47 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F27380D;
 Tue, 26 Feb 2019 04:35:44 -0800 (PST)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94AAD3F703;
 Tue, 26 Feb 2019 04:35:42 -0800 (PST)
Subject: Re: [PATCH v5 02/26] arm64: fpsimd: Always set TIF_FOREIGN_FPSTATE on
 task state flush
To: Dave Martin <Dave.Martin@arm.com>
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
 <1550519559-15915-3-git-send-email-Dave.Martin@arm.com>
 <7e358d11-4896-1f09-0496-70a78eb60736@arm.com>
 <20190226120601.GF3567@e103592.cambridge.arm.com>
From: Julien Grall <julien.grall@arm.com>
Message-ID: <3d60d05b-05e5-efe8-f174-a449dbc97445@arm.com>
Date: Tue, 26 Feb 2019 12:35:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190226120601.GF3567@e103592.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_043545_985172_D78B8326 
X-CRM114-Status: GOOD (  16.52  )
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
Cc: Okamoto Takayuki <tokamoto@jp.fujitsu.com>,
 Christoffer Dall <cdall@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Zhang Lei <zhang.lei@jp.fujitsu.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 26/02/2019 12:06, Dave Martin wrote:
> On Thu, Feb 21, 2019 at 12:39:39PM +0000, Julien Grall wrote:
>> Hi Dave,
>>
>> On 18/02/2019 19:52, Dave Martin wrote:
>>> This patch updates fpsimd_flush_task_state() to mirror the new
>>> semantics of fpsimd_flush_cpu_state() introduced by commit
>>> d8ad71fa38a9 ("arm64: fpsimd: Fix TIF_FOREIGN_FPSTATE after
>>> invalidating cpu regs").  Both functions now implicitly set
>>
>> NIT: Double-space before "Both"
>>
>>> TIF_FOREIGN_FPSTATE to indicate that the task's FPSIMD state is not
>>> loaded into the cpu.
>>>
>>> As a side-effect, fpsimd_flush_task_state() now sets
>>> TIF_FOREIGN_FPSTATE even for non-running tasks.  In the case of
>>
>> NIT: Double sppace before "In".
>>
>>> non-running tasks this is not useful but also harmless, because the
>>> flag is live only while the corresponding task is running.  This
>>> function is not called from fast paths, so special-casing this for
>>> the task == current case is not really worth it.
>>>
>>> Compiler barriers previously present in restore_sve_fpsimd_context()
>>> are pulled into fpsimd_flush_task_state() so that it can be safely
>>> called with preemption enabled if necessary.
>>>
>>> Explicit calls to set TIF_FOREIGN_FPSTATE that accompany
>>> fpsimd_flush_task_state() calls and are now redundant are removed
>>> as appropriate.
>>>
>>> fpsimd_flush_task_state() is used to get exclusive access to the
>>> representation of the task's state via task_struct, for the purpose
>>> of replacing the state.  Thus, the call to this function should
>>
>> NIT: Double-space before "Thus".
>>
>>> happen before manipulating fpsimd_state or sve_state etc. in
>>> task_struct.  Anomalous cases are reordered appropriately in order
>>
>> NIT: Double-space before "Anomalous".
> 
> A habit rather than a mistake [1], and I don't propose to change it ;)

I wasn't aware of this. Thank you for the pointer! Please ignore the comments on 
it :).


Cheers,

-- 
Julien Grall

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
