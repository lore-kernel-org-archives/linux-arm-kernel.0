Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972C9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:56:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 694F0204EC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ki+dps1+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 694F0204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mlZDxKfRCI6C+/9OVDsztdDr36DUIcAJcYZghhRn0qU=; b=ki+dps1+1jwEhJ
	OXSVmpzRdUxERpBp7OCcDGygD0QKa2nY7usaV24GSrwsoO+S5vROH3+Khdj7cZExE1A2DCCvCwoVz
	SnLngDxpS2DcAceDziJ2z9EZQsLkBFvs75XL56yBA4UZEIDh9fVksTjNYd9+8QytCuupxsrDBea+d
	QBwpDoaV01cD0I4q8Qjtt9cLRS/HsrGx/H3HburNkfLtqxiixNoUlJzKj1xqVj8TsTiOKVJHt7P9i
	LSmyGfMHc5s7IG9kOBCAJXveNMW6K9imh7FcT1qPWCdzFR2PmNN1MHPn5E9V52TqAeoqRFdHixuWR
	jjSZZJwDJHjVYVgI43jw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvp1t-0008Fz-Hf; Mon, 18 Feb 2019 19:56:41 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvozm-0004c0-4z
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 19:54:42 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D4761BF7;
 Mon, 18 Feb 2019 11:54:14 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 33C953FD55;
 Mon, 18 Feb 2019 11:53:48 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v5 10/26] KVM: arm64: Propagate vcpu into read_id_reg()
Date: Mon, 18 Feb 2019 19:52:23 +0000
Message-Id: <1550519559-15915-11-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_115430_451044_D54CEC56 
X-CRM114-Status: GOOD (  12.93  )
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Okamoto Takayuki <tokamoto@jp.fujitsu.com>,
 Christoffer Dall <cdall@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Zhang Lei <zhang.lei@jp.fujitsu.com>,
 Julien Grall <julien.grall@arm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QXJjaGl0ZWN0dXJlIGZlYXR1cmVzIHRoYXQgYXJlIGNvbmRpdGlvbmFsbHkgdmlzaWJsZSB0byB0
aGUgZ3Vlc3QKd2lsbCByZXF1aXJlIHJ1bi10aW1lIGNoZWNrcyBpbiB0aGUgSUQgcmVnaXN0ZXIg
YWNjZXNzb3IgZnVuY3Rpb25zLgpJbiBwYXJ0aWN1bGFyLCByZWFkX2lkX3JlZygpIHdpbGwgbmVl
ZCB0byBwZXJmb3JtIGNoZWNrcyBpbiBvcmRlcgp0byBnZW5lcmF0ZSB0aGUgY29ycmVjdCBlbXVs
YXRlZCB2YWx1ZSBmb3IgY2VydGFpbiBJRCByZWdpc3RlcgpmaWVsZHMgc3VjaCBhcyBJRF9BQTY0
UEZSMF9FTDEuU1ZFIGZvciBleGFtcGxlLgoKVGhpcyBwYXRjaCBwcm9wYWdhdGVzIHZjcHUgaW50
byByZWFkX2lkX3JlZygpIHNvIHRoYXQgZnV0dXJlCnBhdGNoZXMgY2FuIGFkZCBydW4tdGltZSBj
aGVja3Mgb24gdGhlIGd1ZXN0IGNvbmZpZ3VyYXRpb24gaGVyZS4KCkZvciBub3csIHRoZXJlIGlz
IG5vIGZ1bmN0aW9uYWwgY2hhbmdlLgoKU2lnbmVkLW9mZi1ieTogRGF2ZSBNYXJ0aW4gPERhdmUu
TWFydGluQGFybS5jb20+ClJldmlld2VkLWJ5OiBBbGV4IEJlbm7DqWUgPGFsZXguYmVubmVlQGxp
bmFyby5vcmc+Ci0tLQogYXJjaC9hcm02NC9rdm0vc3lzX3JlZ3MuYyB8IDIzICsrKysrKysrKysr
KystLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9rdm0vc3lzX3JlZ3MuYyBiL2FyY2gvYXJt
NjQva3ZtL3N5c19yZWdzLmMKaW5kZXggZTNlMzcyMi4uNzFjNTgyNSAxMDA2NDQKLS0tIGEvYXJj
aC9hcm02NC9rdm0vc3lzX3JlZ3MuYworKysgYi9hcmNoL2FybTY0L2t2bS9zeXNfcmVncy5jCkBA
IC0xMDI5LDcgKzEwMjksOCBAQCBzdGF0aWMgYm9vbCBhY2Nlc3NfY250cF9jdmFsKHN0cnVjdCBr
dm1fdmNwdSAqdmNwdSwKIH0KIAogLyogUmVhZCBhIHNhbml0aXNlZCBjcHVmZWF0dXJlIElEIHJl
Z2lzdGVyIGJ5IHN5c19yZWdfZGVzYyAqLwotc3RhdGljIHU2NCByZWFkX2lkX3JlZyhzdHJ1Y3Qg
c3lzX3JlZ19kZXNjIGNvbnN0ICpyLCBib29sIHJheikKK3N0YXRpYyB1NjQgcmVhZF9pZF9yZWco
Y29uc3Qgc3RydWN0IGt2bV92Y3B1ICp2Y3B1LAorCQlzdHJ1Y3Qgc3lzX3JlZ19kZXNjIGNvbnN0
ICpyLCBib29sIHJheikKIHsKIAl1MzIgaWQgPSBzeXNfcmVnKCh1MzIpci0+T3AwLCAodTMyKXIt
Pk9wMSwKIAkJCSAodTMyKXItPkNSbiwgKHUzMilyLT5DUm0sICh1MzIpci0+T3AyKTsKQEAgLTEw
NjgsNyArMTA2OSw3IEBAIHN0YXRpYyBib29sIF9fYWNjZXNzX2lkX3JlZyhzdHJ1Y3Qga3ZtX3Zj
cHUgKnZjcHUsCiAJaWYgKHAtPmlzX3dyaXRlKQogCQlyZXR1cm4gd3JpdGVfdG9fcmVhZF9vbmx5
KHZjcHUsIHAsIHIpOwogCi0JcC0+cmVndmFsID0gcmVhZF9pZF9yZWcociwgcmF6KTsKKwlwLT5y
ZWd2YWwgPSByZWFkX2lkX3JlZyh2Y3B1LCByLCByYXopOwogCXJldHVybiB0cnVlOwogfQogCkBA
IC0xMDk3LDE2ICsxMDk4LDE4IEBAIHN0YXRpYyB1NjQgc3lzX3JlZ190b19pbmRleChjb25zdCBz
dHJ1Y3Qgc3lzX3JlZ19kZXNjICpyZWcpOwogICogYXJlIHN0b3JlZCwgYW5kIGZvciBzZXRfaWRf
cmVnKCkgd2UgZG9uJ3QgYWxsb3cgdGhlIGVmZmVjdGl2ZSB2YWx1ZQogICogdG8gYmUgY2hhbmdl
ZC4KICAqLwotc3RhdGljIGludCBfX2dldF9pZF9yZWcoY29uc3Qgc3RydWN0IHN5c19yZWdfZGVz
YyAqcmQsIHZvaWQgX191c2VyICp1YWRkciwKK3N0YXRpYyBpbnQgX19nZXRfaWRfcmVnKGNvbnN0
IHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwKKwkJCWNvbnN0IHN0cnVjdCBzeXNfcmVnX2Rlc2MgKnJk
LCB2b2lkIF9fdXNlciAqdWFkZHIsCiAJCQlib29sIHJheikKIHsKIAljb25zdCB1NjQgaWQgPSBz
eXNfcmVnX3RvX2luZGV4KHJkKTsKLQljb25zdCB1NjQgdmFsID0gcmVhZF9pZF9yZWcocmQsIHJh
eik7CisJY29uc3QgdTY0IHZhbCA9IHJlYWRfaWRfcmVnKHZjcHUsIHJkLCByYXopOwogCiAJcmV0
dXJuIHJlZ190b191c2VyKHVhZGRyLCAmdmFsLCBpZCk7CiB9CiAKLXN0YXRpYyBpbnQgX19zZXRf
aWRfcmVnKGNvbnN0IHN0cnVjdCBzeXNfcmVnX2Rlc2MgKnJkLCB2b2lkIF9fdXNlciAqdWFkZHIs
CitzdGF0aWMgaW50IF9fc2V0X2lkX3JlZyhjb25zdCBzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsCisJ
CQljb25zdCBzdHJ1Y3Qgc3lzX3JlZ19kZXNjICpyZCwgdm9pZCBfX3VzZXIgKnVhZGRyLAogCQkJ
Ym9vbCByYXopCiB7CiAJY29uc3QgdTY0IGlkID0gc3lzX3JlZ190b19pbmRleChyZCk7CkBAIC0x
MTE4LDcgKzExMjEsNyBAQCBzdGF0aWMgaW50IF9fc2V0X2lkX3JlZyhjb25zdCBzdHJ1Y3Qgc3lz
X3JlZ19kZXNjICpyZCwgdm9pZCBfX3VzZXIgKnVhZGRyLAogCQlyZXR1cm4gZXJyOwogCiAJLyog
VGhpcyBpcyB3aGF0IHdlIG1lYW4gYnkgaW52YXJpYW50OiB5b3UgY2FuJ3QgY2hhbmdlIGl0LiAq
LwotCWlmICh2YWwgIT0gcmVhZF9pZF9yZWcocmQsIHJheikpCisJaWYgKHZhbCAhPSByZWFkX2lk
X3JlZyh2Y3B1LCByZCwgcmF6KSkKIAkJcmV0dXJuIC1FSU5WQUw7CiAKIAlyZXR1cm4gMDsKQEAg
LTExMjcsMjUgKzExMzAsMjUgQEAgc3RhdGljIGludCBfX3NldF9pZF9yZWcoY29uc3Qgc3RydWN0
IHN5c19yZWdfZGVzYyAqcmQsIHZvaWQgX191c2VyICp1YWRkciwKIHN0YXRpYyBpbnQgZ2V0X2lk
X3JlZyhzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIGNvbnN0IHN0cnVjdCBzeXNfcmVnX2Rlc2MgKnJk
LAogCQkgICAgICBjb25zdCBzdHJ1Y3Qga3ZtX29uZV9yZWcgKnJlZywgdm9pZCBfX3VzZXIgKnVh
ZGRyKQogewotCXJldHVybiBfX2dldF9pZF9yZWcocmQsIHVhZGRyLCBmYWxzZSk7CisJcmV0dXJu
IF9fZ2V0X2lkX3JlZyh2Y3B1LCByZCwgdWFkZHIsIGZhbHNlKTsKIH0KIAogc3RhdGljIGludCBz
ZXRfaWRfcmVnKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgY29uc3Qgc3RydWN0IHN5c19yZWdfZGVz
YyAqcmQsCiAJCSAgICAgIGNvbnN0IHN0cnVjdCBrdm1fb25lX3JlZyAqcmVnLCB2b2lkIF9fdXNl
ciAqdWFkZHIpCiB7Ci0JcmV0dXJuIF9fc2V0X2lkX3JlZyhyZCwgdWFkZHIsIGZhbHNlKTsKKwly
ZXR1cm4gX19zZXRfaWRfcmVnKHZjcHUsIHJkLCB1YWRkciwgZmFsc2UpOwogfQogCiBzdGF0aWMg
aW50IGdldF9yYXpfaWRfcmVnKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgY29uc3Qgc3RydWN0IHN5
c19yZWdfZGVzYyAqcmQsCiAJCQkgIGNvbnN0IHN0cnVjdCBrdm1fb25lX3JlZyAqcmVnLCB2b2lk
IF9fdXNlciAqdWFkZHIpCiB7Ci0JcmV0dXJuIF9fZ2V0X2lkX3JlZyhyZCwgdWFkZHIsIHRydWUp
OworCXJldHVybiBfX2dldF9pZF9yZWcodmNwdSwgcmQsIHVhZGRyLCB0cnVlKTsKIH0KIAogc3Rh
dGljIGludCBzZXRfcmF6X2lkX3JlZyhzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIGNvbnN0IHN0cnVj
dCBzeXNfcmVnX2Rlc2MgKnJkLAogCQkJICBjb25zdCBzdHJ1Y3Qga3ZtX29uZV9yZWcgKnJlZywg
dm9pZCBfX3VzZXIgKnVhZGRyKQogewotCXJldHVybiBfX3NldF9pZF9yZWcocmQsIHVhZGRyLCB0
cnVlKTsKKwlyZXR1cm4gX19zZXRfaWRfcmVnKHZjcHUsIHJkLCB1YWRkciwgdHJ1ZSk7CiB9CiAK
IC8qIHN5c19yZWdfZGVzYyBpbml0aWFsaXNlciBmb3Iga25vd24gY3B1ZmVhdHVyZSBJRCByZWdp
c3RlcnMgKi8KLS0gCjIuMS40CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
