Return-Path: <SRS0=QUhG=Q7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B0DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 12:56:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAE9520652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 12:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F1SpERTq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE9520652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=martin.sperl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jqERnKf3icJVftjUCJwhISrid29eP0RgnEHO23JkTEY=; b=F1SpERTqLDh9dS
	xOQR02ejs3/9O+52XA3cRix5fqQzHHhW/Tjt1TUtSrunMvK+sgrp3BIA7MJTkW1k9D5LXix+x4jNz
	uKy0OaQ9zWjbB1qncy/EXtjTvXjB9vfWLlMfXlsJJGdaQ21cEDEOSOfdXBaPG89ZE2TBKGbojsGbZ
	B1X98DG7Un3oVLdYgR72DyvpArrfbyi/gffV9belnm3l1UOJMn6TQFVmSdxqzQhHi3T37ZYrzWttG
	zuV4qXPWWDLkICQEWrfqv9eAq3c/APXmBPO/a8y8/BzWgZrtyAKg39K0oRPkzcKVEx2gZgTBOGVtE
	IztcyzdgleomXHsJnaFw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxtKK-0002Yu-Un; Sun, 24 Feb 2019 12:56:16 +0000
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]
 helo=cgate.sperl.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxtJj-0001f9-Nu; Sun, 24 Feb 2019 12:55:42 +0000
Received: from hc1.intern.sperl.org (account martin@sperl.org [10.10.10.59]
 verified) by sperl.org (CommuniGate Pro SMTP 6.2.1 _community_)
 with ESMTPSA id 7757549; Sun, 24 Feb 2019 12:55:07 +0000
From: kernel@martin.sperl.org
To: Mark Brown <broonie@kernel.org>, Eric Anholt <eric@anholt.net>,
 Stefan Wahren <stefan.wahren@i2se.com>,
 Hubert Denkmair <h.denkmair@intence.de>, linux-spi@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/9] spi: bcm2835aux: make the polling duration limits
 configurable
Date: Sun, 24 Feb 2019 12:54:36 +0000
Message-Id: <20190224125440.16117-6-kernel@martin.sperl.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190224125440.16117-1-kernel@martin.sperl.org>
References: <20190224125440.16117-1-kernel@martin.sperl.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_045540_332874_9BBEDB89 
X-CRM114-Status: GOOD (  11.15  )
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
Cc: Martin Sperl <kernel@martin.sperl.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

RnJvbTogTWFydGluIFNwZXJsIDxrZXJuZWxAbWFydGluLnNwZXJsLm9yZz4KClVuZGVyIHNvbWUg
Y2lyY3Vtc3RhbmNlcyB0aGUgZGVmYXVsdCAzMCB1cyBwb2xsaW5nIGxpbWl0IGlzIG5vdCBvcHRp
bWFsCmFuZCBtYXkgbGVhZCB0byBsb25nIGRlbGF5cyBiZWNhdXNlIHdlIGFyZSB3YWl0aW5nIG9u
IHRoZSBpbnRlcnJ1cHQKaGFuZGxlciByZXN1bHRpbmcgaW4gcG9vciBzcGkgYnVzIHV0aWxpemF0
aW9uLgoKV2l0aCB0aGlzIHBhdGNoIHdlIGhhdmUgdGhlIHBvc3NpYmlsaXR5IHRvIGluZmx1ZW5j
ZSB0aGlzIHBvbGljeQpieSBtYWtpbmcgdGhpcyBsaW1pdCBjb25maWd1cmFibGUgdmlhIGEgbW9k
dWxlIHBhcmFtZXRlcnMKClNpZ25lZC1vZmYtYnk6IE1hcnRpbiBTcGVybCA8a2VybmVsQG1hcnRp
bi5zcGVybC5vcmc+Ci0tLQpOb3RlIHRoYXQgdGhpcyBwYXRjaCByZWxpZXMgb24gdGhlIGVmZmVj
dGl2ZV9zcGVlZF9oeiBwYXRjaCBmb3IgdGhlCmRyaXZlciB0byBiZSBhcHBsaWVkIQoKLS0tCiBk
cml2ZXJzL3NwaS9zcGktYmNtMjgzNWF1eC5jIHwgMjMgKysrKysrKysrKysrKy0tLS0tLS0tLS0K
IDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL3NwaS9zcGktYmNtMjgzNWF1eC5jIGIvZHJpdmVycy9zcGkvc3BpLWJj
bTI4MzVhdXguYwppbmRleCAwYTVmMjFlYjNiOTkuLmFmNjY4Y2I2YjM4YiAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9zcGkvc3BpLWJjbTI4MzVhdXguYworKysgYi9kcml2ZXJzL3NwaS9zcGktYmNtMjgz
NWF1eC5jCkBAIC0zNyw2ICszNywxMiBAQAogI2luY2x1ZGUgPGxpbnV4L3NwaS9zcGkuaD4KICNp
bmNsdWRlIDxsaW51eC9zcGlubG9jay5oPgoKKy8qIGRlZmluZSBwb2xsaW5nIGxpbWl0cyAqLwor
dW5zaWduZWQgaW50IHBvbGxpbmdfbGltaXRfdXMgPSAzMDsKK21vZHVsZV9wYXJhbShwb2xsaW5n
X2xpbWl0X3VzLCB1aW50LCAwNjY0KTsKK01PRFVMRV9QQVJNX0RFU0MocG9sbGluZ19saW1pdF91
cywKKwkJICJ0aW1lIGluIHVzIHRvIHJ1biBhIHRyYW5zZmVyIGluIHBvbGxpbmcgbW9kZVxuIik7
CisKIC8qCiAgKiBzcGkgcmVnaXN0ZXIgZGVmaW5lcwogICoKQEAgLTg5LDEwICs5NSw2IEBACiAj
ZGVmaW5lIEJDTTI4MzVfQVVYX1NQSV9TVEFUX0JVU1kJMHgwMDAwMDA0MAogI2RlZmluZSBCQ00y
ODM1X0FVWF9TUElfU1RBVF9CSVRDT1VOVAkweDAwMDAwMDNGCgotLyogdGltZW91dCB2YWx1ZXMg
Ki8KLSNkZWZpbmUgQkNNMjgzNV9BVVhfU1BJX1BPTExJTkdfTElNSVRfVVMJMzAKLSNkZWZpbmUg
QkNNMjgzNV9BVVhfU1BJX1BPTExJTkdfSklGRklFUwkJMgotCiBzdHJ1Y3QgYmNtMjgzNWF1eF9z
cGkgewogCXZvaWQgX19pb21lbSAqcmVnczsKIAlzdHJ1Y3QgY2xrICpjbGs7CkBAIC0zMzUsOCAr
MzM3LDggQEAgc3RhdGljIGludCBiY20yODM1YXV4X3NwaV90cmFuc2Zlcl9vbmVfcG9sbChzdHJ1
Y3Qgc3BpX21hc3RlciAqbWFzdGVyLAogCWJjbTI4MzVhdXhfd3IoYnMsIEJDTTI4MzVfQVVYX1NQ
SV9DTlRMMSwgYnMtPmNudGxbMV0pOwogCWJjbTI4MzVhdXhfd3IoYnMsIEJDTTI4MzVfQVVYX1NQ
SV9DTlRMMCwgYnMtPmNudGxbMF0pOwoKLQkvKiBzZXQgdGhlIHRpbWVvdXQgKi8KLQl0aW1lb3V0
ID0gamlmZmllcyArIEJDTTI4MzVfQVVYX1NQSV9QT0xMSU5HX0pJRkZJRVM7CisJLyogc2V0IHRo
ZSB0aW1lb3V0IHRvIGF0IGxlYXN0IDIgamlmZmllcyAqLworCXRpbWVvdXQgPSBqaWZmaWVzICsg
MiArIEhaICogcG9sbGluZ19saW1pdF91cyAvIDEwMDAwMDA7CgogCS8qIGxvb3AgdW50aWwgZmlu
aXNoZWQgdGhlIHRyYW5zZmVyICovCiAJd2hpbGUgKGJzLT5yeF9sZW4pIHsKQEAgLTM4MSw3ICsz
ODMsNyBAQCBzdGF0aWMgaW50IGJjbTI4MzVhdXhfc3BpX3RyYW5zZmVyX29uZShzdHJ1Y3Qgc3Bp
X21hc3RlciAqbWFzdGVyLAogCQkJCSAgICAgICBzdHJ1Y3Qgc3BpX3RyYW5zZmVyICp0ZnIpCiB7
CiAJc3RydWN0IGJjbTI4MzVhdXhfc3BpICpicyA9IHNwaV9tYXN0ZXJfZ2V0X2RldmRhdGEobWFz
dGVyKTsKLQl1bnNpZ25lZCBsb25nIHNwaV9oeiwgY2xrX2h6LCBzcGVlZDsKKwl1bnNpZ25lZCBs
b25nIHNwaV9oeiwgY2xrX2h6LCBzcGVlZCwgaHpfcGVyX2J5dGUsIGJ5dGVfbGltaXQ7CgogCS8q
IGNhbGN1bGF0ZSB0aGUgcmVnaXN0ZXJzIHRvIGhhbmRsZQogCSAqCkBAIC00MjUsMTQgKzQyNywx
NSBAQCBzdGF0aWMgaW50IGJjbTI4MzVhdXhfc3BpX3RyYW5zZmVyX29uZShzdHJ1Y3Qgc3BpX21h
c3RlciAqbWFzdGVyLAogCSAqIG9mIEh6IHBlciBieXRlIHBlciBwb2xsaW5nIGxpbWl0LiAgRS5n
Liwgd2UgY2FuIHRyYW5zZmVyIDEgYnl0ZSBpbgogCSAqIDMwIMK1cyBwZXIgMzAwLDAwMCBIeiBv
ZiBidXMgY2xvY2suCiAJICovCi0jZGVmaW5lIEhaX1BFUl9CWVRFICgoOSAqIDEwMDAwMDApIC8g
QkNNMjgzNV9BVVhfU1BJX1BPTExJTkdfTElNSVRfVVMpCisJaHpfcGVyX2J5dGUgPSBwb2xsaW5n
X2xpbWl0X3VzID8gKDkgKiAxMDAwMDAwKSAvIHBvbGxpbmdfbGltaXRfdXMgOiAwOworCWJ5dGVf
bGltaXQgPSBoel9wZXJfYnl0ZSA/IHRmci0+ZWZmZWN0aXZlX3NwZWVkX2h6IC8gaHpfcGVyX2J5
dGUgOiAxOworCiAJLyogcnVuIGluIHBvbGxpbmcgbW9kZSBmb3Igc2hvcnQgdHJhbnNmZXJzICov
Ci0JaWYgKHRmci0+bGVuIDwgdGZyLT5lZmZlY3RpdmVfc3BlZWRfaHogLyBIWl9QRVJfQllURSkK
KwlpZiAodGZyLT5sZW4gPCBieXRlX2xpbWl0KQogCQlyZXR1cm4gYmNtMjgzNWF1eF9zcGlfdHJh
bnNmZXJfb25lX3BvbGwobWFzdGVyLCBzcGksIHRmcik7CgogCS8qIHJ1biBpbiBpbnRlcnJ1cHQg
bW9kZSBmb3IgYWxsIG90aGVycyAqLwogCXJldHVybiBiY20yODM1YXV4X3NwaV90cmFuc2Zlcl9v
bmVfaXJxKG1hc3Rlciwgc3BpLCB0ZnIpOwotI3VuZGVmIEhaX1BFUl9CWVRFCiB9Cgogc3RhdGlj
IGludCBiY20yODM1YXV4X3NwaV9wcmVwYXJlX21lc3NhZ2Uoc3RydWN0IHNwaV9tYXN0ZXIgKm1h
c3RlciwKLS0KMi4xMS4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1hcm0ta2VybmVsCg==
