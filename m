Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5678C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:12:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6324214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fEOPejg4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6324214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FCEE2N5By+fZRarkM8/uw1Qnf/sk6WdcEF7m0zjn3Yo=; b=fEOPejg4wUBhG8gJpVFc6zE5D
	ogaMMUgfvj1ur++qqcWL+oW6TkAh/yPEKfi7Dtx+4TkFYm11duoe5Ovl9gSzftYi8TLv0Ehsk+snb
	qTVVTZpjXyLKy5vSFlpB9GGIr8fjBpaQeqSkWpEMM7MeU+BDI+jV9JD74WDNiGo2azJN01E8LdX76
	LvSepxx4iD9K4rJp4jDADoDCvoh6hJJqVa79MuUqurKN8P3PWrxV2K/IY9e8C2zei94OI4o7Un1ng
	f3tohK6QyBITyq76+2qcxwB2iojrdWYPZPqvj6M2AO8527ZJe48p1eofREY3aOYqxcvJ7crLqV+2T
	wYc+tdFqg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghXK7-0006cy-B2; Thu, 10 Jan 2019 10:12:27 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghXK4-0006cU-FF
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 10:12:25 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 223E280D;
 Thu, 10 Jan 2019 02:12:24 -0800 (PST)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F17A93F694;
 Thu, 10 Jan 2019 02:12:22 -0800 (PST)
Subject: Re: [PATCH] ARM: irq: Add IRQ_SET_MASK_OK_DONE handling in
 migrate_one_irq()
To: Marc Zyngier <marc.zyngier@arm.com>, linux-arm-kernel@lists.infradead.org
References: <20190108135805.5535-1-dietmar.eggemann@arm.com>
 <9288fdeb-8eb1-28ca-f950-ccf36d63688a@arm.com>
 <1fcb35b7-4105-e4b7-a528-eb48be876edf@arm.com>
 <9235d4df-55b8-2f33-a992-abab64e35347@arm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <29e5c472-40b0-f7e2-e04e-ef3093f997a6@arm.com>
Date: Thu, 10 Jan 2019 11:12:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <9235d4df-55b8-2f33-a992-abab64e35347@arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_021224_513292_65484711 
X-CRM114-Status: GOOD (  17.53  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/9/19 5:21 PM, Marc Zyngier wrote:
> On 09/01/2019 15:47, Dietmar Eggemann wrote:
>> Hi Marc,
>>
>> On 1/8/19 3:16 PM, Marc Zyngier wrote:
>>> Hi Dietmar,
>>>
>>> On 08/01/2019 13:58, Dietmar Eggemann wrote:

[...]

>>> On the arm64 side, we've solved the exact same issue by getting rid of
>>> this code and using the generic implementation. See 217d453d473c5
>>> ("arm64: fix a migrating irq bug when hotplug cpu"), which uses
>>> irq_migrate_all_off_this_cpu instead.
>>>
>>> I'm not sure there is much value in not using the core code in this case.
>>
>> Thanks for the hint! Much more elegant! I tried the following on TC2 and
>> it worked just fine. I'm not aware on any drawbacks of using the generic
>> irq migration for Arm32 as well.
> 
> [...]
> 
> Sounds great! Can you put it in a proper patch and resend it?

Yes. I renamed the patch to "arm: fix a migrating irq bug when hotplug 
cpu" so it's closer to its arm64 counterpart patch.

https://lore.kernel.org/lkml/20190110100922.20280-1-dietmar.eggemann@arm.com/

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
