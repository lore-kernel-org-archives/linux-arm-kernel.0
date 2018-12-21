Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37640C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:19:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0411321720
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oSxyGDLX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0411321720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2PL5Raw9eAXANnkbKR8YR3FQuI/5d20vEhRYcZJAImA=; b=oSxyGDLXyzSZ/n
	nuGxV+daIIhu29tHNf2F5kTcdbD/kWpEAFTnB9sdF83UNB4BBBCll+8seiqH8dvDlVuTorWm/UW4Q
	K5e4UkdMciPpQ4RdIwo+gOU21jL1ImYtE1TtJcHH3KKTN51V7DsBgGY5UdoOWQI078Mai7CU1hxXo
	pgG5iVDuitPMrfM+URcgkAPt6mU53XWcwufR9DeNuFJn/FpvGV3eZFKXMMxuvv8TUhFLK9Sk7iWgF
	rWUexJ5oRyBzNoYtOXQ7W0Em+UFExC+yBIWW4eGZIB9r5p9f9w4C4H2o/5e08ZUFbW3cvF1bAHqiq
	MdugZWRZffrj6XW/ZU1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaQKl-0000Cn-Ta; Fri, 21 Dec 2018 19:19:43 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaQKj-0000Bn-4v
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 19:19:42 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13B2280D;
 Fri, 21 Dec 2018 11:19:26 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EBD13F575;
 Fri, 21 Dec 2018 11:19:25 -0800 (PST)
Subject: Re: [PATCH] firmware: arm_sdei: fix wrong of_node_put() in init
 function
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
References: <20181126121536.28739-1-nsaenzjulienne@suse.de>
 <08d6b9e6-7aa0-9342-193b-1ce6e0417f77@arm.com>
 <7a75afd030cbd17c986a3ad486aab35ad3418b28.camel@suse.de>
From: James Morse <james.morse@arm.com>
Message-ID: <cf4e5313-c467-8343-ac90-bb4b937b63ff@arm.com>
Date: Fri, 21 Dec 2018 19:19:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <7a75afd030cbd17c986a3ad486aab35ad3418b28.camel@suse.de>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_111941_197405_E640F176 
X-CRM114-Status: GOOD (  15.33  )
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
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Nicolas,

On 03/12/2018 12:25, Nicolas Saenz Julienne wrote:
> On Fri, 2018-11-30 at 18:31 +0000, James Morse wrote:
>> On 26/11/2018 12:15, Nicolas Saenz Julienne wrote:
>>> After finding a "firmware" dt node arm_sdei tries to match it's
>>> compatible string with it. To do so it's calling
>>> of_find_matching_node()
>>> which already takes care of decreasing the refcount on the
>>> "firmware"
>>> node. We are then incorrectly decreasing the refcount on that node
>>> again.
>>>
>>> This patch removes the unwarranted call to of_node_put().
>>>
>>> Fixes: ad6eb31ef903 ("firmware: arm_sdei: Add driver for Software
>>> Delegated Exceptions")
>>> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>>
>> Thanks!, I agree this is unwarranted.
>> Is there a tool that picks these up? I remember sparse giving me a
>> headache, but
>> I don't remember this one... I probably cargo-culted it from
>> somewhere else.
> 
> We stumbled upon this one on a test system. TBH I don't really know
> much about these tools so I can't tell. That said, I sent 4 more fixes
> on this bug (one more in drivers/firmware) so there definitively was
> some cargo-culting happening.

Well this is embarrassing. I was trying to test this before re-posting it, to
discover dt-probing hasn't worked properly since it was merged, so I evidently
didn't test it properly after the merge-window. (at the same time the OF core
code took over creating platform devices from the firmware node, meaning my
attempt here fails, and the driver never gets registered).

I'll post the additional patch, and drop the fixes tag as this has never worked.


Thanks!

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
