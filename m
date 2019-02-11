Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AFEC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:20:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4E78218D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EfVB6X2M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E78218D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pKuu/35gH+PHnpr+VfZI0lwJzQqJZudugjukwFvXm2g=; b=EfVB6X2MdPjaxP
	P3YpllRUG/SrZ9qFdZ86RPhOmwA+K+kVMA2oJcN54gqJStlRjVc60Hxi99ZaL9RnkffL8NueEL3FJ
	Jlni/lbRC9pHd/RPhi8w1Ow5GEGIgQIInQVVP8CuMsERHb2cOVcQDV1I4Qkz6RrURTYoA2f2vft8x
	uYam3BrTh4PVYy8HmCwuzyVu5l5AuF//t6Ugu3TK9CB/5xL2qldi73aaBMY6D5hCuYvoTtX58lur5
	/MJPUCcTjfG9b976iAkDqLjh+Y7ehlLNhvZeYwVluVYW3UKb/wsWvicc8xhFwYh7LqWQzWVh24nY0
	EOoKDpL3lFAPFWgV5LxQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtBVf-0000Xi-Sy; Mon, 11 Feb 2019 13:20:31 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtBVc-0000Wq-J9
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 13:20:29 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9A6E80D;
 Mon, 11 Feb 2019 05:20:27 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 3F9553F557; Mon, 11 Feb 2019 05:20:25 -0800 (PST)
Subject: Re: [RESEND PATCH v2 28/33] ARM: davinci: cp-intc: unify error
 handling
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190211122606.8662-1-brgl@bgdev.pl>
 <20190211122606.8662-29-brgl@bgdev.pl>
 <7b494951-7b37-3ee5-5ece-f486b7a566fe@arm.com>
 <CAMpxmJVeQe7sxfharvA8REsOdmeaQUr2f1ByJwHCc5NnaFYEsw@mail.gmail.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <16f8fc15-2522-f1ef-0550-90802b09e9bf@arm.com>
Date: Mon, 11 Feb 2019 13:20:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAMpxmJVeQe7sxfharvA8REsOdmeaQUr2f1ByJwHCc5NnaFYEsw@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_052028_649876_D71588EC 
X-CRM114-Status: GOOD (  15.47  )
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
Cc: David Lechner <david@lechnology.com>, Kevin Hilman <khilman@kernel.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
 LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 arm-soc <linux-arm-kernel@lists.infradead.org>,
 Jason Cooper <jason@lakedaemon.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTEvMDIvMjAxOSAxMzoxMCwgQmFydG9zeiBHb2xhc3pld3NraSB3cm90ZToKPiBwb24uLCAx
MSBsdXQgMjAxOSBvIDE0OjA4IE1hcmMgWnluZ2llciA8bWFyYy56eW5naWVyQGFybS5jb20+IG5h
cGlzYcWCKGEpOgo+Pgo+PiBPbiAxMS8wMi8yMDE5IDEyOjI2LCBCYXJ0b3N6IEdvbGFzemV3c2tp
IHdyb3RlOgo+Pj4gRnJvbTogQmFydG9zeiBHb2xhc3pld3NraSA8YmdvbGFzemV3c2tpQGJheWxp
YnJlLmNvbT4KPj4+Cj4+PiBVc2UgV0FSTl9PTigpIG9uIGVueSBlcnJvciBpbiBjcC1pbnRjIGlu
aXRpYWxpemF0aW9uIGFuZCBkcm9wIGFsbAo+Pj4gY3VzdG9tIGVycm9yIG1lc3NhZ2VzLgo+Pj4K
Pj4+IFNpZ25lZC1vZmYtYnk6IEJhcnRvc3ogR29sYXN6ZXdza2kgPGJnb2xhc3pld3NraUBiYXls
aWJyZS5jb20+Cj4+PiBSZXZpZXdlZC1ieTogRGF2aWQgTGVjaG5lciA8ZGF2aWRAbGVjaG5vbG9n
eS5jb20+Cj4+PiAtLS0KPj4+ICBhcmNoL2FybS9tYWNoLWRhdmluY2kvY3BfaW50Yy5jIHwgMTAg
KysrLS0tLS0tLQo+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDcgZGVsZXRp
b25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtZGF2aW5jaS9jcF9pbnRj
LmMgYi9hcmNoL2FybS9tYWNoLWRhdmluY2kvY3BfaW50Yy5jCj4+PiBpbmRleCBmMzc4N2FlNGNk
YmQuLmMxZWZiOTM5MDY1NSAxMDA2NDQKPj4+IC0tLSBhL2FyY2gvYXJtL21hY2gtZGF2aW5jaS9j
cF9pbnRjLmMKPj4+ICsrKyBiL2FyY2gvYXJtL21hY2gtZGF2aW5jaS9jcF9pbnRjLmMKPj4+IEBA
IC0yMDAsMjAgKzIwMCwxNiBAQCBkYXZpbmNpX2NwX2ludGNfZG9faW5pdChjb25zdCBzdHJ1Y3Qg
ZGF2aW5jaV9jcF9pbnRjX2NvbmZpZyAqY29uZmlnLAo+Pj4gICAgICAgICAgICAgICAgICAgICAg
IERBVklOQ0lfQ1BfSU5UQ19DSEFOX01BUChvZmZzZXQpKTsKPj4+Cj4+PiAgICAgICBpcnFfYmFz
ZSA9IGlycV9hbGxvY19kZXNjcygtMSwgMCwgY29uZmlnLT5udW1faXJxcywgMCk7Cj4+PiAtICAg
ICBpZiAoaXJxX2Jhc2UgPCAwKSB7Cj4+PiAtICAgICAgICAgICAgIHByX3dhcm4oIkNvdWxkbid0
IGFsbG9jYXRlIElSUSBudW1iZXJzXG4iKTsKPj4+IC0gICAgICAgICAgICAgaXJxX2Jhc2UgPSAw
Owo+Pj4gLSAgICAgfQo+Pj4gKyAgICAgaWYgKFdBUk5fT04oaXJxX2Jhc2UgPCAwKSkKPj4+ICsg
ICAgICAgICAgICAgcmV0dXJuIGlycV9iYXNlOwo+Pj4KPj4+ICAgICAgIC8qIGNyZWF0ZSBhIGxl
Z2FjeSBob3N0ICovCj4+PiAgICAgICBkYXZpbmNpX2NwX2ludGNfaXJxX2RvbWFpbiA9IGlycV9k
b21haW5fYWRkX2xlZ2FjeSgKPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgbm9kZSwgY29uZmlnLT5udW1faXJxcywgaXJxX2Jhc2UsIDAsCj4+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICZkYXZpbmNpX2NwX2ludGNfaXJxX2RvbWFpbl9vcHMs
IE5VTEwpOwo+Pj4KPj4+IC0gICAgIGlmICghZGF2aW5jaV9jcF9pbnRjX2lycV9kb21haW4pIHsK
Pj4+IC0gICAgICAgICAgICAgcHJfZXJyKCJjcF9pbnRjOiBmYWlsZWQgdG8gYWxsb2NhdGUgaXJx
IGhvc3QhXG4iKTsKPj4+ICsgICAgIGlmIChXQVJOX09OKCFkYXZpbmNpX2NwX2ludGNfaXJxX2Rv
bWFpbikpCj4+PiAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOwo+Pj4gLSAgICAgfQo+Pj4K
Pj4+ICAgICAgIHNldF9oYW5kbGVfaXJxKGRhdmluY2lfY3BfaW50Y19oYW5kbGVfaXJxKTsKPj4+
Cj4+Pgo+Pgo+PiBJJ20gc29ycnksIGJ1dCBob3cgaXMgdHVybmluZyBhbiBleHBsaWNpdCBtZXNz
YWdlIGludG8gYSBsb25nIHN0YWNrCj4+IHRyYWNlIHJlYWxseSB1c2VmdWw/Cj4+Cj4gCj4gSWYg
YW55IG9mIHRoZXNlIGNhbGxzIGZhaWxzLCB0aGUgc3lzdGVtIGlzIGZyaWVkLiBJIGFzc3VtZWQg
dGhhdCBhCj4gc3RhY2sgdHJhY2Ugd2lsbCBwb2ludCB1c2VycyBzdHJhaWdodCB0byB0aGUgb2Zm
ZW5kaW5nIGxpbmUuCgpUaGUgbWVzc2FnZSBpcyBhIHJlYWxseSBnb29kIGNsdWUsIGJlY2F1c2Ug
eW91IGNhbiBhY3R1YWxseSBncmVwIGZvciBpdCwKYW5kIGl0IGdpdmVzIHlvdSB0aGUgZXhhY3Qg
c3ltcHRvbS4gWW91IGFyZSBhY3RpdmVseSByZW1vdmluZwppbmZvcm1hdGlvbiBoZXJlLgoKCU0u
Ci0tIApKYXp6IGlzIG5vdCBkZWFkLiBJdCBqdXN0IHNtZWxscyBmdW5ueS4uLgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBt
YWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
