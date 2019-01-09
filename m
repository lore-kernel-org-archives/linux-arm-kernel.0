Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DAEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:21:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A7D4206BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BhUDiVQn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A7D4206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bhoNMO088UhKaUJPRWPXJjULuUQA47J5dqa7n5GK3Iw=; b=BhUDiVQnqPY4hJ
	CE40pZbEvjxD3Y7X4Z3qHvEgW1jrjupT6joNPvLvPUfngXBuWJUEAoz7zf2xvqE3jYRWXTat7QdQV
	0DxxS8gdv28wQs9If4lJgqQBCNyOeY8PsKiuINgnep9nHDeVqLnNtkJkNXIIjK6k2PDhOTWrTyNMN
	Y4r2FcPFIqE9Z+YpyKmLf93B9t/kWKN5EFzIz4GOD1I1AmzPrmUcVjkgkCB5tzo3xQKepgKVrCdVk
	pS2P2We6J/uirQ+gxaEsmjQcebox7SyJbASJuUkmhWtlNsFL5VCnnTTqLPHFc244dFqU3Ue50Z5Vr
	IyTgBDrRdq/A8HOilizA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghGc5-0008RF-5b; Wed, 09 Jan 2019 16:21:53 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghGc2-0008Qs-6z
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 16:21:51 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE65AA78;
 Wed,  9 Jan 2019 08:21:49 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 CAC533F5AF; Wed,  9 Jan 2019 08:21:48 -0800 (PST)
Subject: Re: [PATCH] ARM: irq: Add IRQ_SET_MASK_OK_DONE handling in
 migrate_one_irq()
To: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 linux-arm-kernel@lists.infradead.org
References: <20190108135805.5535-1-dietmar.eggemann@arm.com>
 <9288fdeb-8eb1-28ca-f950-ccf36d63688a@arm.com>
 <1fcb35b7-4105-e4b7-a528-eb48be876edf@arm.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <9235d4df-55b8-2f33-a992-abab64e35347@arm.com>
Date: Wed, 9 Jan 2019 16:21:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <1fcb35b7-4105-e4b7-a528-eb48be876edf@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_082150_267382_50D42495 
X-CRM114-Status: GOOD (  19.89  )
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
Cc: linux-kernel@vger.kernel.org,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 09/01/2019 15:47, Dietmar Eggemann wrote:
> Hi Marc,
> 
> On 1/8/19 3:16 PM, Marc Zyngier wrote:
>> Hi Dietmar,
>>
>> On 08/01/2019 13:58, Dietmar Eggemann wrote:
>>> Arm TC2 (multi_v7_defconfig plus CONFIG_ARM_BIG_LITTLE_CPUFREQ=y and
>>> CONFIG_ARM_VEXPRESS_SPC_CPUFREQ=y) fails hotplug stress tests.
>>>
>>> This issue was tracked down to a missing copy of the new affinity
>>> cpumask of the vexpress-spc interrupt into struct
>>> irq_common_data.affinity when the interrupt is migrated in
>>> migrate_one_irq().
>>>
>>> Commit 0407daceedfe ("irqchip/gic: Return IRQ_SET_MASK_OK_DONE in the
>>> set_affinity method") changed the return value of the irq_set_affinity()
>>> function of the GIC from IRQ_SET_MASK_OK to IRQ_SET_MASK_OK_DONE.
>>>
>>> In migrate_one_irq() if the current irq affinity mask and the cpu
>>> online mask do not share any CPU, the affinity mask is set to the cpu
>>> online mask. In this case (ret == true) and when the irq chip
>>> function irq_set_affinity() returns successfully (IRQ_SET_MASK_OK),
>>> struct irq_common_data.affinity should also be updated.
>>>
>>> Add IRQ_SET_MASK_OK_DONE next to IRQ_SET_MASK_OK when checking that the
>>> irq chip function irq_set_affinity() returns successfully.
>>>
>>> Commit 2cb625478f8c ("genirq: Add IRQ_SET_MASK_OK_DONE to support
>>> stacked irqchip") only added IRQ_SET_MASK_OK_DONE handling to
>>> irq_do_set_affinity() in the irq core and not to the Arm32 irq code.
>>>
>>> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>>> ---
>>>
>>> The hotplug issue on Arm TC2 happens because the vexpress-spc interrupt
>>> (irq=22) is affine to CPU0. This occurs since it is setup early when the
>>> cpu_online_mask is still 0.
>>> But the problem with the missing copy of the affinity mask should occur
>>> with every interrupt which is forced to migrate.
>>>
>>> With additional debug in irq_setup_affinity():
>>>
>>> [0.000619] irq_setup_affinity(): irq=17 mask=0 cpu_online_mask=0 set=0-4
>>> [0.007065] irq_setup_affinity(): irq=22 mask=0 cpu_online_mask=0 set=0-4
>>> [3.372907] irq_setup_affinity(): irq=47 mask=0-4 cpu_online_mask=0-4
>>> set=0-4
>>>
>>> cat /proc/interrupts
>>>             CPU0       CPU1       CPU2       CPU3       CPU4
>>> 22:        316          0          0          0          0     GIC-0 127
>>> Level     vexpress-spc
>>>
>>> cat /proc/irq/22/smp_affinity_list
>>> 0
> 
> [...]
> 
>>
>> On the arm64 side, we've solved the exact same issue by getting rid of
>> this code and using the generic implementation. See 217d453d473c5
>> ("arm64: fix a migrating irq bug when hotplug cpu"), which uses
>> irq_migrate_all_off_this_cpu instead.
>>
>> I'm not sure there is much value in not using the core code in this case.
> 
> Thanks for the hint! Much more elegant! I tried the following on TC2 and 
> it worked just fine. I'm not aware on any drawbacks of using the generic 
> irq migration for Arm32 as well.

[...]

Sounds great! Can you put it in a proper patch and resend it?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
