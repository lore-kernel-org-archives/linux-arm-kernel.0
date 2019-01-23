Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298AAC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:33:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 004412084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ilDPyGcE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 004412084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6b/ULH5hkhAuD3MisrrkOVXvA6Kq00G33TJ9Ec1lqXM=; b=ilDPyGcEwwo8oa
	Kgvcjx2wh1yPGV7JkFnE6l+Fwj03MNqOq5gGLItIB4hoz4pY88XJg/JA9Sem4aJN5Q+Lfy0KsW/PY
	MJi2rT4XcG1GnUz9OsnIUm8mBQ9l9hOAO3hOe11LUG9j0CbBnAgkUckPQ2xLr8xeU5uS8kUrDAo+I
	cUeKrr27EZiPYJhfKPLJgfqawymrQ6omZcd+21JPSAYto4ejjyNjuPbcAsgDaPMgv7DU7vCOsegDz
	Lzxly18MvdGwZvb+9ndz4PYQIlEn6s5/KUniZBRcG6uaoMd3k8skGMw9Y1nH7asTYwZQJjdCRnN0Y
	aU8jvpgZccLD0dhCdzQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmMPQ-0008Ii-BM; Wed, 23 Jan 2019 17:33:52 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmMPN-0008ID-CG
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 17:33:51 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB296EBD;
 Wed, 23 Jan 2019 09:33:48 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71C663F5C1;
 Wed, 23 Jan 2019 09:33:46 -0800 (PST)
Date: Wed, 23 Jan 2019 17:33:44 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Scott Branden <scott.branden@broadcom.com>
Subject: Re: [PATCH RFC 1/1] arm64: Use PSCI calls for CPU stop when hotplug
 is supported
Message-ID: <20190123173343.GC55887@lakrids.cambridge.arm.com>
References: <1547790380-6276-1-git-send-email-pramod.kumar@broadcom.com>
 <20190118113242.GA8928@e107155-lin>
 <CAJ+tv6+6yqT1xkmkY3x6SNQ83K+J6zqKZr7PV5A_ffvyEzceqg@mail.gmail.com>
 <CAJ+tv6KqynSf5t_VwLqpdM4BF+wLWcJ0wPTD4nWqL4ej1Yih4g@mail.gmail.com>
 <20190123164801.GA55887@lakrids.cambridge.arm.com>
 <f1851a76-8078-b8e7-6a54-b038b47f9214@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f1851a76-8078-b8e7-6a54-b038b47f9214@broadcom.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_093349_533903_F8F9B05F 
X-CRM114-Status: GOOD (  27.62  )
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
Cc: Rob Herring <robh@kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Steve Capper <steve.capper@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Pramod Kumar <pramod.kumar@broadcom.com>,
 BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
 Sudeep Holla <sudeep.holla@arm.com>, Dave Martin <dave.martin@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 23, 2019 at 09:05:26AM -0800, Scott Branden wrote:
> Hi Mark,
> 
> Hopefully I can shed some light on the use case inline.
> 
> On 2019-01-23 8:48 a.m., Mark Rutland wrote:
> > On Mon, Jan 21, 2019 at 11:30:02AM +0530, Pramod Kumar wrote:
> > > On Mon, Jan 21, 2019 at 11:28 AM Pramod Kumar <pramod.kumar@broadcom.com>
> > > wrote:
> > > 
> > >      Need comes from a specific use case where one Accelerator card(SoC) is
> > >      plugged in a sever over a PCIe interface.  This Card gets supply from a
> > >      battery, which could provide very less power for a very small time, in case
> > >      of any power loss. Once Card switches to battery, this has to reduce its
> > >      power consumption to its lowest point and back-up the DDR contents asap
> > >      before battery gets fully drained off.
> > In this example is Linux running on the server, or on the accelerator?
> Accelerator
> > 
> > What precisely are you trying to back up from DDR, and why?
> Data in DDR is being written to disk at this time (disk is connected to
> accelerator)
> > 
> > What is responsible for backing up that contents?
> 
> A low power M-class processor and DMA engine which continues necessary
> operations to transfer DDR memory to disk.
> 
> The high power processors on the accelerator running linux needed to be
> halted ASAP on this power loss event and M0 take over. Graceful shutdown of
> linux and other peripherals is unnecessary (and we don't have the power
> necessary to do so).

If graceful shutdown of Linux is not required (and is in fact
undesireable), why is Linux involved at all in this shutdown process?

For example, why is this not a secure interrupt taken to EL3, which can
(gracefully) shut down the CPUs regardless?

> > >      Since battery can provide limited power for a very short time hence need to
> > >      transition to lowest power. As per the transition process , CPUs power
> > >      domain has to be off but before that it needs to flush out its content to
> > >      system memory(L3) so that content could be backed-up by a MCU, a controller
> > >      consuming very less power. Since we can not afford plugging-out every
> > >      individual CPUs in sequence hence uses  ipi_cpu_stop for all other CPUs
> > >      which ultimately switch to ATF to flush out all the CPUs caches and comes
> > >      out of coherency domain so that its power rails could be switched-off.
> > If you're stopping CPUs from completely arbitrary states, what is the
> > benefit of saving the RAM contents?
> 
> Some of the RAM contains data that was in the process of being written to
> disk by the accelerator.

Ok, so this isn't actually about backing up RAM contents; it's about
completing pending I/O.

I'm still confused as to how that works. How do you avoid leaving the
disk in some corrupt state if data runs out partway through?

> This data must be saved to disk and the high power CPUs consume too much
> power to continue performing this operation.
> 
> > CPUs might be running with IRQs disabled for an arbitrarily long time,
> 
> In an embedded linux system we control everything running.

Sure, and that complete control allows you to do something better than
this RFC, AFAICT.

Thanks,
Mark.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
