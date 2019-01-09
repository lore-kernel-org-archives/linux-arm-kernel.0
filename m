Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C851C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 05:57:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 261C420883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 05:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UHSIh/wX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 261C420883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=apO4Z+E5MmhYp9cBulTmXv/HVM2muED5FkbFS2vhksg=; b=UHSIh/wXqRQn8G
	hiPsMzH2liZViUIuwO3epLVE6K9fMTSP0AWGiY4eDEZm0gfiQZddL5uEcajoLpMj51mXyalN32HqG
	e9ZoriH/Ks1sDdkVR6ctj0Uqh4K9hkRfVnpwmarTtHr0G3/FpjJNblLdTpEOVBJfVpWGLxOoLX53K
	v9ySJ2k2A5g6dOoxZ1P9PnmvMCkpYrKVGTddhr/9XehZMsiaWY9pVDsrjyO/IRPYycDGUXQHRSJW0
	+N6xtaApidvrQOXfsv6imu7BkGM4CpiYBwPjjerfekQ2+qVppH/Eln/JHaHKPOS83UwT8FR83tiAK
	pCkVdwwvaNCmw1aXRxhw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gh6rc-0004ev-Ei; Wed, 09 Jan 2019 05:57:16 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gh6rR-0004Td-M7
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 05:57:10 +0000
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ore@pengutronix.de>)
 id 1gh6rF-0002Gd-5K; Wed, 09 Jan 2019 06:56:53 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.91)
 (envelope-from <ore@pengutronix.de>)
 id 1gh6rE-0008Q1-E6; Wed, 09 Jan 2019 06:56:52 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Wolfram Sang <wsa@the-dreams.de>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v5 2/2] i2c: imx: improve the error handling in
 i2c_imx_dma_request()
Date: Wed,  9 Jan 2019 06:56:50 +0100
Message-Id: <20190109055650.32259-3-o.rempel@pengutronix.de>
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
X-CRM114-CacheID: sfid-20190108_215706_186167_4907A094 
X-CRM114-Status: GOOD (  13.65  )
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

SW1wcm92ZSB0aGUgZXJyb3IgaGFuZGxpbmcgaW4gaTJjX2lteF9kbWFfcmVxdWVzdCgpIGFuZCBs
ZXQgaXQgcmV0dXJuIGFuIGVycm9yCmluZGljYXRpb24gdGhhdCB0aGUgY2FsbGVyIHRoZW4gY2Fu
IGhhbmRsZSBhY2NvcmRpbmdseS4KClNpZ25lZC1vZmYtYnk6IE9sZWtzaWogUmVtcGVsIDxvLnJl
bXBlbEBwZW5ndXRyb25peC5kZT4KQWNrZWQtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWlu
ZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+Ci0tLQogZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1pbXgu
YyB8IDE2ICsrKysrKysrKystLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCsp
LCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtaW14
LmMgYi9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLWlteC5jCmluZGV4IGUyOGVmNDk0ZGFjOC4uMDli
MTI0NTQ3NjY5IDEwMDY0NAotLS0gYS9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLWlteC5jCisrKyBi
L2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtaW14LmMKQEAgLTI3Myw4ICsyNzMsOCBAQCBzdGF0aWMg
aW5saW5lIHVuc2lnbmVkIGNoYXIgaW14X2kyY19yZWFkX3JlZyhzdHJ1Y3QgaW14X2kyY19zdHJ1
Y3QgKmkyY19pbXgsCiB9CiAKIC8qIEZ1bmN0aW9ucyBmb3IgRE1BIHN1cHBvcnQgKi8KLXN0YXRp
YyB2b2lkIGkyY19pbXhfZG1hX3JlcXVlc3Qoc3RydWN0IGlteF9pMmNfc3RydWN0ICppMmNfaW14
LAotCQkJCQkJZG1hX2FkZHJfdCBwaHlfYWRkcikKK3N0YXRpYyBpbnQgaTJjX2lteF9kbWFfcmVx
dWVzdChzdHJ1Y3QgaW14X2kyY19zdHJ1Y3QgKmkyY19pbXgsCisJCQkgICAgICAgZG1hX2FkZHJf
dCBwaHlfYWRkcikKIHsKIAlzdHJ1Y3QgaW14X2kyY19kbWEgKmRtYTsKIAlzdHJ1Y3QgZG1hX3Ns
YXZlX2NvbmZpZyBkbWFfc2NvbmZpZzsKQEAgLTI4Myw3ICsyODMsNyBAQCBzdGF0aWMgdm9pZCBp
MmNfaW14X2RtYV9yZXF1ZXN0KHN0cnVjdCBpbXhfaTJjX3N0cnVjdCAqaTJjX2lteCwKIAogCWRt
YSA9IGRldm1fa3phbGxvYyhkZXYsIHNpemVvZigqZG1hKSwgR0ZQX0tFUk5FTCk7CiAJaWYgKCFk
bWEpCi0JCXJldHVybjsKKwkJcmV0dXJuIC1FTk9NRU07CiAKIAlkbWEtPmNoYW5fdHggPSBkbWFf
cmVxdWVzdF9jaGFuKGRldiwgInR4Iik7CiAJaWYgKElTX0VSUihkbWEtPmNoYW5fdHgpKSB7CkBA
IC0zMjgsNyArMzI4LDcgQEAgc3RhdGljIHZvaWQgaTJjX2lteF9kbWFfcmVxdWVzdChzdHJ1Y3Qg
aW14X2kyY19zdHJ1Y3QgKmkyY19pbXgsCiAJZGV2X2luZm8oZGV2LCAidXNpbmcgJXMgKHR4KSBh
bmQgJXMgKHJ4KSBmb3IgRE1BIHRyYW5zZmVyc1xuIiwKIAkJZG1hX2NoYW5fbmFtZShkbWEtPmNo
YW5fdHgpLCBkbWFfY2hhbl9uYW1lKGRtYS0+Y2hhbl9yeCkpOwogCi0JcmV0dXJuOworCXJldHVy
biAwOwogCiBmYWlsX3J4OgogCWRtYV9yZWxlYXNlX2NoYW5uZWwoZG1hLT5jaGFuX3J4KTsKQEAg
LTMzNiw2ICszMzYsOCBAQCBzdGF0aWMgdm9pZCBpMmNfaW14X2RtYV9yZXF1ZXN0KHN0cnVjdCBp
bXhfaTJjX3N0cnVjdCAqaTJjX2lteCwKIAlkbWFfcmVsZWFzZV9jaGFubmVsKGRtYS0+Y2hhbl90
eCk7CiBmYWlsX2FsOgogCWRldm1fa2ZyZWUoZGV2LCBkbWEpOworCS8qIHJldHVybiBzdWNjZXNz
ZnVsbHkgaWYgdGhlcmUgaXMgbm8gZG1hIHN1cHBvcnQgKi8KKwlyZXR1cm4gcmV0ID09IC1FTk9E
RVYgPyAwIDogcmV0OwogfQogCiBzdGF0aWMgdm9pZCBpMmNfaW14X2RtYV9jYWxsYmFjayh2b2lk
ICphcmcpCkBAIC0xMTYzLDExICsxMTY1LDEzIEBAIHN0YXRpYyBpbnQgaTJjX2lteF9wcm9iZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCWRldl9kYmcoJmkyY19pbXgtPmFkYXB0ZXIu
ZGV2LCAiZGV2aWNlIHJlc291cmNlczogJXBSXG4iLCByZXMpOwogCWRldl9kYmcoJmkyY19pbXgt
PmFkYXB0ZXIuZGV2LCAiYWRhcHRlciBuYW1lOiBcIiVzXCJcbiIsCiAJCWkyY19pbXgtPmFkYXB0
ZXIubmFtZSk7Ci0JZGV2X2luZm8oJmkyY19pbXgtPmFkYXB0ZXIuZGV2LCAiSU1YIEkyQyBhZGFw
dGVyIHJlZ2lzdGVyZWRcbiIpOwogCiAJLyogSW5pdCBETUEgY29uZmlnIGlmIHN1cHBvcnRlZCAq
LwotCWkyY19pbXhfZG1hX3JlcXVlc3QoaTJjX2lteCwgcGh5X2FkZHIpOworCXJldCA9IGkyY19p
bXhfZG1hX3JlcXVlc3QoaTJjX2lteCwgcGh5X2FkZHIpOworCWlmIChyZXQgPCAwKQorCQlnb3Rv
IGNsa19ub3RpZmllcl91bnJlZ2lzdGVyOwogCisJZGV2X2luZm8oJmkyY19pbXgtPmFkYXB0ZXIu
ZGV2LCAiSU1YIEkyQyBhZGFwdGVyIHJlZ2lzdGVyZWRcbiIpOwogCXJldHVybiAwOyAgIC8qIFJl
dHVybiBPSyAqLwogCiBjbGtfbm90aWZpZXJfdW5yZWdpc3RlcjoKLS0gCjIuMTkuMQoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJu
ZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
