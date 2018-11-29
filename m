Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0596C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:01:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F7A52145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rtCokpyD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F7A52145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Wn1xE7r5aHg4R3n54fm+MzaUvJqOi30MtyshDiKl+ZM=; b=rtCokpyD31Gpi7
	e99QnO2ApfadrOkfzKP/QFXNVHVz9xNMn+e2Yf0dCHb+DWnXtPnG6ZPScS0czK3V4AvulE4oZaobm
	8nXdYkmztLxgpj4/yMSRbuKjIz//KIGxe8LCq1APGJYikEGrT1GcjU6lBQgS1CyWh4JtxWsh2g7B2
	O+GCfJByDZtmDoGzDf4+06fdQGRHE2DksFjGnDnEukJUUgpzHXIrfqzbkro/7pymovh6HSTl960kB
	eB8HSx7tUzg/s9R4hir+3S4B0URog7JenxbKp9Ppfd45KS5MvASe3/HnFSqvFXtxtWz4TN9wvuMN9
	nN2P0O9ugmt1bOp/6Okg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSPgW-0006FX-LR; Thu, 29 Nov 2018 17:01:04 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSPgU-0006EY-4d
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 17:01:03 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90387A78;
 Thu, 29 Nov 2018 09:00:51 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3E803F59C;
 Thu, 29 Nov 2018 09:00:50 -0800 (PST)
Date: Thu, 29 Nov 2018 17:00:48 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Jackie Liu <liuyun01@kylinos.cn>
Subject: Re: [PATCH v3 2/2] arm64: crypto: add NEON accelerated XOR
 implementation
Message-ID: <20181129170048.GQ3505@e103592.cambridge.arm.com>
References: <20181127100858.6995-1-liuyun01@kylinos.cn>
 <20181127100858.6995-2-liuyun01@kylinos.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181127100858.6995-2-liuyun01@kylinos.cn>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_090102_187108_9626CC00 
X-CRM114-Status: GOOD (  24.47  )
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
Cc: linux-block@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 ard.biesheuvel@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Nov 27, 2018 at 06:08:58PM +0800, Jackie Liu wrote:
> This is a NEON acceleration method that can improve
> performance by approximately 20%. I got the following
> data from the centos 7.5 on Huawei's HISI1616 chip:
> 
> [ 93.837726] xor: measuring software checksum speed
> [ 93.874039]   8regs  : 7123.200 MB/sec
> [ 93.914038]   32regs : 7180.300 MB/sec
> [ 93.954043]   arm64_neon: 9856.000 MB/sec
> [ 93.954047] xor: using function: arm64_neon (9856.000 MB/sec)
> 
> I believe this code can bring some optimization for
> all arm64 platform.
> 
> That is patch version 3. Thanks for Ard Biesheuvel's
> suggestions.
> 
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>  arch/arm64/include/asm/Kbuild |   1 -
>  arch/arm64/include/asm/xor.h  |  73 +++++++++++++++++
>  arch/arm64/lib/Makefile       |   6 ++
>  arch/arm64/lib/xor-neon.c     | 184 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 263 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/include/asm/xor.h
>  create mode 100644 arch/arm64/lib/xor-neon.c
> 
> diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
> index 6cd5d77..1877f29 100644
> --- a/arch/arm64/include/asm/Kbuild
> +++ b/arch/arm64/include/asm/Kbuild
> @@ -27,4 +27,3 @@ generic-y += trace_clock.h
>  generic-y += unaligned.h
>  generic-y += user.h
>  generic-y += vga.h
> -generic-y += xor.h
> diff --git a/arch/arm64/include/asm/xor.h b/arch/arm64/include/asm/xor.h
> new file mode 100644
> index 0000000..856386a
> --- /dev/null
> +++ b/arch/arm64/include/asm/xor.h
> @@ -0,0 +1,73 @@
> +/*
> + * arch/arm64/include/asm/xor.h
> + *
> + * Authors: Jackie Liu <liuyun01@kylinos.cn>
> + * Copyright (C) 2018,Tianjin KYLIN Information Technology Co., Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/hardirq.h>
> +#include <asm-generic/xor.h>
> +#include <asm/hwcap.h>
> +#include <asm/neon.h>
> +
> +#ifdef CONFIG_KERNEL_MODE_NEON
> +
> +extern struct xor_block_template const xor_block_inner_neon;
> +
> +static void
> +xor_neon_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
> +{
> +	kernel_neon_begin();
> +	xor_block_inner_neon.do_2(bytes, p1, p2);
> +	kernel_neon_end();
> +}
> +
> +static void
> +xor_neon_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> +		unsigned long *p3)
> +{
> +	kernel_neon_begin();
> +	xor_block_inner_neon.do_3(bytes, p1, p2, p3);
> +	kernel_neon_end();
> +}
> +
> +static void
> +xor_neon_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> +		unsigned long *p3, unsigned long *p4)
> +{
> +	kernel_neon_begin();
> +	xor_block_inner_neon.do_4(bytes, p1, p2, p3, p4);
> +	kernel_neon_end();
> +}
> +
> +static void
> +xor_neon_5(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> +		unsigned long *p3, unsigned long *p4, unsigned long *p5)
> +{
> +	kernel_neon_begin();
> +	xor_block_inner_neon.do_5(bytes, p1, p2, p3, p4, p5);
> +	kernel_neon_end();
> +}
> +
> +static struct xor_block_template xor_block_arm64 = {
> +	.name   = "arm64_neon",
> +	.do_2   = xor_neon_2,
> +	.do_3   = xor_neon_3,
> +	.do_4   = xor_neon_4,
> +	.do_5	= xor_neon_5
> +};
> +#undef XOR_TRY_TEMPLATES
> +#define XOR_TRY_TEMPLATES           \
> +	do {        \
> +		xor_speed(&xor_block_8regs);    \
> +		xor_speed(&xor_block_32regs);    \
> +		if (cpu_has_neon()) { \
> +			xor_speed(&xor_block_arm64);\
> +		} \
> +	} while (0)

Should there be a may_use_simd() check somewhere?

If we invoke this in a softirq I don't see what prevents us from
corrupting the task's NEON state.

(The check might be in some surrounding glue code that I missed...)

[...]

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
