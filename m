Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FDCC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:56:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1E86218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cR/MEAbt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E86218B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8R3dRYfdttoOTI1UB68V1uArOjDdzl4pN/rG2DSEuIE=; b=cR/MEAbtWfI4w/MHLMEa7JMDt
	kdWPDuXEGoSfRYvBDi/TMsDAixebLoiQSS3O1KmxnYekt09B+7qyWMOIG2/wSeJOIrlkdqXyg5V+s
	fz8CnGMTCzX/fJ97fuwv1Vu+dqZMawEs7ZElTcwRUhlaV4JKqC3PY8LJAg8qn+gECc6efbu4yrsRe
	DkMH9T5+mBkHBVPwsDDqP3US9BsxjS7uqEDy8DWSyJhKCuLls6EWJ5oqpL/+UCnBbxvp3o3A2+c4a
	6CtTe5Z4jKIQNnLZfEekduRUR3PVHn+JoimM+Hrh+woUGpbsiJb3ZEzQrZquLo6a1xb8PDOO6q9+T
	lOwWNvq9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn3qa-0007xR-Sc; Fri, 25 Jan 2019 15:56:48 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn3qX-0007x5-VH
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 15:56:47 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDD77A78;
 Fri, 25 Jan 2019 07:56:45 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 813253F5AF;
 Fri, 25 Jan 2019 07:56:43 -0800 (PST)
Subject: Re: [PATCH RFC 1/1] arm64: Use PSCI calls for CPU stop when hotplug
 is supported
To: Pramod Kumar <pramod.kumar@broadcom.com>
References: <1547790380-6276-1-git-send-email-pramod.kumar@broadcom.com>
 <20190118113242.GA8928@e107155-lin>
 <CAJ+tv6+6yqT1xkmkY3x6SNQ83K+J6zqKZr7PV5A_ffvyEzceqg@mail.gmail.com>
 <CAJ+tv6KqynSf5t_VwLqpdM4BF+wLWcJ0wPTD4nWqL4ej1Yih4g@mail.gmail.com>
 <20190123164801.GA55887@lakrids.cambridge.arm.com>
 <f1851a76-8078-b8e7-6a54-b038b47f9214@broadcom.com>
 <20190123173343.GC55887@lakrids.cambridge.arm.com>
 <CAJ+tv6+Mm8Rmsx8cfOuDT4+CVWVd4gKLzUnTs_EMxKYax+NScw@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <28d43f76-12ac-662b-31ad-942c9d7e81ea@arm.com>
Date: Fri, 25 Jan 2019 15:56:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAJ+tv6+Mm8Rmsx8cfOuDT4+CVWVd4gKLzUnTs_EMxKYax+NScw@mail.gmail.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_075646_014018_8A40C4CE 
X-CRM114-Status: GOOD (  27.99  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Scott Branden <scott.branden@broadcom.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org,
 BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
 Sudeep Holla <sudeep.holla@arm.com>, Dave Martin <dave.martin@arm.com>,
 linux-arm-kernel@lists.infradead.org, Steve Capper <steve.capper@arm.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 25/01/2019 07:03, Pramod Kumar wrote:
> On Wed, Jan 23, 2019 at 11:03 PM Mark Rutland <mark.rutland@arm.com> wrote:
>>
>> On Wed, Jan 23, 2019 at 09:05:26AM -0800, Scott Branden wrote:
>>> Hi Mark,
>>>
>>> Hopefully I can shed some light on the use case inline.
>>>
>>> On 2019-01-23 8:48 a.m., Mark Rutland wrote:
>>>> On Mon, Jan 21, 2019 at 11:30:02AM +0530, Pramod Kumar wrote:
>>>>> On Mon, Jan 21, 2019 at 11:28 AM Pramod Kumar <pramod.kumar@broadcom.com>
>>>>> wrote:
>>>>>
>>>>>       Need comes from a specific use case where one Accelerator card(SoC) is
>>>>>       plugged in a sever over a PCIe interface.  This Card gets supply from a
>>>>>       battery, which could provide very less power for a very small time, in case
>>>>>       of any power loss. Once Card switches to battery, this has to reduce its
>>>>>       power consumption to its lowest point and back-up the DDR contents asap
>>>>>       before battery gets fully drained off.
>>>> In this example is Linux running on the server, or on the accelerator?
>>> Accelerator
>>>>
>>>> What precisely are you trying to back up from DDR, and why?
>>> Data in DDR is being written to disk at this time (disk is connected to
>>> accelerator)
>>>>
>>>> What is responsible for backing up that contents?
>>>
>>> A low power M-class processor and DMA engine which continues necessary
>>> operations to transfer DDR memory to disk.
>>>
>>> The high power processors on the accelerator running linux needed to be
>>> halted ASAP on this power loss event and M0 take over. Graceful shutdown of
>>> linux and other peripherals is unnecessary (and we don't have the power
>>> necessary to do so).
>>
>> If graceful shutdown of Linux is not required (and is in fact
>> undesireable), why is Linux involved at all in this shutdown process?
>>
>> For example, why is this not a secure interrupt taken to EL3, which can
>> (gracefully) shut down the CPUs regardless?
>>
> 
> This is an GPIO interrupt. This can not be marked secure as for that
> we need to mark whole GPIO controller as secure which is not possible
> as GPIO controller is meant for non-secure world having more than 100
> lines connected.
> 
> I agree we have work around where we invoke handler in Linux and
> switch to ATF via SMC and from ATF we need bring all secondary CPU to
> ATF via sending SGI and and then respective core flushes the L1/L2 and
> bring himself out of coherency domain and cluster and MCU shutdowns
> the CPU subsystem gracefully. This could work for our requirement.
> Need to check ATF support for that.

Right, SMCCC has whole spaces for SoC-specific and platform-specific 
service calls. If your system has a need to power off as fast as 
possible under system-specific constraints, it seems much more sensible 
to immediately tell the firmware "power off as fast as possible under 
the system-specific constraints that you have full knowledge of, 
please", rather than trying to coax the generic kernel_halt() (or 
whatever) infrastructure to sort-of-do-what-you-want.

> But What about generic system? This patch address the generic
> multi-master system's requirement. Consider system where shutting down
> the linux does not mean shutting down the complete system. Lets take
> an example of smartnic case Where NIC master and CPUs access cachable
> DDR. In smarnic its quite common to bring CPUs on demand means when
> needed via MCU help.
> Now in full-fledged system. if CPU subsystem is shutdown via poweroff
> command which does not bring secondary CPUs out of coherency domain,
> it will bring the complete system unstable when NIC master tries to
> access DDR and snoop is send to CPUs as well which is not available.
> Fabric/System hangs...

Not sure that's really relevant here... If platform firmware is able to 
power things off in a way that breaks the platform, surely that's 
entirely the firmware's own fault.

> I feel While shutting down the CPUs subsystem or powering off, All
> secondary CPUs must be shutdown properly by bring-out of coherency
> domain to remain rest of subsystem usable. I agree that introducing
> PSCI call introduce delay for shutdown/reboot case but stability
> matter than little delay.

Again, if you don't trust the firmware to implement SYSTEM_OFF 
appropriately for the platform, can you really assume its CPU_OFF 
implementation is safe either?

People already complain today about how long CPU bringup takes on 
certain systems. Extending their reboot cycle by a similar degree for 
reasons that are entirely irrelevant to those systems is hardly going to 
make those users any happier.

Robin.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
