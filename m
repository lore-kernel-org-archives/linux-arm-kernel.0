Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEECC7112F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:27:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF21120663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r74FC/uY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF21120663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=0Tp/u/03uPl0Mcu2hSs4szKRf3xGuGQLsCrQLrSGKpU=; b=r74FC/uYm6ACST
	tYWI7W10GUW60d4neKmrV3uclRzqw5BxYNyQRQBSlWh0wv+u3FMHC0Wmb5AsmF7nNn1S3bJOokg/k
	GCPJ+ANQJMH7htIe2Iiim7FymviKGEOT+MiA331cC7OKwczrDmy2ytFieGqWZtXOnkQD9X8NXtzRt
	fUp9pzE3TQBOs37JPW6Q10Tzsk9Q71HsYNe+W9D3+UYXk/fTlqZgp1JbM7CIoDLliVTrpE7rkBkbG
	yPhfTc3hOyRoyVEkn1TAXoT0c5dWWBUrEw13nAOZ8MQaXfBYytRLW66jTyx6R1p4fGPAOsaU6QA6s
	5cB1+SYjHFq99HPgPdSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glXjb-0005sW-72; Mon, 21 Jan 2019 11:27:19 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glXip-00057S-7m
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 11:27:16 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1348AEBD;
 Mon, 21 Jan 2019 03:26:29 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.44])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B08883F5C1;
 Mon, 21 Jan 2019 03:26:27 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH] dma: imx: Fix arm64 compilation issue due to min() size issue
Date: Mon, 21 Jan 2019 11:26:22 +0000
Message-Id: <20190121112622.127542-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_032631_612996_9BAFAA43 
X-CRM114-Status: GOOD (  16.31  )
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
Cc: dmaengine@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Q29tcGlsaW5nIHRoZSBpLk1YIERNQSBkcml2ZXIgZm9yIGFybTY0IHJlc3VsdHMgaW4gYSB3YXJu
aW5nIGR1ZSB0bwppbXhkbWFfZGVzYy0+bGVuIGJlaW5nIGEgc2l6ZV90LCB3aGlsZSBzY2F0dGVy
bGlzdC0+bGVuIGJlaW5nIGFuIHVpbnQ6Cgpkcml2ZXJzL2RtYS9pbXgtZG1hLmM6IEluIGZ1bmN0
aW9uIOKAmGlteGRtYV9zZ19uZXh04oCZOgovc3JjL2xpbnV4L2luY2x1ZGUvbGludXgva2VybmVs
Lmg6ODQ2OjI5OiB3YXJuaW5nOiBjb21wYXJpc29uIG9mIGRpc3RpbmN0IHBvaW50ZXIgdHlwZXMg
bGFja3MgYSBjYXN0CiAgICghIShzaXplb2YoKHR5cGVvZih4KSAqKTEgPT0gKHR5cGVvZih5KSAq
KTEpKSkKLi4uCmRyaXZlcnMvZG1hL2lteC1kbWEuYzoyODg6ODogbm90ZTogaW4gZXhwYW5zaW9u
IG9mIG1hY3JvIOKAmG1pbuKAmQogIG5vdyA9IG1pbihkLT5sZW4sIHNnX2RtYV9sZW4oc2cpKTsK
ICAgICAgICBefn4KCkkgYW0gbm90IHN1cmUgaWYgc2l6ZV90IGlzIHRoZSByaWdodCB0eXBlIGZv
ciBsZW4gaW4gdGhlIGZpcnN0IHBsYWNlLApidXQgYW55d2F5IHRoZSBmaXggaXMgcHJldHR5IHNp
bXBsZS4KClRoaXMgZml4ZXMgY29tcGlsaW5nIGFuIGFybTY0IGtlcm5lbCB3aXRoIGkuTVggKERN
QSkgc3VwcG9ydCBlbmFibGVkLgoKU2lnbmVkLW9mZi1ieTogQW5kcmUgUHJ6eXdhcmEgPGFuZHJl
LnByenl3YXJhQGFybS5jb20+Ci0tLQpIaSwKCmFwb2xvZ2llcyBpZiB0aGlzIGhhcyBiZWVuIHNl
bnQgYWxyZWFkeSAoanVzdCBpZ25vcmUgaXQgdGhlbiksIGJ1dCBJCmNvdWxkbid0IGZpbmQgYW55
dGhpbmcgcXVpY2tseSBlbm91Z2guIEkgc2VlIHRoaXMgc2luY2UgLXJjMSwgYnV0IGl0J3MKc3Rp
bGwgYW5ub3lpbmcgbWUgaW4gLXJjMywgaGVuY2UgdGhpcyBwYXRjaC4KCkNoZWVycywKQW5kcmUu
CgogZHJpdmVycy9kbWEvaW14LWRtYS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvaW14LWRtYS5j
IGIvZHJpdmVycy9kbWEvaW14LWRtYS5jCmluZGV4IGMyZmZmM2Y2YzljYS4uZmEzZWY0M2ZlMzE0
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2RtYS9pbXgtZG1hLmMKKysrIGIvZHJpdmVycy9kbWEvaW14
LWRtYS5jCkBAIC0yODUsNyArMjg1LDcgQEAgc3RhdGljIGlubGluZSBpbnQgaW14ZG1hX3NnX25l
eHQoc3RydWN0IGlteGRtYV9kZXNjICpkKQogCXN0cnVjdCBzY2F0dGVybGlzdCAqc2cgPSBkLT5z
ZzsKIAl1bnNpZ25lZCBsb25nIG5vdzsKIAotCW5vdyA9IG1pbihkLT5sZW4sIHNnX2RtYV9sZW4o
c2cpKTsKKwlub3cgPSBtaW5fdChzaXplX3QsIGQtPmxlbiwgc2dfZG1hX2xlbihzZykpOwogCWlm
IChkLT5sZW4gIT0gSU1YX0RNQV9MRU5HVEhfTE9PUCkKIAkJZC0+bGVuIC09IG5vdzsKIAotLSAK
Mi4xNy4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtYXJtLWtlcm5lbAo=
