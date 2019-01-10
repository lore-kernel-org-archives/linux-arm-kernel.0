Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFEDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:46:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFAE5214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sCzEi2o1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFAE5214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M26InynXmYfkc2br4yfcJdTuqvrRU448eGV00ri1mT0=; b=sCzEi2o1QDXrzu
	iCsCNexxM5KulobbkhAGMJkaC9NnHqNqFxiuM/GV6rL7lGYT8Ew3PW5FJPcO7vjsVp0RoIk+pPDRs
	YH1v0g3rcAYbIt2fzKuJ0x/uPiVREEUixP2wBuhCzIWVZDTtsMDgt27anJbCP3I90kuaGc6YjpIAi
	Ep3VEGfqxks375QNUplu8Mt8+5jTdHXKTZmrmC/Dbu5IFutVveYjFp4xDjSmrhqj9q87HLra5HyeC
	1hmg2cQ3EVmepZpHH1/2mC4rCNSht/z7J0RMn4TeNx8dHigA03W4l0CRegQ9JbecH1pC4WWG6QYLH
	1LnjUKDEVqzvX/8G31Mg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghWuV-0003I2-M8; Thu, 10 Jan 2019 09:45:59 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghWuT-0003Hg-0h
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 09:45:58 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C06680D;
 Thu, 10 Jan 2019 01:45:56 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 244AE3F694;
 Thu, 10 Jan 2019 01:45:56 -0800 (PST)
Subject: Re: arm64: some question about default_idle_call flow
To: yoma sophian <sophian.yoma@gmail.com>
References: <CADUS3om=GzsVaVHvcAChivp1cTFYq-5YC_mQr-Yw3ANxbn4k+Q@mail.gmail.com>
 <a5660bda-c4b1-1907-93e4-d9ce9d6f84d5@arm.com>
 <CADUS3onK0LVpnALtscHY=cLfJ-UA+08dhp9tH7QO93QVGhp1iQ@mail.gmail.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <61035392-ef04-3697-935f-76155177f6ad@arm.com>
Date: Thu, 10 Jan 2019 09:45:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CADUS3onK0LVpnALtscHY=cLfJ-UA+08dhp9tH7QO93QVGhp1iQ@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_014557_057307_3F8DD6EF 
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
Cc: linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 10/01/2019 08:53, yoma sophian wrote:
> hi Julien:
>> A note in the same section adds:
>> "WFI wake-up events are never disabled by EDSCR.INTdis, and are never
>> masked by the PSTATE.{A, I, F} mask bits. If wake-up is invoked by an
>> interrupt that is disabled or masked the interrupt is not taken."
> I have one question:
> a) if not only local_irq_disabled but also turn off GIC, the CPU will
> not be waked up after run WFI, right?
> (The PE will not receive any  SError interrupt, IRQ interrupt, or FIQ interrupt,
> since GIC is turned off. And at this time, only legacy fiq/irq can wake up CPU)
> 

I'm not entirely sure what you mean by "turn off the GIC". But yes, if
for some reason the GIC does not send interrupts to the CPU (because
interrupts are disabled at the GIC level or even because there is a
priority mask too high in the PMR), it might not be able to wake up from
a WFI.

But I'm not sure why you'd turn off all interrupts at the GIC level
after boot time. If for some reason you do, make sure they are
re-enabled before doing WFI or anything that would rely on receiving
interrupts.

Cheers,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
