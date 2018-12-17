Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E066DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:43:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF80F217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NoadoWom"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF80F217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=I8hpB3RvGI7koTN1bqcRplaRuRTsd0BEJjgjwScPZI8=; b=NoadoWom4rfZMn
	NyI7fslq/ln7j87CSfMikFpdInT22sEtKzwhZPkuzaAbeUsVLIWYtXq7UP6GyFnxLmpwqfXjnq3HJ
	kCQknioHSOlxLq0/rxoI5PPFV11Jt134/BI5r8HVK1Hp8vo+4yjTBWOKyyoZg68kSyfLTFQI9BPna
	PwOUJOyLJvExhifjvzSWkuI4THfyOAXmnnhU8x7VlXpxiCpoAIYJ0l1OXdRM84D8+KpGg8+YwrMU4
	l2LOVEEJbQHxqu9kmHsgYfJqIKwiKdSRbUn2paEQBQsxSsy36tckWz8TyjB2PFVWfui+s2bsZi2WF
	Lw1oZjzEWmmFhQJPmLNQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYoUz-0006KI-MM; Mon, 17 Dec 2018 08:43:37 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYoUv-0006Jm-VU
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 08:43:35 +0000
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gYoUi-0006We-0S; Mon, 17 Dec 2018 09:43:20 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gYoUg-0006kK-VR; Mon, 17 Dec 2018 09:43:18 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Linus Walleij <linus.walleij@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
 Ralph Sennhauser <ralph.sennhauser@gmail.com>
Subject: [PATCH] gpio: mvebu: only fail on missing clk if pwm is actually to
 be used
Date: Mon, 17 Dec 2018 09:43:13 +0100
Message-Id: <20181217084313.15379-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_004334_170029_A2A5476E 
X-CRM114-Status: GOOD (  13.34  )
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
Cc: linux-gpio@vger.kernel.org, stable@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhlIGdwaW8gSVAgb24gQXJtYWRhIDM3MCBhdCBvZmZzZXQgMHgxODE4MCBoYXMgbmVpdGhlciBh
IGNsayBub3IgcHdtCnJlZ2lzdGVycy4gU28gdGhlcmUgaXMgbm8gbmVlZCBmb3IgYSBjbGsgYXMg
dGhlIHB3bSBpc24ndCB1c2VkIGFueWhvdy4KU28gb25seSBjaGVjayBmb3IgdGhlIGNsayBpbiB0
aGUgcHJlc2VuY2Ugb2YgdGhlIHB3bSByZWdpc3RlcnMuIFRoaXMgZml4ZXMKYSBmYWlsdXJlIHRv
IHByb2JlIHRoZSBncGlvIGRyaXZlciBmb3IgdGhlIGFib3ZlIG1lbnRpb25lZCBncGlvIGRldmlj
ZS4KCkZpeGVzOiA3NTc2NDJmOWE1ODQgKCJncGlvOiBtdmVidTogQWRkIGxpbWl0ZWQgUFdNIHN1
cHBvcnQiKQpTaWduZWQtb2ZmLWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmln
QHBlbmd1dHJvbml4LmRlPgotLS0KIGRyaXZlcnMvZ3Bpby9ncGlvLW12ZWJ1LmMgfCA2ICsrKy0t
LQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwaW8vZ3Bpby1tdmVidS5jIGIvZHJpdmVycy9ncGlvL2dwaW8tbXZl
YnUuYwppbmRleCA2ZTAyMTQ4YzIwOGIuLmFkYzc2OGY5MDhmMSAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncGlvL2dwaW8tbXZlYnUuYworKysgYi9kcml2ZXJzL2dwaW8vZ3Bpby1tdmVidS5jCkBAIC03
NzMsOSArNzczLDYgQEAgc3RhdGljIGludCBtdmVidV9wd21fcHJvYmUoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldiwKIAkJCQkgICAgICJtYXJ2ZWxsLGFybWFkYS0zNzAtZ3BpbyIpKQogCQly
ZXR1cm4gMDsKIAotCWlmIChJU19FUlIobXZjaGlwLT5jbGspKQotCQlyZXR1cm4gUFRSX0VSUiht
dmNoaXAtPmNsayk7Ci0KIAkvKgogCSAqIFRoZXJlIGFyZSBvbmx5IHR3byBzZXRzIG9mIFBXTSBj
b25maWd1cmF0aW9uIHJlZ2lzdGVycyBmb3IKIAkgKiBhbGwgdGhlIEdQSU8gbGluZXMgb24gdGhv
c2UgU29DcyB3aGljaCB0aGlzIGRyaXZlciByZXNlcnZlcwpAQCAtNzg2LDYgKzc4Myw5IEBAIHN0
YXRpYyBpbnQgbXZlYnVfcHdtX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsCiAJ
aWYgKCFyZXMpCiAJCXJldHVybiAwOwogCisJaWYgKElTX0VSUihtdmNoaXAtPmNsaykpCisJCXJl
dHVybiBQVFJfRVJSKG12Y2hpcC0+Y2xrKTsKKwogCS8qCiAJICogVXNlIHNldCBBIGZvciBsaW5l
cyBvZiBHUElPIGNoaXAgd2l0aCBpZCAwLCBCIGZvciBHUElPIGNoaXAKIAkgKiB3aXRoIGlkIDEu
IERvbid0IGFsbG93IGZ1cnRoZXIgR1BJTyBjaGlwcyB0byBiZSB1c2VkIGZvciBQV00uCi0tIAoy
LjE5LjIKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
aW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1hcm0ta2VybmVsCg==
