Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AFCC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:32:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EC5A21929
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fQfVZCzO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC5A21929
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aNjRhEnu3RiYLUPX+Krs0GemCZ7b6BKPvdEB92Lj1IY=; b=fQfVZCzO0Cs0ON
	Nbtg40PhW3QLgBwMxZaEC5ixNrm2V5QwmHfcMZwra2f0Y//imHFneK3O/ild9s9RqpHCt1bJjwWXa
	56LPezcTqySb1r3mVwaam+GWc0mpliRcydG8S8ySw8DRAEctuhkSqBJJwQ21pzXghRMR3LsdZIVgz
	JysGW0on133a0+OLCBNfl3fPeWi+n2lKXFp5V6GJ4l5+w2N5vJ/bi6p+HirRXpWtIRjjVS9So2of3
	0AhrFcKigJNPl8JGYU3r7VJbjkVjnJPXPZ5hdL6qqp0vIwzJAVFjKt9upXH3yE4blGdsn3pDnWR8W
	8jlKJps5dNTuG7C7OriQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guhLs-000340-Id; Fri, 15 Feb 2019 17:32:40 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guhLp-00033R-3L
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 17:32:38 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA2C5A78;
 Fri, 15 Feb 2019 09:32:36 -0800 (PST)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02A433F589;
 Fri, 15 Feb 2019 09:32:33 -0800 (PST)
Subject: Re: [PATCH 13/13] x86: mm: Convert dump_pagetables to use
 walk_page_range
To: Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org
References: <20190215170235.23360-1-steven.price@arm.com>
 <20190215170235.23360-14-steven.price@arm.com>
 <59a6d402-e383-b9d0-499a-7d65b9a2d402@intel.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <9d7d1e1f-93de-c9a8-e6bb-63696e162210@arm.com>
Date: Fri, 15 Feb 2019 17:32:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <59a6d402-e383-b9d0-499a-7d65b9a2d402@intel.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_093237_146541_858791D2 
X-CRM114-Status: GOOD (  17.89  )
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
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 James Morse <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 15/02/2019 17:16, Dave Hansen wrote:
> On 2/15/19 9:02 AM, Steven Price wrote:
>>  arch/x86/mm/dump_pagetables.c | 281 ++++++++++++++++++----------------
>>  1 file changed, 146 insertions(+), 135 deletions(-)
> 
> I'll look through this in more detail in a bit.  But, I'm a bit bummed
> out by the diffstat.  When I see patches add a bunch of infrastructure,
> I *really* hope for code simplification.
> 
> Looking at the diff, I think it gets there.  The code you add is
> simpler than the code you remove.  But, the diffstat is misleading.

I agree, I was disappointed myself by the diffstat. Hopefully the code
is simplier though - there's unfortunately quite a bit of boiler plate
code in the new version, but that code is at least easier to understand.

My hope is that it will be possible to move the boiler plate code into
common code (there's a lot of similarity with arm64 here). However I
wanted to get some agreement on the approach and make a non-functional
change before attempting to unify the different dump_pagetables
implementations (which is likely to cause minor functional changes).

> I'd probably address this disparity for each patch in the changelogs.

Good point, I'll try to remember for next time.

Thanks for taking a look,

Steve

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
