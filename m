Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1006C282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:01:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 710CF20663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ug87J9ZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 710CF20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cCGnWrTaqh8xuHucNw99g80Xe9ifViyVwh/UPVieq4c=; b=ug87J9ZKwZ5weO
	jQPXNOLc+7gmp/5p9iJ9FNMjNniFwoX041sbX+Ct2bYqOY2Xbpjjbkd4oS68qe3//w+TRYnYMjzSb
	MokAZUQMHmLpbnjJc+VwhZ8+10wNytAkoozvrPyOqUavjx/oWsIv9Bhw1Tj7uBJEnZsEpvMDSIWXF
	MaGJIYxAv7wLp+eGCRwfAF3NnVcLs2f2kLjN/kSveOApe0KpryCOJ9Pnl6aJ0zERF2y0uaewJF7Id
	p8q1Ww4OcSZtngNSFzlhBbpgebDuwSJs8z6Iig7YB6bNTF7v5WIHQdfu7hoWnL7atfwpyrnEajLO5
	Hh/AQMFdBB7F9lEhHTfA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glWOC-0005Kp-0g; Mon, 21 Jan 2019 10:01:08 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glWO4-0005Jj-5h
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 10:01:05 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 38F90209BF; Mon, 21 Jan 2019 11:00:58 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr
 [90.88.156.87])
 by mail.bootlin.com (Postfix) with ESMTPSA id AF17A206A7;
 Mon, 21 Jan 2019 11:00:47 +0100 (CET)
Date: Mon, 21 Jan 2019 11:00:47 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2 03/10] usb: ehci-orion: avoid double PHY initialization
Message-ID: <20190121110047.7654a67e@xps13>
In-Reply-To: <ffb3d79a-a506-5bda-402e-98e67d52933f@cogentembedded.com>
References: <20190111133133.24803-1-miquel.raynal@bootlin.com>
 <20190111133133.24803-4-miquel.raynal@bootlin.com>
 <ffb3d79a-a506-5bda-402e-98e67d52933f@cogentembedded.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_020100_347410_5EC39BFA 
X-CRM114-Status: GOOD (  19.30  )
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
 Jason Cooper <jason@lakedaemon.net>, Mathias Nyman <mathias.nyman@intel.com>,
 devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Gregory Clement <gregory.clement@bootlin.com>, linux-usb@vger.kernel.org,
 Kishon Vijay Abraham I <kishon@ti.com>, Nadav Haklai <nadavh@marvell.com>,
 Rob Herring <robh+dt@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgU2VyZ2VpLAoKU2VyZ2VpIFNodHlseW92IDxzZXJnZWkuc2h0eWx5b3ZAY29nZW50ZW1iZWRk
ZWQuY29tPiB3cm90ZSBvbiBGcmksIDExCkphbiAyMDE5IDIxOjAzOjAxICswMzAwOgoKPiBIZWxs
byEKPiAKPiBPbiAwMS8xMS8yMDE5IDA0OjMxIFBNLCBNaXF1ZWwgUmF5bmFsIHdyb3RlOgo+IAo+
ID4gTm8gbmVlZCB0byBpbml0aWFsaXplIHRoZSBQSFkgZnJvbSB0aGUgZHJpdmVyJ3MgcHJvYmUu
IEl0IGlzIGRvbmUgYnkKPiA+IHRoZSBjb3JlIGF1dG9tYXRpY2FsbHkgYW5kIGRvaW5nIGl0IHR3
aWNlIHdvdWxkIGluY3JlbWVudCB0aGUKPiA+IHBoeS0+cG93ZXJjb3VudCBjb3VudGVyIHRvIDIg
aW5zdGVhZCBvZiAxLiBEdXJpbmcgbGF0ZXIgc3VzcGVuZAo+ID4gb3BlcmF0aW9uLCB0aGUgY291
bnRlciB3aWxsIGJlIGRlY3JlbWVudGVkIHRvIG9uZSwgbm8gcGh5LT5wb3dlcl9vZmYoKQo+ID4g
d2lsbCBvY2N1ciBhbmQgd29yc3QgdGhhbiB0aGF0LCB0aGUgZm9sbG93aW5nIHBoeS0+cG93ZXJf
b24oKSBhdCAgCj4gCj4gICAgV29yc2UuCgpOb3RlZAoKPiAKPiA+IHJlc3VtZSB0aW1lIHdpbGwg
YmUgYWxzbyBza2lwcGVkLCBmYWlsaW5nIHRoZSB3aG9sZSBTMlJBTSBvcGVyYXRpb24uCj4gPiAK
PiA+IFNpZ25lZC1vZmYtYnk6IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5j
b20+Cj4gPiAtLS0KPiA+ICBkcml2ZXJzL3VzYi9ob3N0L2VoY2ktb3Jpb24uYyB8IDI2ICsrKy0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KSwgMjMgZGVsZXRpb25zKC0pCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0
L2VoY2ktb3Jpb24uYyBiL2RyaXZlcnMvdXNiL2hvc3QvZWhjaS1vcmlvbi5jCj4gPiBpbmRleCAx
YWQ3MjY0N2EwNjkuLjMxMDlmMDgyOTQ5ZSAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2hv
c3QvZWhjaS1vcmlvbi5jCj4gPiArKysgYi9kcml2ZXJzL3VzYi9ob3N0L2VoY2ktb3Jpb24uYwo+
ID4gQEAgLTI1NywxNSArMjU3LDcgQEAgc3RhdGljIGludCBlaGNpX29yaW9uX2Rydl9wcm9iZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+ID4gIAlpZiAoSVNfRVJSKHByaXYtPnBoeSkp
IHsKPiA+ICAJCWVyciA9IFBUUl9FUlIocHJpdi0+cGh5KTsKPiA+ICAJCWlmIChlcnIgIT0gLUVO
T1NZUykKPiA+IC0JCQlnb3RvIGVycl9waHlfZ2V0Owo+ID4gLQl9IGVsc2Ugewo+ID4gLQkJZXJy
ID0gcGh5X2luaXQocHJpdi0+cGh5KTsKPiA+IC0JCWlmIChlcnIpCj4gPiAtCQkJZ290byBlcnJf
cGh5X2luaXQ7Cj4gPiAtCj4gPiAtCQllcnIgPSBwaHlfcG93ZXJfb24ocHJpdi0+cGh5KTsKPiA+
IC0JCWlmIChlcnIpCj4gPiAtCQkJZ290byBlcnJfcGh5X3Bvd2VyX29uOwo+ID4gKwkJCWdvdG8g
ZXJyX2Rpc19jbGs7ICAKPiAKPiAgICBGYW1pbGlhciBjb2RlIGluIHVuZmFtaWxpYXIgcGxhY2Uu
IFNvbWVib2R5IG11c3QgaGF2ZSBibGluZGx5IGNvcGllZCBpdC4uLiA6LSkKCkFjdHVhbGx5IGEg
Z2l0IGJsYW1lIHNob3dzIHRoYXQgdGhpcyBjb2RlIGlzIHRoZXJlIHNpbmNlIDIwMTQsIDQgeWVh
cnMKYmVmb3JlIHRoZSBIQ0QgY29yZSBzdXBwb3J0ZWQgUEhZcy4gVGhpcyBkcml2ZXIgd2FzIHBy
b2JhYmx5IGZvcmdvdHRlbgpkdXJpbmcgdGhlIHByb2Nlc3MuIAoKClRoYW5rcywKTWlxdcOobAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJt
LWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtl
cm5lbAo=
