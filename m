Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DCAC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:57:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54949206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q5XlcRNt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54949206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zk3KCmXo/IWcWWi6f7BUdsJcLXLtUWJ5APz3bD1HgJs=; b=Q5XlcRNt3Tg/jf
	IyeitYexGfUU8CzrLEbvyjqPTPxEx8sKfAwIAtQrxVYNDaqoLp9GEj1SR2oyxdXss/C9gB5TgNu8z
	p1LRoot5lLXYw4TxUd48Nbk5GCjpdDHeGyg/NoT259Oo7xmfkIDM/OWc91Hahrm6UJhLZBE+JEJat
	FFs1MACTJ6++bYWiQS/ei+e7AQeOSr/yYgGMVbLZMh3v7ms0WWVmT/uc7hH8dG2dwyesEqr3LbGW+
	LeRIL9r6VZNvm3QQsXcyd4vOUcr2QZhlSd12FgSiVdQJyKLMEaarVBJG1zn86sIrj3tSz8GOO4u3B
	xIEdxroOaZO+wYl+onYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gToj0-00043m-7x; Mon, 03 Dec 2018 13:57:26 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gToir-0003sS-4K
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 13:57:24 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 6C24520CFB; Mon,  3 Dec 2018 14:57:01 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr
 [90.88.18.158])
 by mail.bootlin.com (Postfix) with ESMTPSA id 9FCE920EB9;
 Mon,  3 Dec 2018 14:56:22 +0100 (CET)
Date: Mon, 3 Dec 2018 14:56:22 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v2 2/8] phy: mvebu-cp110-comphy: fix port check in
 ->xlate()
Message-ID: <20181203145622.0d38869d@xps13>
In-Reply-To: <20181203003623.GJ30658@n2100.armlinux.org.uk>
References: <20181130144743.675-1-miquel.raynal@bootlin.com>
 <20181130144743.675-3-miquel.raynal@bootlin.com>
 <20181130190031.GH30658@n2100.armlinux.org.uk>
 <20181202203509.21b067c4@xps13>
 <20181203003623.GJ30658@n2100.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_055723_139549_F6241184 
X-CRM114-Status: GOOD (  29.87  )
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
LnVrPiB3cm90ZSBvbiBNb24sIDMgRGVjCjIwMTggMDA6MzY6MjMgKzAwMDA6Cgo+IE9uIFN1biwg
RGVjIDAyLCAyMDE4IGF0IDA4OjM1OjA5UE0gKzAxMDAsIE1pcXVlbCBSYXluYWwgd3JvdGU6Cj4g
PiBIaSBSdXNzZWxsLAo+ID4gCj4gPiBSdXNzZWxsIEtpbmcgLSBBUk0gTGludXggPGxpbnV4QGFy
bWxpbnV4Lm9yZy51az4gd3JvdGUgb24gRnJpLCAzMCBOb3YKPiA+IDIwMTggMTk6MDA6MzEgKzAw
MDA6Cj4gPiAgIAo+ID4gPiBPbiBGcmksIE5vdiAzMCwgMjAxOCBhdCAwMzo0NzozN1BNICswMTAw
LCBNaXF1ZWwgUmF5bmFsIHdyb3RlOiAgCj4gPiA+ID4gU28gZmFyIHRoZSBQSFkgLT54bGF0ZSgp
IGNhbGxiYWNrIHdhcyBjaGVja2luZyBpZiB0aGUgcG9ydCB3YXMKPiA+ID4gPiAiaW52YWxpZCIg
YmVmb3JlIGNvbnRpbnVpbmcsIG1lYW5pbmcgdGhhdCB0aGUgcG9ydCBoYXMgbm90IGJlZW4gdXNl
ZAo+ID4gPiA+IHlldC4gVGhpcyBjaGVjayBpcyBub3QgY29ycmVjdCBhcyB0aGVyZSBpcyBubyBv
cHBvc2l0ZSBjYWxsIHRvICAgIAo+ID4gPiA+IC0+eGxhdGUoKSBvbmNlIHRoZSBQSFkgaXMgcmVs
ZWFzZWQgYnkgdGhlIHVzZXIgYW5kIHRoZSBwb3J0IHdpbGwgICAgCj4gPiA+ID4gcmVtYWluICJ2
YWxpZCIgYWZ0ZXIgdGhlIGZpcnN0IHBoeV9nZXQoKS9waHlfcHV0KCkgY2FsbHMuIEhlbmNlLCBp
Zgo+ID4gPiA+IHRoaXMgZHJpdmVyIGlzIGJ1aWx0IGFzIGEgbW9kdWxlLCBpbnNlcnRlZCwgcmVt
b3ZlZCBhbmQgaW5zZXJ0ZWQKPiA+ID4gPiBhZ2FpbiwgdGhlIFBIWSB3aWxsIGFwcGVhciBidXN5
IGFuZCB0aGUgc2Vjb25kIHByb2JlIHdpbGwgZmFpbC4KPiA+ID4gPiAKPiA+ID4gPiBUbyBmaXgg
dGhpcywganVzdCBkcm9wIHRoZSBmYXVsdHkgY2hlY2sgYW5kIGluc3RlYWQgdmVyaWZ5IHRoYXQg
dGhlCj4gPiA+ID4gcG9ydCBudW1iZXIgaXMgdmFsaWQgKGllLiBpbiB0aGUgcG9zc2libGUgcmFu
Z2UpLgo+ID4gPiA+IAo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IE1pcXVlbCBSYXluYWwgPG1pcXVl
bC5yYXluYWxAYm9vdGxpbi5jb20+Cj4gPiA+ID4gLS0tCj4gPiA+ID4gIGRyaXZlcnMvcGh5L21h
cnZlbGwvcGh5LW12ZWJ1LWNwMTEwLWNvbXBoeS5jIHwgNCArKy0tCj4gPiA+ID4gIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gPiA+ID4gCj4gPiA+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGh5L21hcnZlbGwvcGh5LW12ZWJ1LWNwMTEwLWNvbXBoeS5j
IGIvZHJpdmVycy9waHkvbWFydmVsbC9waHktbXZlYnUtY3AxMTAtY29tcGh5LmMKPiA+ID4gPiBp
bmRleCAzMWI5YTFjMTgzNDUuLmE0MGI4NzZmZjIxNCAxMDA2NDQKPiA+ID4gPiAtLS0gYS9kcml2
ZXJzL3BoeS9tYXJ2ZWxsL3BoeS1tdmVidS1jcDExMC1jb21waHkuYwo+ID4gPiA+ICsrKyBiL2Ry
aXZlcnMvcGh5L21hcnZlbGwvcGh5LW12ZWJ1LWNwMTEwLWNvbXBoeS5jCj4gPiA+ID4gQEAgLTU2
Nyw5ICs1NjcsOSBAQCBzdGF0aWMgc3RydWN0IHBoeSAqbXZlYnVfY29tcGh5X3hsYXRlKHN0cnVj
dCBkZXZpY2UgKmRldiwKPiA+ID4gPiAgCQlyZXR1cm4gcGh5Owo+ID4gPiA+ICAKPiA+ID4gPiAg
CWxhbmUgPSBwaHlfZ2V0X2RydmRhdGEocGh5KTsKPiA+ID4gPiAtCWlmIChsYW5lLT5wb3J0ID49
IDApCj4gPiA+ID4gLQkJcmV0dXJuIEVSUl9QVFIoLUVCVVNZKTsKPiA+ID4gPiAgCWxhbmUtPnBv
cnQgPSBhcmdzLT5hcmdzWzBdOwo+ID4gPiA+ICsJaWYgKGxhbmUtPnBvcnQgPj0gTVZFQlVfQ09N
UEhZX1BPUlRTKQo+ID4gPiA+ICsJCXJldHVybiBFUlJfUFRSKC1FSU5WQUwpOyAgICAKPiA+ID4g
Cj4gPiA+IFNob3VsZG4ndCB3ZSB2YWxpZGF0ZSBhcmdzLT5hcmdzWzBdIGJlZm9yZSBkb2luZyBh
bnl0aGluZz8KPiA+ID4gICAKPiA+IAo+ID4gSSBkb24ndCB1bmRlcnN0YW5kIHlvdXIgcG9pbnQs
IHRoZXJlIGlzIGEgY2hlY2sgb24gYXJncy0+YXJnc1swXSBhcwo+ID4gd2UgY2hlY2sgaXRzIHZh
bHVlICh0aHJvdWdoIGxhbmUtPnBvcnQpIHJpZ2h0IGFmdGVyLiBXaGF0IGRvIHlvdQo+ID4gaGF2
ZSBpbiBtaW5kPyAgCj4gCj4gUmlnaHQsIHRoZXJlIGlzIGFscmVhZHkgYSBjaGVjayBvbiBhcmdz
LT5hcmdzWzBdIGZvciBpdCBiZWluZyBncmVhdGVyCj4gdGhhbiBNVkVCVV9DT01QSFlfUE9SVFMg
YW5kIHJldHVybmluZyBhbiBlcnJvciAoYW5kIGluIGZhY3Qgd2FybmluZwo+IGlmIHRoYXQgaXMg
dGhlIGNhc2UpLiAgU28gaW4gdGhhdCBjYXNlLCB3aGF0IGlzIHRoZSB1c2Ugb2YgdGhlIGFib3Zl
Cj4gYWRkaXRpb25hbCB0ZXN0IHlvdSBhcmUgcHJvcG9zaW5nIHRvIGFkZD8gIFRoZSByZXN1bHRp
bmcgY29kZSBlbmRzIHVwCj4gbG9va2luZyBsaWtlIHRoaXM6Cj4gCj4gCWlmIChXQVJOX09OKGFy
Z3MtPmFyZ3NbMF0gPj0gTVZFQlVfQ09NUEhZX1BPUlRTKSkKPiAJCXJldHVybiBFUlJfUFRSKC1F
SU5WQUwpOwo+IC4uLgo+IAlsYW5lLT5wb3J0ID0gYXJncy0+YXJnc1swXTsKPiArCWlmIChsYW5l
LT5wb3J0ID49IE1WRUJVX0NPTVBIWV9QT1JUUykKPiArCQlyZXR1cm4gRVJSX1BUUigtRUlOVkFM
KTsgIAo+IAo+IHdoaWNoIGlzIGp1c3Qgc2lsbHkgLSB0aGUgc2Vjb25kIHRlc3QgY2FuIG5ldmVy
IGJlIGV2YWx1YXRlZCBhcyB0cnVlLAo+IGFuZCB0aGVyZWZvcmUgaXMgcmVkdW5kYW50Lgo+IAo+
IEluIGFueSBjYXNlLCBteSBwb2ludCB3YXMgdGhhdCBpbiB5b3VyIHBhdGNoLCB3aGVyZSB5b3Ug
YXNzaWduCj4gbGFuZS0+cG9ydCBhbmQgdGhlbiB2YWxpZGF0ZSB0aGUgbGFuZS0+cG9ydCB2YWx1
ZSwgdGhpcyBpcyBpbgo+IHByaW5jaXBsZSB0aGUgd3Jvbmcgb3JkZXIgLSB0aGUgb3JkZXIgc2hv
dWxkIGFsd2F5cyBiZTogdmFsaWRhdGUKPiBmaXJzdCwgdGhlbiBtYWtlIHVzZS4KPiAKCllvdSBh
cmUgcmlnaHQsIHRoaXMgdGVzdCBpcyByZWR1bmRhbnQ7IEkgZm9yZ290IGFib3V0IHRoZSBmaXJz
dApjaGVjay4gSSB3aWxsIGp1c3QgZHJvcCB0aGVzZSBhZGRpdGlvbmFsIHR3byBsaW5lcyBhbmQg
anVzdCBkbzoKCiAgICAgICAgICAgICAgICBbLi4uXQogICAgICAgICAgICAgICAgbGFuZS0+cG9y
dCA9IGFyZ3MtPmFyZ3NbMF07CgogICAgICAgICAgICAgICAgcmV0dXJuIDA7CiAgICAgICAgfQoK
VGhhbmtzLApNaXF1w6hsCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1hcm0ta2VybmVsCg==
