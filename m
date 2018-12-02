Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F93C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 19:35:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A828C20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 19:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="canWdyzf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A828C20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0/AQzN29FL2VNiu1x2xfW7mqvJgw084YsUv33cK6mx0=; b=canWdyzftd0bq0
	tY2KkrCdppTpxFrHI0yqFY5CeaAGxy/NSYB4SJxVEOajGZUtOoRYdYVtRTL5ydGFZpaNViZyt4jAb
	dFf78TOddbCAo7L/MJZP+s9KisaKFRigC8AlfxmdJvVsJI/6W2hIEOpb8IH9oxdumMZSC/13t2rNA
	nzEu06YMsvI9/KXj/pGV0x9e4iuqExM66YhjgLD0QYDJr0Z1xNeAs508PBRTsIcQunQPKanR15GH+
	zLkWmIc/e50lfkjrHMkfD81+AkatWE48nOq++7XhSo5wMK0XYb+Npuhya1cXUbypr8gbsgnoh7CVR
	mLbXc7urBlVovE+9esgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTXWb-0000CT-HX; Sun, 02 Dec 2018 19:35:29 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTXWX-0000At-0d
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 19:35:27 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 9B05820787; Sun,  2 Dec 2018 20:35:11 +0100 (CET)
Received: from xps13 (unknown [91.224.148.103])
 by mail.bootlin.com (Postfix) with ESMTPSA id A1C902071D;
 Sun,  2 Dec 2018 20:35:10 +0100 (CET)
Date: Sun, 2 Dec 2018 20:35:09 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v2 2/8] phy: mvebu-cp110-comphy: fix port check in
 ->xlate()
Message-ID: <20181202203509.21b067c4@xps13>
In-Reply-To: <20181130190031.GH30658@n2100.armlinux.org.uk>
References: <20181130144743.675-1-miquel.raynal@bootlin.com>
 <20181130144743.675-3-miquel.raynal@bootlin.com>
 <20181130190031.GH30658@n2100.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_113526_042271_BA144483 
X-CRM114-Status: GOOD (  21.53  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Marcin Wojtas <mw@semihalf.com>, Jason Cooper <jason@lakedaemon.net>,
 devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 Grzegorz Jaszczyk <jaz@semihalf.com>,
 Gregory Clement <gregory.clement@bootlin.com>, linux-kernel@vger.kernel.org,
 Kishon Vijay Abraham I <kishon@ti.com>, Nadav Haklai <nadavh@marvell.com>,
 Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgUnVzc2VsbCwKClJ1c3NlbGwgS2luZyAtIEFSTSBMaW51eCA8bGludXhAYXJtbGludXgub3Jn
LnVrPiB3cm90ZSBvbiBGcmksIDMwIE5vdgoyMDE4IDE5OjAwOjMxICswMDAwOgoKPiBPbiBGcmks
IE5vdiAzMCwgMjAxOCBhdCAwMzo0NzozN1BNICswMTAwLCBNaXF1ZWwgUmF5bmFsIHdyb3RlOgo+
ID4gU28gZmFyIHRoZSBQSFkgLT54bGF0ZSgpIGNhbGxiYWNrIHdhcyBjaGVja2luZyBpZiB0aGUg
cG9ydCB3YXMKPiA+ICJpbnZhbGlkIiBiZWZvcmUgY29udGludWluZywgbWVhbmluZyB0aGF0IHRo
ZSBwb3J0IGhhcyBub3QgYmVlbiB1c2VkCj4gPiB5ZXQuIFRoaXMgY2hlY2sgaXMgbm90IGNvcnJl
Y3QgYXMgdGhlcmUgaXMgbm8gb3Bwb3NpdGUgY2FsbCB0byAgCj4gPiAtPnhsYXRlKCkgb25jZSB0
aGUgUEhZIGlzIHJlbGVhc2VkIGJ5IHRoZSB1c2VyIGFuZCB0aGUgcG9ydCB3aWxsICAKPiA+IHJl
bWFpbiAidmFsaWQiIGFmdGVyIHRoZSBmaXJzdCBwaHlfZ2V0KCkvcGh5X3B1dCgpIGNhbGxzLiBI
ZW5jZSwgaWYKPiA+IHRoaXMgZHJpdmVyIGlzIGJ1aWx0IGFzIGEgbW9kdWxlLCBpbnNlcnRlZCwg
cmVtb3ZlZCBhbmQgaW5zZXJ0ZWQKPiA+IGFnYWluLCB0aGUgUEhZIHdpbGwgYXBwZWFyIGJ1c3kg
YW5kIHRoZSBzZWNvbmQgcHJvYmUgd2lsbCBmYWlsLgo+ID4gCj4gPiBUbyBmaXggdGhpcywganVz
dCBkcm9wIHRoZSBmYXVsdHkgY2hlY2sgYW5kIGluc3RlYWQgdmVyaWZ5IHRoYXQgdGhlCj4gPiBw
b3J0IG51bWJlciBpcyB2YWxpZCAoaWUuIGluIHRoZSBwb3NzaWJsZSByYW5nZSkuCj4gPiAKPiA+
IFNpZ25lZC1vZmYtYnk6IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+
Cj4gPiAtLS0KPiA+ICBkcml2ZXJzL3BoeS9tYXJ2ZWxsL3BoeS1tdmVidS1jcDExMC1jb21waHku
YyB8IDQgKystLQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BoeS9tYXJ2ZWxsL3BoeS1tdmVi
dS1jcDExMC1jb21waHkuYyBiL2RyaXZlcnMvcGh5L21hcnZlbGwvcGh5LW12ZWJ1LWNwMTEwLWNv
bXBoeS5jCj4gPiBpbmRleCAzMWI5YTFjMTgzNDUuLmE0MGI4NzZmZjIxNCAxMDA2NDQKPiA+IC0t
LSBhL2RyaXZlcnMvcGh5L21hcnZlbGwvcGh5LW12ZWJ1LWNwMTEwLWNvbXBoeS5jCj4gPiArKysg
Yi9kcml2ZXJzL3BoeS9tYXJ2ZWxsL3BoeS1tdmVidS1jcDExMC1jb21waHkuYwo+ID4gQEAgLTU2
Nyw5ICs1NjcsOSBAQCBzdGF0aWMgc3RydWN0IHBoeSAqbXZlYnVfY29tcGh5X3hsYXRlKHN0cnVj
dCBkZXZpY2UgKmRldiwKPiA+ICAJCXJldHVybiBwaHk7Cj4gPiAgCj4gPiAgCWxhbmUgPSBwaHlf
Z2V0X2RydmRhdGEocGh5KTsKPiA+IC0JaWYgKGxhbmUtPnBvcnQgPj0gMCkKPiA+IC0JCXJldHVy
biBFUlJfUFRSKC1FQlVTWSk7Cj4gPiAgCWxhbmUtPnBvcnQgPSBhcmdzLT5hcmdzWzBdOwo+ID4g
KwlpZiAobGFuZS0+cG9ydCA+PSBNVkVCVV9DT01QSFlfUE9SVFMpCj4gPiArCQlyZXR1cm4gRVJS
X1BUUigtRUlOVkFMKTsgIAo+IAo+IFNob3VsZG4ndCB3ZSB2YWxpZGF0ZSBhcmdzLT5hcmdzWzBd
IGJlZm9yZSBkb2luZyBhbnl0aGluZz8KPiAKCkkgZG9uJ3QgdW5kZXJzdGFuZCB5b3VyIHBvaW50
LCB0aGVyZSBpcyBhIGNoZWNrIG9uIGFyZ3MtPmFyZ3NbMF0gYXMKd2UgY2hlY2sgaXRzIHZhbHVl
ICh0aHJvdWdoIGxhbmUtPnBvcnQpIHJpZ2h0IGFmdGVyLiBXaGF0IGRvIHlvdQpoYXZlIGluIG1p
bmQ/CgoKVGhhbmtzLApNaXF1w6hsCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
