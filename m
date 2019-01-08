Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2555C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:21:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9264020665
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fgw4RxmH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9264020665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Bb+L9p5ibrSOMHPx2Dhp8zueIKsU67MsiaeKKx3cpoI=; b=fgw4RxmHIL3rr3
	ckbOSWgg1QLo+cOdY3TEYpzcuy/keC0FNmQkzz6It+OrWSofhQlUuK/rKHV0ZIZvvmzDGvbD4mh81
	PAMWANxaBWf3HXi1fjblKcR+Uz1tJGQ9aMOBEbp7Y27ZVcybl+ALUCtntnrZMwAdN2fzMyjQB5tzr
	EsnP9zCDRceiRA79MWr/+WElKFBsQs/T2NJ0fp79/JhyfDxOUZf+Hl0WYe1r5ZGTqOufm/9cd7xHQ
	wvSSzVr6ua879/+lAZC5N+lsXYol4wiVSXptYRLZvVV3R9rP9RMb7CBEj8uMmq/Ibsvv/OMIcNflU
	t1FwjNlPjGiitNk6gCiw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggmdw-0002WW-Qo; Tue, 08 Jan 2019 08:21:48 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggmdt-0002Vs-JN
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 08:21:47 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1ggmdn-0003rq-Kv; Tue, 08 Jan 2019 09:21:39 +0100
Message-ID: <1546935698.3580.21.camel@pengutronix.de>
Subject: Re: [PATCH v4 3/4] PCI: imx6: Convert DIRECT_SPEED_CHANGE quirk
 code to use a flag
From: Lucas Stach <l.stach@pengutronix.de>
To: Andrey Smirnov <andrew.smirnov@gmail.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>
Date: Tue, 08 Jan 2019 09:21:38 +0100
In-Reply-To: <20190104165335.13205-4-andrew.smirnov@gmail.com>
References: <20190104165335.13205-1-andrew.smirnov@gmail.com>
 <20190104165335.13205-4-andrew.smirnov@gmail.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_002145_792072_CE0E0F3C 
X-CRM114-Status: GOOD (  16.38  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com,
 Bjorn Helgaas <bhelgaas@google.com>, Leonard Crestez <leonard.crestez@nxp.com>,
 Chris Healy <cphealy@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gRnJlaXRhZywgZGVuIDA0LjAxLjIwMTksIDA4OjUzIC0wODAwIHNjaHJpZWIgQW5kcmV5IFNt
aXJub3Y6Cj4gQm90aCBpLk1YN0QgYW5kIGkuTVg4TVEgaGF2ZSB0aGUgc2FtZSBiZWhhdmlvdXIg
d2hlbiBpdCBjb21lcyB0bwo+IGNsZWFyaW5nIERJUkVDVF9TUEVFRF9DSEFOR0UgYml0IHdoZW4g
bm8gc3BlZWQgY2hhbmdlIG9jY3VyLiBUbwo+IGFjY291bnQgZm9yIHRoYXQgY2hhbmdlIHRoZSBj
b2RlIGhhbmRsaW5nIHRoYXQgdG8gdXNlIGEgZ2VuZXJpYyBmbGFnCj4gaW5zdGVhZCBvZiBjaGVj
a2luZyBJUCBibG9jayB2YXJpYW50Lgo+IAo+ID4gQ2M6IEJqb3JuIEhlbGdhYXMgPGJoZWxnYWFz
QGdvb2dsZS5jb20+Cj4gPiBDYzogRmFiaW8gRXN0ZXZhbSA8ZmFiaW8uZXN0ZXZhbUBueHAuY29t
Pgo+ID4gQ2M6IENocmlzIEhlYWx5IDxjcGhlYWx5QGdtYWlsLmNvbT4KPiA+IENjOiBMdWNhcyBT
dGFjaCA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT4KPiA+IENjOiBMZW9uYXJkIENyZXN0ZXogPGxl
b25hcmQuY3Jlc3RlekBueHAuY29tPgo+ID4gQ2M6ICJBLnMuIERvbmciIDxhaXNoZW5nLmRvbmdA
bnhwLmNvbT4KPiA+IENjOiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+Cj4gQ2M6
IGxpbnV4LWlteEBueHAuY29tCj4gQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZwo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCj4gQ2M6IGxpbnV4LXBjaUB2
Z2VyLmtlcm5lbC5vcmcKPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgU21pcm5vdiA8YW5kcmV3LnNt
aXJub3ZAZ21haWwuY29tPgoKUmV2aWV3ZWQtYnk6IEx1Y2FzIFN0YWNoIDxsLnN0YWNoQHBlbmd1
dHJvbml4LmRlPgoKPiAtLS0KPiDCoGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2
LmMgfCAxMyArKysrKysrKystLS0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCsp
LCA0IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2ktaW14Ni5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYwo+
IGluZGV4IGM1NWQ5M2MxMTg3ZC4uNzVlZTBjZDdhZjNiIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMKPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2ktaW14Ni5jCj4gQEAgLTQyLDYgKzQyLDcgQEAgZW51bSBpbXg2X3BjaWVfdmFy
aWFudHMgewo+IMKgfTsKPiDCoAo+ID4gwqAjZGVmaW5lIElNWDZfUENJRV9GTEFHX0lNWDZfUEhZ
CQkJQklUKDApCj4gPiArI2RlZmluZSBJTVg2X1BDSUVfRkxBR19JTVg2X1NQRUVEX0NIQU5HRQlC
SVQoMSkKPiDCoAo+IMKgc3RydWN0IGlteDZfcGNpZV9kcnZkYXRhIHsKPiA+IMKgCWVudW0gaW14
Nl9wY2llX3ZhcmlhbnRzIHZhcmlhbnQ7Cj4gQEAgLTcxMSw3ICs3MTIsOCBAQCBzdGF0aWMgaW50
IGlteDZfcGNpZV9lc3RhYmxpc2hfbGluayhzdHJ1Y3QgaW14Nl9wY2llICppbXg2X3BjaWUpCj4g
PiDCoAkJdG1wIHw9IFBPUlRfTE9HSUNfU1BFRURfQ0hBTkdFOwo+ID4gwqAJCWR3X3BjaWVfd3Jp
dGVsX2RiaShwY2ksIFBDSUVfTElOS19XSURUSF9TUEVFRF9DT05UUk9MLCB0bXApOwo+IMKgCj4g
PiAtCQlpZiAoaW14Nl9wY2llLT5kcnZkYXRhLT52YXJpYW50ICE9IElNWDdEKSB7Cj4gPiArCQlp
ZiAoaW14Nl9wY2llLT5kcnZkYXRhLT5mbGFncyAmCj4gPiArCQnCoMKgwqDCoElNWDZfUENJRV9G
TEFHX0lNWDZfU1BFRURfQ0hBTkdFKSB7Cj4gPiDCoAkJCS8qCj4gPiDCoAkJCcKgKiBPbiBpLk1Y
NywgRElSRUNUX1NQRUVEX0NIQU5HRSBiZWhhdmVzIGRpZmZlcmVudGx5Cj4gPiDCoAkJCcKgKiBm
cm9tIGkuTVg2IGZhbWlseSB3aGVuIG5vIGxpbmsgc3BlZWQgdHJhbnNpdGlvbgo+IEBAIC0xMDk3
LDE1ICsxMDk5LDE4IEBAIHN0YXRpYyB2b2lkIGlteDZfcGNpZV9zaHV0ZG93bihzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQo+IMKgc3RhdGljIGNvbnN0IHN0cnVjdCBpbXg2X3BjaWVfZHJ2
ZGF0YSBkcnZkYXRhW10gPSB7Cj4gPiDCoAlbSU1YNlFdID0gewo+ID4gwqAJCS52YXJpYW50ID0g
SU1YNlEsCj4gPiAtCQkuZmxhZ3MgPSBJTVg2X1BDSUVfRkxBR19JTVg2X1BIWSwKPiA+ICsJCS5m
bGFncyA9IElNWDZfUENJRV9GTEFHX0lNWDZfUEhZIHwKPiA+ICsJCQnCoElNWDZfUENJRV9GTEFH
X0lNWDZfU1BFRURfQ0hBTkdFLAo+ID4gwqAJfSwKPiA+IMKgCVtJTVg2U1hdID0gewo+ID4gwqAJ
CS52YXJpYW50ID0gSU1YNlNYLAo+ID4gLQkJLmZsYWdzID0gSU1YNl9QQ0lFX0ZMQUdfSU1YNl9Q
SFksCj4gPiArCQkuZmxhZ3MgPSBJTVg2X1BDSUVfRkxBR19JTVg2X1BIWSB8Cj4gPiArCQkJwqBJ
TVg2X1BDSUVfRkxBR19JTVg2X1NQRUVEX0NIQU5HRSwKPiA+IMKgCX0sCj4gPiDCoAlbSU1YNlFQ
XSA9IHsKPiA+IMKgCQkudmFyaWFudCA9IElNWDZRUCwKPiA+IC0JCS5mbGFncyA9IElNWDZfUENJ
RV9GTEFHX0lNWDZfUEhZLAo+ID4gKwkJLmZsYWdzID0gSU1YNl9QQ0lFX0ZMQUdfSU1YNl9QSFkg
fAo+ID4gKwkJCcKgSU1YNl9QQ0lFX0ZMQUdfSU1YNl9TUEVFRF9DSEFOR0UsCj4gPiDCoAl9LAo+
ID4gwqAJW0lNWDdEXSA9IHsKPiA+IMKgCQkudmFyaWFudCA9IElNWDdELAoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWls
aW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
