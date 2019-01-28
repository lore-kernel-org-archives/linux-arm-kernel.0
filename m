Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF81AC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:16:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EB5D20856
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nyG4HrDB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aw28n8iE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB5D20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HifAdLEXYUl29qfWyP9iXO5N+4TWKV5iW0JQAfCoSTU=; b=nyG4HrDBJUFbbO
	xg/GHgItH8K039rU9YlUe6sFa5K6QXYz/16DFFyh9uRU85x+ArOa/qTbHGlhRXJa9YL4Kry2YfddN
	7WA03TDha2yWyoirV32WXIh445/mexzyv7XQv+idEb4de0i2N6AZ32XOeasYCFtiotyMoLJDtkVIk
	bNp/koD04x409C09mHrDlQlp8c7nKUTxRoofnU8k4nd6m7OPSAUWynxbAv7BKHa5VIcL7R0tKoEup
	fjP/m65BPx+GWzl2+gZU3g50Jzh7zeVq0qwxmafe4QpM0hYZb0NWXgtBfr6X1NryvI+1Fg30394cq
	mtiTUcfzUYwpA15w0Cxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go3xH-0002Ho-2H; Mon, 28 Jan 2019 10:15:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go3xC-0002H8-Bp
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 10:15:48 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2CC5B20856;
 Mon, 28 Jan 2019 10:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548670543;
 bh=oyXEftwZ1GLNPaw5L6KuZGnCT+5kOhemtMNZw8aQCsk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Aw28n8iEjdhFroHnl8iwtrRxXw4xStt7peCRIEX2JdcHCnXBeKA09uIxgj23GpK20
 4qlXJAI5VRLrRgo27LTcdd1cOe1Xl2JNKpLOoeNIRZJWtmQTb876fRj8SbVfFLHFaN
 p4o5B43UJyJeEvY/v/4QWZomf5W8WK8yTEhNoA3g=
Date: Mon, 28 Jan 2019 11:15:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [PATCH] iommu/io-pgtable-arm-v7s: only kmemleak_ignore L2 tables
Message-ID: <20190128101541.GA32222@kroah.com>
References: <20190128094301.151252-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190128094301.151252-1-drinkcat@chromium.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_021546_478534_0D8932D9 
X-CRM114-Status: GOOD (  14.50  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 28, 2019 at 05:43:01PM +0800, Nicolas Boichat wrote:
> L1 tables are allocated with __get_dma_pages, and therefore already
> ignored by kmemleak.
> 
> Without this, the kernel would print this error message on boot,
> when the first L1 table is allocated:
> 
> [    2.810533] kmemleak: Trying to color unknown object at 0xffffffd652388000 as Black
> [    2.818190] CPU: 5 PID: 39 Comm: kworker/5:0 Tainted: G S                4.19.16 #8
> [    2.831227] Workqueue: events deferred_probe_work_func
> [    2.836353] Call trace:
> ...
> [    2.852532]  paint_ptr+0xa0/0xa8
> [    2.855750]  kmemleak_ignore+0x38/0x6c
> [    2.859490]  __arm_v7s_alloc_table+0x168/0x1f4
> [    2.863922]  arm_v7s_alloc_pgtable+0x114/0x17c
> [    2.868354]  alloc_io_pgtable_ops+0x3c/0x78
> ...
> 
> Fixes: e5fc9753b1a8314 ("iommu/io-pgtable: Add ARMv7 short descriptor support")
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
> 
> I only tested this on top of my other series
> (https://patchwork.kernel.org/patch/10720495/), but I think the same fix
> applies. I'm still a bit confused as to why this only shows up now, as IIUC,
> the kmemleak_ignore call was always wrong with L1 tables.
> 
>  drivers/iommu/io-pgtable-arm-v7s.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
