Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70871C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:28:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42F5520449
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ri3r4opA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F5520449
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hiAZ0/J6dTzfNvEuHNab9hfgcvcMnJaGxE2HRUGY7qU=; b=ri3r4opArHie6G
	W+f42sHlQ2R21vnNJvPPTKbN4qGZWu5MYuoaFyb6KJSHNKXfuo7+YUmW8A3wEOSH7ujkq0B7mCaip
	rQOY+oVYgVx38XuIIt1wr0KqwLkq4L/jbR6hBFjelxeTJ0XZ62azsnDV2QvDs6O42nVPeM4j0gQ8n
	p3PFbHm/FJhNLsqoPfJhs27e7qCB07K/PURzE5OqzehHsOE1FjvUXFtemRbpsXfihSnglQhOnaMpb
	NFY2Vnb+supCYzxVcg1r7fxOjaGNlKEr8aHlf8XncZBr4J8Auuu1ilwoji4RQT9ff4HQggHWz5rt+
	bLRcnuW0gonFzOasALog==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw4VK-0008HP-6O; Tue, 19 Feb 2019 12:28:06 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw4VF-0008Gm-Hg
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 12:28:03 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D70D7EBD;
 Tue, 19 Feb 2019 04:27:56 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45AEB3F720;
 Tue, 19 Feb 2019 04:27:46 -0800 (PST)
Date: Tue, 19 Feb 2019 13:27:44 +0100
From: Christoffer Dall <christoffer.dall@arm.com>
To: =?utf-8?B?QW5kcsOp?= Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH 11/14] KVM: arm/arm64: timer: Rework data structures for
 multiple timers
Message-ID: <20190219122744.GC28113@e113682-lin.lund.arm.com>
References: <20190124140032.8588-1-christoffer.dall@arm.com>
 <20190124140032.8588-12-christoffer.dall@arm.com>
 <d44bd102-5ad6-6e08-5e47-8a8386a139c6@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d44bd102-5ad6-6e08-5e47-8a8386a139c6@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_042801_594265_8F57B75A 
X-CRM114-Status: GOOD (  25.01  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gTW9uLCBGZWIgMTgsIDIwMTkgYXQgMDM6MTA6MTZQTSArMDAwMCwgQW5kcsOpIFByenl3YXJh
IHdyb3RlOgo+IE9uIFRodSwgMjQgSmFuIDIwMTkgMTU6MDA6MjkgKzAxMDAKPiBDaHJpc3RvZmZl
ciBEYWxsIDxjaHJpc3RvZmZlci5kYWxsQGFybS5jb20+IHdyb3RlOgo+IAo+IEhpLAo+IAo+IEkg
YWxyZWFkeSBsb29rZWQgYXQgbW9zdCBvZiB0aGVzZSBwYXRjaGVzIGVhcmxpZXIsIHdpdGhvdXQg
ZmluZGluZwo+IHNlcmlvdXMgaXNzdWVzLCBidXQgZmlndXJlZCBJIHdvdWxkIGdpdmUgdGhvc2Ug
d2l0aG91dCBhbnkgUmV2aWV3ZWQtYnk6Cj4gb3IgQWNrZWQtYnk6IHRhZ3MgYSBjbG9zZXIgbG9v
ay4KPiAoVGhpcyBwYXRjaCBqdXN0IGNhcnJpZXMgYSBTLW8tYjogdGFnIGZyb20gTWFyYyBpbiB0
aGUga3ZtLWFybSBnaXQgcmVwby4pCj4gCj4gPiBQcmVwYXJlIGZvciBoYXZpbmcgNCB0aW1lciBk
YXRhIHN0cnVjdHVyZXMgKDIgZm9yIG5vdykuCj4gPiAKPiA+IENoYW5nZSBsb2FkZWQgdG8gYW4g
ZW51bSBzbyB0aGF0IHdlIGtub3cgbm90IGp1c3Qgd2hldGhlciAqc29tZSogc3RhdGUKPiA+IGlz
IGxvYWRlZCBvbiB0aGUgQ1BVLCBidXQgYWxzbyAqd2hpY2gqIHN0YXRlIGlzIGxvYWRlZC4KPiA+
IAo+ID4gTW92ZSBsb2FkZWQgdG8gdGhlIGNwdSBkYXRhIHN0cnVjdHVyZSBhbmQgbm90IHRoZSBp
bmRpdmlkdWFsIHRpbWVyCj4gPiBzdHJ1Y3R1cmUsIGluIHByZXBhcmF0aW9uIGZvciBhc3NpZ25p
bmcgdGhlIEVMMSBwaHlzIHRpbWVyIGFzIHdlbGwuCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IENo
cmlzdG9mZmVyIERhbGwgPGNocmlzdG9mZmVyLmRhbGxAYXJtLmNvbT4KPiA+IEFja2VkLWJ5OiBN
YXJjIFp5bmdpZXIgPG1hcmMuenluZ2llckBhcm0uY29tPgo+ID4gLS0tCj4gPiAgaW5jbHVkZS9r
dm0vYXJtX2FyY2hfdGltZXIuaCB8IDQ0ICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQo+ID4g
IHZpcnQva3ZtL2FybS9hcmNoX3RpbWVyLmMgICAgfCA1OCArKysrKysrKysrKysrKysrKysrLS0t
LS0tLS0tLS0tLS0tLS0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDU0IGluc2VydGlvbnMoKyksIDQ4
IGRlbGV0aW9ucygtKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9rdm0vYXJtX2FyY2hf
dGltZXIuaCBiL2luY2x1ZGUva3ZtL2FybV9hcmNoX3RpbWVyLmgKPiA+IGluZGV4IGQyNmI3ZmRl
OTkzNS4uZDQwZmU1N2EyZDBkIDEwMDY0NAo+ID4gLS0tIGEvaW5jbHVkZS9rdm0vYXJtX2FyY2hf
dGltZXIuaAo+ID4gKysrIGIvaW5jbHVkZS9rdm0vYXJtX2FyY2hfdGltZXIuaAo+ID4gQEAgLTM2
LDYgKzM2LDggQEAgZW51bSBrdm1fYXJjaF90aW1lcl9yZWdzIHsKPiA+ICB9Owo+ID4gIAo+ID4g
IHN0cnVjdCBhcmNoX3RpbWVyX2NvbnRleHQgewo+ID4gKwlzdHJ1Y3Qga3ZtX3ZjcHUJCQkqdmNw
dTsKPiA+ICsKPiA+ICAJLyogUmVnaXN0ZXJzOiBjb250cm9sIHJlZ2lzdGVyLCB0aW1lciB2YWx1
ZSAqLwo+ID4gIAl1MzIJCQkJY250X2N0bDsKPiA+ICAJdTY0CQkJCWNudF9jdmFsOwo+ID4gQEAg
LTQzLDMyICs0NSwzNCBAQCBzdHJ1Y3QgYXJjaF90aW1lcl9jb250ZXh0IHsKPiA+ICAJLyogVGlt
ZXIgSVJRICovCj4gPiAgCXN0cnVjdCBrdm1faXJxX2xldmVsCQlpcnE7Cj4gPiAgCj4gPiAtCS8q
Cj4gPiAtCSAqIFdlIGhhdmUgbXVsdGlwbGUgcGF0aHMgd2hpY2ggY2FuIHNhdmUvcmVzdG9yZSB0
aGUgdGltZXIgc3RhdGUKPiA+IC0JICogb250byB0aGUgaGFyZHdhcmUsIHNvIHdlIG5lZWQgc29t
ZSB3YXkgb2Yga2VlcGluZyB0cmFjayBvZgo+ID4gLQkgKiB3aGVyZSB0aGUgbGF0ZXN0IHN0YXRl
IGlzLgo+ID4gLQkgKgo+ID4gLQkgKiBsb2FkZWQgPT0gdHJ1ZTogIFN0YXRlIGlzIGxvYWRlZCBv
biB0aGUgaGFyZHdhcmUgcmVnaXN0ZXJzLgo+ID4gLQkgKiBsb2FkZWQgPT0gZmFsc2U6IFN0YXRl
IGlzIHN0b3JlZCBpbiBtZW1vcnkuCj4gPiAtCSAqLwo+ID4gLQlib29sCQkJbG9hZGVkOwo+ID4g
LQo+ID4gIAkvKiBWaXJ0dWFsIG9mZnNldCAqLwo+ID4gLQl1NjQJCQljbnR2b2ZmOwo+ID4gKwl1
NjQJCQkJY250dm9mZjsKPiA+ICsKPiA+ICsJLyogRW11bGF0ZWQgVGltZXIgKG1heSBiZSB1bnVz
ZWQpICovCj4gPiArCXN0cnVjdCBocnRpbWVyCQkJaHJ0aW1lcjsKPiA+ICt9Owo+ID4gKwo+ID4g
K2VudW0gbG9hZGVkX3RpbWVyX3N0YXRlIHsKPiA+ICsJVElNRVJfTk9UX0xPQURFRCwKPiA+ICsJ
VElNRVJfRUwxX0xPQURFRCwKPiAKPiBTbyB0aGlzIGdldHMgcmV2ZXJ0ZWQgaW4gUEFUQ0ggMTMv
MTQsIGFuZCBJIGRvbid0IHNlZSBpdCByZWFwcGVhcmluZyBpbgo+IHRoZSBudiBzZXJpZXMgbGF0
ZXIgb24uCj4gSXMgdGhhdCBqdXN0IG5lZWRlZCBmb3IgYXNzaWduaW5nIHRoZSBwaHlzIHRpbWVy
IGluIHRoZSBuZXh0IHBhdGNoLCBhbmQKPiBnZXRzIG9ic29sZXRlIHdpdGggdGhlIHRpbWVyX21h
cD8KPiBPciBpcyB0aGlzIGEgcmViYXNlIGFydGVmYWN0IGFuZCB3ZSBkb24ndCBhY3R1YWxseSBu
ZWVkIHRoaXM/CgpJIHRoaW5rIHRoaXMgaXMgYSByZWJhc2UgcHJvYmxlbSBhbmQgd2UgY291bGQg
aGF2ZSBvcHRpbWl6ZWQgdGhpcyBvdXQgdG8KcmVkdWNlIHRoZSBwYXRjaCBkaWZmLiAgVGhlIGVu
ZCByZXN1bHQgaXMgdGhlIHNhbWUgdGhvdWdoLgoKPiAKPiBUaGUgcmVzdCBvZiB0aGUgcGF0Y2gg
bG9va3MgbGlrZSB2YWxpZCB0cmFuc2Zvcm1hdGlvbnMgdG8gbWUuCj4gClRoYW5rcyBmb3IgaGF2
aW5nIGEgbG9vay4KCiAgICBDaHJpc3RvZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
