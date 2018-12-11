Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269EAC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:30:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4CF92082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CupOVgTr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4CF92082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bIL0PvbMK2nzgV1JogAM97Ka+otsnPVRtCIZl7QDtWc=; b=CupOVgTrd5iKlt
	CbGeqXby9A5uZ2vdLV8szzfwbJA0L9PTPGHgu5HSPUUQufmvJxDXeQJEVGFdJpm3m7tCtNah9lH1j
	l1FpkYNluVYaGewskjoIXPjyXR4kSe7QOu9yxP3J2fi+US4JgeVOYGr9EYH34IUoL7uUb6DGqOE5L
	jZLgwGMd4J4nSQ7osjWujOrUwAXoJS7MzG8Pej2+tupOX+z7LEZhsVzmuhyxvyxGIRjKuX98am7fk
	JibZgqK0iRwBXEaVFIHT8tzsdOOJ5vXUP9efVQMbSiSWRJUizOBvcjscxn/anRIzu2OaE8fU/6qd6
	y2ymweLMniRB271QvDRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWdRN-0005ZP-MF; Tue, 11 Dec 2018 08:30:53 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWdRK-0005Yn-03
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 08:30:51 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA3C315BF;
 Tue, 11 Dec 2018 00:30:47 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B0D33F614;
 Tue, 11 Dec 2018 00:30:47 -0800 (PST)
Date: Tue, 11 Dec 2018 09:30:45 +0100
From: Christoffer Dall <christoffer.dall@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/2] kvm/arm: skip MMIO insn after emulation
Message-ID: <20181211083045.GU30263@e113682-lin.lund.arm.com>
References: <20181109150711.45864-1-mark.rutland@arm.com>
 <20181109150711.45864-2-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181109150711.45864-2-mark.rutland@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_003050_043489_EFFDE3F5 
X-CRM114-Status: GOOD (  18.68  )
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
Cc: marc.zyngier@arm.com, peter.maydell@linaro.org, alex.bennee@linaro.org,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCBOb3YgMDksIDIwMTggYXQgMDM6MDc6MTBQTSArMDAwMCwgTWFyayBSdXRsYW5kIHdy
b3RlOgo+IFdoZW4gd2UgZW11bGF0ZSBhbiBNTUlPIGluc3RydWN0aW9uLCB3ZSBhZHZhbmNlIHRo
ZSBDUFUgc3RhdGUgd2l0aGluCj4gZGVjb2RlX2hzcigpLCBiZWZvcmUgZW11bGF0aW5nIHRoZSBp
bnN0cnVjdGlvbiBlZmZlY3RzLgo+IAo+IEhhdmluZyB0aGlzIGxvZ2ljIGluIGRlY29kZV9oc3Io
KSBpcyBvcGFxdWUsIGFuZCBhZHZhbmNpbmcgdGhlIHN0YXRlCj4gYmVmb3JlIGVtdWxhdGlvbiBp
cyBwcm9ibGVtYXRpYy4gSXQgZ2V0cyBpbiB0aGUgd2F5IG9mIGFwcGx5aW5nCj4gY29uc2lzdGVu
dCBzaW5nbGUtc3RlcCBsb2dpYywgYW5kIGl0IHByZXZlbnRzIHVzIGZyb20gYmVpbmcgYWJsZSB0
byBmYWlsCj4gYW4gTU1JTyBpbnN0cnVjdGlvbiB3aXRoIGEgc3luY2hyb25vdXMgZXhjZXB0aW9u
Lgo+IAo+IENsZWFuIHRoaXMgdXAgYnkgb25seSBhZHZhbmNpbmcgdGhlIENQVSBzdGF0ZSAqYWZ0
ZXIqIHRoZSBlZmZlY3RzIG9mIHRoZQo+IGluc3RydWN0aW9uIGFyZSBlbXVsYXRlZC4KPiAKPiBT
aWduZWQtb2ZmLWJ5OiBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPgo+IENjOiBB
bGV4IEJlbm7DqWUgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+Cj4gQ2M6IENocmlzdG9mZmVyIERh
bGwgPGNocmlzdG9mZmVyLmRhbGxAYXJtLmNvbT4KPiBDYzogTWFyYyBaeW5naWVyIDxtYXJjLnp5
bmdpZXJAYXJtLmNvbT4KPiBDYzogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8u
b3JnPgo+IC0tLQo+ICB2aXJ0L2t2bS9hcm0vbW1pby5jIHwgMTEgKysrKysrLS0tLS0KPiAgMSBm
aWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0t
Z2l0IGEvdmlydC9rdm0vYXJtL21taW8uYyBiL3ZpcnQva3ZtL2FybS9tbWlvLmMKPiBpbmRleCBk
YWM3Y2ViMWE2NzcuLjA4NDQzYTE1ZTZiZSAxMDA2NDQKPiAtLS0gYS92aXJ0L2t2bS9hcm0vbW1p
by5jCj4gKysrIGIvdmlydC9rdm0vYXJtL21taW8uYwo+IEBAIC0xMTcsNiArMTE3LDEyIEBAIGlu
dCBrdm1faGFuZGxlX21taW9fcmV0dXJuKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgc3RydWN0IGt2
bV9ydW4gKnJ1bikKPiAgCQl2Y3B1X3NldF9yZWcodmNwdSwgdmNwdS0+YXJjaC5tbWlvX2RlY29k
ZS5ydCwgZGF0YSk7Cj4gIAl9Cj4gIAo+ICsJLyoKPiArCSAqIFRoZSBNTUlPIGluc3RydWN0aW9u
IGlzIGVtdWxhdGVkIGFuZCBzaG91bGQgbm90IGJlIHJlLWV4ZWN1dGVkCj4gKwkgKiBpbiB0aGUg
Z3Vlc3QuCj4gKwkgKi8KPiArCWt2bV9za2lwX2luc3RyKHZjcHUsIGt2bV92Y3B1X3RyYXBfaWxf
aXMzMmJpdCh2Y3B1KSk7Cj4gKwo+ICAJcmV0dXJuIDA7Cj4gIH0KPiAgCj4gQEAgLTE0NCwxMSAr
MTUwLDYgQEAgc3RhdGljIGludCBkZWNvZGVfaHNyKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgYm9v
bCAqaXNfd3JpdGUsIGludCAqbGVuKQo+ICAJdmNwdS0+YXJjaC5tbWlvX2RlY29kZS5zaWduX2V4
dGVuZCA9IHNpZ25fZXh0ZW5kOwo+ICAJdmNwdS0+YXJjaC5tbWlvX2RlY29kZS5ydCA9IHJ0Owo+
ICAKPiAtCS8qCj4gLQkgKiBUaGUgTU1JTyBpbnN0cnVjdGlvbiBpcyBlbXVsYXRlZCBhbmQgc2hv
dWxkIG5vdCBiZSByZS1leGVjdXRlZAo+IC0JICogaW4gdGhlIGd1ZXN0Lgo+IC0JICovCj4gLQlr
dm1fc2tpcF9pbnN0cih2Y3B1LCBrdm1fdmNwdV90cmFwX2lsX2lzMzJiaXQodmNwdSkpOwo+ICAJ
cmV0dXJuIDA7Cj4gIH0KPiAgCj4gLS0gCj4gMi4xMS4wCj4gClJldmlld2VkLWJ5OiBDaHJpc3Rv
ZmZlciBEYWxsIDxjaHJpc3RvZmZlci5kYWxsQGFybS5jb20+CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
