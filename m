Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB2AC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:25:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2A17222BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Gn2Bkjv0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A17222BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UXYZnURM9nqMSO0GyU1FUm3sUmmcRzv0prA/41cg4lE=; b=Gn2Bkjv08eKnFm
	SDcJuStr1gYK8IV6BpBdmix91HLwBEDxfmdppuM0SeKCrl4nCV5dH0LfqzckN9ARiV+JHSFpRceLk
	bEodHGINdN/mmFEqi8yhBLKCd4kMG5q7uxt9CHvINIG8JbLnugg7ytK01fxzDx6k/2Ivrh8uo8Jep
	9h7am512syz28HKiPXbPLeSLDHCOz+4HStmIYdGzMF6SHM3MDPlN2aevHmtILVtD+LIfRF5g3Z+nX
	39WKUDtdIWdslGsgsyxnJ2uG2yziszfCAafkCIXImiiGZ/HxgkEW4dMQruhZIrcbPjiXmwYjNUkfH
	Riu6Qb9+1vu2F+tI0JWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtck6-0004MV-Rf; Tue, 12 Feb 2019 18:25:14 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1gtck3-0004M7-MB; Tue, 12 Feb 2019 18:25:11 +0000
Date: Tue, 12 Feb 2019 10:25:11 -0800
From: Christoph Hellwig <hch@infradead.org>
To: =?iso-8859-1?Q?Ga=EBl?= PORTAY <gael.portay@collabora.com>
Subject: Re: [PATCH] ARM: dma-mapping: prevent writeback deadlock in CMA
 allocator
Message-ID: <20190212182511.GA10532@infradead.org>
References: <20190212042458.31856-1-gael.portay@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190212042458.31856-1-gael.portay@collabora.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
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
Cc: Laura Abbott <labbott@redhat.com>, linux-mm@kvack.org, kernel@collabora.com,
 Gabriel Krisman Bertazi <krisman@collabora.com>,
 linux-arm-kernel@lists.infradead.org, Mike Kravetz <mike.kravetz@oracle.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 11, 2019 at 11:24:58PM -0500, Ga=EBl PORTAY wrote:
> The ARM DMA layer checks for allow blocking flag (__GFP_DIRECT_RECLAIM)
> to decide whether to go for CMA or not. That test is not sufficient to
> cover the case of writeback (GFP_NOIO).

The ARM DMA layer doesn't, the CMA helper does.

> -	bool allowblock, cma;
> +	bool allowblock, allowwriteback, cma;
>  	struct arm_dma_buffer *buf;
>  	struct arm_dma_alloc_args args =3D {
>  		.dev =3D dev,
> @@ -769,7 +769,8 @@ static void *__dma_alloc(struct device *dev, size_t s=
ize, dma_addr_t *handle,
>  =

>  	*handle =3D DMA_MAPPING_ERROR;
>  	allowblock =3D gfpflags_allow_blocking(gfp);
> -	cma =3D allowblock ? dev_get_cma_area(dev) : false;
> +	allowwriteback =3D gfpflags_allow_writeback(gfp);
> +	cma =3D (allowblock && !allowwriteback) ? dev_get_cma_area(dev) : false;

But this only fixes ARM, but not all the user callers of
gfpflags_allow_blocking and dma_alloc_from_contiguous.

I think we just need a dma_can_alloc_from_contigous helper and
switch all callers of dma_alloc_from_contiguous to it.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
