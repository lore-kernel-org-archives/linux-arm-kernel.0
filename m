Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A14EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:53:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61BC720879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UzeR1xy2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61BC720879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4VfJqXwfYzp/4uoF6mowJU34tis4sktf4xRzBtm/lXE=; b=UzeR1xy2anbOD2
	AzY68II1bzcw16pMM+2u3NDmKOQ7MecS3NVA25i/MTyhlvOix+y4dxfpY48xtH71865v6o4f0cJl1
	whR92o8F9b/Z8p6vyZBNRbLOY+o79g1iiwEnzk20nqLzsdLwo4EYC54EjQCncWnr7/G2Il+rxJZ3z
	nPmArwDz/uAuY8iCEIFFOvrG8moHlpdw2babrfXzP8XF6qH2mQwoSEHN+G11bqWl+5kBW/fKmz+as
	gcptQTgPTu1GUBmCZTY8BG1dfL1CvYV0cE1j/x/fRtOm8fiShSao01XpAPhs5GE3iNB9Ft/tl+Sj3
	A0xCau69pWdcl9fDtTNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghamD-0004ys-BO; Thu, 10 Jan 2019 13:53:41 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gham9-0004y7-Op
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 13:53:39 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A2E91596;
 Thu, 10 Jan 2019 05:53:35 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 095573F5AF;
 Thu, 10 Jan 2019 05:53:33 -0800 (PST)
Date: Thu, 10 Jan 2019 13:53:25 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: "huanglingyan (A)" <huanglingyan2@huawei.com>
Subject: Re: [PATCH v3] arm64: lib: accelerate do_csum with NEON instruction
Message-ID: <20190110135255.GB3554@e103592.cambridge.arm.com>
References: <1546739729-17234-1-git-send-email-huanglingyan2@huawei.com>
 <20190109142513.GA3554@e103592.cambridge.arm.com>
 <19a3acc0-87d7-5ca2-46a5-c3324797491d@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <19a3acc0-87d7-5ca2-46a5-c3324797491d@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_055337_819167_BB970CBD 
X-CRM114-Status: GOOD (  43.22  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 10, 2019 at 04:03:59PM +0800, huanglingyan (A) wrote:
> 
> On 2019/1/9 22:58, Dave Martin wrote:
> > On Sun, Jan 06, 2019 at 09:55:29AM +0800, Lingyan Huang wrote:
> >> Function do_csum() in lib/checksum.c is used to compute checksum,
> >> which is turned out to be slowly and costs a lot of resources.
> >> Let's use neon instructions to accelerate the checksum computation
> >> for arm64.
> >>
> >> ------
> >> V2 ==> V3:
> >>     only modify the arm64 codes instead of modifying headers
> >>     under asm-generic and code in lib/checksum.c.
> >> ------
> >> ------
> >> V1 ==> V2:
> >>     Change NEON assembly code to NEON intrinsic code which is built
> >>     on top of arm_neon.h to avoid dropping into assembly.
> >> ------
> >>
> >> Here is the comparison results of function ip_compute_csum() between
> >> general do_csum() and neon instruction do_csum(). The test platform 
> >> is HUAWEI 1620 server with TAISHAN cores.
> >>
> >>         len(1000cycle)      general(ns)        do_csum_neon(ns)
> >>           64B:                58060                 59460
> >>          128B:                82930                 83930
> >>          256B:               132480                 73570
> >>          512B:               230100                 86230
> >>         1024B:               426600                 98200
> > For testing purposes, you would need to cover all possible aligments of
> > buff and all values of (len % 16), as well as testing on big- and
> > little-endian.
> >
> > Otherwise, a lot of code for handling edge cases won't be tested.
> >
> >
> > Also, it would be interesting to know which sizes are actually most
> > common at runtime, to avoid falling into the trap of optimising for
> > rare cases at the expense of the more common cases.
> >
> > You could try adding some instrumentation to collect some statistics on
> > this.
> Different alignements of buff and different lengths should be
> showing here. The test-report will be more detailed as you said.
> 
> The main scene of do_csum is the Internet package checksum as I know.
> The package length is usually 64 Byte - MTU(1500 Byte default).

Sure, but it is used for some other things too.  So we should avoid
assuming that it is used for buffers strictly no larger than a network
packet unless there is clear evidence of that.

> My test platform is little-endian based. I will try my best to find a
> big-endian test platform.

That would be good.

You could also get some information on which sizes are commonest
by some trick like

#include <linux/atomic.h>
#include <linux/log2.h>

#define NR_COUNTERS 17

static atomic_t counters[NR_COUNTERS];

do_csum(..., int len)
{
	/* ... */
	atomic_inc(&counters[max(ilog2(len), NR_COUNTERS - 1)]);
	/* ... */
}

And then print out the counts periodically or expose them via debugfs.
(Probably not useful to upstream that code, but it could provide some
interesting statistics.)

[...]

> >> diff --git a/arch/arm64/lib/do_csum.c b/arch/arm64/lib/do_csum.c
> >> new file mode 100644
> >> index 0000000..893583f
> >> --- /dev/null
> >> +++ b/arch/arm64/lib/do_csum.c
> >> @@ -0,0 +1,136 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Authors: Lingyan Huang <huanglingyan2@huawei.com>
> >> + * Copyright (C) 2018 Hisilicon, Inc. All Rights Reserved.
> >> + *
> >> + * Generic C or neon implementation of do_csum operations.
> >> + * Choose faster neon instructions when NEON is supported.
> >> + *
> >> + */
> >> +
> >> +#include <asm/neon.h>
> >> +#include <asm/simd.h>
> > Unless you call may_use_simd() (see below) I can't see why you need to
> > include <asm/simd.h>.
> 
> Yeah, may_use_simd() should be called.
> 
> >> +#include <asm/checksum.h>
> >> +#include <asm/byteorder.h>
> >> +#include <asm/neon-intrinsics.h>
> >> +
> >> +#define CSUM_NEON_THRESHOLD 128
> >> +#ifdef CONFIG_KERNEL_MODE_NEON
> >> +static inline u32 from64to16(u64 x)
> >> +{
> >> +	/* add up 32-bit and 32-bit for 32+c bit */
> >> +	x = (x & 0xffffffff) + (x >> 32);
> >> +	/* add up carry.. */
> >> +	x = (x & 0xffffffff) + (x >> 32);
> >> +	/* add up 16-bit and 16-bit for 16+c bit */
> >> +	x = ((u32)x & 0xffff) + ((u32)x >> 16);
> >> +	/* add up carry.. */
> >> +	x = ((u32)x & 0xffff) + ((u32)x >> 16);
> >> +	return x;
> >> +}
> >> +
> >> +unsigned int do_csum_neon(const unsigned char *buff, int len)
> >> +{
> >> +	unsigned int odd, count;
> >> +	uint64_t result = 0;
> >> +	unsigned int count64;
> >> +	uint32x4_t vzero = (uint32x4_t){0, 0, 0, 0};
> >> +
> >> +	register uint32x4_t v0, v1, v2, v3;
> > Is "register" needed here?  Is there any impact on performance?
> >
> > Usually it's best to leave register allocation decisions up to the
> > compiler.
> 
> OK
> 
> >
> >> +
> >> +	if (unlikely(len <= 0))
> >> +		return result;
> >> +
> >> +	odd = 1 & (unsigned long)buff;
> >> +	if (unlikely(odd)) {
> >> +		result = *buff;
> > The generic code has a shift here for the little-endian case.  Why don't
> > we need that here?
> 
> I write this code in reference of arch x86 which not distinguish endianess.
> Maybe little-endian should be different from big-endian.

Ah, I see.  I was assuming you adapted the code from the generic version
in lib/checksum.c (which does handle endianness).  I suggest you take a
look there.

There is no issue on x86, since x86 is little-endian only.

> 
> >
> >> +		len--;
> >> +		buff++;
> >> +	}
> >> +
> >> +	count = len >> 1;
> >> +	if (count) {
> >> +		if (2 & (unsigned long)buff) {
> >> +			result += *(unsigned short *)buff;
> >> +			count--;
> >> +			len -= 2;
> >> +			buff += 2;
> >> +		}
> >> +		count >>= 1;            /* nr of 32-bit words.. */
> >> +		if (count) {
> >> +			if (4 & (unsigned long)buff) {
> >> +				result += *(unsigned int *)buff;
> >> +				count--;
> >> +				len -= 4;
> >> +				buff += 4;
> >> +			}
> >> +			count >>= 1;    /* nr of 64-bit words.. */
> >> +
> >> +			v0 = vzero;
> >> +			v1 = vzero;
> >> +			v2 = vzero;
> >> +			v3 = vzero;
> >> +
> >> +			count64 = count >> 3;  /* compute 64 Byte circle */
> >> +			while (count64) {
> >> +				v0 = vpadalq_u16(v0,
> >> +					vld1q_u16((uint16_t *)buff + 0));
> > Can this loop iterate more than 65536 times?  If it can, it looks like
> > we can overflow.
> >
> > (I think the initial value of len would have to be > 0x400000 in order
> > for this to happen.)
> 
> Yes, you are right. I didn't consider the situation of such long length. I wonder
> if there are any application scenarios that have such long length. Besides,
> arch x86 do_csum() in file csum-partial_64.c is not considered of
> that situation either.

If we can find more than 1 other arch (say) that can only work with
limited buffer sizes, than that gives us confidence that this isn't
simply a bug or design flaw that has been pasted from one place to
another.

Using this checksum algorithm for data much larger than a page or so
would be a bit surprising, but it's difficult to prove this doesn't
happen without auditing all the callers...

One option would be to propose an official limit on len, by adding an
RFC patch in your series than adds a suitable comment to
include/asm-generic/checksum.h to document the limit.  If you do that,
you should CC the relevant maintainers and linux-arch (since most
arches have their own versions).

> 
> >> +				v1 = vpadalq_u16(v1,
> >> +					vld1q_u16((uint16_t *)buff + 8));
> >> +				v2 = vpadalq_u16(v2,
> >> +					vld1q_u16((uint16_t *)buff + 16));
> >> +				v3 = vpadalq_u16(v3,
> >> +					vld1q_u16((uint16_t *)buff + 24));
> >> +				buff += 64;
> >> +				count64--;
> >> +			}
> >> +			v0 = vaddq_u32(v0, v1);
> >> +			v2 = vaddq_u32(v2, v3);
> >> +			v0 = vaddq_u32(v0, v2);
> > Can't we defer the folding down until later?  We could just accumulate
> > the next 16 bytes' result into v0, and do the folding all in one go
> > later on.
> 
> Yes, we can. Since 16 bytes' computation doesn't need v1-v3. Folding
> down now or later seems to have no diffenence.

OK, that should reduce code duplication a little.

> >> +
> >> +			count %= 8;
> >> +			while (count >= 2) { /* compute 16 byte circle */
> >> +				v0 = vpadalq_u16(v0,
> >> +					vld1q_u16((uint16_t *)buff + 0));
> >> +				buff += 16;
> >> +				count -= 2;
> >> +			}
> >> +
> >> +			result += vgetq_lane_u32(v0, 0);
> >> +			result += vgetq_lane_u32(v0, 1);
> >> +			result += vgetq_lane_u32(v0, 2);
> >> +			result += vgetq_lane_u32(v0, 3);
> >> +			if (count & 1) {
> >> +				result += *(unsigned long long *)buff;
> >> +				buff += 8;
> >> +			}
> >> +			if (len & 4) {
> >> +				result += *(unsigned int *)buff;
> >> +				buff += 4;
> >> +			}
> >> +		}
> >> +		if (len & 2) {
> >> +			result += *(unsigned short *)buff;
> >> +			buff += 2;
> >> +		}
> >> +	}
> >> +	if (len & 1)
> >> +		result += *buff;
> > What about the little-endian case?

(See lib/checksum.c for this too.)

> >
> >> +	result = from64to16(result);
> >> +	if (odd)
> >> +		result = ((result >> 8) & 0xff) | ((result & 0xff) << 8);
> >> +	return result;
> >> +}
> >> +#endif
> >> +
> >> +
> >> +unsigned int do_csum_arm(const unsigned char *buff, int len)
> >> +{
> >> +	unsigned int res;
> >> +
> >> +	kernel_neon_begin();
> >> +	res = do_csum_neon(buff, len);
> > If len can be large, you should split into smaller blocks, with
> > kernel_neon_end()/_begin() between to provide a change to preempt if len
> > is large.  (Splitting into smaller blocks may also help avoid overflow.)
> >
> > Ard may have may able to suggest how often this should be done.
> 
> Good solutions for large length.
> 
> > Also, there is no guarantee that you can use NEON in softirq context,
> > because the kernel may already have been using NEON when the softirq
> > fired.  If this code may get called from softirq context, then you would
> > need something along the lines of
> >
> > 	if (may_use_simd()) {
> > 		kernel_neon_begin();
> > 		/* NEON accelerated code */
> > 		kernel_neon_end();
> > 	} else {
> > 		/* Fallback C code */
> > 	}
> >
> > [...]

[...]

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
