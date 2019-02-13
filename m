Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB054C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:50:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97FC3222CF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u/+tEkpG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97FC3222CF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yaAxIieogQrQb+RMBs25wNUpfK8sQN/YD4NKKO4o03k=; b=u/+tEkpGKyy4zx
	0JcpWqZO5O4FiNj3ZT4p3/3cAWQ+p8fVx0cptJuoWZYpdHmsoLSfG/Y2s+dx4J22VugRIbYiH23gq
	/NKrzgw0GwL/rWqvToMjbmUmAkes6meqqoqBnY9BCBENvCmoLapgJOMu3wH+xmb4Tre/vyVhuz/Td
	uH0GPXSzkzF3dSfwY69gx9QSqp+iFDA3qR2NyXKltGi4OIUoqN+uh3hScdGmuDa6Fmm46ZMIlh37g
	W9P6Cnr3CuCNiWV+xpuOicx/Xmle1bTU6u160fgUwa/pEnib/5fx8Ahc/4+jh5TA9onbrWwUAqKeE
	sKLqeXEZ3pTGKh6OWGpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtxk8-0001M7-55; Wed, 13 Feb 2019 16:50:40 +0000
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtxk4-0001Lk-P6
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 16:50:38 +0000
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
 (envelope-from <bigeasy@linutronix.de>)
 id 1gtxk2-0007kV-Hp; Wed, 13 Feb 2019 17:50:34 +0100
Date: Wed, 13 Feb 2019 17:50:34 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [RFC PATCH] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
Message-ID: <20190213165034.mda5rdfwsxbcdtfa@linutronix.de>
References: <20190208165513.8435-1-julien.grall@arm.com>
 <20190213143029.ad2kzg7vtuo3zpjk@linutronix.de>
 <20190213153630.GK3567@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190213153630.GK3567@e103592.cambridge.arm.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_085036_953160_E6775BFC 
X-CRM114-Status: GOOD (  18.02  )
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
Cc: linux-rt-users@vger.kernel.org, ard.biesheuvel@linaro.org,
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 Julien Grall <julien.grall@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMjAxOS0wMi0xMyAxNTozNjozMCBbKzAwMDBdLCBEYXZlIE1hcnRpbiB3cm90ZToKPiBPbiBX
ZWQsIEZlYiAxMywgMjAxOSBhdCAwMzozMDoyOVBNICswMTAwLCBTZWJhc3RpYW4gQW5kcnplaiBT
aWV3aW9yIHdyb3RlOgo+ID4gT24gMjAxOS0wMi0wOCAxNjo1NToxMyBbKzAwMDBdLCBKdWxpZW4g
R3JhbGwgd3JvdGU6Cj4gPiA+IFdoZW4gdGhlIGtlcm5lbCBpcyBjb21waWxlZCB3aXRoIENPTkZJ
R19LRVJORUxfTU9ERV9ORU9OLCBzb21lIHBhcnQgb2YKPiA+ID4gdGhlIGtlcm5lbCBtYXkgYmUg
YWJsZSB0byB1c2UgRlBTSU1EL1NWRS4gVGhpcyBpcyBmb3IgaW5zdGFuY2UgdGhlIGNhc2UKPiA+
ID4gZm9yIGNyeXB0byBjb2RlLgo+ID4gPiAKPiA+ID4gQW55IHVzZSBvZiBGUFNJTUQvU1ZFIGlu
IHRoZSBrZXJuZWwgYXJlIGNsZWFybHkgbWFya2VkIGJ5IHVzaW5nIHRoZQo+ID4gPiBmdW5jdGlv
biBrZXJuZWxfbmVvbl97YmVnaW4sIGVuZH0uIEZ1cnRoZXJtb3JlLCB0aGlzIGNhbiBvbmx5IGJl
IHVzZWQKPiA+ID4gd2hlbiBtYXlfdXNlX3NpbWQoKSByZXR1cm5zIHRydWUuCj4gPiAKPiA+IFRo
aXMgaXMgZXF1YWwgd2hhdCB4ODYgaXMgY3VycmVudGx5IGRvaW5nLiBUaGUgbmFtaW5nIGlzIHNs
aWdodGx5Cj4gPiBkaWZmZXJlbnQsIHRoZXJlIGlzIGlycV9mcHVfdXNhYmxlKCkuCj4gCj4gWWVz
LCBJIHRoaW5rIGl0J3MgYmFzaWNhbGx5IHRoZSBzYW1lIGlkZWEuCj4gCj4gSXQncyBiZWVuIGV2
b2x2aW5nIGEgYml0IG9uIGJvdGggc2lkZXMsIGJ1dCBpcyBxdWl0ZSBzaW1pbGFyIG5vdy4KCkkg
dGhvdWdoIHRoYXQgdGhpcyBpcyBjb21wbGljYXRlZCBhbmQgd2FudGVkIHRvIHN1Ym1pdCBhIHBh
dGNoIHRvIHJlbW92ZQppcnFfZnB1X3VzYWJsZSgpIGFuZCBkaXNhYmxlIEJIIGFzIHBhcnQgb2Yg
a2VybmVsX2ZwdV9iZWdpbigpIChidXQgaGF2ZQpjdXJyZW50bHkgdGhlIG9ub3RoZXIgRlBVIHNl
cmllcyBvbmdvaW5nIHdoaWNoIEkgd2FudCB0byBmaW5pc2ggZmlyc3QpLgoK4oCmCj4gIlVzdWFs
bHkiIGlzIHByb2JhYmx5IG5vdCBnb29kIGVub3VnaCBpZiBhbm90aGVyIHRhc2sgY2FuIHJ1bjog
aWYgdGhlCj4gcHJlZW1wdGluZyB0YXNrIGVudGVycyB1c2Vyc3BhY2UgdGhlbiB0aGUgdmVjdG9y
IHJlZ2lzdGVycyBhcmUgbmVlZGVkCj4gZm9yIGl0cyB1c2UsIHdoaWNoIGlzIHRyaWNreSB0byBh
cnJhbmdlIGlmIHRoZSByZWdpc3RlcnMgYXJlIGN1cnJlbnRseQo+IGluIHVzZSBieSBjb250ZXh0
IHN3aXRjaCBsb2dpYyBydW5uaW5nIGluIHRoZSBmaXJzdCB0YXNrLgoKWWVzLgoKPiBNeSBjdXJy
ZW50IGZlZWxpbmcgaXMgdGhhdCB3ZSBwcm9iYWJseSBoYXZlIHRvIHN0aWNrIHdpdGgKPiBwcmVl
bXB0X2Rpc2FibGUoKSBoZXJlLCBidXQgaG9wZWZ1bGx5IHdlIGNhbiBnZXQgcmlkIG9mCj4gbG9j
YWxfYmhfZGlzYWJsZSgpIChhcyBwcm9wb3NlZCkgd2l0aCBubyBpbGwgZWZmZWN0cy4uLgo+IAo+
IERvZXMgdGhhdCBzb3VuZCBzZW5zaWJsZT8KCklmIHlvdSB3YW50IHRvIHN0aWNrIHdpdGggbWF5
X3VzZV9zaW1kKCkgdGhlbiB5ZXMuCgo+IENoZWVycwo+IC0tLURhdmUKClNlYmFzdGlhbgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtl
cm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5l
bAo=
