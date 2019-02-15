Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39E9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:49:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5DE42146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LscjwCuN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5DE42146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Q6ZCg5VFM6IDU1qd//uu5rUZlbEl+p0gVJIfwcLG2WY=; b=LscjwCuNHU36DKtQZJDBtLt3T1
	cQgViAatAwrHzZkD91w4AJOR/Xhagfrs7sczrmPfBGzGGUC/H2xh8s8eMWyOBG2lngw7LLIcmx5KA
	0vkuiAqDE844XgY0+M/jElaokLO65KxbtFhOvVYfqk4u/Fpy7gyHYNFqcsIDZKj3t6Gzbd1t7tquT
	elM8TBHlp9FTnLgwnNXD1tMmTCDUjzsBNPDRiJlAmpHntJ3EibJQ8pPA9FB7kLeo25guxjfnvhi1+
	WYX/oYGSphoZYX5pUJBaPy5G72mkJwn0acoVvOpDdj1YpfL4dOkTaw1HvNL5p51bVPJY5+SIiTtcw
	a9u4HZ5g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gugfd-00050Y-Fa; Fri, 15 Feb 2019 16:49:01 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gugfZ-0004wp-J3
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 16:48:59 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id CF894B03F;
 Fri, 15 Feb 2019 16:48:53 +0000 (UTC)
Subject: Re: [PATCH v3] hugetlb: allow to free gigantic pages regardless of
 the configuration
To: Alexandre Ghiti <alex@ghiti.fr>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
References: <20190214193100.3529-1-alex@ghiti.fr>
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <363365a7-f1ac-5bde-ff7f-bdb137c20628@suse.cz>
Date: Fri, 15 Feb 2019 17:48:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190214193100.3529-1-alex@ghiti.fr>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_084857_780926_87F963FC 
X-CRM114-Status: GOOD (  15.88  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/14/19 8:31 PM, Alexandre Ghiti wrote:
> On systems without CMA or (MEMORY_ISOLATION && COMPACTION) activated but
> that support gigantic pages, boottime reserved gigantic pages can not be
> freed at all. This patch simply enables the possibility to hand back
> those pages to memory allocator.
> 
> This patch also renames:
> 
> - the triplet CMA or (MEMORY_ISOLATION && COMPACTION) into CONTIG_ALLOC,
> and gets rid of all use of it in architecture specific code (and then
> removes ARCH_HAS_GIGANTIC_PAGE config).
> - gigantic_page_supported to make it more accurate: this value being false
> does not mean that the system cannot use gigantic pages, it just means that
> runtime allocation of gigantic pages is not supported, one can still
> allocate boottime gigantic pages if the architecture supports it.
> 
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

...

> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -252,12 +252,17 @@ config MIGRATION
>  	  pages as migration can relocate pages to satisfy a huge page
>  	  allocation instead of reclaiming.
>  
> +

Stray newline? No need to resend, Andrew can fix up.
Ah, he wasn't in To:, adding.

>  config ARCH_ENABLE_HUGEPAGE_MIGRATION
>  	bool
>  
>  config ARCH_ENABLE_THP_MIGRATION
>  	bool
>  
> +config CONTIG_ALLOC
> +	def_bool y
> +	depends on (MEMORY_ISOLATION && COMPACTION) || CMA
> +
>  config PHYS_ADDR_T_64BIT
>  	def_bool 64BIT
>  

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
