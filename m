Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E92C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:25:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B1D02070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uCrkMztU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B1D02070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U2ItfkyGoraehenJKe/U7pNSFSu/TPE3pe5UY9VndTk=; b=uCrkMztUFmabKk
	9Osu7XT3nRluftm68jrdxrBZXBukFzGLVsIjRy6cPWcUTqJrWB8NIbYMfRX7o/VguvJA77Y3dtyuQ
	M7S8NVu5IWedg4fd2/17VLzRCKa8e9T0RvQQZ80DeIL/PQOt4t+Xp61vTqb8R/Xi4VDIvEnHD0fQp
	LVoygxVkEMBu6W0hnsPfK4H6n6ArZ3FaVJRQ49pDgV8UqEy522VUADTQmull2KeqIqx8pvZv0HqGa
	AYH1EsavadzC0xfU2ANLJk5tycwQC+umec3ePaUwl3HwPgN4OHOOHzZsSplyF3l8kQ/Zz5VeOLwmT
	/2QJY5Xg1v3EIB2q+yGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj5z5-0008MQ-Cc; Mon, 14 Jan 2019 17:25:11 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj5z1-0007Y1-Al
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 17:25:09 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1692BA78;
 Mon, 14 Jan 2019 09:25:05 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D24033F5BD;
 Mon, 14 Jan 2019 09:25:02 -0800 (PST)
Subject: Re: [PATCH v8 01/26] arm64: Fix HCR.TGE status for NMI contexts
To: Julien Thierry <julien.thierry@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
 <1546956464-48825-2-git-send-email-julien.thierry@arm.com>
 <20190114155634.GB84430@arrakis.emea.arm.com>
 <229aade3-5bb3-aad4-bd9a-d6220db836c0@arm.com>
From: James Morse <james.morse@arm.com>
Message-ID: <41c6dc69-3bdc-2ea1-4862-5f4df9b843dd@arm.com>
Date: Mon, 14 Jan 2019 17:25:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <229aade3-5bb3-aad4-bd9a-d6220db836c0@arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_092507_398860_19BCBFAD 
X-CRM114-Status: GOOD (  14.26  )
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
Cc: mark.rutland@arm.com, linux-arch@vger.kernel.org,
 daniel.thompson@linaro.org, Arnd Bergmann <arnd@arndb.de>,
 marc.zyngier@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, christoffer.dall@arm.com, joel@joelfernandes.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi guys,

On 14/01/2019 16:12, Julien Thierry wrote:
> On 14/01/2019 15:56, Catalin Marinas wrote:
>> On Tue, Jan 08, 2019 at 02:07:19PM +0000, Julien Thierry wrote:
>>> When using VHE, the host needs to clear HCR_EL2.TGE bit in order
>>> to interract with guest TLBs, switching from EL2&0 translation regime
>>> to EL1&0.
>>>
>>> However, some non-maskable asynchronous event could happen while TGE is
>>> cleared like SDEI. Because of this address translation operations
>>> relying on EL2&0 translation regime could fail (tlb invalidation,
>>> userspace access, ...).
>>
>> Why would an NMI context need to access user space? (just curious what
>> breaks exactly without this patch; otherwise it looks fine)
> 
> If I remember correctly, the SDEI interrupt might perform cache
> maintenance with EL2&0 translation regime, but James can probably give
> more detail (or correct me if I'm wrong).

Yup, spot on.
The APEI driver has to map/unmap memory using the fixmap. If it interrupts a
guest, the TLB maintenance would affect EL1&0 instead.


> Otherwise, if we decide to use the pseudo NMI for profiling with perf, I
> believe the perf interrupt can access user space (although I'm not
> completely sure whether that might be to record profiling data in
> buffers shared with user space or something else).

It does a stack walk, I think its the PERF_SAMPLE_CALLCHAIN feature, and the
code is:
arch/arm64/kernel/perf_callchain.c::user_backtrace()


Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
