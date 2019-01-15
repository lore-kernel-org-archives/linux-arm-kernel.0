Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266F3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:32:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC4D420883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m3NHw8v/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC4D420883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MfKMNg8SZ7oaL/yd4U7e3ct3DG4wzeU3mXmAOhsKemE=; b=m3NHw8v/s98BJpyKS/XsPojbR
	vxI1nE4qd+Zkebm5xpcvUfxCBEozZLwRQ6FCPOV++xtnJIticC8rdn3oljFw1RvtbyPbhRMsLXPqT
	Tbr4fGhgb3pdffyPzTeHrMgxWbzgPSQBePvmswrMi66CCxfZLI7gwfl//HR4gTzL6aAtIhgdc96ET
	84PjOhwZ0fO+obVateTipFnovS3d9BDX1LUJRXIDhab8mLVGL/Xg7UpjQ7AOCuurzxoym7bmvtLNF
	6x+MCZKx5Ks7VrRtaMVnGPXf05QSwoM0kaV9eAuf8bbSuAkn1ju/OL1b4cTmJMKnNbW0VV4ua0bqM
	VW1j4ST/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjYCE-0006QP-1D; Tue, 15 Jan 2019 23:32:38 +0000
Received: from mga03.intel.com ([134.134.136.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjYCB-0006Q4-GC
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 23:32:36 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Jan 2019 15:32:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,483,1539673200"; d="scan'208";a="267421640"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.143])
 ([10.7.153.143])
 by orsmga004.jf.intel.com with ESMTP; 15 Jan 2019 15:32:34 -0800
Subject: Re: [PATCH i2c-next v9 0/5] i2c: aspeed: Add bus idle waiting logic
 for multi-master use cases
To: Wolfram Sang <wsa@the-dreams.de>
References: <20181030210917.32711-1-jae.hyun.yoo@linux.intel.com>
 <20190115224713.duoha332mjlrmwji@ninjato>
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <ae348673-f6d5-36ac-a1f2-872d0bab06b1@linux.intel.com>
Date: Tue, 15 Jan 2019 15:32:33 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190115224713.duoha332mjlrmwji@ninjato>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_153235_593155_12DDC7B1 
X-CRM114-Status: GOOD (  17.12  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, James Feist <james.feist@linux.intel.com>,
 Andrew Jeffery <andrew@aj.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, openbmc@lists.ozlabs.org,
 Brendan Higgins <brendanhiggins@google.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>,
 Jarkko Nikula <jarkko.nikula@linux.intel.com>, Joel Stanley <joel@jms.id.au>,
 Vernon Mauery <vernon.mauery@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/15/2019 2:47 PM, Wolfram Sang wrote:
> On Tue, Oct 30, 2018 at 02:09:11PM -0700, Jae Hyun Yoo wrote:
>> In multi-master environment, this driver's master cannot know
>> exactly when a peer master sends data to this driver's slave so a
>> case can be happened that this master tries to send data through
>> the master_xfer function but slave data from peer master is still
>> being processed by this driver. To prevent state corruption in the
>> case, this patch adds checking code if any slave operation is
>> ongoing and it waits up to the bus timeout duration before starting
>> a master_xfer operation.
>>
>> To support this change, it introduces changes on i2c-core-base to
>> make that able to read the bus timeout and master transfer retries
>> count values from device tree properties.
>>
>> Please review this patch set.
> 
> Marking this as "Changes requested". I think if the mutex approach
> works, these patches become obsolete then.
> 

Hi Wolfram,

Thanks for your touching base. I made and tested a new patch in my
local. Actually, I couldn't use a mutex because it should provide
locking between driver context and interrupt context. Instead, after
taking lots of experiments, I checked that idle waiting can be supported
by this H/W so I didn't need to use any locking method in the driver
code for multi-master handling. I'll submit a new patch tomorrow using a
different thread. Please drop this patch set.

Thanks,
Jae

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
