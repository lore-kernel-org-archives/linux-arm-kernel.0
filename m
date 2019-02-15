Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3771C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:12:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2F6B2192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h/Anhj4T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2F6B2192D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aYc2ARTU8t5xIw3yDQNH9ZPdHIvrFpBUaukPlSc9RCk=; b=h/Anhj4TJMQhpW
	/790aEy+rxqIzmThXL9pQJsdhCxvgpeGmC+DwbvVvutZQseAzCW47FKk+DjgjH4LRYdoAkg2yZk/P
	7jGlRwfpkP2giKK6/OV9y476YykLBm90pKA/7A+WgaLl7jkfAtIGQZYBqYjYDuxIdgzPw+yLg3sby
	oln162nx3PRbEYULFWBwtyVbx4e2OAcUgHFoeY67efy/pKUKz8KEBBFOwczAZ5RKqfmJiNR58NRg8
	68G5UtTrS6RYZ7FPwmEaSn90JfykWHuVrk062USe+xy1pDFOQOX5tA0LMRlHTldPfSFEkI0E6Ij+S
	LQDoLggtOsOZ+AFHwkXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gueDi-0005oz-Oo; Fri, 15 Feb 2019 14:12:02 +0000
Received: from honk.sigxcpu.org ([24.134.29.49])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gueDe-0005n7-T9; Fri, 15 Feb 2019 14:12:00 +0000
Received: from localhost (localhost [127.0.0.1])
 by honk.sigxcpu.org (Postfix) with ESMTP id 7154DFB04;
 Fri, 15 Feb 2019 15:11:57 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
 by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fKVRYMpwFlcI; Fri, 15 Feb 2019 15:11:56 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
 id 529B748DC2; Fri, 15 Feb 2019 15:11:53 +0100 (CET)
From: =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Bastien Nocera <hadess@hadess.net>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
 linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: [PATCH v3 3/3] input: goodix: Print values in case of inconsistencies
Date: Fri, 15 Feb 2019 15:11:53 +0100
Message-Id: <c2f48f779b64478cb7e0c63e3a2ee19e160d1292.1550239328.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1550239328.git.agx@sigxcpu.org>
References: <cover.1550239328.git.agx@sigxcpu.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_061159_099530_52C11DE2 
X-CRM114-Status: UNSURE (   9.41  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

IkludmFsaWQgY29uZmlnIiBnaXZlcyBsaXR0bGUgaWRlYSB3aGF0J3Mgd3JvbmcuIFByaW50IHRo
ZSB2YWx1ZXMgdGhhdAptdXN0IG5vdCBiZSAwIHNvIHdlIGtub3cgd2hpY2ggb25lcyBhcmUgb2Zm
LgoKU2lnbmVkLW9mZi1ieTogR3VpZG8gR8O8bnRoZXIgPGFneEBzaWd4Y3B1Lm9yZz4KLS0tCiBk
cml2ZXJzL2lucHV0L3RvdWNoc2NyZWVuL2dvb2RpeC5jIHwgNCArKystCiAxIGZpbGUgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
bnB1dC90b3VjaHNjcmVlbi9nb29kaXguYyBiL2RyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vZ29v
ZGl4LmMKaW5kZXggNDdiMWNlZDQxNTc2Li5mNTdkODIyMjBhODggMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvaW5wdXQvdG91Y2hzY3JlZW4vZ29vZGl4LmMKKysrIGIvZHJpdmVycy9pbnB1dC90b3VjaHNj
cmVlbi9nb29kaXguYwpAQCAtNjkzLDcgKzY5Myw5IEBAIHN0YXRpYyBpbnQgZ29vZGl4X2NvbmZp
Z3VyZV9kZXYoc3RydWN0IGdvb2RpeF90c19kYXRhICp0cykKIAl0b3VjaHNjcmVlbl9wYXJzZV9w
cm9wZXJ0aWVzKHRzLT5pbnB1dF9kZXYsIHRydWUsICZ0cy0+cHJvcCk7CiAKIAlpZiAoIXRzLT5w
cm9wLm1heF94IHx8ICF0cy0+cHJvcC5tYXhfeSB8fCAhdHMtPm1heF90b3VjaF9udW0pIHsKLQkJ
ZGV2X2VycigmdHMtPmNsaWVudC0+ZGV2LCAiSW52YWxpZCBjb25maWcsIHVzaW5nIGRlZmF1bHRz
XG4iKTsKKwkJZGV2X2VycigmdHMtPmNsaWVudC0+ZGV2LAorCQkJIkludmFsaWQgY29uZmlnICgl
ZCwgJWQsICVkKSwgdXNpbmcgZGVmYXVsdHNcbiIsCisJCQl0cy0+cHJvcC5tYXhfeCwgdHMtPnBy
b3AubWF4X3ksIHRzLT5tYXhfdG91Y2hfbnVtKTsKIAkJdHMtPnByb3AubWF4X3ggPSBHT09ESVhf
TUFYX1dJRFRIIC0gMTsKIAkJdHMtPnByb3AubWF4X3kgPSBHT09ESVhfTUFYX0hFSUdIVCAtIDE7
CiAJCXRzLT5tYXhfdG91Y2hfbnVtID0gR09PRElYX01BWF9DT05UQUNUUzsKLS0gCjIuMjAuMQoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFy
bS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1r
ZXJuZWwK
