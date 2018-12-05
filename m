Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281FFC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:01:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6E982084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fUqG4DxO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6E982084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ylnnMrJCdVc2TaitKu/hq4+Pcuac+fzXfYYSAsr5JN4=; b=fUqG4DxO12UthZ
	5o0OPk2nkoSF5bePxLyXT1PvC/lI24CxWQFRQVh08A/4aRkJ7GLzlggj7u9QPXN7sFz81uihvXE6P
	pB4rfis2vwXIRj+EqYvUhpjIgXo5zaq8xtRHSPZm6b4j4iOM1WzKO0Gh6p8IVs+KvTc2qs5k0iz3l
	iyHMq6eTgnzxe0Lb6trM3lVuzr7CW+KaRkQDDjZIHeD7AkWgS6fXhulJfcAAAxH6nCAd979UBU9sc
	w8g08G7f8vnlE3D8HpzR535+v1kkW0F+MLK09riG8IHcwx38C+rtEsEkyvyBsrj8aOKSJuNGl/n1J
	I7tda2SYSlL1RvPK9biQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUXjT-0002hP-FV; Wed, 05 Dec 2018 14:00:55 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUXjO-0002gF-Pm; Wed, 05 Dec 2018 14:00:53 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5C7080D;
 Wed,  5 Dec 2018 06:00:39 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE3303F59C;
 Wed,  5 Dec 2018 06:00:36 -0800 (PST)
Subject: Re: [PATCH RFC 6/7] arm64: kexec: no need to ClearPageReserved()
To: David Hildenbrand <david@redhat.com>
References: <20181205122851.5891-1-david@redhat.com>
 <20181205122851.5891-7-david@redhat.com>
From: James Morse <james.morse@arm.com>
Message-ID: <ce6a4c28-3c3b-329e-df01-325294bd9b2e@arm.com>
Date: Wed, 5 Dec 2018 14:00:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181205122851.5891-7-david@redhat.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_060050_835478_25692301 
X-CRM114-Status: GOOD (  13.29  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-s390@vger.kernel.org,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Bhupesh Sharma <bhsharma@redhat.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
 linux-m68k@lists.linux-m68k.org, Dave Kleikamp <dave.kleikamp@oracle.com>,
 linux-mediatek@lists.infradead.org, linux-riscv@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi David,

(CC: +Akashi)

On 05/12/2018 12:28, David Hildenbrand wrote:
> This will already be done by free_reserved_page().

(will already be -> will be ?)

So it does!


> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index 922add8adb74..0ef4ea73aa54 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -353,7 +353,6 @@ void crash_free_reserved_phys_range(unsigned long begin, unsigned long end)
>  
>  	for (addr = begin; addr < end; addr += PAGE_SIZE) {
>  		page = phys_to_page(addr);
> -		ClearPageReserved(page);
>  		free_reserved_page(page);
>  	}
>  }
> 

Acked-by: James Morse <james.morse@arm.com>


Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
