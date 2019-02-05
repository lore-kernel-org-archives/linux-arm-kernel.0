Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE111C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:48:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AADF82073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="faZXaGJe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AADF82073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xKN9VhmTXfixjEye1hMX/PQVKoDsyeFsywrxvocrAEk=; b=faZXaGJeJHv0Z5
	sKiNW/4tDkoukxU7WPXLb7/FyG3kOiQlEgGPQJp/7blaql7ovf5n/WqxJQcRZ/ejhtkV2QgUdUCc7
	vvjHJ+whwoa4C0GqVxyTusmCbJqWMw118IabScZ7n5jmqVbUiQ5E473kKczoWTzi3ii4fXLIDzdQC
	Fkg/3N156kGuLgGcpuC65jhACLClQsdCWoW7WiYBC7VesUC097G3nFFnzwpVRbbvCLUc+RE7yuJop
	xuZECYMbMZswiy5WODcRTcWNBZtgCmTop94lraI/if0IQavewdlnv10GHmnflRWNZWpAPq+R4kU/n
	Vnr2aUEhaBLe79M/zBlA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqxKr-0000KV-NL; Tue, 05 Feb 2019 09:48:09 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqxKn-0000Jv-Vk
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 09:48:07 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gqxKk-0002hS-S1; Tue, 05 Feb 2019 10:48:02 +0100
Message-ID: <1549360082.2544.36.camel@pengutronix.de>
Subject: Re: [PATCH v2 3/3] PCI: imx: Add workaround for e10728, IMX7d PCIe
 PLL failure
From: Lucas Stach <l.stach@pengutronix.de>
To: Trent Piepho <tpiepho@impinj.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>
Date: Tue, 05 Feb 2019 10:48:02 +0100
In-Reply-To: <20190205001721.18639-4-tpiepho@impinj.com>
References: <20190205001721.18639-1-tpiepho@impinj.com>
 <20190205001721.18639-4-tpiepho@impinj.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_014806_177494_69905747 
X-CRM114-Status: GOOD (  20.36  )
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
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gRGllbnN0YWcsIGRlbiAwNS4wMi4yMDE5LCAwMDoxNyArMDAwMCBzY2hyaWViIFRyZW50IFBp
ZXBobzoKPiBUaGlzIGltcGxlbWVudHMgdGhlIHdvcmtvdW5kIGRlc2NyaWJlZCBpbiB0aGUgTlhQ
IElNWDdkIGVycmF0dW0gZTEwNzI4Lgo+IAo+IEluaXRpYWwgVkNPIG9zY2lsbGF0aW9uIG1heSBm
YWlsIHVuZGVyIGNvcm5lciBjb25kaXRpb25zIHN1Y2ggYXMgY29sZAo+IHRlbXBlcmF0dXJlLsKg
wqBJdCBjYXVzZXMgUENJZSBQTEwgdG8gZmFpbCB0byBsb2NrIGluIHRoZSBpbml0aWFsaXphdGlv
bgo+IHBoYXNlLCB3aGljaCByZXN1bHRzIGluIHRoZSBQQ0llIGxpbmsgZmFpbGluZyB0byBjb21l
IHVwLgo+IAo+IFRoZSB3b3JrYXJvdW5kIGlzIHRvIGRpc2FibGUgRHV0eS1jeWNsZSBDb3JyZWN0
b3IgKERDQykgY2FsaWJyYXRpb24KPiBhZnRlciBHX1JTVC4KPiAKPiBUbyBkbyB0aGlzIGl0IGlz
IG5lY2Vzc2FyeSB0byBnYWluIGFjY2VzcyB0byB0aGUgdW5kb2N1bWVudGVkIGFuZAo+IGN1cnJl
bnRseSB1bnVzZWQgUENJZSBQSFkgcmVnaXN0ZXIgYmFuay7CoMKgQSBuZXcgZGV2aWNlIHRyZWUg
bm9kZSBvZiB0eXBlCj4gImZzbCxpbXg3ZC1wY2llLXBoeSIgaXMgY3JlYXRlZCBmb3IgdGhlIFBI
WSBibG9jayBhbmQgdGhlIGV4aXN0aW5nIFBDSWUKPiBkZXZpY2UgdXNlcyBhIHBoYW5kbGUgbmFt
ZWQgImZzbCxpbXg3ZC1wY2llLXBoeSIgdG8gcG9pbnQgdG8gaXQuCj4gCj4gU2lnbmVkLW9mZi1i
eTogVHJlbnQgUGllcGhvIDx0cGllcGhvQGltcGluai5jb20+CgpSZXZpZXdlZC1ieTogTHVjYXMg
U3RhY2ggPGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU+Cgo+IC0tLQo+IMKgZHJpdmVycy9wY2kvY29u
dHJvbGxlci9kd2MvcGNpLWlteDYuYyB8IDU3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrCj4gwqAxIGZpbGUgY2hhbmdlZCwgNTcgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jIGIvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvcGNpLWlteDYuYwo+IGluZGV4IDgwZjg0MzAzMGUzNi4uMDZkZDZhYTky
N2Q0IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMK
PiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jCj4gQEAgLTE4LDYg
KzE4LDcgQEAKPiDCoCNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KPiDCoCNpbmNsdWRlIDxsaW51
eC9vZl9ncGlvLmg+Cj4gwqAjaW5jbHVkZSA8bGludXgvb2ZfZGV2aWNlLmg+Cj4gKyNpbmNsdWRl
IDxsaW51eC9vZl9hZGRyZXNzLmg+Cj4gwqAjaW5jbHVkZSA8bGludXgvcGNpLmg+Cj4gwqAjaW5j
bHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+Cj4gwqAjaW5jbHVkZSA8bGludXgvcmVnbWFw
Lmg+Cj4gQEAgLTYxLDYgKzYyLDcgQEAgc3RydWN0IGlteDZfcGNpZSB7Cj4gPiA+IMKgCXUzMgkJ
CXR4X3N3aW5nX2xvdzsKPiA+ID4gwqAJaW50CQkJbGlua19nZW47Cj4gPiA+IMKgCXN0cnVjdCBy
ZWd1bGF0b3IJKnZwY2llOwo+ID4gPiArCXZvaWQgX19pb21lbQkJKnBoeV9iYXNlOwo+IMKgCj4g
PiDCoAkvKiBwb3dlciBkb21haW4gZm9yIHBjaWUgKi8KPiA+ID4gwqAJc3RydWN0IGRldmljZQkJ
KnBkX3BjaWU7Cj4gQEAgLTExNyw2ICsxMTksMjMgQEAgc3RydWN0IGlteDZfcGNpZSB7Cj4gwqAj
ZGVmaW5lIFBDSUVfUEhZX1JYX0FTSUNfT1VUIDB4MTAwRAo+ID4gwqAjZGVmaW5lIFBDSUVfUEhZ
X1JYX0FTSUNfT1VUX1ZBTElECSgxIDw8IDApCj4gwqAKPiArLyogaU1YNyBQQ0llIFBIWSByZWdp
c3RlcnMgKi8KPiA+ICsjZGVmaW5lIFBDSUVfUEhZX0NNTl9SRUc0CQkweDE0Cj4gKy8qIFRoZXNl
IGFyZSBwcm9iYWJseSB0aGUgYml0cyB0aGF0ICphcmVuJ3QqIERDQ19GQl9FTiAqLwo+ID4gKyNk
ZWZpbmUgUENJRV9QSFlfQ01OX1JFRzRfRENDX0ZCX0VOCTB4MjkKPiArCj4gPiArI2RlZmluZSBQ
Q0lFX1BIWV9DTU5fUkVHMTUJwqDCoMKgwqDCoMKgwqDCoDB4NTQKPiA+ICsjZGVmaW5lIFBDSUVf
UEhZX0NNTl9SRUcxNV9ETFlfNAlCSVQoMikKPiA+ICsjZGVmaW5lIFBDSUVfUEhZX0NNTl9SRUcx
NV9QTExfUEQJQklUKDUpCj4gPiArI2RlZmluZSBQQ0lFX1BIWV9DTU5fUkVHMTVfT1ZSRF9QTExf
UEQJQklUKDcpCj4gKwo+ID4gKyNkZWZpbmUgUENJRV9QSFlfQ01OX1JFRzI0CQkweDkwCj4gPiAr
I2RlZmluZSBQQ0lFX1BIWV9DTU5fUkVHMjRfUlhfRVEJQklUKDYpCj4gPiArI2RlZmluZSBQQ0lF
X1BIWV9DTU5fUkVHMjRfUlhfRVFfU0VMCUJJVCgzKQo+ICsKPiA+ICsjZGVmaW5lIFBDSUVfUEhZ
X0NNTl9SRUcyNgkJMHg5OAo+ID4gKyNkZWZpbmUgUENJRV9QSFlfQ01OX1JFRzI2X0FUVF9NT0RF
CTB4QkMKPiArCj4gwqAjZGVmaW5lIFBIWV9SWF9PVlJEX0lOX0xPIDB4MTAwNQo+IMKgI2RlZmlu
ZSBQSFlfUlhfT1ZSRF9JTl9MT19SWF9EQVRBX0VOICgxIDw8IDUpCj4gwqAjZGVmaW5lIFBIWV9S
WF9PVlJEX0lOX0xPX1JYX1BMTF9FTiAoMSA8PCAzKQo+IEBAIC00OTAsNiArNTA5LDI2IEBAIHN0
YXRpYyB2b2lkIGlteDZfcGNpZV9kZWFzc2VydF9jb3JlX3Jlc2V0KHN0cnVjdCBpbXg2X3BjaWUg
KmlteDZfcGNpZSkKPiA+IMKgCXN3aXRjaCAoaW14Nl9wY2llLT52YXJpYW50KSB7Cj4gPiDCoAlj
YXNlIElNWDdEOgo+ID4gwqAJCXJlc2V0X2NvbnRyb2xfZGVhc3NlcnQoaW14Nl9wY2llLT5wY2ll
cGh5X3Jlc2V0KTsKPiArCj4gPiArCQkvKiBXb3JrYXJvdW5kIGZvciBFUlIwMTA3MjgsIGZhaWx1
cmUgb2YgUENJLWUgUExMIFZDTyB0bwo+ID4gKwkJwqAqIG9zY2lsbGF0ZSwgZXNwZWNpYWxseSB3
aGVuIGNvbGQuwqDCoFRoaXMgdHVybnMgb2ZmICJEdXR5LWN5Y2xlCj4gPiArCQnCoCogQ29ycmVj
dG9yIiBhbmQgb3RoZXIgbXlzdGVyaW91cyB1bmRvY3VtZW50ZWQgdGhpbmdzLgo+ID4gKwkJwqAq
Lwo+ID4gKwkJaWYgKGxpa2VseShpbXg2X3BjaWUtPnBoeV9iYXNlKSkgewo+ID4gKwkJCS8qIERl
LWFzc2VydCBEQ0NfRkJfRU4gKi8KPiA+ICsJCQl3cml0ZWwoUENJRV9QSFlfQ01OX1JFRzRfREND
X0ZCX0VOLAo+ID4gKwkJCcKgwqDCoMKgwqDCoMKgaW14Nl9wY2llLT5waHlfYmFzZSArIFBDSUVf
UEhZX0NNTl9SRUc0KTsKPiA+ICsJCQkvKiBBc3NlcnQgUlhfRVFTIGFuZCBSWF9FUVNfU0VMICov
Cj4gPiArCQkJd3JpdGVsKFBDSUVfUEhZX0NNTl9SRUcyNF9SWF9FUV9TRUwKPiA+ICsJCQkJfCBQ
Q0lFX1BIWV9DTU5fUkVHMjRfUlhfRVEsCj4gPiArCQkJwqDCoMKgwqDCoMKgwqBpbXg2X3BjaWUt
PnBoeV9iYXNlICsgUENJRV9QSFlfQ01OX1JFRzI0KTsKPiA+ICsJCQkvKiBBc3NlcnQgQVRUX01P
REUgKi8KPiA+ICsJCQl3cml0ZWwoUENJRV9QSFlfQ01OX1JFRzI2X0FUVF9NT0RFLAo+ID4gKwkJ
CcKgwqDCoMKgwqDCoMKgaW14Nl9wY2llLT5waHlfYmFzZSArIFBDSUVfUEhZX0NNTl9SRUcyNik7
Cj4gPiArCQl9IGVsc2Ugewo+ID4gKwkJCWRldl93YXJuKGRldiwgIkRUIGxhY2tzIGlteDdkLXBj
aWUtcGh5LCB1bmFibGUgdG8gYXBwbHkgRVJSMDEwNzI4IHdvcmthcm91bmRcbiIpOwo+ID4gKwkJ
fQo+ICsKPiA+IMKgCQlpbXg3ZF9wY2llX3dhaXRfZm9yX3BoeV9wbGxfbG9jayhpbXg2X3BjaWUp
Owo+ID4gwqAJCWJyZWFrOwo+ID4gwqAJY2FzZSBJTVg2U1g6Cj4gQEAgLTkxOSw2ICs5NTgsNyBA
QCBzdGF0aWMgaW50IGlteDZfcGNpZV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
KQo+ID4gwqAJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsKPiA+IMKgCXN0cnVjdCBk
d19wY2llICpwY2k7Cj4gPiDCoAlzdHJ1Y3QgaW14Nl9wY2llICppbXg2X3BjaWU7Cj4gPiArCXN0
cnVjdCBkZXZpY2Vfbm9kZSAqbnA7Cj4gPiDCoAlzdHJ1Y3QgcmVzb3VyY2UgKmRiaV9iYXNlOwo+
ID4gwqAJc3RydWN0IGRldmljZV9ub2RlICpub2RlID0gZGV2LT5vZl9ub2RlOwo+ID4gwqAJaW50
IHJldDsKPiBAQCAtOTM5LDYgKzk3OSwyMyBAQCBzdGF0aWMgaW50IGlteDZfcGNpZV9wcm9iZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+ID4gwqAJaW14Nl9wY2llLT52YXJpYW50ID0K
PiA+IMKgCQkoZW51bSBpbXg2X3BjaWVfdmFyaWFudHMpb2ZfZGV2aWNlX2dldF9tYXRjaF9kYXRh
KGRldik7Cj4gwqAKPiA+ICsJLyogRmluZCB0aGUgUEhZIGlmIG9uZSBpcyBkZWZpbmVkLCBvbmx5
IGlteDdkIHVzZXMgaXQgKi8KPiA+ICsJbnAgPSBvZl9wYXJzZV9waGFuZGxlKG5vZGUsICJmc2ws
aW14N2QtcGNpZS1waHkiLCAwKTsKPiA+ICsJaWYgKG5wKSB7Cj4gPiArCQlzdHJ1Y3QgcmVzb3Vy
Y2UgcmVzOwo+ICsKPiA+ICsJCXJldCA9IG9mX2FkZHJlc3NfdG9fcmVzb3VyY2UobnAsIDAsICZy
ZXMpOwo+ID4gKwkJaWYgKHJldCkgewo+ID4gKwkJCWRldl9lcnIoZGV2LCAiVW5hYmxlIHRvIG1h
cCBQQ0llIFBIWVxuIik7Cj4gPiArCQkJcmV0dXJuIHJldDsKPiA+ICsJCX0KPiA+ICsJCWlteDZf
cGNpZS0+cGh5X2Jhc2UgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoZGV2LCAmcmVzKTsKPiA+ICsJ
CWlmIChJU19FUlIoaW14Nl9wY2llLT5waHlfYmFzZSkpIHsKPiA+ICsJCQlkZXZfZXJyKGRldiwg
IlVuYWJsZSB0byBtYXAgUENJZSBQSFlcbiIpOwo+ID4gKwkJCXJldHVybiBQVFJfRVJSKGlteDZf
cGNpZS0+cGh5X2Jhc2UpOwo+ID4gKwkJfQo+ID4gKwl9Cj4gKwo+ID4gwqAJZGJpX2Jhc2UgPSBw
bGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOwo+ID4gwqAJcGNp
LT5kYmlfYmFzZSA9IGRldm1faW9yZW1hcF9yZXNvdXJjZShkZXYsIGRiaV9iYXNlKTsKPiA+IMKg
CWlmIChJU19FUlIocGNpLT5kYmlfYmFzZSkpCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
