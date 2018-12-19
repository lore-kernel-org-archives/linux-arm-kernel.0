Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE119C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:37:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C1E0218AD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ms25ZqBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1E0218AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=smbAmYUWZ+8XowsmwDM9X4N74L42XD+zzWUqtuSdMIA=; b=Ms25ZqByc6kUW7
	5H1pJJfA6Dw5p9SCVkfcY3pFEz2vggDgxuECL3WCKb4OEfjps/Ak6tdJYGyEVmgBKhGyh9Ejdj/K4
	6RcVYaRf3RI02INm0Xyzq6D/Q/hALYbVzXxk8T+IJKSQCr2loCMY4lRiuvc9OUodyXy9AEnOiahy/
	+yGZL7mMY7zHFcJqoL4W8rPdoSHHC5bf0lics2ZXugU1njiKbLzx0FZDHfbCqAGtNULySLGe9/96c
	rC63N3sBq9algUYnOIgGY7/BbtKT9wXxW5gBiV/kyFi7JqktMDAT4xWFViwEUeI2owXquvtXkyR+v
	5qu/+JR6p803/eJb0cIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZcyF-0003RQ-8M; Wed, 19 Dec 2018 14:37:11 +0000
Received: from inva020.nxp.com ([92.121.34.13])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZcyB-0003QN-13
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 14:37:08 +0000
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D9BAF1A0059;
 Wed, 19 Dec 2018 15:36:54 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com
 [134.27.226.22])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C3A5A1A0051;
 Wed, 19 Dec 2018 15:36:54 +0100 (CET)
Received: from enigma.ea.freescale.net (enigma.ea.freescale.net
 [10.171.81.110])
 by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 7195620466;
 Wed, 19 Dec 2018 15:36:54 +0100 (CET)
From: =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH] crypto: caam - fix zero-length buffer DMA mapping
Date: Wed, 19 Dec 2018 16:36:44 +0200
Message-Id: <20181219143644.22089-1-horia.geanta@nxp.com>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_063707_345424_D83B9B37 
X-CRM114-Status: GOOD (  10.39  )
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
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>, Christoph Hellwig <hch@lst.de>,
 linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

RnJvbTogQXltZW4gU2doYWllciA8YXltZW4uc2doYWllckBueHAuY29tPgoKUmVjZW50IGNoYW5n
ZXMgLSBwcm9iYWJseSBETUEgQVBJIHJlbGF0ZWQgKGdlbmVyaWMgYW5kL29yIGFybTY0LXNwZWNp
ZmljKSAtCmV4cG9zZWQgYSBjYXNlIHdoZXJlIGRyaXZlciBtYXBzIGEgemVyby1sZW5ndGggYnVm
ZmVyOgphaGFzaF9pbml0KCktPmFoYXNoX3VwZGF0ZSgpLT5haGFzaF9maW5hbCgpIHdpdGggYSB6
ZXJvLWxlbmd0aCBzdHJpbmcgdG8KaGFzaAoKa2VybmVsIEJVRyBhdCBrZXJuZWwvZG1hL3N3aW90
bGIuYzo0NzUhCkludGVybmFsIGVycm9yOiBPb3BzIC0gQlVHOiAwIFsjMV0gUFJFRU1QVCBTTVAK
TW9kdWxlcyBsaW5rZWQgaW46CkNQVTogMiBQSUQ6IDE4MjMgQ29tbTogY3J5cHRvbWdyX3Rlc3Qg
Tm90IHRhaW50ZWQgNC4yMC4wLXJjMS0wMDEwOC1nMDBjOWZlMzdhN2YyICMxCkhhcmR3YXJlIG5h
bWU6IExTMTA0NkEgUkRCIEJvYXJkIChEVCkKcHN0YXRlOiA4MDAwMDAwNSAoTnpjdiBkYWlmIC1Q
QU4gLVVBTykKcGMgOiBzd2lvdGxiX3RibF9tYXBfc2luZ2xlKzB4MTcwLzB4MmI4CmxyIDogc3dp
b3RsYl9tYXBfcGFnZSsweDEzNC8weDFmOApzcCA6IGZmZmYwMDAwMGY3OWI4ZjAKeDI5OiBmZmZm
MDAwMDBmNzliOGYwIHgyODogMDAwMDAwMDAwMDAwMDAwMAp4Mjc6IGZmZmYwMDAwMDkzZDAwMDAg
eDI2OiAwMDAwMDAwMDAwMDAwMDAwCngyNTogMDAwMDAwMDAwMDFmM2ZmZSB4MjQ6IDAwMDAwMDAw
MDAyMDAwMDAKeDIzOiAwMDAwMDAwMDAwMDAwMDAwIHgyMjogMDAwMDAwMDlmMmM1MzhjMAp4MjE6
IGZmZmY4MDA5NzBhZWI0MTAgeDIwOiAwMDAwMDAwMDAwMDAwMDAxCngxOTogZmZmZjgwMDk3MGFl
YjQxMCB4MTg6IDAwMDAwMDAwMDAwMDAwMDcKeDE3OiAwMDAwMDAwMDAwMDAwMDBlIHgxNjogMDAw
MDAwMDAwMDAwMDAwMQp4MTU6IDAwMDAwMDAwMDAwMDAwMTkgeDE0OiBjMzJjYjgyMThhMTY3ZmU4
CngxMzogZmZmZmZmZmYwMDAwMDAwMCB4MTI6IGZmZmY4MDA5N2ZkYWUzNDgKeDExOiAwMDAwODAw
OTc2YmNhMDAwIHgxMDogMDAwMDAwMDAwMDAwMDAxMAp4OSA6IDAwMDAwMDAwMDAwMDAwMDAgeDgg
OiBmZmZmMDAwMDA5MWZkNmM4Cng3IDogMDAwMDAwMDAwMDAwMDAwMCB4NiA6IDAwMDAwMDA5ZjJj
NTM4YmYKeDUgOiAwMDAwMDAwMDAwMDAwMDAwIHg0IDogMDAwMDAwMDAwMDAwMDAwMQp4MyA6IDAw
MDAwMDAwMDAwMDAwMDAgeDIgOiAwMDAwMDAwOWYyYzUzOGMwCngxIDogMDAwMDAwMDBmOWZmZjAw
MCB4MCA6IDAwMDAwMDAwMDAwMDAwMDAKUHJvY2VzcyBjcnlwdG9tZ3JfdGVzdCAocGlkOiAxODIz
LCBzdGFjayBsaW1pdCA9IDB4KF9fX19wdHJ2YWxfX19fKSkKQ2FsbCB0cmFjZToKIHN3aW90bGJf
dGJsX21hcF9zaW5nbGUrMHgxNzAvMHgyYjgKIHN3aW90bGJfbWFwX3BhZ2UrMHgxMzQvMHgxZjgK
IGFoYXNoX2ZpbmFsX25vX2N0eCsweGM0LzB4NmNjCiBhaGFzaF9maW5hbCsweDEwLzB4MTgKIGNy
eXB0b19haGFzaF9vcCsweDMwLzB4ODQKIGNyeXB0b19haGFzaF9maW5hbCsweDE0LzB4MWMKIF9f
dGVzdF9oYXNoKzB4NTc0LzB4ZTBjCiB0ZXN0X2hhc2grMHgyOC8weDgwCiBfX2FsZ190ZXN0X2hh
c2grMHg4NC8weGQwCiBhbGdfdGVzdF9oYXNoKzB4NzgvMHgxNDQKIGFsZ190ZXN0LnBhcnQuMzAr
MHgxMmMvMHgyYjQKIGFsZ190ZXN0KzB4M2MvMHg2OAogY3J5cHRvbWdyX3Rlc3QrMHg0NC8weDRj
CiBrdGhyZWFkKzB4ZmMvMHgxMjgKIHJldF9mcm9tX2ZvcmsrMHgxMC8weDE4CkNvZGU6IGQzNGJm
YzE4IDJhMWEwM2Y3IDFhOWY4Njk0IDM1ZmZmODlhIChkNDIxMDAwMCkKCkNjOiA8c3RhYmxlQHZn
ZXIua2VybmVsLm9yZz4KU2lnbmVkLW9mZi1ieTogQXltZW4gU2doYWllciA8YXltZW4uc2doYWll
ckBueHAuY29tPgpTaWduZWQtb2ZmLWJ5OiBIb3JpYSBHZWFudMSDIDxob3JpYS5nZWFudGFAbnhw
LmNvbT4KLS0tCgpBIGJpc2VjdCBiL3cgYWJvdmUtbWVudGlvbmVkIGNvbW1pdCAwMGM5ZmUzN2E3
ZjIgKGJhZCkgYW5kIHY0LjE5IChnb29kKQpwb2ludHMgdG8gY29tbWl0CmI0ZWJlNjA2MzIwNCAo
ImRtYS1kaXJlY3Q6IGltcGxlbWVudCBjb21wbGV0ZSBidXNfZG1hX21hc2sgaGFuZGxpbmciKQoK
Q2hyb25vbG9naWNhbGx5Ogp2NC4xOSAoZ29vZCkgLT4gYjRlYmU2MDYzMjA0IChiYWQpIC0+IDAw
YzlmZTM3YTdmMiAoYmFkKSAtPiB2NC4yMC1yYzcgKGdvb2QpCgpDYy1pbmcgc3RhYmxlIHRvIG1h
a2Ugc3VyZSBwYXRjaCB3aWxsIGJlIGFkZGVkIGluIDQuMjAueQoKIGRyaXZlcnMvY3J5cHRvL2Nh
YW0vY2FhbWhhc2guYyB8IDE1ICsrKysrKysrKy0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDkgaW5z
ZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2NyeXB0by9j
YWFtL2NhYW1oYXNoLmMgYi9kcml2ZXJzL2NyeXB0by9jYWFtL2NhYW1oYXNoLmMKaW5kZXggODE3
MTJhYTVkMGYyLi5iYjFhMmNkZjE5NTEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY3J5cHRvL2NhYW0v
Y2FhbWhhc2guYworKysgYi9kcml2ZXJzL2NyeXB0by9jYWFtL2NhYW1oYXNoLmMKQEAgLTEwNzIs
MTMgKzEwNzIsMTYgQEAgc3RhdGljIGludCBhaGFzaF9maW5hbF9ub19jdHgoc3RydWN0IGFoYXNo
X3JlcXVlc3QgKnJlcSkKIAogCWRlc2MgPSBlZGVzYy0+aHdfZGVzYzsKIAotCXN0YXRlLT5idWZf
ZG1hID0gZG1hX21hcF9zaW5nbGUoanJkZXYsIGJ1ZiwgYnVmbGVuLCBETUFfVE9fREVWSUNFKTsK
LQlpZiAoZG1hX21hcHBpbmdfZXJyb3IoanJkZXYsIHN0YXRlLT5idWZfZG1hKSkgewotCQlkZXZf
ZXJyKGpyZGV2LCAidW5hYmxlIHRvIG1hcCBzcmNcbiIpOwotCQlnb3RvIHVubWFwOwotCX0KKwlp
ZiAoYnVmbGVuKSB7CisJCXN0YXRlLT5idWZfZG1hID0gZG1hX21hcF9zaW5nbGUoanJkZXYsIGJ1
ZiwgYnVmbGVuLAorCQkJCQkJRE1BX1RPX0RFVklDRSk7CisJCWlmIChkbWFfbWFwcGluZ19lcnJv
cihqcmRldiwgc3RhdGUtPmJ1Zl9kbWEpKSB7CisJCQlkZXZfZXJyKGpyZGV2LCAidW5hYmxlIHRv
IG1hcCBzcmNcbiIpOworCQkJZ290byB1bm1hcDsKKwkJfQogCi0JYXBwZW5kX3NlcV9pbl9wdHIo
ZGVzYywgc3RhdGUtPmJ1Zl9kbWEsIGJ1ZmxlbiwgMCk7CisJCWFwcGVuZF9zZXFfaW5fcHRyKGRl
c2MsIHN0YXRlLT5idWZfZG1hLCBidWZsZW4sIDApOworCX0KIAogCWVkZXNjLT5kc3RfZG1hID0g
bWFwX3NlcV9vdXRfcHRyX3Jlc3VsdChkZXNjLCBqcmRldiwgcmVxLT5yZXN1bHQsCiAJCQkJCQlk
aWdlc3RzaXplKTsKLS0gCjIuMTYuMgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
