Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56887C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:31:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23B4B2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RPUyCggD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B4B2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3Upyz9ajKzoTtr+hpzpxgRhnTD7XRY4fGWoWIjIHBe4=; b=RPUyCggDGcPO6i
	hQNMMjWcYViwrP5OxhQi4jxYOA6IXiN5tEFxVLL9tj8wmR3ShymMoBThCKheU26yqgVKXClqxr/St
	bw8JN0Lz9L0ysPq0PBRGO51QD/LYvZUaCtrtCB6+n8jGdvL3qwZgBbFAOPTWJYWY7962XZRll5oZl
	3YSFN5mgp5nAAkUJsbPSdtRlTcn6oEjK6mbdbPKMyh9TtlPfGTn2Ef9FgT2zMgZykmKse4qA2TupM
	qzlsd82BrdbX85I0ad/sau0x5VXGkLNAnGicVOtl6dU2UFfXiWplVJmMq9/mSiulJhK07/CEIGr+b
	nmS7zLVDw4mlGvAmEMzw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTusS-0000ex-7c; Mon, 03 Dec 2018 20:31:36 +0000
Received: from mout.gmx.net ([212.227.17.22])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTusO-0000dm-3k
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 20:31:33 +0000
Received: from dhcp-41-57.bos.redhat.com ([66.187.233.206]) by mail.gmx.com
 (mrgmx103 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0MOwY7-1gXTe01chT-006M5J; Mon, 03 Dec 2018 21:31:07 +0100
Message-ID: <1543869063.12945.46.camel@gmx.us>
Subject: Re: [PATCH] clocksource/arm_arch_timer: fix a lockdep warning
From: Qian Cai <cai@gmx.us>
To: Waiman Long <longman@redhat.com>, mark.rutland@arm.com, 
 marc.zyngier@arm.com
Date: Mon, 03 Dec 2018 15:31:03 -0500
In-Reply-To: <11876b19-ec16-c7c5-4b21-c45c2b0f7244@redhat.com>
References: <1543865624-17301-1-git-send-email-cai@gmx.us>
 <11876b19-ec16-c7c5-4b21-c45c2b0f7244@redhat.com>
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
X-Provags-ID: V03:K1:4N5VGSVCq4tq82hEqR1vijJDuvoyRunQg7ziYIgclxgvGscz3W5
 uh1lCYLYSfxFbv4KfSUcl2YNLLnBnnMUyZxOGli7RVAQ7dH4Nz6U/xRDyDiw9st/dsTYGMw
 6N5XIpB6oisRpsvVxNLpmZC218mt3YWXM6wREya5gOMQ81wKoeLyuqSEEUVO/i6YKAMGjiw
 afcuon/PLHCVDoCoKcZvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:njGd+fk9Eao=:DrkSTggsAEnLTC6IrZxusU
 319Xtqwvu1nnXboZbML63FaKveAvX3EIsZuDpbIhlW6PiwHvMsTaj9VvTRi5XvN0DEr10Oujr
 FM9qAS3sDG/hojbo6E9RDqHrIgeCjvj7kVXQT4iBb1l5Xj5u5gpXlPzrRaAjo0ng850y19oQo
 xzaZ29q1nQnD2Rab4uDtvQEOs69Q3JIgoZvR9lrrO4LHkbCMT2N95J/fSncibdGNCfwynZTgi
 /s6bXKOYwnCUodwISYQ777NFRVO1cf1mCG7OYSGxZMCtdICMjrd+OMM9HTbFgJ7RuqgTtHsXM
 doGCRsLvN1KVswgUgaEknvfCOnaiDNuBGOZH8htvVxaDFsYu5fc9tk4X6CpriAucFOcG1nfla
 zX7ZwfYw+Ky/rfvcpK8ui58USyC4up+0MDISrI26xFjH7BxCKc+VSCjqyEhFitqXWnrm1OvNK
 SGqL5Ha+ysuTeJup+yLjRXpqc9X2eOzhvxALmSr1x2CIfEsg00DOD6J1RtPnwPUsWdKU6XbJ2
 ZjwGpCbJ4y574qEMCelKMUKoZbME+UCbjqovysZGNCfW/2T66/ZYtqN+3VCe8XzyFin4Gez5o
 OZPta+iUMu6Om6EbvM6KExkQG22jgqy/AkrzGyUbQyE8iXBGCZAvGWg2BdGhN8rN96Gc4g0lS
 ZueSH+Wbq5cRy0E29ablrnv2Lkccb0GqNExJMvZEGw94cgBcWAxwhtj8nPSxLbVq3igIUm/MO
 wCRCwIqg5y45Ec2AQn1XVhY8vdKXbYiM+8Yo8LPaO9uoIoVfn/8lNpLaKXqVpDaUw/lkHqq3/
 IU9BrRK9nd/5ALL2FKbZ2Dg7vk6lnPffVDxdshPzEV5VvftrJ0IMaFSMVmmHkQq+zkjqSnXCN
 9oyUe1PcCZADHCwgh1fROfQIXAw3w8EzQx/pKlrLOKYeb4zbE5KlJ94kdnIo++
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_123132_464515_274EA303 
X-CRM114-Status: GOOD (  21.83  )
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

T24gTW9uLCAyMDE4LTEyLTAzIGF0IDE1OjA3IC0wNTAwLCBXYWltYW4gTG9uZyB3cm90ZToKPiBP
biAxMi8wMy8yMDE4IDAyOjMzIFBNLCBRaWFuIENhaSB3cm90ZToKPiA+IEJvb3RpbmcgdGhpcyBI
dWF3ZWkgVGFpU2hhbiAyMjgwIGFybTY0IHNlcnZlciBnZW5lcmF0ZWQgdGhpcyBsb2NrZGVwCj4g
PiB3YXJuaW5nLgo+ID4gCj4gPiBbwqDCoMKgwqAwLjAwMDAwMF3CoMKgbG9ja2RlcF9hc3NlcnRf
Y3B1c19oZWxkKzB4NTAvMHg2MAo+ID4gW8KgwqDCoMKgMC4wMDAwMDBdwqDCoHN0YXRpY19rZXlf
ZW5hYmxlX2NwdXNsb2NrZWQrMHgzMC8weGU4Cj4gPiBbwqDCoMKgwqAwLjAwMDAwMF3CoMKgYXJj
aF90aW1lcl9jaGVja19vb2xfd29ya2Fyb3VuZCsweDEyOC8weDJkMAo+ID4gW8KgwqDCoMKgMC4w
MDAwMDBdwqDCoGFyY2hfdGltZXJfYWNwaV9pbml0KzB4Mjc0LzB4NmFjCj4gPiBbwqDCoMKgwqAw
LjAwMDAwMF3CoMKgYWNwaV90YWJsZV9wYXJzZSsweDFhYy8weDIxOAo+ID4gW8KgwqDCoMKgMC4w
MDAwMDBdwqDCoF9fYWNwaV9wcm9iZV9kZXZpY2VfdGFibGUrMHgxNjQvMHgxZWMKPiA+IFvCoMKg
wqDCoDAuMDAwMDAwXcKgwqB0aW1lcl9wcm9iZSsweDFiYy8weDI1NAo+ID4gW8KgwqDCoMKgMC4w
MDAwMDBdwqDCoHRpbWVfaW5pdCsweDQ0LzB4OTgKPiA+IFvCoMKgwqDCoDAuMDAwMDAwXcKgwqBz
dGFydF9rZXJuZWwrMHg0ZWMvMHg3ZDQKPiA+IAo+ID4gVGhpcyBpcyBkdWUgdG8gdGhlIGNvbW1p
dCBjYjUzODI2N2VhMWUgKCJqdW1wX2xhYmVsL2xvY2tkZXA6IEFzc2VydCB3ZSBob2xkCj4gPiB0
aGUgaG90cGx1ZyBsb2NrIGZvciBfY3B1c2xvY2tlZCgpIG9wZXJhdGlvbnMiKS4gVGhlcmVmb3Jl
LCBpdCB3aWxsIGNoZWNrCj4gPiBpZiBpdCBpcyByZWFsbHkgaW4gdGhlIENQVSBob3RwbHVnIHBh
dGggb3Igbm90LCBhbmQgd29yayBhcm91bmQgdGhpcwo+ID4gcHJvYmxlbSBieSB1c2luZyBjcHVz
X3JlYWRfdHJ5bG9jaygpLiBUaGUgY2hhbmNlIG9mIG5vdCBnZXR0aW5nIHRoZSByZWFkCj4gPiBs
b2NrIGlzIHZlcnkgc21hbGwuIElmIHRoYXQgaGFwcGVucywgaXQgd2lsbCByZXBvcnQgYSBsb2Nr
ZGVwIHdhcm5pbmcgYXQKPiA+IG1vc3QuCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IFFpYW4gQ2Fp
IDxjYWlAZ214LnVzPgo+ID4gLS0tCj4gPiDCoGRyaXZlcnMvY2xvY2tzb3VyY2UvYXJtX2FyY2hf
dGltZXIuYyB8IDkgKysrKysrKysrCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMo
KykKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xvY2tzb3VyY2UvYXJtX2FyY2hfdGlt
ZXIuYwo+ID4gYi9kcml2ZXJzL2Nsb2Nrc291cmNlL2FybV9hcmNoX3RpbWVyLmMKPiA+IGluZGV4
IDlhN2Q0ZGMuLjVjOWFjYmQgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2Nsb2Nrc291cmNlL2Fy
bV9hcmNoX3RpbWVyLmMKPiA+ICsrKyBiL2RyaXZlcnMvY2xvY2tzb3VyY2UvYXJtX2FyY2hfdGlt
ZXIuYwo+ID4gQEAgLTQ5NywxMSArNDk3LDIwIEBAIHZvaWQgYXJjaF90aW1lcl9lbmFibGVfd29y
a2Fyb3VuZChjb25zdCBzdHJ1Y3QKPiA+IGFyY2hfdGltZXJfZXJyYXR1bV93b3JrYXJvdW5kICp3
YQo+ID4gwqAJCQlwZXJfY3B1KHRpbWVyX3Vuc3RhYmxlX2NvdW50ZXJfd29ya2Fyb3VuZCwgaSkg
PSB3YTsKPiA+IMKgCX0KPiA+IMKgCj4gPiArI2lmZGVmIENPTkZJR19IT1RQTFVHX0NQVQo+IAo+
IElmIEhPVFBMVUdfQ1BVIGlzbid0IGRlZmluZWQsIGFsbCB0aGUgY3B1c19sb2NrKCkgYW5kIHJl
bGF0ZWQgZnVuY3Rpb25zCj4gYXJlIGp1c3Qgbm8tb3AuIFlvdSBkb24ndCBuZWVkIHRvIHVzZSBj
b25kaXRpb25hbCBjb21waWxhdGlvbiBkaXJlY3RpdmUKPiBoZXJlLgoKTWFrZSBzZW5zZS4KCj4g
Cj4gPiArCWkgPSAwOwo+ID4gKwo+ID4gwqAJLyoKPiA+IMKgCcKgKiBVc2UgdGhlIGxvY2tlZCB2
ZXJzaW9uLCBhcyB3ZSdyZSBjYWxsZWQgZnJvbSB0aGUgQ1BVCj4gPiDCoAnCoCogaG90cGx1ZyBm
cmFtZXdvcmsuIE90aGVyd2lzZSwgd2UgZW5kLXVwIGluIGRlYWRsb2NrLWxhbmQuCj4gPiDCoAnC
oCovCj4gCj4gSSB0aGluayB0aGUgbWFpbiBwcm9ibGVtIGlzIHRoZSBhYm92ZSBjb21tZW50IG1h
eSBub3QgYmUgdHJ1ZSBhbnltb3JlIG9yCj4gaXMgb25seSBvY2Nhc2lvbmFsbHkgdHJ1ZS4gV2Ug
bmVlZCB0byBhdWRpdCB0aGUgY29kZSB0byBmaW5kIHRoZSByb290IGNhdXNlLgoKVGhpcyB3YXMg
YSBjb21taXQgaW50cm9kdWNlZCBpbiBBdWcuIDIwMTcsIDQ1MGY5Njg5ZjI5NAooY2xvY2tzb3Vy
Y2UvYXJtX2FyY2hfdGltZXI6IFVzZSBzdGF0aWNfYnJhbmNoX2VuYWJsZV9jcHVzbG9ja2VkKCkp
IHdoaWNoCmJhc2ljYWxseSBkcm9wIHRoZSBjcHVzX3JlYWRfbG9jaygpLiBNYXkgSSBhc2sgd2hh
dCBjaGFuZ2VzIG1hZGUgeW91IHRoaW5rIHRoZQphYm92ZSBjb21tZW50IGluY29ycmVjdCBub3c/
Cgo+IAo+ID4gKwlpID0gY3B1c19yZWFkX3RyeWxvY2soKTsKPiA+IMKgCXN0YXRpY19icmFuY2hf
ZW5hYmxlX2NwdXNsb2NrZWQoJmFyY2hfdGltZXJfcmVhZF9vb2xfZW5hYmxlZCk7Cj4gPiArCWlm
IChpKQo+ID4gKwkJY3B1c19yZWFkX3VubG9jaygpOwo+IAo+IFRoaXMgaXMgbm90IHRoZSByaWdo
dCB3YXkgb2YgZml4aW5nIHRoZSBsb2NrZGVwIHNwbGFzaC4KPiAKCkkgc2hvdWxkIGhhZCBzYWlk
IGl0IGlzIGEgd29ya2Fyb3VuZC4gSSBhbSBhbGwtZWFycyBmb3IgYSBwcm9wZXIgd2F5IHRvIGZp
eAp0aGlzLiBXaGVuIHRoZSBhYm92ZSBjb21taXTCoDQ1MGY5Njg5ZjI5NCB3YXMgbWVyZ2VkLCB0
aGVyZSB3YXMgbm8gY2I1MzgyNjdlYTFlCnNvIG5vIGxvY2tkZXAgd2FybmluZy4KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
