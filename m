Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6BBC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:00:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70F3D2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eUgvMA+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70F3D2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iEIrQlAuv5ekHWGcjhhDc/x2HgaoEKFRoRdlCRzSxgo=; b=eUgvMA+/GjV2iM
	RcSMBdeUslLKU15nDCWyQe5bRO8BQBdQ5kLYWjJChr+CadBw/Mim7+3Y3EXBVhDS77sAx1uASvDo3
	79cSyCpN/sYEYXj3/WzVNYzGlkIIUSWp4rRZwsIFkQvSppjCNAkZUTz2wKGtwhsn/88Ao7RBtZMad
	+1tcuId4pQxb7MNQBSDSkvObl1zoerzt/+UPrKgG3H0PNZUoxcSNZBtqO7AoR4ELzYL0sWrABFxvK
	GvtjBgHT9R4C0ZjVVYKmN5MvA6w5jrFTQNcbpY09ST0ZT00xZbqC8j60nP+ordoTDaMNtUJ8Hd7eP
	hiB9uVZ6I9YJmnmk48gA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU7V0-0004fO-DQ; Tue, 04 Dec 2018 10:00:14 +0000
Received: from ozlabs.org ([2401:3900:2:1::2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU7Us-0003Lb-SA
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 10:00:12 +0000
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 438HQk43DGz9s7W;
 Tue,  4 Dec 2018 20:59:42 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mike Rapoport <rppt@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/6] powerpc: prefer memblock APIs returning virtual
 address
In-Reply-To: <1543852035-26634-2-git-send-email-rppt@linux.ibm.com>
References: <1543852035-26634-1-git-send-email-rppt@linux.ibm.com>
 <1543852035-26634-2-git-send-email-rppt@linux.ibm.com>
Date: Tue, 04 Dec 2018 20:59:41 +1100
Message-ID: <87woophasy.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_020007_375868_83889796 
X-CRM114-Status: GOOD (  16.16  )
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
Cc: Michal Hocko <mhocko@suse.com>, linux-sh@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-mm@kvack.org,
 Rich Felker <dalias@libc.org>, Paul Mackerras <paulus@samba.org>,
 sparclinux@vger.kernel.org, Vincent Chen <deanbo422@gmail.com>,
 Jonas Bonn <jonas@southpole.se>, linux-c6x-dev@linux-c6x.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@linux.ibm.com>,
 Mark Salter <msalter@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Mike,

Thanks for trying to clean these up.

I think a few could be improved though ...

Mike Rapoport <rppt@linux.ibm.com> writes:
> diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
> index 913bfca..fa884ad 100644
> --- a/arch/powerpc/kernel/paca.c
> +++ b/arch/powerpc/kernel/paca.c
> @@ -42,17 +42,15 @@ static void *__init alloc_paca_data(unsigned long size, unsigned long align,
>  		nid = early_cpu_to_node(cpu);
>  	}
>  
> -	pa = memblock_alloc_base_nid(size, align, limit, nid, MEMBLOCK_NONE);
> -	if (!pa) {
> -		pa = memblock_alloc_base(size, align, limit);
> -		if (!pa)
> -			panic("cannot allocate paca data");
> -	}
> +	ptr = memblock_alloc_try_nid_raw(size, align, MEMBLOCK_LOW_LIMIT,
> +					 limit, nid);
> +	if (!ptr)
> +		panic("cannot allocate paca data");
  
The old code doesn't zero, but two of the three callers of
alloc_paca_data() *do* zero the whole allocation, so I'd be happy if we
did it in here instead.

That would mean we could use memblock_alloc_try_nid() avoiding the need
to panic() manually.

> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index 236c115..d11ee7f 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -634,19 +634,17 @@ __init u64 ppc64_bolted_size(void)
>  
>  static void *__init alloc_stack(unsigned long limit, int cpu)
>  {
> -	unsigned long pa;
> +	void *ptr;
>  
>  	BUILD_BUG_ON(STACK_INT_FRAME_SIZE % 16);
>  
> -	pa = memblock_alloc_base_nid(THREAD_SIZE, THREAD_SIZE, limit,
> -					early_cpu_to_node(cpu), MEMBLOCK_NONE);
> -	if (!pa) {
> -		pa = memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit);
> -		if (!pa)
> -			panic("cannot allocate stacks");
> -	}
> +	ptr = memblock_alloc_try_nid_raw(THREAD_SIZE, THREAD_SIZE,
> +					 MEMBLOCK_LOW_LIMIT, limit,
> +					 early_cpu_to_node(cpu));
> +	if (!ptr)
> +		panic("cannot allocate stacks");
 
Similarly here, several of the callers zero the stack, and I'd rather
all of them did.

So again we could use memblock_alloc_try_nid() here and remove the
memset()s from emergency_stack_init().

> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> index 9311560..415a1eb0 100644
> --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -51,24 +51,18 @@ static int native_register_process_table(unsigned long base, unsigned long pg_sz
>  static __ref void *early_alloc_pgtable(unsigned long size, int nid,
>  			unsigned long region_start, unsigned long region_end)
>  {
> -	unsigned long pa = 0;
> +	phys_addr_t min_addr = MEMBLOCK_LOW_LIMIT;
> +	phys_addr_t max_addr = MEMBLOCK_ALLOC_ANYWHERE;
>  	void *pt;
>  
> -	if (region_start || region_end) /* has region hint */
> -		pa = memblock_alloc_range(size, size, region_start, region_end,
> -						MEMBLOCK_NONE);
> -	else if (nid != -1) /* has node hint */
> -		pa = memblock_alloc_base_nid(size, size,
> -						MEMBLOCK_ALLOC_ANYWHERE,
> -						nid, MEMBLOCK_NONE);
> +	if (region_start)
> +		min_addr = region_start;
> +	if (region_end)
> +		max_addr = region_end;
>  
> -	if (!pa)
> -		pa = memblock_alloc_base(size, size, MEMBLOCK_ALLOC_ANYWHERE);
> -
> -	BUG_ON(!pa);
> -
> -	pt = __va(pa);
> -	memset(pt, 0, size);
> +	pt = memblock_alloc_try_nid_nopanic(size, size, min_addr, max_addr,
> +					    nid);
> +	BUG_ON(!pt);

I don't think there's any reason to BUG_ON() here rather than letting
memblock() call panic() for us. So this could also be memblock_alloc_try_nid().

> diff --git a/arch/powerpc/platforms/pasemi/iommu.c b/arch/powerpc/platforms/pasemi/iommu.c
> index f297152..f62930f 100644
> --- a/arch/powerpc/platforms/pasemi/iommu.c
> +++ b/arch/powerpc/platforms/pasemi/iommu.c
> @@ -208,7 +208,9 @@ static int __init iob_init(struct device_node *dn)
>  	pr_debug(" -> %s\n", __func__);
>  
>  	/* For 2G space, 8x64 pages (2^21 bytes) is max total l2 size */
> -	iob_l2_base = (u32 *)__va(memblock_alloc_base(1UL<<21, 1UL<<21, 0x80000000));
> +	iob_l2_base = memblock_alloc_try_nid_raw(1UL << 21, 1UL << 21,
> +					MEMBLOCK_LOW_LIMIT, 0x80000000,
> +					NUMA_NO_NODE);

This isn't equivalent is it?

memblock_alloc_base() panics on failure but memblock_alloc_try_nid_raw()
doesn't?

Same comment for the other locations that do that conversion.

cheers

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
