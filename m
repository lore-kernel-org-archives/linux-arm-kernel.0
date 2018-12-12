Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3782C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:51:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4D5B20839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="avjCfS8x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D5B20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fSBr651VFXUmgXjPAyOPi7EyylCzDoyv2pRMHd5E2J8=; b=avjCfS8xv59JFyzQd+OY/01RO
	Fz4HvvpSdjnsYN3hTcwyhlqdhHI0HPntGFRmG37hJsYbZYllW7/2IpwxQ7EY4EcBGLOvVH2NoT3mr
	ZYagd7Dv7XHSmcROMY8ULXzfwqjRwkkbZWri9i0lyXqzGzmz1z3/hTwSWaSZzrfoM1QWZrHx7qLxR
	xohJd5cEb7uM2GFolMH7bQGLa46EidHSZ6L5N1z1zUvrx+nKaGJEyYh/qQ94ppxT07ADQ1aKsQ1NF
	8Ag5lIwQItgPHOvq0Qr9JyLW/fBOMop1x+Zy+lyw3nyabfiRGd5GNJRE3PqCm1JSHk6QDBaqnOu8I
	7BnwXVuDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX27I-0001W8-7f; Wed, 12 Dec 2018 10:51:48 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX27F-0001VJ-57
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 10:51:46 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8C50A78;
 Wed, 12 Dec 2018 02:51:34 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DEB663F575;
 Wed, 12 Dec 2018 02:51:31 -0800 (PST)
Subject: Re: [PATCH v8 4/5] arm64: arm_pmu: Add support for
 exclude_host/exclude_guest attributes
To: Julien Thierry <julien.thierry@arm.com>,
 Andrew Murray <andrew.murray@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
References: <1544610573-28446-1-git-send-email-andrew.murray@arm.com>
 <1544610573-28446-5-git-send-email-andrew.murray@arm.com>
 <89242306-a445-017b-553e-105ae52d8cbe@arm.com>
 <5fe821a9-a2b2-c40d-7a83-b014d7b8f4d1@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <f6dc17b1-7365-74c8-fb78-786e52af7fa9@arm.com>
Date: Wed, 12 Dec 2018 10:51:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5fe821a9-a2b2-c40d-7a83-b014d7b8f4d1@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_025145_210762_873C5469 
X-CRM114-Status: GOOD (  20.07  )
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
Cc: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CgpPbiAxMi8xMi8yMDE4IDEwOjQ3LCBKdWxpZW4gVGhpZXJyeSB3cm90ZToKPiAKPiAKPiBPbiAx
Mi8xMi8yMDE4IDEwOjQyLCBTdXp1a2kgSyBQb3Vsb3NlIHdyb3RlOgo+Pgo+Pgo+PiBPbiAxMi8x
Mi8yMDE4IDEwOjI5LCBBbmRyZXcgTXVycmF5IHdyb3RlOgo+Pj4gQWRkIHN1cHBvcnQgZm9yIHRo
ZSA6RyBhbmQgOkggYXR0cmlidXRlcyBpbiBwZXJmIGJ5IGhhbmRsaW5nIHRoZQo+Pj4gZXhjbHVk
ZV9ob3N0L2V4Y2x1ZGVfZ3Vlc3QgZXZlbnQgYXR0cmlidXRlcy4KPj4+Cj4+PiBXZSBub3RpZnkg
S1ZNIG9mIGNvdW50ZXJzIHRoYXQgd2Ugd2lzaCB0byBiZSBlbmFibGVkIG9yIGRpc2FibGVkIG9u
Cj4+PiBndWVzdCBlbnRyeS9leGl0IGFuZCB0aHVzIGRlZmVyIGZyb20gc3RhcnRpbmcgb3Igc3Rv
cHBpbmcgOkcgZXZlbnRzCj4+PiBhcyBwZXIgdGhlIGV2ZW50cyBleGNsdWRlX2hvc3QgYXR0cmli
dXRlLgo+Pj4KPj4+IFdpdGggYm90aCBWSEUgYW5kIG5vbi1WSEUgd2Ugc3dpdGNoIHRoZSBjb3Vu
dGVycyBiZXR3ZWVuIGhvc3QvZ3Vlc3QKPj4+IGF0IEVMMi4gV2UgYXJlIGFibGUgdG8gZWxpbWlu
YXRlIGNvdW50ZXJzIGNvdW50aW5nIGhvc3QgZXZlbnRzIG9uCj4+PiB0aGUgYm91bmRhcmllcyBv
ZiBndWVzdCBlbnRyeS9leGl0IHdoZW4gdXNpbmcgOkcgYnkgZmlsdGVyaW5nIG91dAo+Pj4gRUwy
IGZvciBleGNsdWRlX2hvc3QuIEhvd2V2ZXIgd2hlbiB1c2luZyA6SCB1bmxlc3MgZXhjbHVkZV9o
diBpcyBzZXQKPj4+IG9uIG5vbi1WSEUgdGhlbiB0aGVyZSBpcyBhIHNtYWxsIGJsYWNrb3V0IHdp
bmRvdyBhdCB0aGUgZ3Vlc3QKPj4+IGVudHJ5L2V4aXQgd2hlcmUgaG9zdCBldmVudHMgYXJlIG5v
dCBjYXB0dXJlZC4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXcgTXVycmF5IDxhbmRyZXcu
bXVycmF5QGFybS5jb20+Cj4+PiAtLS0KPj4+ICDCoCBhcmNoL2FybTY0L2tlcm5lbC9wZXJmX2V2
ZW50LmMgfCA1MQo+Pj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
Cj4+PiAgwqAgMSBmaWxlIGNoYW5nZWQsIDQ0IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0p
Cj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQva2VybmVsL3BlcmZfZXZlbnQuYwo+Pj4g
Yi9hcmNoL2FybTY0L2tlcm5lbC9wZXJmX2V2ZW50LmMKPj4+IGluZGV4IGRlNTY0YWUuLjRhM2M3
M2QgMTAwNjQ0Cj4+PiAtLS0gYS9hcmNoL2FybTY0L2tlcm5lbC9wZXJmX2V2ZW50LmMKPj4+ICsr
KyBiL2FyY2gvYXJtNjQva2VybmVsL3BlcmZfZXZlbnQuYwo+Pj4gQEAgLTI2LDYgKzI2LDcgQEAK
Pj4+ICDCoCDCoCAjaW5jbHVkZSA8bGludXgvYWNwaS5oPgo+Pj4gIMKgICNpbmNsdWRlIDxsaW51
eC9jbG9ja3NvdXJjZS5oPgo+Pj4gKyNpbmNsdWRlIDxsaW51eC9rdm1faG9zdC5oPgo+Pj4gIMKg
ICNpbmNsdWRlIDxsaW51eC9vZi5oPgo+Pj4gIMKgICNpbmNsdWRlIDxsaW51eC9wZXJmL2FybV9w
bXUuaD4KPj4+ICDCoCAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+Cj4+PiBAQCAt
NjQ3LDExICs2NDgsMjYgQEAgc3RhdGljIGlubGluZSBpbnQgYXJtdjhwbXVfZW5hYmxlX2NvdW50
ZXIoaW50IGlkeCkKPj4+ICDCoCDCoCBzdGF0aWMgaW5saW5lIHZvaWQgYXJtdjhwbXVfZW5hYmxl
X2V2ZW50X2NvdW50ZXIoc3RydWN0IHBlcmZfZXZlbnQKPj4+ICpldmVudCkKPj4+ICDCoCB7Cj4+
PiArwqDCoMKgIHN0cnVjdCBwZXJmX2V2ZW50X2F0dHIgKmF0dHIgPSAmZXZlbnQtPmF0dHI7Cj4+
PiAgwqDCoMKgwqDCoCBpbnQgaWR4ID0gZXZlbnQtPmh3LmlkeDsKPj4+ICvCoMKgwqAgaW50IGZs
YWdzID0gMDsKPj4+ICvCoMKgwqAgdTMyIGNvdW50ZXJfYml0cyA9IEJJVChBUk1WOF9JRFhfVE9f
Q09VTlRFUihpZHgpKTsKPj4+ICDCoCAtwqDCoMKgIGFybXY4cG11X2VuYWJsZV9jb3VudGVyKGlk
eCk7Cj4+PiAgwqDCoMKgwqDCoCBpZiAoYXJtdjhwbXVfZXZlbnRfaXNfY2hhaW5lZChldmVudCkp
Cj4+PiAtwqDCoMKgwqDCoMKgwqAgYXJtdjhwbXVfZW5hYmxlX2NvdW50ZXIoaWR4IC0gMSk7Cj4+
PiArwqDCoMKgwqDCoMKgwqAgY291bnRlcl9iaXRzIHw9IEJJVChBUk1WOF9JRFhfVE9fQ09VTlRF
UihpZHggLSAxKSk7Cj4+PiArCj4+PiArwqDCoMKgIGlmICghYXR0ci0+ZXhjbHVkZV9ob3N0KQo+
Pj4gK8KgwqDCoMKgwqDCoMKgIGZsYWdzIHw9IEtWTV9QTVVfRVZFTlRTX0hPU1Q7Cj4+PiArwqDC
oMKgIGlmICghYXR0ci0+ZXhjbHVkZV9ndWVzdCkKPj4+ICvCoMKgwqDCoMKgwqDCoCBmbGFncyB8
PSBLVk1fUE1VX0VWRU5UU19HVUVTVDsKPj4+ICsKPj4+ICvCoMKgwqAga3ZtX3NldF9wbXVfZXZl
bnRzKGNvdW50ZXJfYml0cywgZmxhZ3MpOwo+Pj4gKwo+Pj4gK8KgwqDCoCBpZiAoIWF0dHItPmV4
Y2x1ZGVfaG9zdCkgewo+Pj4gK8KgwqDCoMKgwqDCoMKgIGFybXY4cG11X2VuYWJsZV9jb3VudGVy
KGlkeCk7Cj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKGFybXY4cG11X2V2ZW50X2lzX2NoYWluZWQo
ZXZlbnQpKQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYXJtdjhwbXVfZW5hYmxlX2NvdW50
ZXIoaWR4IC0gMSk7Cj4+PiArwqDCoMKgIH0KPj4+ICDCoCB9Cj4+PiAgwqAgwqAgc3RhdGljIGlu
bGluZSBpbnQgYXJtdjhwbXVfZGlzYWJsZV9jb3VudGVyKGludCBpZHgpCj4+PiBAQCAtNjY0LDEx
ICs2ODAsMjAgQEAgc3RhdGljIGlubGluZSBpbnQgYXJtdjhwbXVfZGlzYWJsZV9jb3VudGVyKGlu
dCBpZHgpCj4+PiAgwqAgc3RhdGljIGlubGluZSB2b2lkIGFybXY4cG11X2Rpc2FibGVfZXZlbnRf
Y291bnRlcihzdHJ1Y3QgcGVyZl9ldmVudAo+Pj4gKmV2ZW50KQo+Pj4gIMKgIHsKPj4+ICDCoMKg
wqDCoMKgIHN0cnVjdCBod19wZXJmX2V2ZW50ICpod2MgPSAmZXZlbnQtPmh3Owo+Pj4gK8KgwqDC
oCBzdHJ1Y3QgcGVyZl9ldmVudF9hdHRyICphdHRyID0gJmV2ZW50LT5hdHRyOwo+Pj4gIMKgwqDC
oMKgwqAgaW50IGlkeCA9IGh3Yy0+aWR4Owo+Pj4gK8KgwqDCoCB1MzIgY291bnRlcl9iaXRzID0g
QklUKEFSTVY4X0lEWF9UT19DT1VOVEVSKGlkeCkpOwo+Pj4gIMKgIMKgwqDCoMKgwqAgaWYgKGFy
bXY4cG11X2V2ZW50X2lzX2NoYWluZWQoZXZlbnQpKQo+Pj4gLcKgwqDCoMKgwqDCoMKgIGFybXY4
cG11X2Rpc2FibGVfY291bnRlcihpZHggLSAxKTsKPj4+IC3CoMKgwqAgYXJtdjhwbXVfZGlzYWJs
ZV9jb3VudGVyKGlkeCk7Cj4+PiArwqDCoMKgwqDCoMKgwqAgY291bnRlcl9iaXRzIHw9IEJJVChB
Uk1WOF9JRFhfVE9fQ09VTlRFUihpZHggLSAxKSk7Cj4+PiArCj4+PiArwqDCoMKgIGt2bV9jbHJf
cG11X2V2ZW50cyhjb3VudGVyX2JpdHMpOwo+Pj4gKwo+Pj4gK8KgwqDCoCBpZiAoIWF0dHItPmV4
Y2x1ZGVfaG9zdCkgewo+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmIChhcm12OHBtdV9ldmVudF9pc19j
aGFpbmVkKGV2ZW50KSkKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFybXY4cG11X2Rpc2Fi
bGVfY291bnRlcihpZHggLSAxKTsKPj4+ICvCoMKgwqDCoMKgwqDCoCBhcm12OHBtdV9kaXNhYmxl
X2NvdW50ZXIoaWR4KTsKPj4+ICvCoMKgwqAgfQo+Pgo+PiBTaG91bGRuJ3Qgd2UgZGlzYWJsZSB0
aGUgZXZlbnRzLCBpcnJlc3BlY3RpdmUgb2Ygd2hldGhlciBpdCBpcyBmb3IgaG9zdAo+PiBvci9h
bmQgZ3Vlc3QgPyBPdGhlcndpc2UgbG9va3MgZ29vZCB0byBtZS4KPj4KPiAKPiBJIG1hZGUgdGhl
IG9wcG9zaXRlIHJlbWFyayBvbiBvbmUgb2YgdGhlIGVhcmx5IHZlcnNpb24uIE15IHJlYXNvbmlu
ZyBpcwo+IHRoYXQsIGlmIHdlIHJlbHkgb24gdGhlIGh5cGVydmlzb3IgdG8gZW5hYmxlIGV2ZW50
IHRoYXQgZXhjbHVkZSB0aGUKPiBob3N0LCB3ZSBzaG91bGQgYWxzbyByZWx5IG9uIHRoZSBoeXBl
cnZpc29yIGRpc2FibGluZyB0aGVzZSBldmVudHMuCj4gCj4gQXQgbGVhc3QgaW4gbXkgbWluZCBp
dCBtYWtlcyBtb3JlIHNlbnNlIHRoaXMgd2F5LgoKQWghIG9rLiBNYWtlcyBzZW5zZS4gSSB3YXMg
dGhpbmtpbmcgYWJvdXQgc29tZXRoaW5nIHNpbWlsYXIgaW4gdGhlIHdheQp3ZSBhcHBseSB0aGUg
ZmlsdGVycyAoc2V0L2NscikgaW4gdGhlIEtWTSBob29rLiBJdCBtYXkgbWFrZSBzZW5zZSB0byBh
ZGQKaW4gYSBjb21tZW50LgoKU29ycnkgZm9yIHRoZSBub2lzZS4KClN1enVraQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBt
YWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
