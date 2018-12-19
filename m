Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D744C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:36:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A368520815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VzGuBYn4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LTZM1FCc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A368520815
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:From:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XsZEuSRpko9LRcEhI+QIDCfgxQtM0QvLZvHUN0II8Yo=; b=VzGuBYn4u5nuyb
	cUcaSW0Mawcz/iKmqax1JTLYI2CXITzUm9HDficwuVBWvogqoWWo0N9Y6Z0Rla20xvsk9JMIszIhI
	Uc0KSzC5Jix5B2qmpuGhMJ+QMsW0JyCh2bYPJB9fO1XQ9ll17cxlCabhuoBaSUrRq5KOLZUL54U1s
	twKX4Q9bFcnhVspU0KtZ2alZG8/WosYedEl2b1t0leps/MFrQO54zr2ihkXZnBlCph5hOpBoTR5/P
	hEERRy5/Xlji92Zhx+X6ojEj/ge1+U7XJFdPC3BcUJs4khZ/MsgFcNUwGd+JKAw70P+x1gb+/f+0/
	L1nnkvfqBzoZYB1nQS6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZa9O-0004Ci-N8; Wed, 19 Dec 2018 11:36:30 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZa9L-0004BV-Bs
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 11:36:28 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBJBaATt103314;
 Wed, 19 Dec 2018 05:36:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1545219370;
 bh=8ph5zF6NhMVyzrfvvQKULttybZjLjecQxYq9avjPZFU=;
 h=Subject:From:To:CC:References:Date:In-Reply-To;
 b=LTZM1FCcYg1Qvux5bX1+uWz1t5IrJqpMa4S7g5YztvOFefzU+cxQgrla6+tsg3CtR
 JgToYRfoFu5HkL1HDD/xFZxX3HBtoeMRwH7RLJmkzSxXii1KZZUhza6gKAombVuK+4
 DHkgP06IOcttaAX0886B2fynurWhxUiTuN15Tp68=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBJBaAXV122000
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 19 Dec 2018 05:36:10 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 19
 Dec 2018 05:36:10 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 19 Dec 2018 05:36:10 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBJBa8X8026552;
 Wed, 19 Dec 2018 05:36:08 -0600
Subject: Re: [PATCH] ARM: dts: da850-lcdk: Correct the audio codec regulators
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
To: <tony@atomide.com>, <linux@armlinux.org.uk>, <nsekhar@ti.com>
References: <20181219101305.20832-1-peter.ujfalusi@ti.com>
Message-ID: <d38cf58e-0bff-532b-a99c-e0e54b7bf810@ti.com>
Date: Wed, 19 Dec 2018 13:37:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181219101305.20832-1-peter.ujfalusi@ti.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_033627_507455_1BB33D76 
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
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, bcousson@baylibre.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CgpPbiAxOS8xMi8yMDE4IDEyLjEzLCBQZXRlciBVamZhbHVzaSB3cm90ZToKPiBBZGQgdGhlIGJv
YXJkIGxldmVsIGZpeGVkIHJlZ3VsYXRvcnMgZm9yIDMuM1YgYW5kIDEuOFYgd2hpY2ggaXMgdXNl
ZCB0bwo+IHBvd2VyIC0gYW1vbmcgb3RoZXIgdGhpbmdzIC0gdGhlIHRsdjMyMGFpYzMxMDYgY29k
ZWMuCj4gCj4gQXBhcnQgZnJvbSByZW1vdmluZyB0aGUgZm9sbG93aW5nIHdhcm5pbmcgZHVyaW5n
IGJvb3Q6Cj4gdGx2MzIwYWljM3gtY29kZWMgMC0wMDE4OiBJbnZhbGlkIHN1cHBseSB2b2x0YWdl
KHMpIEFWREQ6IC0yMiwgRFZERDogLTIyCj4gCj4gV2l0aCB0aGUgY29ycmVjdCB2b2x0YWdlcyB0
aGUgZHJpdmVyIGNhbiBzZWxlY3QgY29ycmVjdCBPQ01WIHZhbHVlIHRvCj4gcmVkdWNlIHBvcCBu
b2lzZS4KClBsZWFzZSBpZ25vcmUgdGhpcywgSSdsbCBzZW5kIGFuIHVwZGF0ZS4KCj4gCj4gU2ln
bmVkLW9mZi1ieTogUGV0ZXIgVWpmYWx1c2kgPHBldGVyLnVqZmFsdXNpQHRpLmNvbT4KPiAtLS0K
PiAgYXJjaC9hcm0vYm9vdC9kdHMvZGE4NTAtbGNkay5kdHMgfCAzNiArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKQo+IAo+
IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9kYTg1MC1sY2RrLmR0cyBiL2FyY2gvYXJt
L2Jvb3QvZHRzL2RhODUwLWxjZGsuZHRzCj4gaW5kZXggMDE3N2UzZWQyMGZlLi5jMTk2ZTM3NjA2
YzQgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvZGE4NTAtbGNkay5kdHMKPiArKysg
Yi9hcmNoL2FybS9ib290L2R0cy9kYTg1MC1sY2RrLmR0cwo+IEBAIC0zOSw2ICszOSwzNiBAQAo+
ICAJCX07Cj4gIAl9Owo+ICAKPiArCXZjY181dmQ6IGZpeGVkcmVndWxhdG9yLXZjY181dmQgewo+
ICsJCWNvbXBhdGlibGUgPSAicmVndWxhdG9yLWZpeGVkIjsKPiArCQlyZWd1bGF0b3ItbmFtZSA9
ICJ2Y2NfNXZkIjsKPiArCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDw1MDAwMDAwPjsKPiAr
CQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDw1MDAwMDAwPjsKPiArCQlyZWd1bGF0b3ItYm9v
dC1vbjsKPiArCX07Cj4gKwo+ICsJdmNjXzN2M2Q6IGZpeGVkcmVndWxhdG9yLXZjY18zdjNkIHsK
PiArCQkvKiBUUFM2NTAyNTAgLSBWRENEQzEgKi8KPiArCQljb21wYXRpYmxlID0gInJlZ3VsYXRv
ci1maXhlZCI7Cj4gKwkJcmVndWxhdG9yLW5hbWUgPSAidmNjXzN2M2QiOwo+ICsJCXJlZ3VsYXRv
ci1taW4tbWljcm92b2x0ID0gPDMzMDAwMDA+Owo+ICsJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0
ID0gPDMzMDAwMDA+Owo+ICsJCXZpbi1zdXBwbHkgPSA8JnZjY181dmQ+Owo+ICsJCXJlZ3VsYXRv
ci1hbHdheXMtb247Cj4gKwkJcmVndWxhdG9yLWJvb3Qtb247Cj4gKwl9Owo+ICsKPiArCXZjY18x
djhkOiBmaXhlZHJlZ3VsYXRvci12Y2NfMXY4ZCB7Cj4gKwkJLyogVFBTNjUwMjUwIC0gVkRDREMy
ICovCj4gKwkJY29tcGF0aWJsZSA9ICJyZWd1bGF0b3ItZml4ZWQiOwo+ICsJCXJlZ3VsYXRvci1u
YW1lID0gInZjY18xdjhkIjsKPiArCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwxODAwMDAw
PjsKPiArCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwxODAwMDAwPjsKPiArCQl2aW4tc3Vw
cGx5ID0gPCZ2Y2NfNXZkPjsKPiArCQlyZWd1bGF0b3ItYWx3YXlzLW9uOwo+ICsJCXJlZ3VsYXRv
ci1ib290LW9uOwo+ICsJfTsKPiArCj4gIAlzb3VuZCB7Cj4gIAkJY29tcGF0aWJsZSA9ICJzaW1w
bGUtYXVkaW8tY2FyZCI7Cj4gIAkJc2ltcGxlLWF1ZGlvLWNhcmQsbmFtZSA9ICJEQTg1MC9PTUFQ
LUwxMzggTENESyI7Cj4gQEAgLTIyMSw2ICsyNTEsMTIgQEAKPiAgCQljb21wYXRpYmxlID0gInRp
LHRsdjMyMGFpYzMxMDYiOwo+ICAJCXJlZyA9IDwweDE4PjsKPiAgCQlzdGF0dXMgPSAib2theSI7
Cj4gKwo+ICsJCS8qIFJlZ3VsYXRvcnMgKi8KPiArCQlJT1ZERC1zdXBwbHkgPSA8JnZjY18zdjNk
PjsKPiArCQlBVkRELXN1cHBseSA9IDwmdmNjXzN2M2Q+Owo+ICsJCURSVkRELXN1cHBseSA9IDwm
dmNjXzN2M2Q+Owo+ICsJCURWREQtc3VwcGx5ID0gPCZ2Y2NfMXY4ZD47Cj4gIAl9Owo+ICB9Owo+
ICAKPiAKCi0gUMOpdGVyCgpUZXhhcyBJbnN0cnVtZW50cyBGaW5sYW5kIE95LCBQb3Jra2FsYW5r
YXR1IDIyLCAwMDE4MCBIZWxzaW5raS4KWS10dW5udXMvQnVzaW5lc3MgSUQ6IDA2MTU1MjEtNC4g
S290aXBhaWtrYS9Eb21pY2lsZTogSGVsc2lua2kKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
