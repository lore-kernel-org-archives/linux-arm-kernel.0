Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B047AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:13:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D823214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ugPUoBN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D823214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=R5H6VkcXT2gsrFm62fFEWJaLKIfD+m9cqDw2jhPIvdY=; b=ugPUoBN1B1RMTs
	vjTsryiLVMVxSYVawQE+U44rkX6NdTlVAEuVDANS8QVTdpyirrDFHs//h5Ze6yfoH3DEwQssCtwOG
	1SFBnxnc34mAdF3kQnKXMMk98YpQFE7Aw3uVih8xaoQjpIqI/xm16+3xDgKDj1SwuV6SfEUwLrbT4
	X/3xa9VL27X3GKsx7/iVkb3rF42xKRD16iN4hTHAUCrD/3cXDCXVO8slcsAJA5zFarn1Cie6MBbXu
	RFF6HviNPAVhLCfqORQfql+Ts1q6GLbvmLoi+XHzQPAVULz72HgiGln9UxC3Xv9wJrGjSAQa+DtlC
	BeYWusHDLizwD7aAgjkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghVTE-0004Rd-BE; Thu, 10 Jan 2019 08:13:44 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghVTA-0004RI-Oq
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 08:13:42 +0000
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id C94A83B046748BB6C3AC;
 Thu, 10 Jan 2019 16:13:36 +0800 (CST)
Received: from [127.0.0.1] (10.40.74.132) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Thu, 10 Jan 2019
 16:13:27 +0800
Subject: Re: [PATCH v3] arm64: lib: accelerate do_csum with NEON instruction
To: =?UTF-8?B?6IOh5rW3?= <hhtracer@gmail.com>
References: <1546739729-17234-1-git-send-email-huanglingyan2@huawei.com>
 <CAKv+Gu_wsK1UNXSp=5Hvd7XCHKC3cVkYjTYHhvqM4Xt09A9iKg@mail.gmail.com>
 <9129b882-60f3-8046-0cb9-e0b2452a118d@huawei.com>
 <20190108135444.GB14476@fuggles.cambridge.arm.com>
 <cd5bb83e-bb0e-b348-5365-095c5fcd9648@huawei.com>
 <CAAq-RfT_Kjd8hbm=BaRg5a6uvTGLzZipt91wpSPXCW51hGTnNQ@mail.gmail.com>
From: "huanglingyan (A)" <huanglingyan2@huawei.com>
Message-ID: <6da11978-71f1-02c1-fb6a-cfed1b704013@huawei.com>
Date: Thu, 10 Jan 2019 16:14:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAAq-RfT_Kjd8hbm=BaRg5a6uvTGLzZipt91wpSPXCW51hGTnNQ@mail.gmail.com>
X-Originating-IP: [10.40.74.132]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_001340_976995_F8229239 
X-CRM114-Status: UNSURE (   8.53  )
X-CRM114-Notice: Please train this message.
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
Cc: Zhangshaokun <zhangshaokun@hisilicon.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-arm-kernel@lists.infradead.org, ard.biesheuvel@linaro.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Ck9uIDIwMTkvMS8xMCAxMjowOCwg6IOh5rW3IHdyb3RlOgo+IGhpLCBodWFuZ2xpbmd5YW4KPgo+
IEhhdmUgeW91IHZlcmlmaWVkIHRoZSBjb3JyZWN0bmVzcyBvZiBkb19jc3VtPwo+IEkgdmFsaWRh
dGVkIGl0IG9uIEZUMjAwMCsgYW5kIGRvX2NzdW0gZ290IHRoZSB3cm9uZyByZXN1bHQuCj4KPiBZ
b3UgY2FuIHRlc3QgaXQgYnkgaW5jcmVhc2luZyB0aGUgaW5wdXQgbGVuZ3RoIHRvIG1vcmUgdGhh
biA2MDAwMCBhbmQKPiBzZXR0aW5nIGFsbCBidWZmcyB0byAweGZmLgo+IEkgdGhpbmsgaXQncyBw
b3NzaWJsZSB0aGF0IHZwYWRhbHFfdTE2IHdpbGwgb3ZlcmZsb3csIGFuZCB0aGUgY29kZQo+IGRv
ZXNuJ3QgdGFrZSB0aGlzIGludG8gYWNjb3VudC4KPgoKWWVzLMKgIEkgYWN0dWFsbHkgZGlkbid0
IGNvbnNpZGVyIG9mIHN1Y2ggbGFyZ2UgbGVuZ3RoLiBJIHdvbmRlciBpZiB0aGVyZSBhcmUKc29t
ZSBhcHBsaWNhdGlvbiBzY2VuYXJpZXMgdGhhdCBzaG91bGQgdXNlIGxhcmdlIGxlbmd0aHMuIFdo
YXRldmVyLAp0aGlzIHNob3VsZCBiZSBmaXhlZCBpbiBuZXh0IHZlcnNpb24uCgotLS1MaW5neWFu
IEh1YW5nCi4KCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LWFybS1rZXJuZWwK
