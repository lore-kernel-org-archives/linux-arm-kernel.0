Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FBBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:36:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A5E820815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QDEF97q/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DiKoM6l6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A5E820815
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:From:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=slDI0UmdRek4kUIZCbLWaab4ctJMDt5vlZ5fJb7thm4=; b=QDEF97q/Ez+7RA
	JGAwQJrln89FtDUiB1haHtjlEVZ2GC6iAkIs7LvSy+nJEP47eUXBnmqdYh1B1OnloGR2o1n4uJxol
	9u8oIQvY2x/gR3bhJTiuajH83WvDMVTbuvNz4U8IC13ewFHiFupDSaZm/HNm9w/Tkm22R0HWqusUX
	7xqAbUICYUkVYXXkoL4wqdxPoscV8fwDCsMNIbGrMRZ8/8RZiJuIUv3Cayrpq/J3TOWMkCJjGLhH7
	+MocBjQmL4wqnHCVXgI552Me2lZQYOrya+VAn2fAOq6w7GBoh4Ct4vo8zmLV4JD4VyvJ3e8mRVr8v
	4mM6PVuniLYRW55OMHRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZa9W-0004Jp-IS; Wed, 19 Dec 2018 11:36:38 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZa9L-0004BP-QM
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 11:36:29 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBJBa0ak100312;
 Wed, 19 Dec 2018 05:36:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1545219360;
 bh=/Ah/aJZjc0Z81nv0Qrm01SHgfRA6HU6l97TW6X5tlrQ=;
 h=Subject:From:To:CC:References:Date:In-Reply-To;
 b=DiKoM6l6vNrmDPiJx+d1qmMoGIanHWru1jkpCxN7/3JKN2a3yhf9Yt5ma2VaQySkS
 2GbfRFksxDE0/ETlvcTxGaT1XgL0+HVknHbtAIe686Tw7KjiuqPfsiMds/+zrTv0uj
 liTtdR4Vup3FFRx8Qzy06E0x5lv6xTKczTxrvi+w=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBJBa0B1130655
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 19 Dec 2018 05:36:00 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 19
 Dec 2018 05:35:59 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 19 Dec 2018 05:35:59 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBJBZvJX015171;
 Wed, 19 Dec 2018 05:35:58 -0600
Subject: Re: [PATCH] ARM: dts: da850-evm: Correct the audio codec regulators
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
To: <tony@atomide.com>, <linux@armlinux.org.uk>, <nsekhar@ti.com>
References: <20181219101258.20763-1-peter.ujfalusi@ti.com>
Message-ID: <b82d43d5-8bb7-e9a7-5367-07589b8ebaee@ti.com>
Date: Wed, 19 Dec 2018 13:37:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181219101258.20763-1-peter.ujfalusi@ti.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_033627_931757_7EC8FF19 
X-CRM114-Status: GOOD (  21.79  )
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
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, bcousson@baylibre.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGksCgpPbiAxOS8xMi8yMDE4IDEyLjEyLCBQZXRlciBVamZhbHVzaSB3cm90ZToKPiBBZGQgdGhl
IGJvYXJkIGxldmVsIGZpeGVkIHJlZ3VsYXRvcnMgZm9yIDMuM1YgYW5kIDEuOFYgd2hpY2ggaXMg
dXNlZCB0bwo+IHBvd2VyIC0gYW1vbmcgb3RoZXIgdGhpbmdzIC0gdGhlIHRsdjMyMGFpYzMxMDYg
Y29kZWMuCj4gCj4gQXBhcnQgZnJvbSByZW1vdmluZyB0aGUgZm9sbG93aW5nIHdhcm5pbmcgZHVy
aW5nIGJvb3Q6Cj4gdGx2MzIwYWljM3gtY29kZWMgMC0wMDE4OiBUb28gaGlnaCBzdXBwbHkgdm9s
dGFnZShzKSBBVkREOiA1MDAwMDAwLCBEVkREOiA1MDAwMDAwCj4gCj4gV2l0aCB0aGUgY29ycmVj
dCB2b2x0YWdlcyB0aGUgZHJpdmVyIGNhbiBzZWxlY3QgY29ycmVjdCBPQ01WIHZhbHVlIHRvCj4g
cmVkdWNlIHBvcCBub2lzZS4KClBsZWFzZSBpZ25vcmUgdGhpcywgSSdsbCBzZW5kIGFuIHVwZGF0
ZS4KCj4gCj4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgVWpmYWx1c2kgPHBldGVyLnVqZmFsdXNpQHRp
LmNvbT4KPiAtLS0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvZGE4NTAtZXZtLmR0cyB8IDI5ICsrKysr
KysrKysrKysrKysrKysrKysrKystLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9k
YTg1MC1ldm0uZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvZGE4NTAtZXZtLmR0cwo+IGluZGV4IGY5
YTVhODIxMmM4NC4uOTk3YmVkZTJhNDhmIDEwMDY0NAo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRz
L2RhODUwLWV2bS5kdHMKPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9kYTg1MC1ldm0uZHRzCj4g
QEAgLTk0LDYgKzk0LDI4IEBACj4gIAkJcmVndWxhdG9yLWJvb3Qtb247Cj4gIAl9Owo+ICAKPiAr
CWJhc2Vib2FyZF8zdjM6IGZpeGVkcmVndWxhdG9yLTN2MyB7Cj4gKwkJLyogVFBTNzM3MDFEQ1Eg
Ki8KPiArCQljb21wYXRpYmxlID0gInJlZ3VsYXRvci1maXhlZCI7Cj4gKwkJcmVndWxhdG9yLW5h
bWUgPSAiYmFzZWJvYXJkXzN2MyI7Cj4gKwkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8MzMw
MDAwMD47Cj4gKwkJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MzMwMDAwMD47Cj4gKwkJdmlu
LXN1cHBseSA9IDwmdmJhdD47Cj4gKwkJcmVndWxhdG9yLWFsd2F5cy1vbjsKPiArCQlyZWd1bGF0
b3ItYm9vdC1vbjsKPiArCX07Cj4gKwo+ICsJYmFzZWJvYXJkXzF2ODogZml4ZWRyZWd1bGF0b3It
MXY4IHsKPiArCQkvKiBUUFM3MzcwMURDUSAqLwo+ICsJCWNvbXBhdGlibGUgPSAicmVndWxhdG9y
LWZpeGVkIjsKPiArCQlyZWd1bGF0b3ItbmFtZSA9ICJiYXNlYm9hcmRfMXY4IjsKPiArCQlyZWd1
bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwxODAwMDAwPjsKPiArCQlyZWd1bGF0b3ItbWF4LW1pY3Jv
dm9sdCA9IDwxODAwMDAwPjsKPiArCQl2aW4tc3VwcGx5ID0gPCZ2YmF0PjsKPiArCQlyZWd1bGF0
b3ItYWx3YXlzLW9uOwo+ICsJCXJlZ3VsYXRvci1ib290LW9uOwo+ICsJfTsKPiArCj4gIAliYWNr
bGlnaHRfbGNkOiBiYWNrbGlnaHQtcmVndWxhdG9yIHsKPiAgCQljb21wYXRpYmxlID0gInJlZ3Vs
YXRvci1maXhlZCI7Cj4gIAkJcmVndWxhdG9yLW5hbWUgPSAibGNkX2JhY2tsaWdodF9wd3IiOwo+
IEBAIC0yMTAsMTAgKzIzMiw5IEBACj4gIAo+ICAJCS8qIFJlZ3VsYXRvcnMgKi8KPiAgCQlJT1ZE
RC1zdXBwbHkgPSA8JnZkY2RjMl9yZWc+Owo+IC0JCS8qIERlcml2ZWQgZnJvbSBWQkFUOiBCYXNl
Ym9hcmQgMy4zViAvIDEuOFYgKi8KPiAtCQlBVkRELXN1cHBseSA9IDwmdmJhdD47Cj4gLQkJRFJW
REQtc3VwcGx5ID0gPCZ2YmF0PjsKPiAtCQlEVkRELXN1cHBseSA9IDwmdmJhdD47Cj4gKwkJQVZE
RC1zdXBwbHkgPSA8JmJhc2Vib2FyZF8zdjM+Owo+ICsJCURSVkRELXN1cHBseSA9IDwmYmFzZWJv
YXJkXzN2Mz47Cj4gKwkJRFZERC1zdXBwbHkgPSA8JmJhc2Vib2FyZF8xdjg+Owo+ICAJfTsKPiAg
CXRjYTY0MTY6IGdwaW9AMjAgewo+ICAJCWNvbXBhdGlibGUgPSAidGksdGNhNjQxNiI7Cj4gCgot
IFDDqXRlcgoKVGV4YXMgSW5zdHJ1bWVudHMgRmlubGFuZCBPeSwgUG9ya2thbGFua2F0dSAyMiwg
MDAxODAgSGVsc2lua2kuClktdHVubnVzL0J1c2luZXNzIElEOiAwNjE1NTIxLTQuIEtvdGlwYWlr
a2EvRG9taWNpbGU6IEhlbHNpbmtpCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
