Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24DEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:54:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBCA72087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ok5x4AQk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBCA72087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HJTAZZmodB8CW+iLvpub5n0a4a6PFn4gj51BfxSxqOk=; b=Ok5x4AQkXxJa6c
	xUFR8H2lA8irk1zzNH7Lm2y2obOdEEX9C+extkxpcVSAQ71YefPuXWqsSgLIMKdfiAtxat6mUNZt8
	TfH9P42580Y5ifZQ7+aSP0wkdTT/ifQ7Q/UMLz3hHKTHdzpwr60cEHGTM6CzEc/d79/NHQSsazl7X
	ZMZTtxh3aeQJdwlonkyn4V6ZG0y7sCUnPslKPNKdzuvBfLSVJI+IuwyDYtZX11QwCIo6P1yxSE0Jm
	r1oA7HGS8zY3F39Sl+Ib1kal5akxAgz4w1eIMY1tTgifHX5ZU9zTesd8tYoK3dIpl2Re79Jwdng43
	gqIFO4jqI+jZryFUIfHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggrqH-0001AJ-BD; Tue, 08 Jan 2019 13:54:53 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggrqD-00019r-Hf
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 13:54:50 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD59980D;
 Tue,  8 Jan 2019 05:54:47 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDE993F70D;
 Tue,  8 Jan 2019 05:54:46 -0800 (PST)
Date: Tue, 8 Jan 2019 13:54:44 +0000
From: Will Deacon <will.deacon@arm.com>
To: "huanglingyan (A)" <huanglingyan2@huawei.com>
Subject: Re: [PATCH v3] arm64: lib: accelerate do_csum with NEON instruction
Message-ID: <20190108135444.GB14476@fuggles.cambridge.arm.com>
References: <1546739729-17234-1-git-send-email-huanglingyan2@huawei.com>
 <CAKv+Gu_wsK1UNXSp=5Hvd7XCHKC3cVkYjTYHhvqM4Xt09A9iKg@mail.gmail.com>
 <9129b882-60f3-8046-0cb9-e0b2452a118d@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9129b882-60f3-8046-0cb9-e0b2452a118d@huawei.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_055449_583554_05D8DE6E 
X-CRM114-Status: GOOD (  12.98  )
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
 linux-arm-kernel@lists.infradead.org, ard.biesheuvel@linaro.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

W3JlLWFkZGluZyBBcmQgYW5kIExBS01MIC0tIG5vdCBzdXJlIHdoeSB0aGUgaGVhZGVycyBhcmUg
c28gbXVuZ2VkXQoKT24gTW9uLCBKYW4gMDcsIDIwMTkgYXQgMTA6Mzg6NTVBTSArMDgwMCwgaHVh
bmdsaW5neWFuIChBKSB3cm90ZToKPiDlnKggMjAxOS8xLzYgMTY6MjYsIEFyZCBCaWVzaGV1dmVs
IOWGmemBkzoKPiAgICAgUGxlYXNlIGNoYW5nZSB0aGlzIGludG8KPiAKPiAgICAgaWYgKElTX0VO
QUJMRUQoQ09ORklHX0tFUk5FTF9NT0RFX05FT04pICYmCj4gICAgICAgICBsZW4gPj0gQ1NVTV9O
RU9OX1RIUkVTSE9MRCAmJgo+ICAgICAgICAgbWF5X3VzZV9zaW1kKCkpIHsKPiAgICAgICAgICAg
ICBrZXJuZWxfbmVvbl9iZWdpbigpOwo+ICAgICAgICAgICAgIHJlcyA9IGRvX2NzdW1fbmVvbihi
dWZmLCBsZW4pOwo+ICAgICAgICAgICAgIGtlcm5lbF9uZW9uX2VuZCgpOwo+ICAgICAgICAgfQo+
IAo+ICAgICBhbmQgZHJvcCB0aGUgaW50ZXJtZWRpYXRlIGRvX2NzdW1fYXJtKCkKPiAKPiAKPiAg
ICAgICAgICsgICAgICAgICAgICAgICByZXR1cm4gZG9fY3N1bV9hcm0oYnVmZiwgbGVuKTsKPiAg
ICAgICAgICsjZW5kaWYgIC8qIENPTkZJR19LRVJORUxfTU9ERV9ORU9OICovCj4gCj4gICAgIE5v
IGVsc2U/IFdoYXQgaGFwcGVucyBpZiBsZW4gPCBDU1VNX05FT05fVEhSRVNIT0xEID8KPiAKPiAK
PiAgICAgICAgICsjdW5kZWYgZG9fY3N1bQo+IAo+ICAgICBDYW4gd2UgZHJvcCB0aGlzPwo+IAo+
IFVzaW5nIE5FT04gaW5zdHJ1Y3Rpb25zIHdpbGwgYnJpbmcgc29tZSBjb3N0cy4gVGhlIHNwZW5k
aW5nIG1heWJlIGludHJvZHVjZWQKPiB3aGVuIHJlc2VydmVyaW5nL3Jlc3RvcmluZwo+IG5lb24g
cmVnaXN0ZXJzIHdpdGgga2VybmVsX25lb25fYmVnaW4oKS9rZXJuZWxfbmVvbl9lbmQoKS4gVGhl
cmVmb3JlIE5FT04gY29kZQo+IGlzIE9ubHkgdXNlZCB3aGVuCj4gdGhlIGxlbmd0aCBleGNlZWRz
IENTVU1fTkVPTl9USFJFU0hPTEQuIEdlbmVyYWwgZG8gY3N1bSgpIGNvZGVzIGluIGxpYi8KPiBj
aGVja3N1bS5jIHdpbGwgYmUgdXNlZCBpbgo+IHNob3J0ZXIgbGVuZ3RoLiBUbyBhY2hpZXZlIHRo
aXMgZ29hbCwgSSB1c2UgdGhlICIjdW5kZWYgZG9fY3N1bSIgaW4gZWxzZSBjbGF1c2UKPiB0byBo
YXZlIHRoZSBvcHBvdHVuaXR5IHRvCj4gdXRpbGl6ZSB0aGUgZ2VuZXJhbCBjb2Rlcy4KCkkgZG9u
J3QgdGhpbmsgdGhhdCdzIGhvdyBpdCB3b3JrcyA6LwoKQmVmb3JlIHdlIGdldCBkZWVwZXIgaW50
byB0aGUgaW1wbGVtZW50YXRpb24sIHBsZWFzZSBjb3VsZCB5b3UganVzdGlmeSB0aGUKbmVlZCBm
b3IgYSBDUFUtb3B0aW1pc2VkIGNoZWNrc3VtIGltcGxlbWVudGF0aW9uIGF0IGFsbD8gSSB0aG91
Z2h0IHRoaXMgd2FzCnVzdWFsbHkgb2ZmbG9hZGVkIHRvIHRoZSBOSUM/CgpXaWxsCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVs
IG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
