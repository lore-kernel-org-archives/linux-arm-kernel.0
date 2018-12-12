Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB000C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:45:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B07AA2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kkWVRRKC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B07AA2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vQ/634k2V/GoUY+6b9xGXSYRbLUTuzb1W8jZ0YE7DZc=; b=kkWVRRKCi/nXqnwgjHqb7v6DM
	v/9FMUGnx4tUbV0HazlH1jtJNn8O0DqqOyetlOjA+ewxRZUtw8awzqiFaHbruL8FDgIiaKcUgoWzY
	UBzCRFkE+9rp3Z5XeFwWsm07qtfsN1rwWaYIgYgl1ObxJnc5rBk8DyfjonGynQp4PzSA3whCvMXxS
	ngX6EF7HsD8gAW0HaUId9WAmLTNtHYqh0BAlJlHDXFJB9HD6y0Mhy7WLITmjLzFpyPnY6v7pKSY/N
	3D9zux21oYhGLnhSgpuOgc10hjmc3nKtr52QjyZrdQZNri1whHXgX3/SMS4I2OVdlSg9v9HL1eaKZ
	UjUr0ML+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX2xO-0006TF-2j; Wed, 12 Dec 2018 11:45:38 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX2xK-0006Sg-JQ
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 11:45:36 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1A1AA78;
 Wed, 12 Dec 2018 03:45:22 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D0013F575;
 Wed, 12 Dec 2018 03:45:21 -0800 (PST)
Subject: Re: Built a neon version copy_page/clear_page is correct?
To: JackieLiu <liuyun01@kylinos.cn>, Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <BE9C50D9-738C-4EAD-9BBC-5D1CE6BC077E@kylinos.cn>
 <CAKv+Gu-OWVd_oq-Zb49Kgsswr99oZ5pUOoTN5pkYPFmRDDWoOA@mail.gmail.com>
 <370722B9-5CAE-4420-9126-3DF805BC115B@kylinos.cn>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <3ce08db0-a138-1f36-a038-62071b6ab537@arm.com>
Date: Wed, 12 Dec 2018 11:45:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <370722B9-5CAE-4420-9126-3DF805BC115B@kylinos.cn>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_034534_675467_2807B902 
X-CRM114-Status: GOOD (  20.00  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Andrew Pinski <apinski@cavium.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTIvMTIvMjAxOCAwNzozMiwgSmFja2llTGl1IHdyb3RlOgo+IFllcy4gSSBoYXZlIGEgYm90
dGxlbmVjaywgbWF5YmUgaXTigJlzIG5vdCBjb3B5X3BhZ2XigJlzLiBidXQKPiBkdXJpbmcgdGhl
IGRlYnVnZ2luZyBwcm9jZXNzLCB0aGlzIGZ1bmN0aW9uIGhhcyBhIHZlcnkgaGlnaAo+IENQVSB1
dGlsaXphdGlvbi4KPiAKPiBUaGUgdGVzdCBwcm9ncmFtIGlzIFVuaXhCZW5jaOKAmXMgc3JjL3Nw
YXduLmMsIHdpdGggYSB3aGlsZSB0bwo+IGZvcmsgcHJvY2Vzcy4gVGhlIG9ubHkgdmFyaWFibGUg
Zm9yIHRlc3QgaXMgUEFHRV9TSVpFLCBvbmUgaXMKPiA0ayBQQUdFX1NJWkUsIG5leHQgaXMgNjRr
IFBBR0VfU0laRS4KCkFGQUlDUyBhbGwgdGhhdCBkb2VzIGlzIGNhbGwgZm9yaygpIGluIGEgbG9v
cCBhcyBmYXN0IGFzIGl0IHBvc3NpYmx5IApjYW4uIEZvcmtpbmcgaW52b2x2ZXMgY29weWluZyBw
YWdlcywgZWl0aGVyIGR1cmluZyB0aGUgY2FsbCBvciB2aWEgCmNvcHktb24td3JpdGUgdHJpZ2dl
cmluZyBpbiBvbmUgb3IgYm90aCBwcm9jZXNzZXMgYWZ0ZXIgdGhlIHN5c2NhbGwgCnJldHVybnMu
IFNvIHlvdXIgJ3Byb2JsZW0nIGlzIHRoYXQgc29tZSBiZW5jaG1hcmsgY29kZSBzcGVuZHMgYSBm
YWlyIAphbW91bnQgb2YgdGltZSBkb2luZyB0aGUgbWFqb3IgcGFydCBvZiB0aGUgb3BlcmF0aW9u
IGl0J3MgYmVuY2htYXJraW5nLi4uIDovCgo+IHJlc3VsdCBmb3IgInBlcmYgdG9wIjoKPiA0ayAg
fCAgMTMlIENQVSAgY29weV9wYWdlCj4gNjRrIHwgIDQ4JSBDUFUgIGNvcHlfcGFnZQo+IAo+IFRo
aXMgaXMgd2h5IEkgd2FudCB0byBvcHRpbWl6ZSB0aGlzIGZ1bmN0aW9uLiBNYXliZSBib3R0bGVu
ZWNrCj4gaXMgbm90IGhlcmU/CgpBbHNvIGJlYXIgaW4gbWluZCB0aGF0IEFGQUlLIG1vc3QgY3Vy
cmVudCBjb3JlcyBjYW4gaGFwcGlseSBzYXR1cmF0ZSAKdGhlaXIgbG9hZC9zdG9yZSB1bml0IHdp
dGgganVzdCBMRFAvU1RQIC0gdGhpcyBpc24ndCBsaWtlIEFybXY3IHdoZXJlIApWTEQqIHdhcyB0
aGUgb25seSB3YXkgdG8gZ2VuZXJhdGUgYSBzaW5nbGUgMTI4LWJpdCB3aWRlIGFjY2Vzcy4gSWYg
CnlvdSdyZSBub3QgZG9pbmcgYW55IGFjdHVhbCBjYWxjdWxhdGlvbiBvciBMRG4vU1RuIGludGVy
bGVhdmluZyAKdHJpY2tlcnksIHVzaW5nIE5FT04gcHVyZWx5IHRvIG1vdmUgZGF0YSBpcyB1bmxp
a2VseSB0byBiZSB3b3J0aHdoaWxlIGluIApnZW5lcmFsLiBPbiBtYW55IGNvcmVzIGl0IG1heSB3
ZWxsIGVuZCB1cCBiZWluZyBzbG93ZXIuCgpSb2Jpbi4KCj4gCj4+IOWcqCAyMDE45bm0MTLmnIgx
MuaXpe+8jDE1OjE477yMQXJkIEJpZXNoZXV2ZWwgPGFyZC5iaWVzaGV1dmVsQGxpbmFyby5vcmc+
IOWGmemBk++8mgo+Pgo+PiBBcyBmb3IgY29weV9wYWdlKCksIHBsZWFzZSBkZXNjcmliZSBhIHVz
ZSBjYXNlIHdoZXJlIGl0IGlzIGEKPj4gYm90dGxlbmVjaywgYW5kIHJlYXNvbiBhYm91dCBob3cg
bXVjaCB5b3UgY291bGQgaW1wcm92ZSBwZXJmb3JtYW5jZSBpbgo+PiB0aGF0IGNhc2UgYnkgaW1w
cm92aW5nIHRoZSBzcGVlZCBvZiBjb3B5X3BhZ2UoKSBpdHNlbGYuIE90aGVyd2lzZSwKPj4gd2Un
cmUganVzdCBhZGRpbmcgTkVPTiByb3V0aW5lcyBmb3IgdGhlIHNha2UgaWYgaXQsIHdoaWNoIGlz
IGEgYmFkCj4+IGlkZWEgaW1vLgo+IAo+IAo+IAo+IAo+IAo+IF9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxp
c3QKPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKPiBodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwKPiAKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJu
ZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
