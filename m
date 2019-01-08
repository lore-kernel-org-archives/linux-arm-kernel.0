Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5362DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:45:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09BA32087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uI3gq2H0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09BA32087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=apilGamUNwprwHs9v9dygatU1AdIjd+RLGDVzfjxxXo=; b=uI3gq2H0tYM4WG
	RhD0QMNV1umEg3enGab46K+03uCyKufDE5EEXO7WUNhvDKU2AztxutY4K5W9iLy6IwptnSrvFkOUZ
	jH0xPaz9c4yTBZ5diPZZeItzc/F1b1Z7a7A/eom6+UkjUaEGEZQrAdq9o8uoasA2wbFtxe2t9F/YV
	JuRWg6ao8U+o8ai4pxSMa5vzrIrlh3LLg8Yctl1PaFtxF3jApRGaFddFuaXBpTDOdmUy7vB7lLKU5
	RuroWKzVSffEQHYRNer3rSkKvCf0fhp92iC6B7Dtxd0Uff9RY2lSrBlt8IP+8bZjn1TT3r2EgLNxn
	/5ozWNc5PQDd8iSkGd8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gguVI-0007J2-5R; Tue, 08 Jan 2019 16:45:24 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gguVE-0007Hp-IX
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 16:45:22 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD04AA78;
 Tue,  8 Jan 2019 08:45:17 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 832BC3F5AF;
 Tue,  8 Jan 2019 08:45:15 -0800 (PST)
Date: Tue, 8 Jan 2019 16:45:13 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v8 12/26] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
Message-ID: <20190108164510.GB5840@e103592.cambridge.arm.com>
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
 <1546956464-48825-13-git-send-email-julien.thierry@arm.com>
 <20190108153957.GA5840@e103592.cambridge.arm.com>
 <8cae8016-d2c7-3c86-9832-f4278d42ea21@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8cae8016-d2c7-3c86-9832-f4278d42ea21@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_084520_628974_7732AE0E 
X-CRM114-Status: GOOD (  24.95  )
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
Cc: mark.rutland@arm.com, daniel.thompson@linaro.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, catalin.marinas@arm.com,
 Julien Thierry <julien.thierry@arm.com>, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, christoffer.dall@arm.com, james.morse@arm.com,
 Oleg Nesterov <oleg@redhat.com>, joel@joelfernandes.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVHVlLCBKYW4gMDgsIDIwMTkgYXQgMDM6NTE6MThQTSArMDAwMCwgTWFyYyBaeW5naWVyIHdy
b3RlOgo+IE9uIDA4LzAxLzIwMTkgMTU6NDAsIERhdmUgTWFydGluIHdyb3RlOgo+ID4gT24gVHVl
LCBKYW4gMDgsIDIwMTkgYXQgMDI6MDc6MzBQTSArMDAwMCwgSnVsaWVuIFRoaWVycnkgd3JvdGU6
Cj4gPj4gSW5zdGVhZCBkaXNhYmxpbmcgaW50ZXJydXB0cyBieSBzZXR0aW5nIHRoZSBQU1IuSSBi
aXQsIHVzZSBhIHByaW9yaXR5Cj4gPj4gaGlnaGVyIHRoYW4gdGhlIG9uZSB1c2VkIGZvciBpbnRl
cnJ1cHRzIHRvIG1hc2sgdGhlbSB2aWEgUE1SLgo+ID4+Cj4gPj4gV2hlbiB1c2luZyBQTVIgdG8g
ZGlzYWJsZSBpbnRlcnJ1cHRzLCB0aGUgdmFsdWUgb2YgUE1SIHdpbGwgYmUgdXNlZAo+ID4+IGlu
c3RlYWQgb2YgUFNSLltEQUlGXSBmb3IgdGhlIGlycWZsYWdzLgo+ID4+Cj4gPj4gU2lnbmVkLW9m
Zi1ieTogSnVsaWVuIFRoaWVycnkgPGp1bGllbi50aGllcnJ5QGFybS5jb20+Cj4gPj4gU3VnZ2Vz
dGVkLWJ5OiBEYW5pZWwgVGhvbXBzb24gPGRhbmllbC50aG9tcHNvbkBsaW5hcm8ub3JnPgo+ID4+
IENjOiBDYXRhbGluIE1hcmluYXMgPGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tPgo+ID4+IENjOiBX
aWxsIERlYWNvbiA8d2lsbC5kZWFjb25AYXJtLmNvbT4KPiA+PiBDYzogQXJkIEJpZXNoZXV2ZWwg
PGFyZC5iaWVzaGV1dmVsQGxpbmFyby5vcmc+Cj4gPj4gQ2M6IE9sZWcgTmVzdGVyb3YgPG9sZWdA
cmVkaGF0LmNvbT4KPiA+PiAtLS0KPiA+PiAgYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9lZmkuaCAg
ICAgIHwgIDExICsrKysKPiA+PiAgYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9pcnFmbGFncy5oIHwg
MTIzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tCj4gPj4gIDIgZmlsZXMg
Y2hhbmdlZCwgMTA2IGluc2VydGlvbnMoKyksIDI4IGRlbGV0aW9ucygtKQo+ID4gCj4gPiBbLi4u
XQo+ID4gCj4gPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vaXJxZmxhZ3Mu
aCBiL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vaXJxZmxhZ3MuaAo+ID4+IGluZGV4IDI0NjkyZWQu
LmZhM2IwNmYgMTAwNjQ0Cj4gPj4gLS0tIGEvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9pcnFmbGFn
cy5oCj4gPj4gKysrIGIvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9pcnFmbGFncy5oCj4gPj4gQEAg
LTE4LDcgKzE4LDkgQEAKPiA+IAo+ID4gWy4uLl0KPiA+IAo+ID4+ICBzdGF0aWMgaW5saW5lIHZv
aWQgYXJjaF9sb2NhbF9pcnFfZW5hYmxlKHZvaWQpCj4gPj4gIHsKPiA+PiAtCWFzbSB2b2xhdGls
ZSgKPiA+PiAtCQkibXNyCWRhaWZjbHIsICMyCQkvLyBhcmNoX2xvY2FsX2lycV9lbmFibGUiCj4g
Pj4gLQkJOgo+ID4+ICsJdW5zaWduZWQgbG9uZyB1bm1hc2tlZCA9IEdJQ19QUklPX0lSUU9OOwo+
ID4+ICsKPiA+PiArCWFzbSB2b2xhdGlsZShBTFRFUk5BVElWRSgKPiA+PiArCQkibXNyCWRhaWZj
bHIsICMyCQkvLyBhcmNoX2xvY2FsX2lycV9lbmFibGVcbiIKPiA+PiArCQkibm9wIiwKPiA+PiAr
CQkibXNyX3MgICIgX19zdHJpbmdpZnkoU1lTX0lDQ19QTVJfRUwxKSAiLCUwXG4iCj4gPj4gKwkJ
ImRzYglzeSIsCj4gPiAKPiA+IEknbSBzdGlsbCBub3QgY29udmluY2VkIHRoZXNlIGRzYnMgYXJl
IG5lZWRlZC4KPiA+IAo+ID4gV2l0aG91dCB0aGUgZHNiLCB3ZSBhcmUgcHJvYmFibHkgbm90IGd1
YXJhbnRlZWQgdG8gdGFrZSBhIHBlbmRpbmcKPiA+IGludGVycnVwdCBfaW1tZWRpYXRlbHlfIG9u
IHVubWFza2luZywgYnV0IEknbSBub3Qgc3VyZSB0aGF0J3MgYQo+ID4gcHJvYmxlbS4KPiA+IAo+
ID4gV2hhdCBnb2VzIHdyb25nIGlmIHdlIG9taXQgdGhlbT8KPiAKPiBUaGVuIHRoZSBHSUMgZG9l
c24ndCBrbm93IGl0IGNhbiBub3cgZGVsaXZlciBpbnRlcnJ1cHRzIG9mIGEgbG93ZXIKPiBwcmlv
cml0eS4gT25seSBhIGRzYiBjYW4gZ3VhcmFudGVlIHRoYXQgdGhlIEdJQydzIHZpZXcgb2YgUE1S
IHdpbGwgZ2V0Cj4gdXBkYXRlZC4KPiAKPiBTZWUgOS4xLjYgKE9ic2VydmFiaWxpdHkgb2YgdGhl
IGVmZmVjdHMgb2YgYWNjZXNzZXMgdG8gdGhlIEdJQwo+IHJlZ2lzdGVycyksIHdoaWNoIHN0YXRl
czoKPiAKPiA8cXVvdGU+Cj4gQXJjaGl0ZWN0dXJhbCBleGVjdXRpb24gb2YgYSBEU0IgaW5zdHJ1
Y3Rpb24gZ3VhcmFudGVlcyB0aGF0Cj4g4oCUIFRoZSBsYXN0IHZhbHVlIHdyaXR0ZW4gdG8gSUND
X1BNUl9FTDEgb3IgR0lDQ19QTVIgaXMgb2JzZXJ2ZWQgYnkgdGhlCj4gYXNzb2NpYXRlZCBSZWRp
c3RyaWJ1dG9yLgo+IDwvcXVvdGU+Cj4gCj4gU28geWVzLCBEU0IgaXMgcmVxdWlyZWQuCgpCdXQg
aXQgc2F5cyBuZWl0aGVyIHdoYXQgaXMgbWVhbnMgZm9yIHRoZSBQTVIgd3JpdGUgdG8gYmUgIm9i
c2VydmVkIGJ5CnRoZSByZWRpc3RyaWJ1dG9yIiwgbm9yIHdoZXRoZXIgdGhlIERTQiBpcyByZXF1
aXJlZCBmb3IgdGhlCnJlZGlzdHJpYnV0b3IgdG8gb2JzZXJ2ZSB0aGUgd3JpdGUgYXQgYWxsLiAg
KFNvLCBpcyBhbiBpbXBsZW1lbnRhdGlvbgphbGxvd2VkIHRvIGNhY2hlZCBpbiB0aGUgQ1BVIGlu
dGVyZmFjZSBpbmRlZmluaXRlbHkgdW50aWwgZm9yY2libHkKZmx1c2hlZCB0byB0aGUgcmVkaXN0
cmlidXRvciBieSBhIERTQiwgYW5kIGluIGFueSBjYXNlIGNhbiB0aGUgd3JpdGUncwpyZWFjaGlu
ZyB0aGUgZGlzdHJpYnV0b3IgaW4gZmluaXRlIHRpbWUgb3Igbm90IGhhdmUgYW55IGVmZmVjdCB0
aGF0IHdlCmNhcmUgYWJvdXQgaW4gdGhpcyBjYXNlPykuCgoKTXkgcmVhc29uIGZvciBxdWVyeWlu
ZyB0aGlzIGlzIHRoYXQgdGVtcG9yYXJ5IGxvY2FsIG1hc2tpbmcgb2YgY2xhc3NlcwpvZiBpbnRl
cnJ1cHRzIHNlZW1zIGFuIG9idmlvdXMgdXNlIGNhc2UgZm9yIHRoZSBQTVIsIGFuZCB0aGUgRFNC
CnJlcXVpcmVtZW50IGZsaWVzIHJhdGhlciBpbiB0aGUgZmFjZSBvZiB0aGlzLgoKCkhhdmUgd2Ug
c2VlbiBoYXJkd2FyZSB3aGVyZSBpbnRlcnJ1cHRzIG1heSBzdGFsbCBmb3JldmVyIHVwc3RyZWFt
IG9mIHRoZQpDUFUgaW50ZXJmYWNlIGFmdGVyIGEgUE1SIHdyaXRlLCB1bnRpbCBhIGRzYiBpcyBl
eGVjdXRlZCBieSB0aGUgQ1BVPwoKSWYgc28gdGhhdCBpcyBzYWQsIGJ1dCBJIGd1ZXNzIHdlIGhh
dmUgdG8gbGl2ZSB3aXRoIGl0LgoKQWxzbywgaXMgaXQgZXZlciBpbXBvcnRhbnQgaW4gTGludXgg
dGhhdCBhIHBlbmRpbmcgaW50ZXJydXB0IGJlIHRha2VuCmltbWVkaWF0ZWx5IHVwb24gdW5tYXNr
aW5nIChhbmQgaG93IGRvIHdlIGtub3cgdGhhdCBzYWlkIGludGVycnVwdCBpcwpwZW5kaW5nKT8g
IElmIG5vdCwgd2UgZG9uJ3QgY2FyZSBwcmVjaXNlbHkgd2hlbiBzdWNoIGludGVycnVwdHMgYXJl
CnBlbmRlZCB0byB0aGUgUEUsIGp1c3QgdGhhdCBzdWNoIGFuIGludGVycnVwdCBjYW5ub3QgYmUg
dGFrZW4gYmVmb3JlCnRoZSBQTVIgd3JpdGUgdGhhdCB1bm1hc2tzIGl0LiAgSXQgd291bGQgYmUg
aW5zYW5lIGZvciB0aGUgc2VsZi0Kc3luY2hyb25pemF0aW9uIG9mIFBNUiB3cml0ZXMgdG8gbGFj
ayB0aGlzIGd1YXJhbnRlZSAoYW5kIGEgRFNCIGFmdGVyCnRoZSBQTVIgd3JpdGUgd291bGQgZG8g
bm8gZ29vZCBhbnl3YXkgaW4gdGhhdCBjYXNlKS4KCkhhcHB5IHRvIGJlIHB1dCByaWdodCAtLSBJ
J20gZG91YnRsZXNzIHNob3dpbmcgbXkgaWdub3JhbmNlIGhlcmUhCgpDaGVlcnMKLS0tRGF2ZQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJt
LWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtl
cm5lbAo=
