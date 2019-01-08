Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355EDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:51:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00C7A20827
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tHY4Y9uh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C7A20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aPqXUzCdB1VOVLGWvRCw9DnttGO6zxdiBFULRinOwjY=; b=tHY4Y9uhSNXJvg
	aCkDoEohUA6Qn+DHT6d/W+rWCAz2tt0qTI0Lp5dzuMOF32NRO8YjeOPsTIAcS/rx3NRzkQ345yMlk
	WvLdkpbFA1uSZ8CFUfLQKpTgKjwl2t5B1veaCpcUOgRX9v3PhUzJuHpSQi2MtnsjcwegkKgv76p3K
	ucK3j94nOzR/PkgE++KmvUc1kAvlt9fZbs4t/8EUgyQjfG1gfV+XYPK+BLqKoeJqufj43mDZNcISA
	wEaIvdxiC3EpFYoKSbuPG8rz+FmjD9tLxklh5GtCbMaYiZAX5PfkoYdyB4Q8RrxmXE5jPo2cJq4QY
	hbAxlJm/hXk6GixCTnXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggtf4-0001SX-7x; Tue, 08 Jan 2019 15:51:26 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggtf0-0001S1-PA
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 15:51:24 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20DC380D;
 Tue,  8 Jan 2019 07:51:22 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 06FA03F5AF; Tue,  8 Jan 2019 07:51:19 -0800 (PST)
Subject: Re: [PATCH v8 12/26] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
To: Dave Martin <Dave.Martin@arm.com>, Julien Thierry <julien.thierry@arm.com>
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
 <1546956464-48825-13-git-send-email-julien.thierry@arm.com>
 <20190108153957.GA5840@e103592.cambridge.arm.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <8cae8016-d2c7-3c86-9832-f4278d42ea21@arm.com>
Date: Tue, 8 Jan 2019 15:51:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190108153957.GA5840@e103592.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_075122_829349_9809A4D2 
X-CRM114-Status: GOOD (  17.88  )
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
 will.deacon@arm.com, linux-kernel@vger.kernel.org, christoffer.dall@arm.com,
 james.morse@arm.com, Oleg Nesterov <oleg@redhat.com>, joel@joelfernandes.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMDgvMDEvMjAxOSAxNTo0MCwgRGF2ZSBNYXJ0aW4gd3JvdGU6Cj4gT24gVHVlLCBKYW4gMDgs
IDIwMTkgYXQgMDI6MDc6MzBQTSArMDAwMCwgSnVsaWVuIFRoaWVycnkgd3JvdGU6Cj4+IEluc3Rl
YWQgZGlzYWJsaW5nIGludGVycnVwdHMgYnkgc2V0dGluZyB0aGUgUFNSLkkgYml0LCB1c2UgYSBw
cmlvcml0eQo+PiBoaWdoZXIgdGhhbiB0aGUgb25lIHVzZWQgZm9yIGludGVycnVwdHMgdG8gbWFz
ayB0aGVtIHZpYSBQTVIuCj4+Cj4+IFdoZW4gdXNpbmcgUE1SIHRvIGRpc2FibGUgaW50ZXJydXB0
cywgdGhlIHZhbHVlIG9mIFBNUiB3aWxsIGJlIHVzZWQKPj4gaW5zdGVhZCBvZiBQU1IuW0RBSUZd
IGZvciB0aGUgaXJxZmxhZ3MuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEp1bGllbiBUaGllcnJ5IDxq
dWxpZW4udGhpZXJyeUBhcm0uY29tPgo+PiBTdWdnZXN0ZWQtYnk6IERhbmllbCBUaG9tcHNvbiA8
ZGFuaWVsLnRob21wc29uQGxpbmFyby5vcmc+Cj4+IENjOiBDYXRhbGluIE1hcmluYXMgPGNhdGFs
aW4ubWFyaW5hc0Bhcm0uY29tPgo+PiBDYzogV2lsbCBEZWFjb24gPHdpbGwuZGVhY29uQGFybS5j
b20+Cj4+IENjOiBBcmQgQmllc2hldXZlbCA8YXJkLmJpZXNoZXV2ZWxAbGluYXJvLm9yZz4KPj4g
Q2M6IE9sZWcgTmVzdGVyb3YgPG9sZWdAcmVkaGF0LmNvbT4KPj4gLS0tCj4+ICBhcmNoL2FybTY0
L2luY2x1ZGUvYXNtL2VmaS5oICAgICAgfCAgMTEgKysrKwo+PiAgYXJjaC9hcm02NC9pbmNsdWRl
L2FzbS9pcnFmbGFncy5oIHwgMTIzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDEwNiBpbnNlcnRpb25zKCspLCAyOCBkZWxldGlvbnMo
LSkKPiAKPiBbLi4uXQo+IAo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9p
cnFmbGFncy5oIGIvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9pcnFmbGFncy5oCj4+IGluZGV4IDI0
NjkyZWQuLmZhM2IwNmYgMTAwNjQ0Cj4+IC0tLSBhL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vaXJx
ZmxhZ3MuaAo+PiArKysgYi9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL2lycWZsYWdzLmgKPj4gQEAg
LTE4LDcgKzE4LDkgQEAKPiAKPiBbLi4uXQo+IAo+PiAgc3RhdGljIGlubGluZSB2b2lkIGFyY2hf
bG9jYWxfaXJxX2VuYWJsZSh2b2lkKQo+PiAgewo+PiAtCWFzbSB2b2xhdGlsZSgKPj4gLQkJIm1z
cglkYWlmY2xyLCAjMgkJLy8gYXJjaF9sb2NhbF9pcnFfZW5hYmxlIgo+PiAtCQk6Cj4+ICsJdW5z
aWduZWQgbG9uZyB1bm1hc2tlZCA9IEdJQ19QUklPX0lSUU9OOwo+PiArCj4+ICsJYXNtIHZvbGF0
aWxlKEFMVEVSTkFUSVZFKAo+PiArCQkibXNyCWRhaWZjbHIsICMyCQkvLyBhcmNoX2xvY2FsX2ly
cV9lbmFibGVcbiIKPj4gKwkJIm5vcCIsCj4+ICsJCSJtc3JfcyAgIiBfX3N0cmluZ2lmeShTWVNf
SUNDX1BNUl9FTDEpICIsJTBcbiIKPj4gKwkJImRzYglzeSIsCj4gCj4gSSdtIHN0aWxsIG5vdCBj
b252aW5jZWQgdGhlc2UgZHNicyBhcmUgbmVlZGVkLgo+IAo+IFdpdGhvdXQgdGhlIGRzYiwgd2Ug
YXJlIHByb2JhYmx5IG5vdCBndWFyYW50ZWVkIHRvIHRha2UgYSBwZW5kaW5nCj4gaW50ZXJydXB0
IF9pbW1lZGlhdGVseV8gb24gdW5tYXNraW5nLCBidXQgSSdtIG5vdCBzdXJlIHRoYXQncyBhCj4g
cHJvYmxlbS4KPiAKPiBXaGF0IGdvZXMgd3JvbmcgaWYgd2Ugb21pdCB0aGVtPwoKVGhlbiB0aGUg
R0lDIGRvZXNuJ3Qga25vdyBpdCBjYW4gbm93IGRlbGl2ZXIgaW50ZXJydXB0cyBvZiBhIGxvd2Vy
CnByaW9yaXR5LiBPbmx5IGEgZHNiIGNhbiBndWFyYW50ZWUgdGhhdCB0aGUgR0lDJ3MgdmlldyBv
ZiBQTVIgd2lsbCBnZXQKdXBkYXRlZC4KClNlZSA5LjEuNiAoT2JzZXJ2YWJpbGl0eSBvZiB0aGUg
ZWZmZWN0cyBvZiBhY2Nlc3NlcyB0byB0aGUgR0lDCnJlZ2lzdGVycyksIHdoaWNoIHN0YXRlczoK
CjxxdW90ZT4KQXJjaGl0ZWN0dXJhbCBleGVjdXRpb24gb2YgYSBEU0IgaW5zdHJ1Y3Rpb24gZ3Vh
cmFudGVlcyB0aGF0CuKAlCBUaGUgbGFzdCB2YWx1ZSB3cml0dGVuIHRvIElDQ19QTVJfRUwxIG9y
IEdJQ0NfUE1SIGlzIG9ic2VydmVkIGJ5IHRoZQphc3NvY2lhdGVkIFJlZGlzdHJpYnV0b3IuCjwv
cXVvdGU+CgpTbyB5ZXMsIERTQiBpcyByZXF1aXJlZC4KClRoYW5rcywKCglNLgotLSAKSmF6eiBp
cyBub3QgZGVhZC4gSXQganVzdCBzbWVsbHMgZnVubnkuLi4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0
CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
