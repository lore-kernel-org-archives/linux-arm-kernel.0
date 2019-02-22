Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672ACC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:31:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3669E2075A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bKDXiUg3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3669E2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kB2Uh2X130INUIIF9JtnLbGjzTLz74/FCpEpJDyg5vw=; b=bKDXiUg3QztrfY
	zfv8WAUomcqLLq5XnVUg3l3gMykt5J3VQTj+SX8nuvWz7PtIbrD4mOQn9HjFl7/Kk9JeBAVDE3svG
	fGnXUoPAhlw5Ae0TuM8U65+MxWGpJ0+MU6nQfszhAZiu0hHEd4oMW0JrFY4skOp/MX44yAzeDZ4wy
	8D+dSw0fpmEvVUhL8HvFJ0L4Mi75oAZ/FSgzOFdzTbj1Vc0UMnuslkgAdPlhrr/hGGU3doxckKrBD
	3qbxDUyux6EtOS3grcKIbCfr/Zc4WBR1B3LlxQyy03VnJlc2UiQ3uis7a1SS5iiL0aYKLT6URah1I
	MpSxJQm+qpHNXG6y6nRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxCnX-0003tl-Cf; Fri, 22 Feb 2019 15:31:35 +0000
Received: from relay8-d.mail.gandi.net ([217.70.183.201])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxCnT-0003sV-O3
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 15:31:33 +0000
X-Originating-IP: 90.88.23.190
Received: from xps13 (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr
 [90.88.23.190]) (Authenticated sender: miquel.raynal@bootlin.com)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id A4AD61BF20F;
 Fri, 22 Feb 2019 15:31:15 +0000 (UTC)
Date: Fri, 22 Feb 2019 16:31:14 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 2/5] ata: libahci_platform: Support per-port interrupts
Message-ID: <20190222163114.0f4488fe@xps13>
In-Reply-To: <5040d4cf-7da1-eefa-a8a3-bc4054d528da@redhat.com>
References: <20190222145356.23072-1-miquel.raynal@bootlin.com>
 <20190222145356.23072-3-miquel.raynal@bootlin.com>
 <5040d4cf-7da1-eefa-a8a3-bc4054d528da@redhat.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_073131_932674_E41700AF 
X-CRM114-Status: GOOD (  19.20  )
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
 Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org,
 Marc Zyngier <marc.zyngier@arm.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, linux-ide@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Antoine Tenart <antoine.tenart@bootlin.com>,
 Jens Axboe <axboe@kernel.dk>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgSGFucywKCkhhbnMgZGUgR29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+IHdyb3RlIG9uIEZy
aSwgMjIgRmViIDIwMTkgMTY6MjY6MDEKKzAxMDA6Cgo+IEhpLAo+IAo+IE9uIDIvMjIvMTkgMzo1
MyBQTSwgTWlxdWVsIFJheW5hbCB3cm90ZToKPiA+IFJpZ2h0IG5vdyB0aGUgQVRBIGNvcmUgb25s
eSBhbGxvd3MgSVBzIHRvIHVzZSBhIHNpbmdsZSBpbnRlcnJ1cHQuIFNvbWUKPiA+IG9mIHRoZW0g
KGZvciBpbnN0YW5jZSB0aGUgQXJtYWRhLUNQMTEwIG9uZSkgYWN0dWFsbHkgaGFzIG9uZSBpbnRl
cnJ1cHQKPiA+IHBlciBwb3J0LiBBZGQgc29tZSBsb2dpYyB0byBzdXBwb3J0IHN1Y2ggc2l0dWF0
aW9uLgo+ID4gCj4gPiBXZSBjb25zaWRlciB0aGF0IGVpdGhlciB0aGVyZSBpcyBvbmUgc2luZ2xl
IGludGVycnVwdCBkZWNsYXJlZCBpbiB0aGUKPiA+IG1haW4gSVAgbm9kZSwgb3IgdGhlcmUgYXJl
IHBlci1wb3J0IGludGVycnVwdHMsIGVhY2ggb2YgdGhlbSBiZWluZwo+ID4gZGVjbGFyZWQgaW4g
dGhlIHBvcnQgc3ViLW5vZGVzLgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBNaXF1ZWwgUmF5bmFs
IDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPgo+ID4gLS0tCj4gPiAgIGRyaXZlcnMvYXRhL2Fj
YXJkLWFoY2kuYyAgICAgICB8ICAyICstCj4gPiAgIGRyaXZlcnMvYXRhL2FoY2kuYyAgICAgICAg
ICAgICB8ICAyICstCj4gPiAgIGRyaXZlcnMvYXRhL2FoY2kuaCAgICAgICAgICAgICB8ICAzICst
Cj4gPiAgIGRyaXZlcnMvYXRhL2xpYmFoY2kuYyAgICAgICAgICB8ICAyICstCj4gPiAgIGRyaXZl
cnMvYXRhL2xpYmFoY2lfcGxhdGZvcm0uYyB8IDY2ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KystLS0tLS0KPiA+ICAgZHJpdmVycy9hdGEvc2F0YV9oaWdoYmFuay5jICAgIHwgIDIgKy0KPiA+
ICAgNiBmaWxlcyBjaGFuZ2VkLCA2MSBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkKPiA+
IAo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYXRhL2FjYXJkLWFoY2kuYyBiL2RyaXZlcnMvYXRh
L2FjYXJkLWFoY2kuYwo+ID4gaW5kZXggNTgzZTM2NmJlN2UyLi45NDE0YjgxZTk5NGMgMTAwNjQ0
Cj4gPiAtLS0gYS9kcml2ZXJzL2F0YS9hY2FyZC1haGNpLmMKPiA+ICsrKyBiL2RyaXZlcnMvYXRh
L2FjYXJkLWFoY2kuYwo+ID4gQEAgLTQzNCw3ICs0MzQsNyBAQCBzdGF0aWMgaW50IGFjYXJkX2Fo
Y2lfaW5pdF9vbmUoc3RydWN0IHBjaV9kZXYgKnBkZXYsIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNl
X2lkCj4gPiAgIAlpZiAoIWhwcml2KQo+ID4gICAJCXJldHVybiAtRU5PTUVNOyAgCj4gPiAgID4g
LQlocHJpdi0+aXJxID0gcGRldi0+aXJxOyAgCj4gPiArCWhwcml2LT5pcnFzWzBdID0gcGRldi0+
aXJxOwo+ID4gICAJaHByaXYtPmZsYWdzIHw9ICh1bnNpZ25lZCBsb25nKXBpLnByaXZhdGVfZGF0
YTsKPiA+ICAgICAKPiBXaGF0IGNvZGUtcGF0aCBpcyBnb2luZyB0byBhbGxvYyBocHJpdi0+aXJx
cyBmb3IgZHJpdmVycyB1c2luZyB0aGlzIGNvZGUtcGF0aAo+IHdoaWNoIGFyZSBub3QgdXNpbmcg
bGliYWhjaV9wbGF0Zm9ybSAuYyA/CgpJIGRvbid0IHVuZGVyc3RhbmQgdGhlIHF1ZXN0aW9uIChv
ciB0aGUgcmVtYXJrIGJlaGluZCB0aGUgcXVlc3Rpb24pLApjYW4geW91IGV4cGxhaW4gYSBsaXR0
bGUgYml0IG1vcmUgd2hhdCB5b3UgaGF2ZSBpbiBtaW5kPwoKClRoYW5rcywKTWlxdcOobAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtl
cm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5l
bAo=
