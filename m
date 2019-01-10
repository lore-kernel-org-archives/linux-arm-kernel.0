Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D9BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:03:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06B77206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EZxo64o/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B77206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NPppZDyTrZkK9G/6xecmOlza9ryCyIYC1dOdHHcwgIM=; b=EZxo64o/C7Bjs1
	e/wJ3i3yXLRtAu8/ix31l5lgiQKQjcmnyciGgGi9Az/BvHRS2ZnDnArYlC8SbGSz8zfe3kSOUaONk
	30lZ3jQ6beJK+IQsjeSl7Wo1qaynvqfx1HIxz78sy4RPhzFUQJVLcydQVJiT9YMx8UiHRmL/mnD4K
	JS3d00ou0VZmaCBY9OxpvjkPaYzkRb4sgguVnqe6AF/78aA9SXdKHuoSYwc93d0zbwGSD0YzYJO9L
	gQQdDopPsJjX8zue6cjApsHVFAoAyDnpf5tm3HIyJEyIZILqNr5Iy6U45HcFtu2TeuS/lUf4HT533
	d3XKvJFKS6JZkAtrRF6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghVJP-00078W-CS; Thu, 10 Jan 2019 08:03:35 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghVJJ-00077w-6Z
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 08:03:33 +0000
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 887FE16BA33A461C0ACB;
 Thu, 10 Jan 2019 16:03:20 +0800 (CST)
Received: from [127.0.0.1] (10.40.74.132) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Thu, 10 Jan 2019
 16:03:15 +0800
Subject: Re: [PATCH v3] arm64: lib: accelerate do_csum with NEON instruction
To: Dave Martin <Dave.Martin@arm.com>
References: <1546739729-17234-1-git-send-email-huanglingyan2@huawei.com>
 <20190109142513.GA3554@e103592.cambridge.arm.com>
From: "huanglingyan (A)" <huanglingyan2@huawei.com>
Message-ID: <19a3acc0-87d7-5ca2-46a5-c3324797491d@huawei.com>
Date: Thu, 10 Jan 2019 16:03:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20190109142513.GA3554@e103592.cambridge.arm.com>
X-Originating-IP: [10.40.74.132]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_000330_745036_82FAFFE8 
X-CRM114-Status: GOOD (  33.10  )
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
Cc: Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-arm-kernel@lists.infradead.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 2019/1/9 22:58, Dave Martin wrote:
> On Sun, Jan 06, 2019 at 09:55:29AM +0800, Lingyan Huang wrote:
>> Function do_csum() in lib/checksum.c is used to compute checksum,
>> which is turned out to be slowly and costs a lot of resources.
>> Let's use neon instructions to accelerate the checksum computation
>> for arm64.
>>
>> ------
>> V2 ==> V3:
>>     only modify the arm64 codes instead of modifying headers
>>     under asm-generic and code in lib/checksum.c.
>> ------
>> ------
>> V1 ==> V2:
>>     Change NEON assembly code to NEON intrinsic code which is built
>>     on top of arm_neon.h to avoid dropping into assembly.
>> ------
>>
>> Here is the comparison results of function ip_compute_csum() between
>> general do_csum() and neon instruction do_csum(). The test platform 
>> is HUAWEI 1620 server with TAISHAN cores.
>>
>>         len(1000cycle)      general(ns)        do_csum_neon(ns)
>>           64B:                58060                 59460
>>          128B:                82930                 83930
>>          256B:               132480                 73570
>>          512B:               230100                 86230
>>         1024B:               426600                 98200
> For testing purposes, you would need to cover all possible aligments of
> buff and all values of (len % 16), as well as testing on big- and
> little-endian.
>
> Otherwise, a lot of code for handling edge cases won't be tested.
>
>
> Also, it would be interesting to know which sizes are actually most
> common at runtime, to avoid falling into the trap of optimising for
> rare cases at the expense of the more common cases.
>
> You could try adding some instrumentation to collect some statistics on
> this.
Different alignements of buff and different lengths should be
showing here. The test-report will be more detailed as you said.

The main scene of do_csum is the Internet package checksum as I know.
The package length is usually 64 Byte - MTU(1500 Byte default).

My test platform is little-endian based. I will try my best to find a big-endian
test platform.
>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Signed-off-by: Lingyan Huang <huanglingyan2@huawei.com>
>> ---
>>  arch/arm64/include/asm/checksum.h |   5 ++
>>  arch/arm64/lib/Makefile           |   8 +--
>>  arch/arm64/lib/checksum.c         |  26 ++++++++
>>  arch/arm64/lib/do_csum.c          | 136 ++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 171 insertions(+), 4 deletions(-)
>>  create mode 100644 arch/arm64/lib/checksum.c
>>  create mode 100644 arch/arm64/lib/do_csum.c
>>
>> diff --git a/arch/arm64/include/asm/checksum.h b/arch/arm64/include/asm/checksum.h
>> index 0b6f5a7..7acd713 100644
>> --- a/arch/arm64/include/asm/checksum.h
>> +++ b/arch/arm64/include/asm/checksum.h
>> @@ -26,6 +26,10 @@ static inline __sum16 csum_fold(__wsum csum)
>>  }
>>  #define csum_fold csum_fold
>>  
>> +#define do_csum do_csum
>> +unsigned int do_csum(const unsigned char *buff, int len);
>> +extern unsigned int do_csum_arm(const unsigned char *buff, int len);
>> +
>>  static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
>>  {
>>  	__uint128_t tmp;
>> @@ -46,6 +50,7 @@ static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
>>  }
>>  #define ip_fast_csum ip_fast_csum
>>  
>> +
>>  #include <asm-generic/checksum.h>
>>  
>>  #endif	/* __ASM_CHECKSUM_H */
>> diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
>> index 5540a16..c0b5b8c 100644
>> --- a/arch/arm64/lib/Makefile
>> +++ b/arch/arm64/lib/Makefile
>> @@ -3,12 +3,12 @@ lib-y		:= clear_user.o delay.o copy_from_user.o		\
>>  		   copy_to_user.o copy_in_user.o copy_page.o		\
>>  		   clear_page.o memchr.o memcpy.o memmove.o memset.o	\
>>  		   memcmp.o strcmp.o strncmp.o strlen.o strnlen.o	\
>> -		   strchr.o strrchr.o tishift.o
>> +		   strchr.o strrchr.o tishift.o checksum.o
>>  
>>  ifeq ($(CONFIG_KERNEL_MODE_NEON), y)
>> -obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
>> -CFLAGS_REMOVE_xor-neon.o	+= -mgeneral-regs-only
>> -CFLAGS_xor-neon.o		+= -ffreestanding
> Did you mean to delete these lines? 

It's my mistake.

>> +obj-y    += do_csum.o
>> +CFLAGS_REMOVE_do_csum.o	+= -mgeneral-regs-only
>> +CFLAGS_do_csum.o		+= -ffreestanding
>>  endif
>>  
>>  # Tell the compiler to treat all general purpose registers (with the
>> diff --git a/arch/arm64/lib/checksum.c b/arch/arm64/lib/checksum.c
>> new file mode 100644
>> index 0000000..15a31bb
>> --- /dev/null
>> +++ b/arch/arm64/lib/checksum.c
>> @@ -0,0 +1,26 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + *
>> + * Authors: Lingyan Huang <huanglingyan2@huawei.com>
>> + * Copyright (C) 2018 Hisilicon, Inc. All Rights Reserved.
>> + *
>> + * Generic C or neon implementation of do_csum operations.
>> + * Choose faster neon instructions when NEON is supported.
>> + *
>> + */
>> +
>> +#include <asm/neon.h>
>> +#include <asm/simd.h>
>> +#include <asm/checksum.h>
>> +
>> +#define CSUM_NEON_THRESHOLD 128
>> +
>> +unsigned int do_csum(const unsigned char *buff, int len)
>> +{
>> +#ifdef CONFIG_KERNEL_MODE_NEON
>> +	if (len >= CSUM_NEON_THRESHOLD)
>> +		return do_csum_arm(buff, len);
>> +#endif  /* CONFIG_KERNEL_MODE_NEON */
>> +#undef do_csum
>> +	return 0;
>> +}
>> diff --git a/arch/arm64/lib/do_csum.c b/arch/arm64/lib/do_csum.c
>> new file mode 100644
>> index 0000000..893583f
>> --- /dev/null
>> +++ b/arch/arm64/lib/do_csum.c
>> @@ -0,0 +1,136 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Authors: Lingyan Huang <huanglingyan2@huawei.com>
>> + * Copyright (C) 2018 Hisilicon, Inc. All Rights Reserved.
>> + *
>> + * Generic C or neon implementation of do_csum operations.
>> + * Choose faster neon instructions when NEON is supported.
>> + *
>> + */
>> +
>> +#include <asm/neon.h>
>> +#include <asm/simd.h>
> Unless you call may_use_simd() (see below) I can't see why you need to
> include <asm/simd.h>.

Yeah, may_use_simd() should be called.

>> +#include <asm/checksum.h>
>> +#include <asm/byteorder.h>
>> +#include <asm/neon-intrinsics.h>
>> +
>> +#define CSUM_NEON_THRESHOLD 128
>> +#ifdef CONFIG_KERNEL_MODE_NEON
>> +static inline u32 from64to16(u64 x)
>> +{
>> +	/* add up 32-bit and 32-bit for 32+c bit */
>> +	x = (x & 0xffffffff) + (x >> 32);
>> +	/* add up carry.. */
>> +	x = (x & 0xffffffff) + (x >> 32);
>> +	/* add up 16-bit and 16-bit for 16+c bit */
>> +	x = ((u32)x & 0xffff) + ((u32)x >> 16);
>> +	/* add up carry.. */
>> +	x = ((u32)x & 0xffff) + ((u32)x >> 16);
>> +	return x;
>> +}
>> +
>> +unsigned int do_csum_neon(const unsigned char *buff, int len)
>> +{
>> +	unsigned int odd, count;
>> +	uint64_t result = 0;
>> +	unsigned int count64;
>> +	uint32x4_t vzero = (uint32x4_t){0, 0, 0, 0};
>> +
>> +	register uint32x4_t v0, v1, v2, v3;
> Is "register" needed here?  Is there any impact on performance?
>
> Usually it's best to leave register allocation decisions up to the
> compiler.

OK

>
>> +
>> +	if (unlikely(len <= 0))
>> +		return result;
>> +
>> +	odd = 1 & (unsigned long)buff;
>> +	if (unlikely(odd)) {
>> +		result = *buff;
> The generic code has a shift here for the little-endian case.  Why don't
> we need that here?

I write this code in reference of arch x86 which not distinguish endianess.
Maybe little-endian should be different from big-endian.

>
>> +		len--;
>> +		buff++;
>> +	}
>> +
>> +	count = len >> 1;
>> +	if (count) {
>> +		if (2 & (unsigned long)buff) {
>> +			result += *(unsigned short *)buff;
>> +			count--;
>> +			len -= 2;
>> +			buff += 2;
>> +		}
>> +		count >>= 1;            /* nr of 32-bit words.. */
>> +		if (count) {
>> +			if (4 & (unsigned long)buff) {
>> +				result += *(unsigned int *)buff;
>> +				count--;
>> +				len -= 4;
>> +				buff += 4;
>> +			}
>> +			count >>= 1;    /* nr of 64-bit words.. */
>> +
>> +			v0 = vzero;
>> +			v1 = vzero;
>> +			v2 = vzero;
>> +			v3 = vzero;
>> +
>> +			count64 = count >> 3;  /* compute 64 Byte circle */
>> +			while (count64) {
>> +				v0 = vpadalq_u16(v0,
>> +					vld1q_u16((uint16_t *)buff + 0));
> Can this loop iterate more than 65536 times?  If it can, it looks like
> we can overflow.
>
> (I think the initial value of len would have to be > 0x400000 in order
> for this to happen.)

Yes, you are right. I didn't consider the situation of such long length. I wonder
if there are any application scenarios that have such long length. Besides,
arch x86 do_csum() in file csum-partial_64.c is not considered of
that situation either.

>> +				v1 = vpadalq_u16(v1,
>> +					vld1q_u16((uint16_t *)buff + 8));
>> +				v2 = vpadalq_u16(v2,
>> +					vld1q_u16((uint16_t *)buff + 16));
>> +				v3 = vpadalq_u16(v3,
>> +					vld1q_u16((uint16_t *)buff + 24));
>> +				buff += 64;
>> +				count64--;
>> +			}
>> +			v0 = vaddq_u32(v0, v1);
>> +			v2 = vaddq_u32(v2, v3);
>> +			v0 = vaddq_u32(v0, v2);
> Can't we defer the folding down until later?  We could just accumulate
> the next 16 bytes' result into v0, and do the folding all in one go
> later on.

Yes, we can. Since 16 bytes' computation doesn't need v1-v3. Folding down now or later seems
to have no diffenence.

>
>> +
>> +			count %= 8;
>> +			while (count >= 2) { /* compute 16 byte circle */
>> +				v0 = vpadalq_u16(v0,
>> +					vld1q_u16((uint16_t *)buff + 0));
>> +				buff += 16;
>> +				count -= 2;
>> +			}
>> +
>> +			result += vgetq_lane_u32(v0, 0);
>> +			result += vgetq_lane_u32(v0, 1);
>> +			result += vgetq_lane_u32(v0, 2);
>> +			result += vgetq_lane_u32(v0, 3);
>> +			if (count & 1) {
>> +				result += *(unsigned long long *)buff;
>> +				buff += 8;
>> +			}
>> +			if (len & 4) {
>> +				result += *(unsigned int *)buff;
>> +				buff += 4;
>> +			}
>> +		}
>> +		if (len & 2) {
>> +			result += *(unsigned short *)buff;
>> +			buff += 2;
>> +		}
>> +	}
>> +	if (len & 1)
>> +		result += *buff;
> What about the little-endian case?
>
>> +	result = from64to16(result);
>> +	if (odd)
>> +		result = ((result >> 8) & 0xff) | ((result & 0xff) << 8);
>> +	return result;
>> +}
>> +#endif
>> +
>> +
>> +unsigned int do_csum_arm(const unsigned char *buff, int len)
>> +{
>> +	unsigned int res;
>> +
>> +	kernel_neon_begin();
>> +	res = do_csum_neon(buff, len);
> If len can be large, you should split into smaller blocks, with
> kernel_neon_end()/_begin() between to provide a change to preempt if len
> is large.  (Splitting into smaller blocks may also help avoid overflow.)
>
> Ard may have may able to suggest how often this should be done.

Good solutions for large length.

> Also, there is no guarantee that you can use NEON in softirq context,
> because the kernel may already have been using NEON when the softirq
> fired.  If this code may get called from softirq context, then you would
> need something along the lines of
>
> 	if (may_use_simd()) {
> 		kernel_neon_begin();
> 		/* NEON accelerated code */
> 		kernel_neon_end();
> 	} else {
> 		/* Fallback C code */
> 	}
>
> [...]

Yes, you are right.

>
> Cheers
> ---Dave
>
> .
>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
