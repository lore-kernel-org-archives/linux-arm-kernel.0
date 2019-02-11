Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B55C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:56:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECD9521B69
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MZnA8/nn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD9521B69
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=puUFodqKT3/vcLpHXrMsWAiEAoyTMJBzPkHpPc55wPk=; b=MZnA8/nno70Jeo
	IyNP5tk916oFMhGy/KWOx9mRjTQHqBXAOkNMqNce7o0ehDUt2h2Tqotn9bPXteUepfCMziRk7osKe
	FcneUE03X789XgijcdDUQfRJM4tYrWUQ1+IcM2CywQWNVS+mhSopzzO1lhF7zMDRs49+Bnm5978s7
	HGziDBefBjt3xUQczsVQofW0fqYqgOICizDXWSl61JdA3WKKJKha+DrmurzqbeNf/EA3oPyZKrgeT
	NkwBb15I93rb7qihjsMs1eTvjNVTYd68vfT3GKfVd4CG0sCSx5LzoBl3BZP9sOfqAGmc0f20FgfPD
	jr09+5OU6xmYhhYM9H8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtEsa-0006nZ-9r; Mon, 11 Feb 2019 16:56:24 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtEsS-0006he-K2
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 16:56:18 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gtEsI-0001OV-SV; Mon, 11 Feb 2019 17:56:06 +0100
Message-ID: <1549904165.2546.14.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/2] pci: imx6: avoid dereferencing program counter
 from user mode
From: Lucas Stach <l.stach@pengutronix.de>
To: Stefan Agner <stefan@agner.ch>, hongxing.zhu@nxp.com
Date: Mon, 11 Feb 2019 17:56:05 +0100
In-Reply-To: <20181204132733.14422-1-stefan@agner.ch>
References: <20181204132733.14422-1-stefan@agner.ch>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_085616_813189_AD4B2F29 
X-CRM114-Status: GOOD (  14.74  )
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
Cc: lorenzo.pieralisi@arm.com, andrew.smirnov@gmail.com, robin.murphy@arm.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 bhelgaas@google.com, leonard.crestez@nxp.com, festevam@gmail.com,
 linux-arm-kernel@lists.infradead.org, tpiepho@impinj.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gRGllbnN0YWcsIGRlbiAwNC4xMi4yMDE4LCAxNDoyNyArMDEwMCBzY2hyaWViIFN0ZWZhbiBB
Z25lcjoKPiBUaGUgY3VzdG9tIGZhdWx0IGhhbmRsZXIgaXMgY3VycmVudGx5IG9ubHkgbWVhbnQg
dG8gaGFuZGxlIGtlcm5lbAo+IG1vZGUgYnVzIGZhdWx0cy4gRXhpdCBpbiBjYXNlIHRoZSBhYm9y
dCBoYXBwZW5lZCBpbiB1c2VyIG1vZGUuCj4gCj4gU2lnbmVkLW9mZi1ieTogU3RlZmFuIEFnbmVy
IDxzdGVmYW5AYWduZXIuY2g+CgpSZXZpZXdlZC1ieTogTHVjYXMgU3RhY2ggPGwuc3RhY2hAcGVu
Z3V0cm9uaXguZGU+Cgo+IC0tLQo+IMKgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlt
eDYuYyB8IDEwICsrKysrKysrLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaS1pbXg2LmMgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jCj4g
aW5kZXggNjlmODYyMzRmN2MwLi41NGEyOWU0NDEzMDMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9w
Y2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYwo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvZHdjL3BjaS1pbXg2LmMKPiBAQCAtMjcwLDggKzI3MCwxNCBAQCBzdGF0aWMgaW50IGlteDZx
X3BjaWVfYWJvcnRfaGFuZGxlcih1bnNpZ25lZCBsb25nIGFkZHIsCj4gwqAJCXVuc2lnbmVkIGlu
dCBmc3IsIHN0cnVjdCBwdF9yZWdzICpyZWdzKQo+IMKgewo+IMKgCXVuc2lnbmVkIGxvbmcgcGMg
PSBpbnN0cnVjdGlvbl9wb2ludGVyKHJlZ3MpOwo+IC0JdW5zaWduZWQgbG9uZyBpbnN0ciA9ICoo
dW5zaWduZWQgbG9uZyAqKXBjOwo+IC0JaW50IHJlZyA9IChpbnN0ciA+PiAxMikgJiAxNTsKPiAr
CXVuc2lnbmVkIGxvbmcgaW5zdHI7Cj4gKwlpbnQgcmVnOwo+ICsKPiArCWlmICh1c2VyX21vZGUo
cmVncykpCj4gKwkJcmV0dXJuIDE7Cj4gKwo+ICsJaW5zdHIgPSAqKHVuc2lnbmVkIGxvbmcgKilw
YzsKPiArCXJlZyA9IChpbnN0ciA+PiAxMikgJiAxNTsKPiDCoAo+IMKgCS8qCj4gwqAJwqAqIElm
IHRoZSBpbnN0cnVjdGlvbiBiZWluZyBleGVjdXRlZCB3YXMgYSByZWFkLAoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWls
aW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
