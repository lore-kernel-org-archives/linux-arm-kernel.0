Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33ADCC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:48:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4A2B2054F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qi5X8XCi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4A2B2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nR+F7yCfGPxZxNJrS9JNu51libUHmoqF9Imomx32dew=; b=Qi5X8XCiwsEa+0
	+a/yHrDZ9N1L2nLgbVfIAfx844rMmy1CR1GXfQvOblTP3j90rJwlIaTS6K2seGRa+ZONeSBUX+Tm2
	msQF7jDa/bkiQUZ+m9PC8/A14fQNDHmAOjzh+lZ0vWGwrODBt72bMB8dhNNrecPVRPJFmkYEW2NMB
	YeRu6rHxaZGpxlfH50whlgbRRkVDHna6FCpl+n/cPTbp+GNYkGWJcA8cSvXirFQoURZ3MOdNUy56V
	0HVaE0Kc7JkGaHh7cFYf8iNpiepexjS4ZcUAygqkUTabZfntb3KZ1uYpBp4HiZfe/r/0SDpdFoyLG
	zp5lQfehsi8PJUfV8tYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWiOL-00022d-Sg; Tue, 11 Dec 2018 13:48:05 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWiOI-0001yN-BX
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 13:48:03 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBBDlg2G019016;
 Tue, 11 Dec 2018 07:47:42 -0600
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBBDlgE1023249
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 11 Dec 2018 07:47:42 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 11
 Dec 2018 07:47:41 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 11 Dec 2018 07:47:41 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBBDldQk017132;
 Tue, 11 Dec 2018 07:47:40 -0600
Subject: Re: [PATCH] mmc: core: Lower max_seg_size if too high for DMA
To: Russell King - ARM Linux <linux@armlinux.org.uk>, Ulf Hansson
 <ulf.hansson@linaro.org>
References: <20181031155738.18367-1-tony@atomide.com>
 <CAPDyKFqtMHRjHsJXcKTTzGYSsyab=2SfWdYiETS4Bo2f7Zw2CQ@mail.gmail.com>
 <20181129191332.GY53235@atomide.com>
 <CAPDyKFpgOjr1Zp=31b-_+KVOnvRnXXdXt5e8b0X1pGNVAihtyA@mail.gmail.com>
 <20181211131336.GD9507@n2100.armlinux.org.uk>
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <b88f7a3f-ed0e-c6d7-6e18-afc2378524bf@ti.com>
Date: Tue, 11 Dec 2018 15:49:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181211131336.GD9507@n2100.armlinux.org.uk>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_054802_476070_2F3244DA 
X-CRM114-Status: GOOD (  20.09  )
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
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, Kishon <kishon@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

UnVzc2VsbCwKCk9uIDExLzEyLzIwMTggMTUuMTMsIFJ1c3NlbGwgS2luZyAtIEFSTSBMaW51eCB3
cm90ZToKPiAKPiBXZSdyZSBuZWFyaW5nIHRoZSBtZXJnZSB3aW5kb3csIGFuZCB0aGlzIGlzIGEg
cmVncmVzc2lvbiB0aGF0IGlzIHlldAo+IHRvIGJlIHNvbHZlZC4gIEl0IGNhdXNlcyBhIGtlcm5l
bCB3YXJuaW5nIHdpdGggYmFja3RyYWNlLCBzbyBpdCdzCj4gdmVyeSBhbm5veWluZy4KPiAKPiBU
aGUgZXJyb3IgaXM6Cj4gCj4gb21hcC1kbWEtZW5naW5lIDRhMDU2MDAwLmRtYS1jb250cm9sbGVy
OiBETUEtQVBJOiBtYXBwaW5nIHNnIHNlZ21lbnQgbG9uZ2VyIHRoYW4gZGV2aWNlIGNsYWltcyB0
byBzdXBwb3J0IFtsZW49Njk2MzJdIFttYXg9NjU1MzZdCj4gCj4gd2hpY2ggaW5kaWNhdGVzIHRo
YXQgd2UgaGF2ZSBhIFNHIHNlZ21lbnQgbGVuZ3RoIHRoYXQgZXhjZWVkcyB0aHRlCj4gcHVibGlz
aGVkIG1heGltdW0gc2VnbWVudCBzaXplIGZvciBhIGRldmljZSAtIGluIHRoaXMgY2FzZSB0aGUK
PiBETUEgZW5naW5lIGRldmljZS4gIFRoZSBtYXhpbXVtIHNlZ21lbnQgc2l6ZSBmb3IgdGhlIERN
QSBlbmdpbmUgY29tZXMKPiBmcm9tIHRoZSBkZWZhdWx0IHBlci1kZXZpY2Ugc2V0dGluZywgaW4g
bGludXgvZG1hLW1hcHBpbmcuaCwgd2hpY2ggaXMKPiA2NEsuCj4gCj4gSG93ZXZlciwgb21hcF9o
c21tYyBzZXRzOgo+IAo+ICAgICAgICAgbW1jLT5tYXhfYmxrX3NpemUgPSA1MTI7ICAgICAgIC8q
IEJsb2NrIExlbmd0aCBhdCBtYXggY2FuIGJlIDEwMjQgKi8KPiAgICAgICAgIG1tYy0+bWF4X2Js
a19jb3VudCA9IDB4RkZGRjsgICAgLyogTm8uIG9mIEJsb2NrcyBpcyAxNiBiaXRzICovCj4gICAg
ICAgICBtbWMtPm1heF9yZXFfc2l6ZSA9IG1tYy0+bWF4X2Jsa19zaXplICogbW1jLT5tYXhfYmxr
X2NvdW50Owo+ICAgICAgICAgbW1jLT5tYXhfc2VnX3NpemUgPSBtbWMtPm1heF9yZXFfc2l6ZTsK
PiAKPiB3aGljaCBlbmRzIHVwIHRlbGxpbmcgdGhlIGJsb2NrIGxheWVyIHRoYXQgd2Ugc3VwcG9y
dCBhIG1heGltdW0gc2VnbWVudAo+IHNpemUgb2YgNjU1MzUqNTEyLCBzbyBvZiBjb3Vyc2UgaXQg
X3dpbGxfIHBhc3MgU0cgbGlzdHMgd2hlcmUgYSBzZWdtZW50Cj4gaXMgbG9uZ2VyIHRoYW4gNjRL
Lgo+IAo+IFRoZSBwcm9ibGVtIGhlcmUgaXMgdGhhdCB0aGUgSFNNTUMgZHJpdmVyIGRvZXNuJ3Qg
dGFrZSBhY2NvdW50IG9mIHRoZQo+IERNQSBlbmdpbmUgZGV2aWNlJ3MgY2FwYWJpbGl0aWVzLgo+
IAo+IFdlIGhhdmUgc29tZXRoaW5nIG9mIGFuIG9kZCBzaXR1YXRpb24gaW4gdGhhdCB0aGUgb21h
cC1kbWEgZGV2aWNlJ3MKPiBtYXhpbXVtIFNHIHNpemUgZGVwZW5kcyBvbiB0aGUgImFkZHJlc3Mg
d2lkdGgiIC0gaXQncyA2NEsgdHJhbnNmZXJzCj4gb2Ygd2hhdGV2ZXIgdW5pdCAiYWRkcmVzcyB3
aWR0aCIgaXMsIHNvIHRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIG9mCj4gcGVyLWRldmljZSBw
YXJhbWV0ZXJzIGRvZXNuJ3QgZXhhY3RseSB3b3JrLiAgVGhhdCBtZWFucyB0aGUgZGVmYXVsdAo+
IDY0SyBsaW1pdCBhdCB0aGUgZGV2aWNlLWxldmVsIGlzIHJlYXNvbmFibGUuCj4gCj4gVGhlIG9u
bHkgdGhpbmcgSSBjYW4gdGhpbmsgb2YgZG9pbmcgaXMgYWRkaW5nIGludG8gb21hcF9oc21tYzoK
PiAKPiAJbW1jLT5tYXhfc2VnX3NpemUgPSBtaW4obW1jLT5tYXhfcmVxX3NpemUsCj4gCQkJCW1p
bihkbWFfZ2V0X21heF9zZWdfc2l6ZShob3N0LT5yeF9jaGFuLT5kZXZpY2UtPmRldiksCj4gCQkJ
CSAgICBkbWFfZ2V0X21heF9zZWdfc2l6ZShob3N0LT50eF9jaGFuLT5kZXZpY2UtPmRldikpKTsK
PiAKPiB0byBsaW1pdCB0aGUgbWF4aW11bSBzZWdtZW50IHNpemUgdG8gdGhhdCBvZiB0aGUgZGV2
aWNlIF9hbmRfIGRtYQo+IGVuZ2luZSdzIGNhcGFiaWxpdGllcy4KCk1ha2Ugc2Vuc2UuCgo+IERv
aW5nIHRoaXMgc29sdmVzIHRoZSBwcm9ibGVtIGZvciBtZS4KPiAKCi0gUMOpdGVyCgpUZXhhcyBJ
bnN0cnVtZW50cyBGaW5sYW5kIE95LCBQb3Jra2FsYW5rYXR1IDIyLCAwMDE4MCBIZWxzaW5raS4K
WS10dW5udXMvQnVzaW5lc3MgSUQ6IDA2MTU1MjEtNC4gS290aXBhaWtrYS9Eb21pY2lsZTogSGVs
c2lua2kKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxp
bnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LWFybS1rZXJuZWwK
