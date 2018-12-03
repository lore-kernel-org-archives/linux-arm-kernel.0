Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94423C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:05:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 640EE2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EaR1j5a/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 640EE2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DMzJhnEzVUkwpjtTOwhYyEGUAetv/x9W5pYqfc+0y7s=; b=EaR1j5a/bKmN21
	FCwaurjhC5BXDt4etpRuQBytGLAdWev4f5nYWUCw1PJRKnud8tUDzI9KMojzx0IFFWz5qiDElTcEG
	nVgX0+D7sB3bpt8B3R4jNlwtMJtI20SJa41dBNOwOznSJgm+NA9pH0mCpZLsZMlr2wOlQcffIbyLd
	3hjL4kyFwrVKx/AQFYHwHL0gKw7DSB6yvvdzxMKeRM0oRvM3su3ZUfvBfPbWRoZ7u50Q7QUQLMckk
	qbey72CO6N7SagJWdLsvi32zLdDbJpur7WPpgywLyuadHDnL/m/fSFNlORQGqENiPfKjjpSRlaiQF
	4Gz7J38hkMXCWRNK5O1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTvP8-0006Sg-1B; Mon, 03 Dec 2018 21:05:22 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTvP4-0006D2-3c
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 21:05:19 +0000
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7180A81DEB;
 Mon,  3 Dec 2018 21:05:06 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-55.bos.redhat.com [10.18.17.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5968D5D778;
 Mon,  3 Dec 2018 21:05:05 +0000 (UTC)
Subject: Re: [PATCH] clocksource/arm_arch_timer: fix a lockdep warning
To: Qian Cai <cai@gmx.us>, mark.rutland@arm.com, marc.zyngier@arm.com
References: <1543865624-17301-1-git-send-email-cai@gmx.us>
 <11876b19-ec16-c7c5-4b21-c45c2b0f7244@redhat.com>
 <1543869063.12945.46.camel@gmx.us>
From: Waiman Long <longman@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=longman@redhat.com; prefer-encrypt=mutual; keydata=
 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
 weim8xU=
Organization: Red Hat
Message-ID: <b225470d-6c32-0697-6a39-6b20246d4f90@redhat.com>
Date: Mon, 3 Dec 2018 16:05:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1543869063.12945.46.camel@gmx.us>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Mon, 03 Dec 2018 21:05:07 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_130518_196926_8ED73AC4 
X-CRM114-Status: GOOD (  22.59  )
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
Cc: peterz@infradead.org, daniel.lezcano@linaro.org,
 linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTIvMDMvMjAxOCAwMzozMSBQTSwgUWlhbiBDYWkgd3JvdGU6Cj4gT24gTW9uLCAyMDE4LTEy
LTAzIGF0IDE1OjA3IC0wNTAwLCBXYWltYW4gTG9uZyB3cm90ZToKPj4gT24gMTIvMDMvMjAxOCAw
MjozMyBQTSwgUWlhbiBDYWkgd3JvdGU6Cj4+PiBCb290aW5nIHRoaXMgSHVhd2VpIFRhaVNoYW4g
MjI4MCBhcm02NCBzZXJ2ZXIgZ2VuZXJhdGVkIHRoaXMgbG9ja2RlcAo+Pj4gd2FybmluZy4KPj4+
Cj4+PiBbwqDCoMKgwqAwLjAwMDAwMF3CoMKgbG9ja2RlcF9hc3NlcnRfY3B1c19oZWxkKzB4NTAv
MHg2MAo+Pj4gW8KgwqDCoMKgMC4wMDAwMDBdwqDCoHN0YXRpY19rZXlfZW5hYmxlX2NwdXNsb2Nr
ZWQrMHgzMC8weGU4Cj4+PiBbwqDCoMKgwqAwLjAwMDAwMF3CoMKgYXJjaF90aW1lcl9jaGVja19v
b2xfd29ya2Fyb3VuZCsweDEyOC8weDJkMAo+Pj4gW8KgwqDCoMKgMC4wMDAwMDBdwqDCoGFyY2hf
dGltZXJfYWNwaV9pbml0KzB4Mjc0LzB4NmFjCj4+PiBbwqDCoMKgwqAwLjAwMDAwMF3CoMKgYWNw
aV90YWJsZV9wYXJzZSsweDFhYy8weDIxOAo+Pj4gW8KgwqDCoMKgMC4wMDAwMDBdwqDCoF9fYWNw
aV9wcm9iZV9kZXZpY2VfdGFibGUrMHgxNjQvMHgxZWMKPj4+IFvCoMKgwqDCoDAuMDAwMDAwXcKg
wqB0aW1lcl9wcm9iZSsweDFiYy8weDI1NAo+Pj4gW8KgwqDCoMKgMC4wMDAwMDBdwqDCoHRpbWVf
aW5pdCsweDQ0LzB4OTgKPj4+IFvCoMKgwqDCoDAuMDAwMDAwXcKgwqBzdGFydF9rZXJuZWwrMHg0
ZWMvMHg3ZDQKPj4+Cj4+PiBUaGlzIGlzIGR1ZSB0byB0aGUgY29tbWl0IGNiNTM4MjY3ZWExZSAo
Imp1bXBfbGFiZWwvbG9ja2RlcDogQXNzZXJ0IHdlIGhvbGQKPj4+IHRoZSBob3RwbHVnIGxvY2sg
Zm9yIF9jcHVzbG9ja2VkKCkgb3BlcmF0aW9ucyIpLiBUaGVyZWZvcmUsIGl0IHdpbGwgY2hlY2sK
Pj4+IGlmIGl0IGlzIHJlYWxseSBpbiB0aGUgQ1BVIGhvdHBsdWcgcGF0aCBvciBub3QsIGFuZCB3
b3JrIGFyb3VuZCB0aGlzCj4+PiBwcm9ibGVtIGJ5IHVzaW5nIGNwdXNfcmVhZF90cnlsb2NrKCku
IFRoZSBjaGFuY2Ugb2Ygbm90IGdldHRpbmcgdGhlIHJlYWQKPj4+IGxvY2sgaXMgdmVyeSBzbWFs
bC4gSWYgdGhhdCBoYXBwZW5zLCBpdCB3aWxsIHJlcG9ydCBhIGxvY2tkZXAgd2FybmluZyBhdAo+
Pj4gbW9zdC4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBRaWFuIENhaSA8Y2FpQGdteC51cz4KPj4+
IC0tLQo+Pj4gwqBkcml2ZXJzL2Nsb2Nrc291cmNlL2FybV9hcmNoX3RpbWVyLmMgfCA5ICsrKysr
KysrKwo+Pj4gwqAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspCj4+Pgo+Pj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvY2xvY2tzb3VyY2UvYXJtX2FyY2hfdGltZXIuYwo+Pj4gYi9kcml2ZXJz
L2Nsb2Nrc291cmNlL2FybV9hcmNoX3RpbWVyLmMKPj4+IGluZGV4IDlhN2Q0ZGMuLjVjOWFjYmQg
MTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2Nsb2Nrc291cmNlL2FybV9hcmNoX3RpbWVyLmMKPj4+
ICsrKyBiL2RyaXZlcnMvY2xvY2tzb3VyY2UvYXJtX2FyY2hfdGltZXIuYwo+Pj4gQEAgLTQ5Nywx
MSArNDk3LDIwIEBAIHZvaWQgYXJjaF90aW1lcl9lbmFibGVfd29ya2Fyb3VuZChjb25zdCBzdHJ1
Y3QKPj4+IGFyY2hfdGltZXJfZXJyYXR1bV93b3JrYXJvdW5kICp3YQo+Pj4gwqAJCQlwZXJfY3B1
KHRpbWVyX3Vuc3RhYmxlX2NvdW50ZXJfd29ya2Fyb3VuZCwgaSkgPSB3YTsKPj4+IMKgCX0KPj4+
IMKgCj4+PiArI2lmZGVmIENPTkZJR19IT1RQTFVHX0NQVQo+PiBJZiBIT1RQTFVHX0NQVSBpc24n
dCBkZWZpbmVkLCBhbGwgdGhlIGNwdXNfbG9jaygpIGFuZCByZWxhdGVkIGZ1bmN0aW9ucwo+PiBh
cmUganVzdCBuby1vcC4gWW91IGRvbid0IG5lZWQgdG8gdXNlIGNvbmRpdGlvbmFsIGNvbXBpbGF0
aW9uIGRpcmVjdGl2ZQo+PiBoZXJlLgo+IE1ha2Ugc2Vuc2UuCj4KPj4+ICsJaSA9IDA7Cj4+PiAr
Cj4+PiDCoAkvKgo+Pj4gwqAJwqAqIFVzZSB0aGUgbG9ja2VkIHZlcnNpb24sIGFzIHdlJ3JlIGNh
bGxlZCBmcm9tIHRoZSBDUFUKPj4+IMKgCcKgKiBob3RwbHVnIGZyYW1ld29yay4gT3RoZXJ3aXNl
LCB3ZSBlbmQtdXAgaW4gZGVhZGxvY2stbGFuZC4KPj4+IMKgCcKgKi8KPj4gSSB0aGluayB0aGUg
bWFpbiBwcm9ibGVtIGlzIHRoZSBhYm92ZSBjb21tZW50IG1heSBub3QgYmUgdHJ1ZSBhbnltb3Jl
IG9yCj4+IGlzIG9ubHkgb2NjYXNpb25hbGx5IHRydWUuIFdlIG5lZWQgdG8gYXVkaXQgdGhlIGNv
ZGUgdG8gZmluZCB0aGUgcm9vdCBjYXVzZS4KPiBUaGlzIHdhcyBhIGNvbW1pdCBpbnRyb2R1Y2Vk
IGluIEF1Zy4gMjAxNywgNDUwZjk2ODlmMjk0Cj4gKGNsb2Nrc291cmNlL2FybV9hcmNoX3RpbWVy
OiBVc2Ugc3RhdGljX2JyYW5jaF9lbmFibGVfY3B1c2xvY2tlZCgpKSB3aGljaAo+IGJhc2ljYWxs
eSBkcm9wIHRoZSBjcHVzX3JlYWRfbG9jaygpLiBNYXkgSSBhc2sgd2hhdCBjaGFuZ2VzIG1hZGUg
eW91IHRoaW5rIHRoZQo+IGFib3ZlIGNvbW1lbnQgaW5jb3JyZWN0IG5vdz8KPgoKSWYgdGhlIGFi
b3ZlIGNvbW1lbnQgaXMgdHJ1ZSwgeW91IHdvbid0IGhhdmUgdGhlIGxvY2tkZXAgc3BsYXQgaW4g
dGhlCmZpcnN0IHBsYWNlLiBJIHRoaW5rIHRoZSBtb3N0IGxpa2VseSBjYXNlIGlzIHRoYXQgdGhl
wqAgZnVuY3Rpb24gY2FuIGJlCmNhbGxlZCBmcm9tIGJvdGggYSBob3RwbHVnIHBhdGggYW5kIGEg
bm9uLWhvdHBsdWcgcGF0aC4gU28gdGhlIGNvbW1lbnQKbmVlZHMgdG8gYmUgdXBkYXRlZCB0byBy
ZWZsZWN0IHRoYXQuCgo+Pj4gKwlpID0gY3B1c19yZWFkX3RyeWxvY2soKTsKPj4+IMKgCXN0YXRp
Y19icmFuY2hfZW5hYmxlX2NwdXNsb2NrZWQoJmFyY2hfdGltZXJfcmVhZF9vb2xfZW5hYmxlZCk7
Cj4+PiArCWlmIChpKQo+Pj4gKwkJY3B1c19yZWFkX3VubG9jaygpOwo+PiBUaGlzIGlzIG5vdCB0
aGUgcmlnaHQgd2F5IG9mIGZpeGluZyB0aGUgbG9ja2RlcCBzcGxhc2guCj4+Cj4gSSBzaG91bGQg
aGFkIHNhaWQgaXQgaXMgYSB3b3JrYXJvdW5kLiBJIGFtIGFsbC1lYXJzIGZvciBhIHByb3BlciB3
YXkgdG8gZml4Cj4gdGhpcy4gV2hlbiB0aGUgYWJvdmUgY29tbWl0wqA0NTBmOTY4OWYyOTQgd2Fz
IG1lcmdlZCwgdGhlcmUgd2FzIG5vIGNiNTM4MjY3ZWExZQo+IHNvIG5vIGxvY2tkZXAgd2Fybmlu
Zy4KCkFzIGEgd29ya2Fyb3VuZCwgeW91IHNob3VsZCBiZXR0ZXIgZG9jdW1lbnQgdGhhdCBpbiB0
aGUgY29kZS4gVGhpbmtpbmcKYWJvdXQgaXQgc29tZSBtb3JlLCB5b3VyIHdvcmthcm91bmQgc2Vl
bXMgdG8gYmUgdmFsaWQuIFJlY3Vyc2l2ZQpjcHVzX3JlYWRfbG9jaygpIGlzIGFsbG93ZWQuIElm
IGl0IGlzIGNhbGxlZCBmcm9tIGEgaG90cGx1ZyBwYXRoLApjcHVzX3dyaXRlX2xvY2soKSBzaG91
bGQgaGF2ZSBiZWVuIHRha2VuIGFuZCBjcHVzX3JlYWRfdHJ5bG9jaygpIHdpbGwKZmFpbGVkLiBP
ZiBjb3Vyc2UsIHdlIHdpbGwgaGF2ZSB0byBhc3N1bWUgdGhhdCB0aGUgY3VycmVudCBDUFUgaXMg
dGhlCm9uZSB0aGF0IGhhcyB0YWtlbiB0aGUgd3JpdGUgbG9jayBpbiB0aGlzIGNhc2UuCgpDaGVl
cnMsCkxvbmdtYW4KCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LWFybS1rZXJuZWwK
