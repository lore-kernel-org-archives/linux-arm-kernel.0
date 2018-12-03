Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476E4C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:29:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1389E20661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ec+m1uFT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1389E20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cJfkMJPwEEkyhq3pgKHB1ana9yvwn3fFrcHbeokvuSI=; b=Ec+m1uFTMUF0tD
	U0fAm1M/q2KvxPikSphEqx5p+IvsakHKvhqJQ6jYHRY+aWvyomdiGXucBEUlkDFQfkn3/Xsf4oj8R
	5fLsDAfP+vYoVPhU+RJyGDwLjrstTFn7s9SYflNg2BXom63dgXYKBRxeTtNtQG+M48oxVxuDp1CJO
	f1S7TtMCjK24Y006lD6BjObCdNtH+ZLxh2QFHcSNCJwv+RU5PFNntcpargxLw9k8GtGDRW1ZUhENo
	icHW49m99A1EKaJuCjdgDL+g2QNuTGM1IPfchB+gNyYFRwLEb0FEPxE8SxbMBpk+9RUrt3Ho35WLC
	hV7N2tCiaXe1r87oiCrw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTr6C-0005CF-GZ; Mon, 03 Dec 2018 16:29:32 +0000
Received: from asavdk4.altibox.net ([109.247.116.15])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTr63-0004tn-I8
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 16:29:27 +0000
Received: from ravnborg.org (unknown [158.248.194.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by asavdk4.altibox.net (Postfix) with ESMTPS id 6534A805E6;
 Mon,  3 Dec 2018 17:29:09 +0100 (CET)
Date: Mon, 3 Dec 2018 17:29:08 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v2 5/6] arch: simplify several early memory allocations
Message-ID: <20181203162908.GB4244@ravnborg.org>
References: <1543852035-26634-1-git-send-email-rppt@linux.ibm.com>
 <1543852035-26634-6-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543852035-26634-6-git-send-email-rppt@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
 a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
 a=kj9zAlcOel0A:10 a=lgckvxMN7vj0gfKUQUYA:9 a=CjuIK1q_8ugA:10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_082924_348767_A4D2471D 
X-CRM114-Status: GOOD (  14.81  )
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
 Michael Ellerman <mpe@ellerman.id.au>, Russell King <linux@armlinux.org.uk>,
 Mark Salter <msalter@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Mike.

> index c37955d..2a17665 100644
> --- a/arch/sparc/kernel/prom_64.c
> +++ b/arch/sparc/kernel/prom_64.c
> @@ -34,16 +34,13 @@
>  
>  void * __init prom_early_alloc(unsigned long size)
>  {
> -	unsigned long paddr = memblock_phys_alloc(size, SMP_CACHE_BYTES);
> -	void *ret;
> +	void *ret = memblock_alloc(size, SMP_CACHE_BYTES);
>  
> -	if (!paddr) {
> +	if (!ret) {
>  		prom_printf("prom_early_alloc(%lu) failed\n", size);
>  		prom_halt();
>  	}
>  
> -	ret = __va(paddr);
> -	memset(ret, 0, size);
>  	prom_early_allocated += size;
>  
>  	return ret;

memblock_alloc() calls memblock_alloc_try_nid().
And if allocation fails then memblock_alloc_try_nid() calls panic().
So will we ever hit the prom_halt() code?

Do we have a panic() implementation that actually returns?


> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index 3c8aac2..52884f4 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -1089,16 +1089,13 @@ static void __init allocate_node_data(int nid)
>  	struct pglist_data *p;
>  	unsigned long start_pfn, end_pfn;
>  #ifdef CONFIG_NEED_MULTIPLE_NODES
> -	unsigned long paddr;
>  
> -	paddr = memblock_phys_alloc_try_nid(sizeof(struct pglist_data),
> -					    SMP_CACHE_BYTES, nid);
> -	if (!paddr) {
> +	NODE_DATA(nid) = memblock_alloc_node(sizeof(struct pglist_data),
> +					     SMP_CACHE_BYTES, nid);
> +	if (!NODE_DATA(nid)) {
>  		prom_printf("Cannot allocate pglist_data for nid[%d]\n", nid);
>  		prom_halt();
>  	}
> -	NODE_DATA(nid) = __va(paddr);
> -	memset(NODE_DATA(nid), 0, sizeof(struct pglist_data));
>  
>  	NODE_DATA(nid)->node_id = nid;
>  #endif

Same here.

I did not look at the other cases.

	Sam

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
