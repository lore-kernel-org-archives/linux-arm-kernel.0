Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D19EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 05:57:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 423A620883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 05:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e31Czluo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 423A620883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CSuahYDKQBkCxUvjjNdcI2ittbm3RSbganm6DeGgWLw=; b=e31Czluoj07Z2T
	srXCt+qGWdWwl+v8knitUYodBN6r+hL3vFPso9NB0rY+7nrt2nw886jmscJNPAXLTIJ/yfP1K07we
	eCb5hreWuKLZ+nmthJS4e+AbjGvIk0QnEc3wVKEo10c2N0+33fdSPLUye4WzuWyc7DXjvT0bbN3Q9
	2I6l2jhkQx5foMdsMz2V8ZJPoewJVuuMdkNKBJklgEjLiboVurLlyotmh5U7JqbIPcz6ZdIIw0fYl
	UiNcnRBTMvdjH9fGEkP+ZNuE2TXwU+Udpcv5nn3NiUM+ilDWhaC4Q7cfdS0ogXf+AetTz5vxJXZ2f
	gCCE0IkAgPqwURiF9zDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gh6rQ-0004TI-Hm; Wed, 09 Jan 2019 05:57:04 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gh6rN-0004ST-DJ
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 05:57:03 +0000
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ore@pengutronix.de>)
 id 1gh6rF-0002Gc-5L; Wed, 09 Jan 2019 06:56:53 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.91)
 (envelope-from <ore@pengutronix.de>)
 id 1gh6rE-0008Ps-DH; Wed, 09 Jan 2019 06:56:52 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Wolfram Sang <wsa@the-dreams.de>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v5 1/2] i2c: imx: notify about real errors on dma
 i2c_imx_dma_request
Date: Wed,  9 Jan 2019 06:56:49 +0100
Message-Id: <20190109055650.32259-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190109055650.32259-1-o.rempel@pengutronix.de>
References: <20190109055650.32259-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_215701_600558_0C463890 
X-CRM114-Status: GOOD (  13.27  )
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
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, linux-i2c@vger.kernel.org,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, linux-arm-kernel@lists.infradead.org,
 NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QXQgbGVhc3Qgb24gaS5NWDV4LCB0aGUgRE1BIGV2ZW50cyBmb3IgSTJDIGFuZCBTREhDIHVzZSB0
aGUgc2FtZSBjaGFubmVsCmFuZCB0aGVyZSBjYW4gb25seSBiZSBhIHNpbmdsZSB1c2VyLiBTbyBp
biB0aGlzIGNhc2UgdGhlcmUgc2hvdWxkIGJlIG5vCm1lc3NhZ2UgZW1pdHRlZCB0aGF0IGxvb2tz
IGxpa2UgYW4gZXJyb3IgaWYgdGhlIEkyQyBkZXZpY2UgZG9lc24ndCBoYXZlCmFuIGFzc2lnbmVk
IERNQSBjaGFubmVsLiBJbiBjb250cmFzdCByZWFsIHByb2JsZW1zIHRoYXQgd2VyZSBvbmx5CmVt
aXR0ZWQgYXQgZGVidWcgbGV2ZWwgYmVmb3JlIHNob3VsZCBiZSBkZXNjcmliZWQgYXQgYSBoaWdo
ZXIgbGV2ZWwKdG8gYmUgYmV0dGVyIHZpc2libGUgYW5kIHNvIHVuZGVyc3RhbmRhYmxlLgoKU2ln
bmVkLW9mZi1ieTogT2xla3NpaiBSZW1wZWwgPG8ucmVtcGVsQHBlbmd1dHJvbml4LmRlPgpBY2tl
ZC1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4K
LS0tCiBkcml2ZXJzL2kyYy9idXNzZXMvaTJjLWlteC5jIHwgMjEgKysrKysrKysrKysrLS0tLS0t
LS0tCiAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLWlteC5jIGIvZHJpdmVycy9pMmMvYnVz
c2VzL2kyYy1pbXguYwppbmRleCBmYTlhZDUzODQ1ZDkuLmUyOGVmNDk0ZGFjOCAxMDA2NDQKLS0t
IGEvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1pbXguYworKysgYi9kcml2ZXJzL2kyYy9idXNzZXMv
aTJjLWlteC5jCkBAIC0yODUsOSArMjg1LDExIEBAIHN0YXRpYyB2b2lkIGkyY19pbXhfZG1hX3Jl
cXVlc3Qoc3RydWN0IGlteF9pMmNfc3RydWN0ICppMmNfaW14LAogCWlmICghZG1hKQogCQlyZXR1
cm47CiAKLQlkbWEtPmNoYW5fdHggPSBkbWFfcmVxdWVzdF9zbGF2ZV9jaGFubmVsKGRldiwgInR4
Iik7Ci0JaWYgKCFkbWEtPmNoYW5fdHgpIHsKLQkJZGV2X2RiZyhkZXYsICJjYW4ndCByZXF1ZXN0
IERNQSB0eCBjaGFubmVsXG4iKTsKKwlkbWEtPmNoYW5fdHggPSBkbWFfcmVxdWVzdF9jaGFuKGRl
diwgInR4Iik7CisJaWYgKElTX0VSUihkbWEtPmNoYW5fdHgpKSB7CisJCXJldCA9IFBUUl9FUlIo
ZG1hLT5jaGFuX3J4KTsKKwkJaWYgKHJldCAhPSAtRU5PREVWICYmIHJldCAhPSAtRVBST0JFX0RF
RkVSKQorCQkJZGV2X2VycihkZXYsICJjYW4ndCByZXF1ZXN0IERNQSB0eCBjaGFubmVsICglZClc
biIsIHJldCk7CiAJCWdvdG8gZmFpbF9hbDsKIAl9CiAKQEAgLTI5OCwxMyArMzAwLDE1IEBAIHN0
YXRpYyB2b2lkIGkyY19pbXhfZG1hX3JlcXVlc3Qoc3RydWN0IGlteF9pMmNfc3RydWN0ICppMmNf
aW14LAogCWRtYV9zY29uZmlnLmRpcmVjdGlvbiA9IERNQV9NRU1fVE9fREVWOwogCXJldCA9IGRt
YWVuZ2luZV9zbGF2ZV9jb25maWcoZG1hLT5jaGFuX3R4LCAmZG1hX3Njb25maWcpOwogCWlmIChy
ZXQgPCAwKSB7Ci0JCWRldl9kYmcoZGV2LCAiY2FuJ3QgY29uZmlndXJlIHR4IGNoYW5uZWxcbiIp
OworCQlkZXZfZXJyKGRldiwgImNhbid0IGNvbmZpZ3VyZSB0eCBjaGFubmVsICglZClcbiIsIHJl
dCk7CiAJCWdvdG8gZmFpbF90eDsKIAl9CiAKLQlkbWEtPmNoYW5fcnggPSBkbWFfcmVxdWVzdF9z
bGF2ZV9jaGFubmVsKGRldiwgInJ4Iik7Ci0JaWYgKCFkbWEtPmNoYW5fcngpIHsKLQkJZGV2X2Ri
ZyhkZXYsICJjYW4ndCByZXF1ZXN0IERNQSByeCBjaGFubmVsXG4iKTsKKwlkbWEtPmNoYW5fcngg
PSBkbWFfcmVxdWVzdF9jaGFuKGRldiwgInJ4Iik7CisJaWYgKElTX0VSUihkbWEtPmNoYW5fcngp
KSB7CisJCXJldCA9IFBUUl9FUlIoZG1hLT5jaGFuX3J4KTsKKwkJaWYgKHJldCAhPSAtRU5PREVW
ICYmIHJldCAhPSAtRVBST0JFX0RFRkVSKQorCQkJZGV2X2VycihkZXYsICJjYW4ndCByZXF1ZXN0
IERNQSByeCBjaGFubmVsICglZClcbiIsIHJldCk7CiAJCWdvdG8gZmFpbF90eDsKIAl9CiAKQEAg
LTMxNSw3ICszMTksNyBAQCBzdGF0aWMgdm9pZCBpMmNfaW14X2RtYV9yZXF1ZXN0KHN0cnVjdCBp
bXhfaTJjX3N0cnVjdCAqaTJjX2lteCwKIAlkbWFfc2NvbmZpZy5kaXJlY3Rpb24gPSBETUFfREVW
X1RPX01FTTsKIAlyZXQgPSBkbWFlbmdpbmVfc2xhdmVfY29uZmlnKGRtYS0+Y2hhbl9yeCwgJmRt
YV9zY29uZmlnKTsKIAlpZiAocmV0IDwgMCkgewotCQlkZXZfZGJnKGRldiwgImNhbid0IGNvbmZp
Z3VyZSByeCBjaGFubmVsXG4iKTsKKwkJZGV2X2VycihkZXYsICJjYW4ndCBjb25maWd1cmUgcngg
Y2hhbm5lbCAoJWQpXG4iLCByZXQpOwogCQlnb3RvIGZhaWxfcng7CiAJfQogCkBAIC0zMzIsNyAr
MzM2LDYgQEAgc3RhdGljIHZvaWQgaTJjX2lteF9kbWFfcmVxdWVzdChzdHJ1Y3QgaW14X2kyY19z
dHJ1Y3QgKmkyY19pbXgsCiAJZG1hX3JlbGVhc2VfY2hhbm5lbChkbWEtPmNoYW5fdHgpOwogZmFp
bF9hbDoKIAlkZXZtX2tmcmVlKGRldiwgZG1hKTsKLQlkZXZfaW5mbyhkZXYsICJjYW4ndCB1c2Ug
RE1BLCB1c2luZyBQSU8gaW5zdGVhZC5cbiIpOwogfQogCiBzdGF0aWMgdm9pZCBpMmNfaW14X2Rt
YV9jYWxsYmFjayh2b2lkICphcmcpCi0tIAoyLjE5LjEKCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAps
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
