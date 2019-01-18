Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1364C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:51:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A06722086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q0gyvoDv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A06722086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iDTKTu9xiuNDrrS6TktPsMDsfkCqg7L8/rkchx046vw=; b=Q0gyvoDvKIBbx1Om4DJ5ZBO5Z
	e0xKnkdfiSTUVi+gXpGp41heznBxCuSQT2BHJtkM9AsGL6Ui393mjBFIKlgsYCsfbBpj2iUslKHiQ
	K9jhc6JsLA4O6NhzHuheSn7Cb5K18KNKqdHxcDpDOgk80/59oJ7rs9UFNFMpQe45b9gS6Ulv4WsSd
	IZRctN1DhAYkWcSkpjBOvdaJlu0d8sdJyfW2hpiIiiQfJS5WwYytt1ajs5/p5bAaq9ps7NShK3+Rs
	ZT7oEtIlY61T9q9JwPNmcKPi9/yLNX9IdYEjkDWs4bmQAyGUqJo8yuMhZCIrJRgtOIwnv4mPQD+h/
	g1OZue2Ag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkXMq-0003QQ-Ex; Fri, 18 Jan 2019 16:51:40 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkX7T-0000xX-BK
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:35:51 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B13F80D;
 Fri, 18 Jan 2019 08:35:47 -0800 (PST)
Received: from [192.168.100.241] (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48AD83F557;
 Fri, 18 Jan 2019 08:35:46 -0800 (PST)
Subject: Re: [PATCH v3 3/7] arm64: kpti: move check for non-vulnerable CPUs to
 a function
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
 linux-arm-kernel@lists.infradead.org
References: <20190109235544.2992426-1-jeremy.linton@arm.com>
 <20190109235544.2992426-4-jeremy.linton@arm.com>
 <553c4f17-b504-a7a2-51cf-9c0d6c5d7797@arm.com>
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <26cdac8e-ff62-d35c-50ca-a50d86f6651b@arm.com>
Date: Fri, 18 Jan 2019 10:35:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <553c4f17-b504-a7a2-51cf-9c0d6c5d7797@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_083547_813309_D4510D17 
X-CRM114-Status: GOOD (  20.10  )
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
Cc: stefan.wahren@i2se.com, mlangsdo@redhat.com, julien.thierry@arm.com,
 marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, Steven.Price@arm.com, ykaukab@suse.de,
 dave.martin@arm.com, shankerd@codeaurora.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGksCgpPbiAwMS8xNC8yMDE5IDA1OjMyIEFNLCBTdXp1a2kgSyBQb3Vsb3NlIHdyb3RlOgo+IEhp
IEplcmVteSwKPiAKPiBPbiAwOS8wMS8yMDE5IDIzOjU1LCBKZXJlbXkgTGludG9uIHdyb3RlOgo+
PiBGcm9tOiBNaWFuIFlvdXNhZiBLYXVrYWIgPHlrYXVrYWJAc3VzZS5kZT4KPj4KPj4gQWRkIGlz
X21lbHRkb3duX3NhZmUoKSB3aGljaCBpcyBhIHdoaXRlbGlzdCBvZiBrbm93biBzYWZlIGNvcmVz
Lgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBNaWFuIFlvdXNhZiBLYXVrYWIgPHlrYXVrYWJAc3VzZS5k
ZT4KPj4gW01vdmVkIGxvY2F0aW9uIG9mIGZ1bmN0aW9uXQo+PiBTaWduZWQtb2ZmLWJ5OiBKZXJl
bXkgTGludG9uIDxqZXJlbXkubGludG9uQGFybS5jb20+Cj4+IC0tLQo+PiDCoCBhcmNoL2FybTY0
L2tlcm5lbC9jcHVmZWF0dXJlLmMgfCAxNSArKysrKysrKysrKy0tLS0KPj4gwqAgMSBmaWxlIGNo
YW5nZWQsIDExIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQg
YS9hcmNoL2FybTY0L2tlcm5lbC9jcHVmZWF0dXJlLmMgCj4+IGIvYXJjaC9hcm02NC9rZXJuZWwv
Y3B1ZmVhdHVyZS5jCj4+IGluZGV4IDRmMjcyMzk5ZGU4OS4uYWI3ODRkN2EwMDgzIDEwMDY0NAo+
PiAtLS0gYS9hcmNoL2FybTY0L2tlcm5lbC9jcHVmZWF0dXJlLmMKPj4gKysrIGIvYXJjaC9hcm02
NC9rZXJuZWwvY3B1ZmVhdHVyZS5jCj4+IEBAIC05NDcsOCArOTQ3LDcgQEAgaGFzX3VzZWFibGVf
Y25wKGNvbnN0IHN0cnVjdCAKPj4gYXJtNjRfY3B1X2NhcGFiaWxpdGllcyAqZW50cnksIGludCBz
Y29wZSkKPj4gwqAgI2lmZGVmIENPTkZJR19VTk1BUF9LRVJORUxfQVRfRUwwCj4+IMKgIHN0YXRp
YyBpbnQgX19rcHRpX2ZvcmNlZDsgLyogMDogbm90IGZvcmNlZCwgPjA6IGZvcmNlZCBvbiwgPDA6
IAo+PiBmb3JjZWQgb2ZmICovCj4+IC1zdGF0aWMgYm9vbCB1bm1hcF9rZXJuZWxfYXRfZWwwKGNv
bnN0IHN0cnVjdCBhcm02NF9jcHVfY2FwYWJpbGl0aWVzIAo+PiAqZW50cnksCj4+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW50IHNjb3BlKQo+PiArc3RhdGljIGJvb2wgaXNfY3B1
X21lbHRkb3duX3NhZmUodm9pZCkKPj4gwqAgewo+PiDCoMKgwqDCoMKgIC8qIExpc3Qgb2YgQ1BV
cyB0aGF0IGFyZSBub3QgdnVsbmVyYWJsZSBhbmQgZG9uJ3QgbmVlZCBLUFRJICovCj4+IMKgwqDC
oMKgwqAgc3RhdGljIGNvbnN0IHN0cnVjdCBtaWRyX3JhbmdlIGtwdGlfc2FmZV9saXN0W10gPSB7
Cj4+IEBAIC05NjIsNiArOTYxLDE1IEBAIHN0YXRpYyBib29sIHVubWFwX2tlcm5lbF9hdF9lbDAo
Y29uc3Qgc3RydWN0IAo+PiBhcm02NF9jcHVfY2FwYWJpbGl0aWVzICplbnRyeSwKPj4gwqDCoMKg
wqDCoMKgwqDCoMKgIE1JRFJfQUxMX1ZFUlNJT05TKE1JRFJfQ09SVEVYX0E3MyksCj4+IMKgwqDC
oMKgwqDCoMKgwqDCoCB7IC8qIHNlbnRpbmVsICovIH0KPj4gwqDCoMKgwqDCoCB9Owo+PiArwqDC
oMKgIGlmIChpc19taWRyX2luX3JhbmdlX2xpc3QocmVhZF9jcHVpZF9pZCgpLCBrcHRpX3NhZmVf
bGlzdCkpCj4gCj4gbml0OiBEb2VzIGl0IG1ha2Ugc2Vuc2UgdG8gcmVuYW1lIHRoZSBsaXN0IHRv
ICJtZWx0ZG93bl9zYWZlX2xpc3QiLCB0byAKPiBtYXRjaCB0aGUKPiBmdW5jdGlvbiBuYW1lID8K
PiAKPiBBbHNvIGFsc28sIHlvdSBtYXkgZG8gOgo+IAo+ICDCoMKgwqDCoHJldHVybiBpc19taWRy
X2luX3JhbmdlX2xpc3QocmVhZF9jcHVpZF9pZCgpLCBrcHRpX3NhZmVfbGlzdCk7Cj4gCj4gRWl0
aGVyIHdheQo+IAo+IFJldmlld2VkLWJ5OiBTdXp1a2kgSyBQb3Vsb3NlIDxzdXp1a2kucG91bG9z
ZUBhcm0uY29tPgoKSGksIGFnYWluLgoKUGFydCBvZiB0aGUgZGVsYXkgaW4gcmVzcG9uZGluZyB0
byB0aGlzIG9uZSwgaGFzIGJlZW4gdGhlIGZhY3QgdGhhdCAKb3JpZ2luYWxseSBtZWx0b2R3bl9z
YWZlKCkgd2FzIGJlaW5nIHVzZWQgaW4gdHdvIHBsYWNlcyAod2hpY2ggaXMgd2h5IGl0IAp3YXMg
YnJva2VuIG91dCkuIEJ1dCB0aGF0IGlzbid0IHRydWUgYW55bW9yZSwgYW5kIHRoaXMgcGF0Y2gg
aXMgCmVmZmVjdGl2ZWx5IGp1c3QgZmx1ZmYsIHNvIGl0IHNlZW1lZCBhcHByb3ByaWF0ZSBmb3Ig
dGhlIGNob3BwaW5nIGJsb2NrIAp0b28sIHdoaWNoIGlzIHdoYXQgaSdtIHBsYW5uaW5nLgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtl
cm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5l
bAo=
