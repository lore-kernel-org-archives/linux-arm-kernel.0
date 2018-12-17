Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0147BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:39:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6CB1204FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kregUX0q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6CB1204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nasmg9tuH1EqyzjCW+R8lvm/Mq1Iz6AME/Ir40tYFEU=; b=kregUX0qNI5SJq
	Z1376pJiIncevfu4AuH6vbTCpINfbiw1TcLT1tGLrdnVmdQHf5HxD+tKWA9YiSJlKkTpqrOiC8m1B
	CQS/4tVFVB2JNTu9GDNzKTcFv2HnngWgvVcpktt6gZrv75M/375t8iJl1Wr3VCTS7M4R9Y83daMjM
	fnNDIoY634TBlUFU4tn1JO6Z4b7kazx/zzYphpwFRAr6epf4na4iF7Kxc2ti/YWj2f+FKjayvIqVA
	2yXBty7jeRK0OWKS38sofYpdhBhixTwlgGqVy1c5SMIlNPJN4mSi3dWJO7llqAjyaI0Y9ja0VMocu
	SRUosp3OMOrLBoidMNWQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYrEl-000122-63; Mon, 17 Dec 2018 11:39:03 +0000
Received: from ozlabs.org ([203.11.71.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYrEi-0000nD-9f; Mon, 17 Dec 2018 11:39:02 +0000
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43JK10123Yz9s2P;
 Mon, 17 Dec 2018 22:38:44 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Subject: Re: [PATCH v1 3/9] powerpc/vdso: don't clear PG_reserved
In-Reply-To: <20181214111014.15672-4-david@redhat.com>
References: <20181214111014.15672-1-david@redhat.com>
 <20181214111014.15672-4-david@redhat.com>
Date: Mon, 17 Dec 2018 22:38:39 +1100
Message-ID: <87pnu0tmbk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_033900_524562_6C1B7C5D 
X-CRM114-Status: GOOD (  13.13  )
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
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, linux-s390@vger.kernel.org,
 Kees Cook <keescook@chromium.org>, David Hildenbrand <david@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 Michal Hocko <mhocko@kernel.org>, linux-m68k@lists.linux-m68k.org,
 linux-mediatek@lists.infradead.org, Paul Mackerras <paulus@samba.org>,
 linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

David Hildenbrand <david@redhat.com> writes:

> The VDSO is part of the kernel image and therefore the struct pages are
> marked as reserved during boot.
>
> As we install a special mapping, the actual struct pages will never be
> exposed to MM via the page tables. We can therefore leave the pages
> marked as reserved.
>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/powerpc/kernel/vdso.c | 2 --
>  1 file changed, 2 deletions(-)

Thanks.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

> diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
> index 65b3bdb99f0b..d59dc2e9a695 100644
> --- a/arch/powerpc/kernel/vdso.c
> +++ b/arch/powerpc/kernel/vdso.c
> @@ -795,7 +795,6 @@ static int __init vdso_init(void)
>  	BUG_ON(vdso32_pagelist == NULL);
>  	for (i = 0; i < vdso32_pages; i++) {
>  		struct page *pg = virt_to_page(vdso32_kbase + i*PAGE_SIZE);
> -		ClearPageReserved(pg);
>  		get_page(pg);
>  		vdso32_pagelist[i] = pg;
>  	}
> @@ -809,7 +808,6 @@ static int __init vdso_init(void)
>  	BUG_ON(vdso64_pagelist == NULL);
>  	for (i = 0; i < vdso64_pages; i++) {
>  		struct page *pg = virt_to_page(vdso64_kbase + i*PAGE_SIZE);
> -		ClearPageReserved(pg);
>  		get_page(pg);
>  		vdso64_pagelist[i] = pg;
>  	}
> -- 
> 2.17.2

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
