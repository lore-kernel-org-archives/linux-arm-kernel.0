Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A359C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:32:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFC8E20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bSd9oFCC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC8E20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DO9PDYyCRcSwqnXVS7FfcOA0dBy++kI+se3eMgYNYA8=; b=bSd9oFCCE8Joy6
	VeSLbtZdh1H5BmvSaIUkS5ZrRBHb6qB6M3rTlyugqlPFbKFlkrUB6N6APE9ZyNGe3sJqpUroPz2yl
	M54A6jIvffcNCYhOHsVjCzsiFS3FLl2ElVCkD3zriKDd1yhSUGEf+c6Ea1c1/we38VUK7BYW6VV5e
	+Z1ovmVcAmZB/3m/vOFRmvZLHhLcLXB7ipNBNnsgfxFq70i0rAvYlF7JZzJIsx8Zq1EFORO4UjV+V
	eeZK3X7ZERA4ezoRDSxy7zRI/jbRvIkIHP7UApBfKq2nCAlXndiCmZ4bhAsdr+/+yqPNcGzhqYeCi
	fWmdVo+61SwxWqZhxEAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWrVz-0007Fr-Me; Tue, 11 Dec 2018 23:32:35 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWrTh-00044s-RH
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 23:30:24 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A6D21688;
 Tue, 11 Dec 2018 15:30:03 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E0B2D3F614;
 Tue, 11 Dec 2018 15:30:01 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [RFC PATCH v3 07/24] arm64/sve: Enable SVE state tracking for
 non-task contexts
Date: Tue, 11 Dec 2018 23:28:44 +0000
Message-Id: <1544570941-7377-8-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1544570941-7377-1-git-send-email-Dave.Martin@arm.com>
References: <1544570941-7377-1-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_153014_462583_AEBC1546 
X-CRM114-Status: GOOD (  16.65  )
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
 Will Deacon <will.deacon@arm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhlIGN1cnJlbnQgRlBTSU1EL1NWRSBjb250ZXh0IGhhbmRsaW5nIHN1cHBvcnQgZm9yIG5vbi10
YXNrIChpLmUuLApLVk0gdmNwdSkgY29udGV4dHMgZG9lcyBub3QgdGFrZSBTVkUgaW50byBhY2Nv
dW50LiAgVGhpcyBtZWFucyB0aGF0Cm9ubHkgdGFzayBjb250ZXh0cyBjYW4gc2FmZWx5IHVzZSBT
VkUgYXQgcHJlc2VudC4KCkluIHByZXBhcmF0aW9uIGZvciBlbmFibGluZyBLVk0gZ3Vlc3RzIHRv
IHVzZSBTVkUsIGl0IGlzIG5lY2Vzc2FyeQp0byBrZWVwIHRyYWNrIG9mIFNWRSBzdGF0ZSBmb3Ig
bm9uLXRhc2sgY29udGV4dHMgdG9vLgoKVGhpcyBwYXRjaCBhZGRzIHRoZSBuZWNlc3Nhcnkgc3Vw
cG9ydCwgcmVtb3ZpbmcgYXNzdW1wdGlvbnMgZnJvbQp0aGUgY29udGV4dCBzd2l0Y2ggY29kZSBh
Ym91dCB0aGUgbG9jYXRpb24gb2YgdGhlIFNWRSBjb250ZXh0CnN0b3JhZ2UuCgpXaGVuIGJpbmRp
bmcgYSB2Y3B1IGNvbnRleHQsIGl0cyB2ZWN0b3IgbGVuZ3RoIGlzIGFyYml0cmFyaWx5CnNwZWNp
ZmllZCBhcyBzdmVfbWF4X3ZsIGZvciBub3cuICBJbiBhbnkgY2FzZSwgYmVjYXVzZSBUSUZfU1ZF
IGlzCnByZXNlbnRseSBjbGVhcmVkIGF0IHZjcHUgY29udGV4dCBiaW5kIHRpbWUsIHRoZSBzcGVj
aWZpZWQgdmVjdG9yCmxlbmd0aCB3aWxsIG5vdCBiZSB1c2VkIGZvciBhbnl0aGluZyB5ZXQuICBJ
biBsYXRlciBwYXRjaGVzIFRJRl9TVkUKd2lsbCBiZSBzZXQgaGVyZSBhcyBhcHByb3ByaWF0ZSwg
YW5kIHRoZSBhcHByb3ByaWF0ZSBtYXhpbXVtIHZlY3RvcgpsZW5ndGggZm9yIHRoZSB2Y3B1IHdp
bGwgYmUgcGFzc2VkIHdoZW4gYmluZGluZy4KClNpZ25lZC1vZmYtYnk6IERhdmUgTWFydGluIDxE
YXZlLk1hcnRpbkBhcm0uY29tPgpSZXZpZXdlZC1ieTogQWxleCBCZW5uw6llIDxhbGV4LmJlbm5l
ZUBsaW5hcm8ub3JnPgotLS0KIGFyY2gvYXJtNjQvaW5jbHVkZS9hc20vZnBzaW1kLmggfCAgMyAr
Ky0KIGFyY2gvYXJtNjQva2VybmVsL2Zwc2ltZC5jICAgICAgfCAyMCArKysrKysrKysrKysrKyst
LS0tLQogYXJjaC9hcm02NC9rdm0vZnBzaW1kLmMgICAgICAgICB8ICA0ICsrKy0KIDMgZmlsZXMg
Y2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9h
cmNoL2FybTY0L2luY2x1ZGUvYXNtL2Zwc2ltZC5oIGIvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9m
cHNpbWQuaAppbmRleCA5NjRhZGM5Li5kZjdhMTQzIDEwMDY0NAotLS0gYS9hcmNoL2FybTY0L2lu
Y2x1ZGUvYXNtL2Zwc2ltZC5oCisrKyBiL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vZnBzaW1kLmgK
QEAgLTU2LDcgKzU2LDggQEAgZXh0ZXJuIHZvaWQgZnBzaW1kX3Jlc3RvcmVfY3VycmVudF9zdGF0
ZSh2b2lkKTsKIGV4dGVybiB2b2lkIGZwc2ltZF91cGRhdGVfY3VycmVudF9zdGF0ZShzdHJ1Y3Qg
dXNlcl9mcHNpbWRfc3RhdGUgY29uc3QgKnN0YXRlKTsKIAogZXh0ZXJuIHZvaWQgZnBzaW1kX2Jp
bmRfdGFza190b19jcHUodm9pZCk7Ci1leHRlcm4gdm9pZCBmcHNpbWRfYmluZF9zdGF0ZV90b19j
cHUoc3RydWN0IHVzZXJfZnBzaW1kX3N0YXRlICpzdGF0ZSk7CitleHRlcm4gdm9pZCBmcHNpbWRf
YmluZF9zdGF0ZV90b19jcHUoc3RydWN0IHVzZXJfZnBzaW1kX3N0YXRlICpzdGF0ZSwKKwkJCQkg
ICAgIHZvaWQgKnN2ZV9zdGF0ZSwgdW5zaWduZWQgaW50IHN2ZV92bCk7CiAKIGV4dGVybiB2b2lk
IGZwc2ltZF9mbHVzaF90YXNrX3N0YXRlKHN0cnVjdCB0YXNrX3N0cnVjdCAqdGFyZ2V0KTsKIGV4
dGVybiB2b2lkIGZwc2ltZF9mbHVzaF9jcHVfc3RhdGUodm9pZCk7CmRpZmYgLS1naXQgYS9hcmNo
L2FybTY0L2tlcm5lbC9mcHNpbWQuYyBiL2FyY2gvYXJtNjQva2VybmVsL2Zwc2ltZC5jCmluZGV4
IDkyYzIzMzEuLjA5ZWUyNjQgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtNjQva2VybmVsL2Zwc2ltZC5j
CisrKyBiL2FyY2gvYXJtNjQva2VybmVsL2Zwc2ltZC5jCkBAIC0xMjEsNiArMTIxLDggQEAKICAq
Lwogc3RydWN0IGZwc2ltZF9sYXN0X3N0YXRlX3N0cnVjdCB7CiAJc3RydWN0IHVzZXJfZnBzaW1k
X3N0YXRlICpzdDsKKwl2b2lkICpzdmVfc3RhdGU7CisJdW5zaWduZWQgaW50IHN2ZV92bDsKIH07
CiAKIHN0YXRpYyBERUZJTkVfUEVSX0NQVShzdHJ1Y3QgZnBzaW1kX2xhc3Rfc3RhdGVfc3RydWN0
LCBmcHNpbWRfbGFzdF9zdGF0ZSk7CkBAIC0yNDEsMTQgKzI0MywxNSBAQCBzdGF0aWMgdm9pZCB0
YXNrX2Zwc2ltZF9sb2FkKHZvaWQpCiAgKi8KIHZvaWQgZnBzaW1kX3NhdmUodm9pZCkKIHsKLQlz
dHJ1Y3QgdXNlcl9mcHNpbWRfc3RhdGUgKnN0ID0gX190aGlzX2NwdV9yZWFkKGZwc2ltZF9sYXN0
X3N0YXRlLnN0KTsKKwlzdHJ1Y3QgZnBzaW1kX2xhc3Rfc3RhdGVfc3RydWN0IGNvbnN0ICpsYXN0
ID0KKwkJdGhpc19jcHVfcHRyKCZmcHNpbWRfbGFzdF9zdGF0ZSk7CiAJLyogc2V0IGJ5IGZwc2lt
ZF9iaW5kX3Rhc2tfdG9fY3B1KCkgb3IgZnBzaW1kX2JpbmRfc3RhdGVfdG9fY3B1KCkgKi8KIAog
CVdBUk5fT04oIWluX3NvZnRpcnEoKSAmJiAhaXJxc19kaXNhYmxlZCgpKTsKIAogCWlmICghdGVz
dF90aHJlYWRfZmxhZyhUSUZfRk9SRUlHTl9GUFNUQVRFKSkgewogCQlpZiAoc3lzdGVtX3N1cHBv
cnRzX3N2ZSgpICYmIHRlc3RfdGhyZWFkX2ZsYWcoVElGX1NWRSkpIHsKLQkJCWlmIChXQVJOX09O
KHN2ZV9nZXRfdmwoKSAhPSBjdXJyZW50LT50aHJlYWQuc3ZlX3ZsKSkgeworCQkJaWYgKFdBUk5f
T04oc3ZlX2dldF92bCgpICE9IGxhc3QtPnN2ZV92bCkpIHsKIAkJCQkvKgogCQkJCSAqIENhbid0
IHNhdmUgdGhlIHVzZXIgcmVncywgc28gY3VycmVudCB3b3VsZAogCQkJCSAqIHJlLWVudGVyIHVz
ZXIgd2l0aCBjb3JydXB0IHN0YXRlLgpAQCAtMjU4LDkgKzI2MSwxMSBAQCB2b2lkIGZwc2ltZF9z
YXZlKHZvaWQpCiAJCQkJcmV0dXJuOwogCQkJfQogCi0JCQlzdmVfc2F2ZV9zdGF0ZShzdmVfcGZm
cigmY3VycmVudC0+dGhyZWFkKSwgJnN0LT5mcHNyKTsKKwkJCXN2ZV9zYXZlX3N0YXRlKChjaGFy
ICopbGFzdC0+c3ZlX3N0YXRlICsKKwkJCQkJCXN2ZV9mZnJfb2Zmc2V0KGxhc3QtPnN2ZV92bCks
CisJCQkJICAgICAgICZsYXN0LT5zdC0+ZnBzcik7CiAJCX0gZWxzZQotCQkJZnBzaW1kX3NhdmVf
c3RhdGUoc3QpOworCQkJZnBzaW1kX3NhdmVfc3RhdGUobGFzdC0+c3QpOwogCX0KIH0KIApAQCAt
MTAzNCw2ICsxMDM5LDggQEAgdm9pZCBmcHNpbWRfYmluZF90YXNrX3RvX2NwdSh2b2lkKQogCQl0
aGlzX2NwdV9wdHIoJmZwc2ltZF9sYXN0X3N0YXRlKTsKIAogCWxhc3QtPnN0ID0gJmN1cnJlbnQt
PnRocmVhZC51dy5mcHNpbWRfc3RhdGU7CisJbGFzdC0+c3ZlX3N0YXRlID0gY3VycmVudC0+dGhy
ZWFkLnN2ZV9zdGF0ZTsKKwlsYXN0LT5zdmVfdmwgPSBjdXJyZW50LT50aHJlYWQuc3ZlX3ZsOwog
CWN1cnJlbnQtPnRocmVhZC5mcHNpbWRfY3B1ID0gc21wX3Byb2Nlc3Nvcl9pZCgpOwogCiAJaWYg
KHN5c3RlbV9zdXBwb3J0c19zdmUoKSkgewpAQCAtMTA0Nyw3ICsxMDU0LDggQEAgdm9pZCBmcHNp
bWRfYmluZF90YXNrX3RvX2NwdSh2b2lkKQogCX0KIH0KIAotdm9pZCBmcHNpbWRfYmluZF9zdGF0
ZV90b19jcHUoc3RydWN0IHVzZXJfZnBzaW1kX3N0YXRlICpzdCkKK3ZvaWQgZnBzaW1kX2JpbmRf
c3RhdGVfdG9fY3B1KHN0cnVjdCB1c2VyX2Zwc2ltZF9zdGF0ZSAqc3QsIHZvaWQgKnN2ZV9zdGF0
ZSwKKwkJCSAgICAgIHVuc2lnbmVkIGludCBzdmVfdmwpCiB7CiAJc3RydWN0IGZwc2ltZF9sYXN0
X3N0YXRlX3N0cnVjdCAqbGFzdCA9CiAJCXRoaXNfY3B1X3B0cigmZnBzaW1kX2xhc3Rfc3RhdGUp
OwpAQCAtMTA1NSw2ICsxMDYzLDggQEAgdm9pZCBmcHNpbWRfYmluZF9zdGF0ZV90b19jcHUoc3Ry
dWN0IHVzZXJfZnBzaW1kX3N0YXRlICpzdCkKIAlXQVJOX09OKCFpbl9zb2Z0aXJxKCkgJiYgIWly
cXNfZGlzYWJsZWQoKSk7CiAKIAlsYXN0LT5zdCA9IHN0OworCWxhc3QtPnN2ZV9zdGF0ZSA9IHN2
ZV9zdGF0ZTsKKwlsYXN0LT5zdmVfdmwgPSBzdmVfdmw7CiB9CiAKIC8qCmRpZmYgLS1naXQgYS9h
cmNoL2FybTY0L2t2bS9mcHNpbWQuYyBiL2FyY2gvYXJtNjQva3ZtL2Zwc2ltZC5jCmluZGV4IGFh
Yzc4MDguLjU1NjU0Y2IgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtNjQva3ZtL2Zwc2ltZC5jCisrKyBi
L2FyY2gvYXJtNjQva3ZtL2Zwc2ltZC5jCkBAIC04NSw3ICs4NSw5IEBAIHZvaWQga3ZtX2FyY2hf
dmNwdV9jdHhzeW5jX2ZwKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkKIAlXQVJOX09OX09OQ0UoIWly
cXNfZGlzYWJsZWQoKSk7CiAKIAlpZiAodmNwdS0+YXJjaC5mbGFncyAmIEtWTV9BUk02NF9GUF9F
TkFCTEVEKSB7Ci0JCWZwc2ltZF9iaW5kX3N0YXRlX3RvX2NwdSgmdmNwdS0+YXJjaC5jdHh0Lmdw
X3JlZ3MuZnBfcmVncyk7CisJCWZwc2ltZF9iaW5kX3N0YXRlX3RvX2NwdSgmdmNwdS0+YXJjaC5j
dHh0LmdwX3JlZ3MuZnBfcmVncywKKwkJCQkJIE5VTEwsIHN2ZV9tYXhfdmwpOworCiAJCWNsZWFy
X3RocmVhZF9mbGFnKFRJRl9GT1JFSUdOX0ZQU1RBVEUpOwogCQljbGVhcl90aHJlYWRfZmxhZyhU
SUZfU1ZFKTsKIAl9Ci0tIAoyLjEuNAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
