Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E483DC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:48:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2C1B2085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r5+j1sis"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2C1B2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=R7RAjyXg3UWImj7hQkby5vg1yL6BjE9ema3nphQ3VYk=; b=r5+j1sis0yAMpC
	DAMCgGMfEYR6N0WZjHplRQhcpEpO0+JarwOj0WGRF63uHWfTd7r66oZ+8G5codSSHIN3H/Q8egREE
	BN1ts7Slkvy5UCLxtW/7Nx7LwT5APCz02tsX0VT0atcHzsUkfV5IdQSctHRV2Y3pTWk64go0vZh2A
	vTOHFP7U3yQ7sIVuHm7Qv//w1b/KRH1sIKv9yk1eamC2EJd7nD+w6gv1Z2A48m2Rgh3FtWnrUfjcF
	hcaJCJEk6pDzELVsDq2stBnWUVR/cTPDk5XvbVekev8kPl4KmBx5H1wQpVmoVwW8BDCbhnQYeF9HB
	lbwlQ2tFAeLj9t4oeQfA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmLhI-0004Vl-Px; Wed, 23 Jan 2019 16:48:16 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmLhE-0004TV-73
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 16:48:14 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15FBFEBD;
 Wed, 23 Jan 2019 08:48:09 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F12E33F237;
 Wed, 23 Jan 2019 08:48:06 -0800 (PST)
Date: Wed, 23 Jan 2019 16:48:02 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Pramod Kumar <pramod.kumar@broadcom.com>
Subject: Re: [PATCH RFC 1/1] arm64: Use PSCI calls for CPU stop when hotplug
 is supported
Message-ID: <20190123164801.GA55887@lakrids.cambridge.arm.com>
References: <1547790380-6276-1-git-send-email-pramod.kumar@broadcom.com>
 <20190118113242.GA8928@e107155-lin>
 <CAJ+tv6+6yqT1xkmkY3x6SNQ83K+J6zqKZr7PV5A_ffvyEzceqg@mail.gmail.com>
 <CAJ+tv6KqynSf5t_VwLqpdM4BF+wLWcJ0wPTD4nWqL4ej1Yih4g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJ+tv6KqynSf5t_VwLqpdM4BF+wLWcJ0wPTD4nWqL4ej1Yih4g@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_084812_262344_C5AEF1A3 
X-CRM114-Status: GOOD (  16.47  )
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
 BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
 Sudeep Holla <sudeep.holla@arm.com>, Dave Martin <dave.martin@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 21, 2019 at 11:30:02AM +0530, Pramod Kumar wrote:
> On Mon, Jan 21, 2019 at 11:28 AM Pramod Kumar <pramod.kumar@broadcom.com>
> wrote:
> 
>     Need comes from a specific use case where one Accelerator card(SoC) is
>     plugged in a sever over a PCIe interface.  This Card gets supply from a
>     battery, which could provide very less power for a very small time, in case
>     of any power loss. Once Card switches to battery, this has to reduce its
>     power consumption to its lowest point and back-up the DDR contents asap
>     before battery gets fully drained off. 

In this example is Linux running on the server, or on the accelerator?

What precisely are you trying to back up from DDR, and why?

What is responsible for backing up that contents?

>     Since battery can provide limited power for a very short time hence need to
>     transition to lowest power. As per the transition process , CPUs power
>     domain has to be off but before that it needs to flush out its content to
>     system memory(L3) so that content could be backed-up by a MCU, a controller
>     consuming very less power. Since we can not afford plugging-out every
>     individual CPUs in sequence hence uses  ipi_cpu_stop for all other CPUs
>     which ultimately switch to ATF to flush out all the CPUs caches and comes
>     out of coherency domain so that its power rails could be switched-off.

If you're stopping CPUs from completely arbitrary states, what is the
benefit of saving the RAM contents?

CPUs might be running with IRQs disabled for an arbitrarily long time,
so there's no guarantee that all of them will be turned off before power
is lost.

I'm very confused as to what you're trying to achieve here.

Thanks,
Mark.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
