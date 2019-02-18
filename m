Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C1FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:58:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7300021773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DGpdZztT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7300021773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7WHROeHHFjdNL7h8AmvcJ72IEmXOu9pyQpb7E5ax2dM=; b=DGpdZztTDBklpU
	xFQa69KjARbzujaAtgeCEsw28TWNk0OM8L+r5BmGwTmesoxba5Yxsr0abrPyyrTiglVIwMcwtvj0c
	VWBj5CQJu5IDJIzrGyu4LbQGVP9vTKCkbEM7El0tf572v79GFeAYBROJPpWXZ/ngHjtyBbg+7Il1m
	BFXRndg0ecvnmpHRGlYo0tNe1EkW3Oc8ulTvXNQvQzBK9nQ0IQnF0VV7O3vkoanvvzmp7eBJo+Kci
	eYjXThHLqUbZ6G8E5nI+qvYKVfOzw0RiFmMLvVTDb7i+RtDKneLhm4ggLFSwzdoEs0fopA2mY77mI
	EwasERppv+GCZ9pVTROA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvp3Q-0001qx-9H; Mon, 18 Feb 2019 19:58:16 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvozh-0004bM-MP
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 19:54:38 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A6991BB0;
 Mon, 18 Feb 2019 11:54:07 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A4D063FBF8;
 Mon, 18 Feb 2019 11:53:43 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v5 08/26] arm64/sve: Enable SVE state tracking for non-task
 contexts
Date: Mon, 18 Feb 2019 19:52:21 +0000
Message-Id: <1550519559-15915-9-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_115426_297840_DD3F3F26 
X-CRM114-Status: GOOD (  17.00  )
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

VGhlIGN1cnJlbnQgRlBTSU1EL1NWRSBjb250ZXh0IGhhbmRsaW5nIHN1cHBvcnQgZm9yIG5vbi10
YXNrIChpLmUuLApLVk0gdmNwdSkgY29udGV4dHMgZG9lcyBub3QgdGFrZSBTVkUgaW50byBhY2Nv
dW50LiAgVGhpcyBtZWFucyB0aGF0Cm9ubHkgdGFzayBjb250ZXh0cyBjYW4gc2FmZWx5IHVzZSBT
VkUgYXQgcHJlc2VudC4KCkluIHByZXBhcmF0aW9uIGZvciBlbmFibGluZyBLVk0gZ3Vlc3RzIHRv
IHVzZSBTVkUsIGl0IGlzIG5lY2Vzc2FyeQp0byBrZWVwIHRyYWNrIG9mIFNWRSBzdGF0ZSBmb3Ig
bm9uLXRhc2sgY29udGV4dHMgdG9vLgoKVGhpcyBwYXRjaCBhZGRzIHRoZSBuZWNlc3Nhcnkgc3Vw
cG9ydCwgcmVtb3ZpbmcgYXNzdW1wdGlvbnMgZnJvbQp0aGUgY29udGV4dCBzd2l0Y2ggY29kZSBh
Ym91dCB0aGUgbG9jYXRpb24gb2YgdGhlIFNWRSBjb250ZXh0CnN0b3JhZ2UuCgpXaGVuIGJpbmRp
bmcgYSB2Y3B1IGNvbnRleHQsIGl0cyB2ZWN0b3IgbGVuZ3RoIGlzIGFyYml0cmFyaWx5CnNwZWNp
ZmllZCBhcyBTVkVfVkxfTUlOIGZvciBub3cuICBJbiBhbnkgY2FzZSwgYmVjYXVzZSBUSUZfU1ZF
IGlzCnByZXNlbnRseSBjbGVhcmVkIGF0IHZjcHUgY29udGV4dCBiaW5kIHRpbWUsIHRoZSBzcGVj
aWZpZWQgdmVjdG9yCmxlbmd0aCB3aWxsIG5vdCBiZSB1c2VkIGZvciBhbnl0aGluZyB5ZXQuICBJ
biBsYXRlciBwYXRjaGVzIFRJRl9TVkUKd2lsbCBiZSBzZXQgaGVyZSBhcyBhcHByb3ByaWF0ZSwg
YW5kIHRoZSBhcHByb3ByaWF0ZSBtYXhpbXVtIHZlY3RvcgpsZW5ndGggZm9yIHRoZSB2Y3B1IHdp
bGwgYmUgcGFzc2VkIHdoZW4gYmluZGluZy4KClNpZ25lZC1vZmYtYnk6IERhdmUgTWFydGluIDxE
YXZlLk1hcnRpbkBhcm0uY29tPgpSZXZpZXdlZC1ieTogQWxleCBCZW5uw6llIDxhbGV4LmJlbm5l
ZUBsaW5hcm8ub3JnPgotLS0KIGFyY2gvYXJtNjQvaW5jbHVkZS9hc20vZnBzaW1kLmggfCAgMyAr
Ky0KIGFyY2gvYXJtNjQva2VybmVsL2Zwc2ltZC5jICAgICAgfCAyMCArKysrKysrKysrKysrKyst
LS0tLQogYXJjaC9hcm02NC9rdm0vZnBzaW1kLmMgICAgICAgICB8ICA1ICsrKystCiAzIGZpbGVz
IGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
YXJjaC9hcm02NC9pbmNsdWRlL2FzbS9mcHNpbWQuaCBiL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20v
ZnBzaW1kLmgKaW5kZXggOTY0YWRjOS4uZGY3YTE0MyAxMDA2NDQKLS0tIGEvYXJjaC9hcm02NC9p
bmNsdWRlL2FzbS9mcHNpbWQuaAorKysgYi9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL2Zwc2ltZC5o
CkBAIC01Niw3ICs1Niw4IEBAIGV4dGVybiB2b2lkIGZwc2ltZF9yZXN0b3JlX2N1cnJlbnRfc3Rh
dGUodm9pZCk7CiBleHRlcm4gdm9pZCBmcHNpbWRfdXBkYXRlX2N1cnJlbnRfc3RhdGUoc3RydWN0
IHVzZXJfZnBzaW1kX3N0YXRlIGNvbnN0ICpzdGF0ZSk7CiAKIGV4dGVybiB2b2lkIGZwc2ltZF9i
aW5kX3Rhc2tfdG9fY3B1KHZvaWQpOwotZXh0ZXJuIHZvaWQgZnBzaW1kX2JpbmRfc3RhdGVfdG9f
Y3B1KHN0cnVjdCB1c2VyX2Zwc2ltZF9zdGF0ZSAqc3RhdGUpOworZXh0ZXJuIHZvaWQgZnBzaW1k
X2JpbmRfc3RhdGVfdG9fY3B1KHN0cnVjdCB1c2VyX2Zwc2ltZF9zdGF0ZSAqc3RhdGUsCisJCQkJ
ICAgICB2b2lkICpzdmVfc3RhdGUsIHVuc2lnbmVkIGludCBzdmVfdmwpOwogCiBleHRlcm4gdm9p
ZCBmcHNpbWRfZmx1c2hfdGFza19zdGF0ZShzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRhcmdldCk7CiBl
eHRlcm4gdm9pZCBmcHNpbWRfZmx1c2hfY3B1X3N0YXRlKHZvaWQpOwpkaWZmIC0tZ2l0IGEvYXJj
aC9hcm02NC9rZXJuZWwvZnBzaW1kLmMgYi9hcmNoL2FybTY0L2tlcm5lbC9mcHNpbWQuYwppbmRl
eCA5MmMyMzMxLi4wOWVlMjY0IDEwMDY0NAotLS0gYS9hcmNoL2FybTY0L2tlcm5lbC9mcHNpbWQu
YworKysgYi9hcmNoL2FybTY0L2tlcm5lbC9mcHNpbWQuYwpAQCAtMTIxLDYgKzEyMSw4IEBACiAg
Ki8KIHN0cnVjdCBmcHNpbWRfbGFzdF9zdGF0ZV9zdHJ1Y3QgewogCXN0cnVjdCB1c2VyX2Zwc2lt
ZF9zdGF0ZSAqc3Q7CisJdm9pZCAqc3ZlX3N0YXRlOworCXVuc2lnbmVkIGludCBzdmVfdmw7CiB9
OwogCiBzdGF0aWMgREVGSU5FX1BFUl9DUFUoc3RydWN0IGZwc2ltZF9sYXN0X3N0YXRlX3N0cnVj
dCwgZnBzaW1kX2xhc3Rfc3RhdGUpOwpAQCAtMjQxLDE0ICsyNDMsMTUgQEAgc3RhdGljIHZvaWQg
dGFza19mcHNpbWRfbG9hZCh2b2lkKQogICovCiB2b2lkIGZwc2ltZF9zYXZlKHZvaWQpCiB7Ci0J
c3RydWN0IHVzZXJfZnBzaW1kX3N0YXRlICpzdCA9IF9fdGhpc19jcHVfcmVhZChmcHNpbWRfbGFz
dF9zdGF0ZS5zdCk7CisJc3RydWN0IGZwc2ltZF9sYXN0X3N0YXRlX3N0cnVjdCBjb25zdCAqbGFz
dCA9CisJCXRoaXNfY3B1X3B0cigmZnBzaW1kX2xhc3Rfc3RhdGUpOwogCS8qIHNldCBieSBmcHNp
bWRfYmluZF90YXNrX3RvX2NwdSgpIG9yIGZwc2ltZF9iaW5kX3N0YXRlX3RvX2NwdSgpICovCiAK
IAlXQVJOX09OKCFpbl9zb2Z0aXJxKCkgJiYgIWlycXNfZGlzYWJsZWQoKSk7CiAKIAlpZiAoIXRl
c3RfdGhyZWFkX2ZsYWcoVElGX0ZPUkVJR05fRlBTVEFURSkpIHsKIAkJaWYgKHN5c3RlbV9zdXBw
b3J0c19zdmUoKSAmJiB0ZXN0X3RocmVhZF9mbGFnKFRJRl9TVkUpKSB7Ci0JCQlpZiAoV0FSTl9P
TihzdmVfZ2V0X3ZsKCkgIT0gY3VycmVudC0+dGhyZWFkLnN2ZV92bCkpIHsKKwkJCWlmIChXQVJO
X09OKHN2ZV9nZXRfdmwoKSAhPSBsYXN0LT5zdmVfdmwpKSB7CiAJCQkJLyoKIAkJCQkgKiBDYW4n
dCBzYXZlIHRoZSB1c2VyIHJlZ3MsIHNvIGN1cnJlbnQgd291bGQKIAkJCQkgKiByZS1lbnRlciB1
c2VyIHdpdGggY29ycnVwdCBzdGF0ZS4KQEAgLTI1OCw5ICsyNjEsMTEgQEAgdm9pZCBmcHNpbWRf
c2F2ZSh2b2lkKQogCQkJCXJldHVybjsKIAkJCX0KIAotCQkJc3ZlX3NhdmVfc3RhdGUoc3ZlX3Bm
ZnIoJmN1cnJlbnQtPnRocmVhZCksICZzdC0+ZnBzcik7CisJCQlzdmVfc2F2ZV9zdGF0ZSgoY2hh
ciAqKWxhc3QtPnN2ZV9zdGF0ZSArCisJCQkJCQlzdmVfZmZyX29mZnNldChsYXN0LT5zdmVfdmwp
LAorCQkJCSAgICAgICAmbGFzdC0+c3QtPmZwc3IpOwogCQl9IGVsc2UKLQkJCWZwc2ltZF9zYXZl
X3N0YXRlKHN0KTsKKwkJCWZwc2ltZF9zYXZlX3N0YXRlKGxhc3QtPnN0KTsKIAl9CiB9CiAKQEAg
LTEwMzQsNiArMTAzOSw4IEBAIHZvaWQgZnBzaW1kX2JpbmRfdGFza190b19jcHUodm9pZCkKIAkJ
dGhpc19jcHVfcHRyKCZmcHNpbWRfbGFzdF9zdGF0ZSk7CiAKIAlsYXN0LT5zdCA9ICZjdXJyZW50
LT50aHJlYWQudXcuZnBzaW1kX3N0YXRlOworCWxhc3QtPnN2ZV9zdGF0ZSA9IGN1cnJlbnQtPnRo
cmVhZC5zdmVfc3RhdGU7CisJbGFzdC0+c3ZlX3ZsID0gY3VycmVudC0+dGhyZWFkLnN2ZV92bDsK
IAljdXJyZW50LT50aHJlYWQuZnBzaW1kX2NwdSA9IHNtcF9wcm9jZXNzb3JfaWQoKTsKIAogCWlm
IChzeXN0ZW1fc3VwcG9ydHNfc3ZlKCkpIHsKQEAgLTEwNDcsNyArMTA1NCw4IEBAIHZvaWQgZnBz
aW1kX2JpbmRfdGFza190b19jcHUodm9pZCkKIAl9CiB9CiAKLXZvaWQgZnBzaW1kX2JpbmRfc3Rh
dGVfdG9fY3B1KHN0cnVjdCB1c2VyX2Zwc2ltZF9zdGF0ZSAqc3QpCit2b2lkIGZwc2ltZF9iaW5k
X3N0YXRlX3RvX2NwdShzdHJ1Y3QgdXNlcl9mcHNpbWRfc3RhdGUgKnN0LCB2b2lkICpzdmVfc3Rh
dGUsCisJCQkgICAgICB1bnNpZ25lZCBpbnQgc3ZlX3ZsKQogewogCXN0cnVjdCBmcHNpbWRfbGFz
dF9zdGF0ZV9zdHJ1Y3QgKmxhc3QgPQogCQl0aGlzX2NwdV9wdHIoJmZwc2ltZF9sYXN0X3N0YXRl
KTsKQEAgLTEwNTUsNiArMTA2Myw4IEBAIHZvaWQgZnBzaW1kX2JpbmRfc3RhdGVfdG9fY3B1KHN0
cnVjdCB1c2VyX2Zwc2ltZF9zdGF0ZSAqc3QpCiAJV0FSTl9PTighaW5fc29mdGlycSgpICYmICFp
cnFzX2Rpc2FibGVkKCkpOwogCiAJbGFzdC0+c3QgPSBzdDsKKwlsYXN0LT5zdmVfc3RhdGUgPSBz
dmVfc3RhdGU7CisJbGFzdC0+c3ZlX3ZsID0gc3ZlX3ZsOwogfQogCiAvKgpkaWZmIC0tZ2l0IGEv
YXJjaC9hcm02NC9rdm0vZnBzaW1kLmMgYi9hcmNoL2FybTY0L2t2bS9mcHNpbWQuYwppbmRleCBh
YWM3ODA4Li4xY2Y0ZjAyIDEwMDY0NAotLS0gYS9hcmNoL2FybTY0L2t2bS9mcHNpbWQuYworKysg
Yi9hcmNoL2FybTY0L2t2bS9mcHNpbWQuYwpAQCAtOSw2ICs5LDcgQEAKICNpbmNsdWRlIDxsaW51
eC9zY2hlZC5oPgogI2luY2x1ZGUgPGxpbnV4L3RocmVhZF9pbmZvLmg+CiAjaW5jbHVkZSA8bGlu
dXgva3ZtX2hvc3QuaD4KKyNpbmNsdWRlIDxhc20vZnBzaW1kLmg+CiAjaW5jbHVkZSA8YXNtL2t2
bV9hc20uaD4KICNpbmNsdWRlIDxhc20va3ZtX2hvc3QuaD4KICNpbmNsdWRlIDxhc20va3ZtX21t
dS5oPgpAQCAtODUsNyArODYsOSBAQCB2b2lkIGt2bV9hcmNoX3ZjcHVfY3R4c3luY19mcChzdHJ1
Y3Qga3ZtX3ZjcHUgKnZjcHUpCiAJV0FSTl9PTl9PTkNFKCFpcnFzX2Rpc2FibGVkKCkpOwogCiAJ
aWYgKHZjcHUtPmFyY2guZmxhZ3MgJiBLVk1fQVJNNjRfRlBfRU5BQkxFRCkgewotCQlmcHNpbWRf
YmluZF9zdGF0ZV90b19jcHUoJnZjcHUtPmFyY2guY3R4dC5ncF9yZWdzLmZwX3JlZ3MpOworCQlm
cHNpbWRfYmluZF9zdGF0ZV90b19jcHUoJnZjcHUtPmFyY2guY3R4dC5ncF9yZWdzLmZwX3JlZ3Ms
CisJCQkJCSBOVUxMLCBTVkVfVkxfTUlOKTsKKwogCQljbGVhcl90aHJlYWRfZmxhZyhUSUZfRk9S
RUlHTl9GUFNUQVRFKTsKIAkJY2xlYXJfdGhyZWFkX2ZsYWcoVElGX1NWRSk7CiAJfQotLSAKMi4x
LjQKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1h
cm0ta2VybmVsCg==
