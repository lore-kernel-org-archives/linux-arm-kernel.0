Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A70C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:44:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A8192145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KLSPFje0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A8192145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=tT/aDMwS7kzLYK9TZ5celLOQbo+wBOBgjfZjlaLFlNk=; b=KLSPFje0EUx5/r
	Z9kIjKnfEjK2bAbNcwwmbVjDlWHqMdVAZJQ88ToVGfQ5klJSDx5yRuDAYf0+QRyxbTXEK2Hps72Ij
	Qp+ppmod22u4JdblZMyjrHcwVdlJsGjRKV7nDQXCX/dPsCNLkbISbUt0S+crTYSDqIg3We+Prxlpa
	oKG6NMd9TwiPL/sLiHiXzlWER2rV4Y4drJg3aBIF/pOYrNZR1Oe6u2bNtsYwNtDG7R44kWWjzA2CJ
	uPK/wV1ukkxRye8T3fUe2wba3TH2ZRoTC1w4gnu+I83EBklxWQkmfbg+CsoMzbyJiEDd9je7XXWb8
	DjdoGqKAutD1TW2ycuOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSfLm-0002uH-B8; Fri, 30 Nov 2018 09:44:42 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSfLi-0002kf-DI
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 09:44:40 +0000
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ore@pengutronix.de>)
 id 1gSfLR-0007RH-EU; Fri, 30 Nov 2018 10:44:21 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.91)
 (envelope-from <ore@pengutronix.de>)
 id 1gSfLP-0004cb-SO; Fri, 30 Nov 2018 10:44:19 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Wolfram Sang <wsa@the-dreams.de>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v3 1/1] i2c: imx: refactor error handling on
 i2c_imx_dma_request()
Date: Fri, 30 Nov 2018 10:44:18 +0100
Message-Id: <20181130094418.17700-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_014438_640024_AF81CBBE 
X-CRM114-Status: GOOD (  16.16  )
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
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, linux-arm-kernel@lists.infradead.org,
 linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

RnJvbTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4K
CkN1cnJlbnQgaW1wbGVtZW50YXRpb24gd2lsbCBwcmludCBlcnJvciBpZiBzeXN0ZW0gaXMgbm90
IGNvbmZpZ3VyZWQKd2l0aCBETUEgZm9yIEkyQyBjb3JlLiBBdCBsZWFzdCBvbiBpLk1YNXggdmFy
aWFudHMgaXMgRE1BIGV2ZW50IGZvciBJMkMKbXV4ZWQgd2l0aCBTREhDLiBTbyBpdCBpcyBwcm9q
ZWN0IHNwZWNpZmljIGNvbmZpZ3VyYXRpb24gYW5kIG5vdCBhbiBlcnJvci4KClRoaXMgcGF0Y2gg
d2lsbCBhbHNvIGFmZmVjdCBwcm9iZSwgc2luY2UgaXQgd2lsbCBmb3J3YXJkIGFsbCBlcnJvciBl
eGNlcHQKb2YgbWlzc2luZyBETUEuCgpTaWduZWQtb2ZmLWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyA8
dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPgpbb3JlOiBtYWtlIGl0IGFjdHVhbGx5IGNv
bXBpbGUsIGZpeCBhIGNvcm5lciBjYXNlXQpTaWduZWQtb2ZmLWJ5OiBPbGVrc2lqIFJlbXBlbCA8
by5yZW1wZWxAcGVuZ3V0cm9uaXguZGU+Ci0tLQpjaGFuZ2VzOgoyMDE4MTEzMCB2MzoKIC0gcmV3
b3JkIGNvbW1pdCBtZXNzYWdlIAoyMDE4MTExMiB2MjoKIC0gZHJvcCAiW1BBVENIIHYxIDIvM10g
aTJjOiBpbXg6IHByb2JlIGRtYSBvbmx5IG9ubHkgb24gaS5NWDUwIGFuZAogICBsYXRlciIgYW5k
IHJlYmFzZSB3aXRob3V0IHRoaXMgcGF0Y2guCiAtIFNldCBwcm9wZXIgaW5pdGlhbCBhdXRob3IK
CiBkcml2ZXJzL2kyYy9idXNzZXMvaTJjLWlteC5jIHwgMzYgKysrKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMTUgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1pbXguYyBiL2Ry
aXZlcnMvaTJjL2J1c3Nlcy9pMmMtaW14LmMKaW5kZXggYzQwNjcwMDc4OWUxLi4zYzEyYjE3NGJi
YjEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtaW14LmMKKysrIGIvZHJpdmVy
cy9pMmMvYnVzc2VzL2kyYy1pbXguYwpAQCAtMjczLDcgKzI3Myw3IEBAIHN0YXRpYyBpbmxpbmUg
dW5zaWduZWQgY2hhciBpbXhfaTJjX3JlYWRfcmVnKHN0cnVjdCBpbXhfaTJjX3N0cnVjdCAqaTJj
X2lteCwKIH0KIAogLyogRnVuY3Rpb25zIGZvciBETUEgc3VwcG9ydCAqLwotc3RhdGljIHZvaWQg
aTJjX2lteF9kbWFfcmVxdWVzdChzdHJ1Y3QgaW14X2kyY19zdHJ1Y3QgKmkyY19pbXgsCitzdGF0
aWMgaW50IGkyY19pbXhfZG1hX3JlcXVlc3Qoc3RydWN0IGlteF9pMmNfc3RydWN0ICppMmNfaW14
LAogCQkJCQkJZG1hX2FkZHJfdCBwaHlfYWRkcikKIHsKIAlzdHJ1Y3QgaW14X2kyY19kbWEgKmRt
YTsKQEAgLTI4MywxMSArMjgzLDEzIEBAIHN0YXRpYyB2b2lkIGkyY19pbXhfZG1hX3JlcXVlc3Qo
c3RydWN0IGlteF9pMmNfc3RydWN0ICppMmNfaW14LAogCiAJZG1hID0gZGV2bV9remFsbG9jKGRl
diwgc2l6ZW9mKCpkbWEpLCBHRlBfS0VSTkVMKTsKIAlpZiAoIWRtYSkKLQkJcmV0dXJuOworCQly
ZXR1cm4gLUVOT01FTTsKIAotCWRtYS0+Y2hhbl90eCA9IGRtYV9yZXF1ZXN0X3NsYXZlX2NoYW5u
ZWwoZGV2LCAidHgiKTsKLQlpZiAoIWRtYS0+Y2hhbl90eCkgewotCQlkZXZfZGJnKGRldiwgImNh
bid0IHJlcXVlc3QgRE1BIHR4IGNoYW5uZWxcbiIpOworCWRtYS0+Y2hhbl90eCA9IGRtYV9yZXF1
ZXN0X2NoYW4oZGV2LCAidHgiKTsKKwlpZiAoSVNfRVJSKGRtYS0+Y2hhbl90eCkpIHsKKwkJcmV0
ID0gUFRSX0VSUihkbWEtPmNoYW5fcngpOworCQlpZiAocmV0ICE9IC1FTk9ERVYgJiYgcmV0ICE9
IC1FUFJPQkVfREVGRVIpCisJCQlkZXZfZXJyKGRldiwgImNhbid0IHJlcXVlc3QgRE1BIHR4IGNo
YW5uZWwgKCVkKVxuIiwgcmV0KTsKIAkJZ290byBmYWlsX2FsOwogCX0KIApAQCAtMjk4LDEzICsz
MDAsMTUgQEAgc3RhdGljIHZvaWQgaTJjX2lteF9kbWFfcmVxdWVzdChzdHJ1Y3QgaW14X2kyY19z
dHJ1Y3QgKmkyY19pbXgsCiAJZG1hX3Njb25maWcuZGlyZWN0aW9uID0gRE1BX01FTV9UT19ERVY7
CiAJcmV0ID0gZG1hZW5naW5lX3NsYXZlX2NvbmZpZyhkbWEtPmNoYW5fdHgsICZkbWFfc2NvbmZp
Zyk7CiAJaWYgKHJldCA8IDApIHsKLQkJZGV2X2RiZyhkZXYsICJjYW4ndCBjb25maWd1cmUgdHgg
Y2hhbm5lbFxuIik7CisJCWRldl9lcnIoZGV2LCAiY2FuJ3QgY29uZmlndXJlIHR4IGNoYW5uZWwg
KCVkKVxuIiwgcmV0KTsKIAkJZ290byBmYWlsX3R4OwogCX0KIAotCWRtYS0+Y2hhbl9yeCA9IGRt
YV9yZXF1ZXN0X3NsYXZlX2NoYW5uZWwoZGV2LCAicngiKTsKLQlpZiAoIWRtYS0+Y2hhbl9yeCkg
ewotCQlkZXZfZGJnKGRldiwgImNhbid0IHJlcXVlc3QgRE1BIHJ4IGNoYW5uZWxcbiIpOworCWRt
YS0+Y2hhbl9yeCA9IGRtYV9yZXF1ZXN0X2NoYW4oZGV2LCAicngiKTsKKwlpZiAoSVNfRVJSKGRt
YS0+Y2hhbl9yeCkpIHsKKwkJcmV0ID0gUFRSX0VSUihkbWEtPmNoYW5fcngpOworCQlpZiAocmV0
ICE9IC1FTk9ERVYgJiYgcmV0ICE9IC1FUFJPQkVfREVGRVIpCisJCQlkZXZfZXJyKGRldiwgImNh
bid0IHJlcXVlc3QgRE1BIHJ4IGNoYW5uZWwgKCVkKVxuIiwgcmV0KTsKIAkJZ290byBmYWlsX3R4
OwogCX0KIApAQCAtMzE1LDcgKzMxOSw3IEBAIHN0YXRpYyB2b2lkIGkyY19pbXhfZG1hX3JlcXVl
c3Qoc3RydWN0IGlteF9pMmNfc3RydWN0ICppMmNfaW14LAogCWRtYV9zY29uZmlnLmRpcmVjdGlv
biA9IERNQV9ERVZfVE9fTUVNOwogCXJldCA9IGRtYWVuZ2luZV9zbGF2ZV9jb25maWcoZG1hLT5j
aGFuX3J4LCAmZG1hX3Njb25maWcpOwogCWlmIChyZXQgPCAwKSB7Ci0JCWRldl9kYmcoZGV2LCAi
Y2FuJ3QgY29uZmlndXJlIHJ4IGNoYW5uZWxcbiIpOworCQlkZXZfZXJyKGRldiwgImNhbid0IGNv
bmZpZ3VyZSByeCBjaGFubmVsICglZClcbiIsIHJldCk7CiAJCWdvdG8gZmFpbF9yeDsKIAl9CiAK
QEAgLTMyNCwxNSArMzI4LDE1IEBAIHN0YXRpYyB2b2lkIGkyY19pbXhfZG1hX3JlcXVlc3Qoc3Ry
dWN0IGlteF9pMmNfc3RydWN0ICppMmNfaW14LAogCWRldl9pbmZvKGRldiwgInVzaW5nICVzICh0
eCkgYW5kICVzIChyeCkgZm9yIERNQSB0cmFuc2ZlcnNcbiIsCiAJCWRtYV9jaGFuX25hbWUoZG1h
LT5jaGFuX3R4KSwgZG1hX2NoYW5fbmFtZShkbWEtPmNoYW5fcngpKTsKIAotCXJldHVybjsKKwly
ZXR1cm4gMDsKIAogZmFpbF9yeDoKIAlkbWFfcmVsZWFzZV9jaGFubmVsKGRtYS0+Y2hhbl9yeCk7
CiBmYWlsX3R4OgogCWRtYV9yZWxlYXNlX2NoYW5uZWwoZG1hLT5jaGFuX3R4KTsKIGZhaWxfYWw6
Ci0JZGV2bV9rZnJlZShkZXYsIGRtYSk7Ci0JZGV2X2luZm8oZGV2LCAiY2FuJ3QgdXNlIERNQSwg
dXNpbmcgUElPIGluc3RlYWQuXG4iKTsKKwkvKiByZXR1cm4gc3VjY2Vzc2Z1bGx5IGlmIHRoZXJl
IGlzIG5vIGRtYSBzdXBwb3J0ICovCisJcmV0dXJuIHJldCA9PSAtRU5PREVWID8gMCA6IHJldDsK
IH0KIAogc3RhdGljIHZvaWQgaTJjX2lteF9kbWFfY2FsbGJhY2sodm9pZCAqYXJnKQpAQCAtMTE1
OSwxMSArMTE2MywxMyBAQCBzdGF0aWMgaW50IGkyY19pbXhfcHJvYmUoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldikKIAlkZXZfZGJnKCZpMmNfaW14LT5hZGFwdGVyLmRldiwgImRldmljZSBy
ZXNvdXJjZXM6ICVwUlxuIiwgcmVzKTsKIAlkZXZfZGJnKCZpMmNfaW14LT5hZGFwdGVyLmRldiwg
ImFkYXB0ZXIgbmFtZTogXCIlc1wiXG4iLAogCQlpMmNfaW14LT5hZGFwdGVyLm5hbWUpOwotCWRl
dl9pbmZvKCZpMmNfaW14LT5hZGFwdGVyLmRldiwgIklNWCBJMkMgYWRhcHRlciByZWdpc3RlcmVk
XG4iKTsKIAogCS8qIEluaXQgRE1BIGNvbmZpZyBpZiBzdXBwb3J0ZWQgKi8KLQlpMmNfaW14X2Rt
YV9yZXF1ZXN0KGkyY19pbXgsIHBoeV9hZGRyKTsKKwlyZXQgPSBpMmNfaW14X2RtYV9yZXF1ZXN0
KGkyY19pbXgsIHBoeV9hZGRyKTsKKwlpZiAocmV0IDwgMCkKKwkJZ290byBjbGtfbm90aWZpZXJf
dW5yZWdpc3RlcjsKIAorCWRldl9pbmZvKCZpMmNfaW14LT5hZGFwdGVyLmRldiwgIklNWCBJMkMg
YWRhcHRlciByZWdpc3RlcmVkXG4iKTsKIAlyZXR1cm4gMDsgICAvKiBSZXR1cm4gT0sgKi8KIAog
Y2xrX25vdGlmaWVyX3VucmVnaXN0ZXI6Ci0tIAoyLjE5LjEKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
