Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAD3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:10:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABA1721738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J9aLbw1U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA1721738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZxvqSMQ6W+2zdk1TipGE7st3Jclgi+tCKiOPvqGBO5Y=; b=J9aLbw1UPRhNzA
	LNEpYvsIv0wGQmXsb4DRDwiK5H7P0s2j4iTZRI9fFw5fJs5m17SHQjz/uj3cXbDZj8cZm743hyRt3
	fFa/bC0uZftDfZa4Cg8Q/zaBLY7KqdZO/n2E4aRGcIFwMj/LOhvjIfk5wEDOkpFXC4kKF47d2kn4d
	RyefJ1qVFM26524YI+YpARKXBqOu1eOJCwxKrJ51AQ6+XlWfOCUD2WFMPtV8WGZSa8I6/Do509cLX
	rW5u+gCAeWgTn6vQhpsyYgK1pUOayovh7AHzHf6icgG7N45hM3b6PNIpC3Ju0W+A6CefFroQ/BJ3Q
	QCaQ3W0S/TBt8SdqN4vQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghAop-0006ZU-BS; Wed, 09 Jan 2019 10:10:39 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghAol-0006YW-OW
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 10:10:37 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B738480D;
 Wed,  9 Jan 2019 02:10:33 -0800 (PST)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC3893F70D;
 Wed,  9 Jan 2019 02:10:27 -0800 (PST)
Subject: Re: [PATCH v3 1/3] kasan, arm64: use ARCH_SLAB_MINALIGN instead of
 manual aligning
To: Andrey Konovalov <andreyknvl@google.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, Christoph Lameter <cl@linux.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Dave Martin <dave.martin@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 "Eric W . Biederman" <ebiederm@xmission.com>, Ingo Molnar
 <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>, kasan-dev@googlegroups.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sparse@vger.kernel.org,
 linux-mm@kvack.org, linux-kbuild@vger.kernel.org
References: <cover.1546540962.git.andreyknvl@google.com>
 <52ddd881916bcc153a9924c154daacde78522227.1546540962.git.andreyknvl@google.com>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <fc93e5a4-fa54-98a1-ea5f-4708568d7857@arm.com>
Date: Wed, 9 Jan 2019 10:10:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <52ddd881916bcc153a9924c154daacde78522227.1546540962.git.andreyknvl@google.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_021035_808765_35079688 
X-CRM114-Status: GOOD (  17.41  )
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
Cc: Vishwath Mohan <vishwath@google.com>,
 Chintan Pandya <cpandya@codeaurora.org>, Jacob Bramley <Jacob.Bramley@arm.com>,
 Jann Horn <jannh@google.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
 Lee Smith <Lee.Smith@arm.com>, Kostya Serebryany <kcc@google.com>,
 Mark Brand <markbrand@google.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Evgeniy Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 03/01/2019 18:45, Andrey Konovalov wrote:
> Instead of changing cache->align to be aligned to KASAN_SHADOW_SCALE_SIZE
> in kasan_cache_create() we can reuse the ARCH_SLAB_MINALIGN macro.
> 
> Suggested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  arch/arm64/include/asm/cache.h | 6 ++++++
>  mm/kasan/common.c              | 2 --
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
> index 13dd42c3ad4e..eb43e09c1980 100644
> --- a/arch/arm64/include/asm/cache.h
> +++ b/arch/arm64/include/asm/cache.h
> @@ -58,6 +58,12 @@
>   */
>  #define ARCH_DMA_MINALIGN	(128)
>  
> +#ifdef CONFIG_KASAN_SW_TAGS
> +#define ARCH_SLAB_MINALIGN	(1ULL << KASAN_SHADOW_SCALE_SHIFT)
> +#else
> +#define ARCH_SLAB_MINALIGN	__alignof__(unsigned long long)
> +#endif
> +

Could you please remove the "#else" case here, because it is redundant (it is
defined in linux/slab.h as ifndef) and could be misleading in future?

>  #ifndef __ASSEMBLY__
>  
>  #include <linux/bitops.h>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 03d5d1374ca7..44390392d4c9 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -298,8 +298,6 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
>  		return;
>  	}
>  
> -	cache->align = round_up(cache->align, KASAN_SHADOW_SCALE_SIZE);
> -
>  	*flags |= SLAB_KASAN;
>  }
>  
> 

-- 
Regards,
Vincenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
