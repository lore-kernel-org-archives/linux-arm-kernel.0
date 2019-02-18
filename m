Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1791C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:54:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0871204EC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iACNEn+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0871204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qdyN6lOshXUwtbTjGNoWThvBGj0R41hcoAZnAamOfQM=; b=iACNEn+GIHSt9N
	bjJ1HCiQg5CPT0rg59V48XOy4K++GEkmQ6WXj8wMTbnvAin8rcx+kDeJF2nS1g01lQUr5HIVnJrdr
	wKL6+DWUGVRK5TNGvOfQ7T3X0ZjbgsLSjNtz9/2tggALvnk5h72KlcPVvf7p4b27hR/mBOX/N7lav
	1V6DLe6KkFNf9s/M4cl/BdpxhTUaVwSRqAdWGhcF8kuXVflRMV+4yNHHdZSBqMO0xMC9IKC7oyAka
	IF0lE1E2cmPVtnJoOVUiIZBrxRqHls2wIy3Fjo0OA6CC+OmzBRA743kRXf8GV916IMejBwoqxHVbi
	xZI3iGizP2DxJSmFsJ7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvozS-0004YK-C6; Mon, 18 Feb 2019 19:54:10 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvozO-0004Vu-KJ
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 19:54:08 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAF921684;
 Mon, 18 Feb 2019 11:53:56 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 88D0E3FB75;
 Mon, 18 Feb 2019 11:53:34 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v5 04/26] KVM: arm64: Refactor kvm_arm_num_regs() for easier
 maintenance
Date: Mon, 18 Feb 2019 19:52:17 +0000
Message-Id: <1550519559-15915-5-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_115407_038037_D015504C 
X-CRM114-Status: GOOD (  13.62  )
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

a3ZtX2FybV9udW1fcmVncygpIGFkZHMgdG9nZXRoZXIgdmFyaW91cyBwYXJ0aWFsIHJlZ2lzdGVy
IGNvdW50cyBpbgphIGZyZWVmb3JtIHN1bSBleHByZXNzaW9uLCB3aGljaCBtYWtlcyBpdCBoYXJk
ZXIgdGhhbiBuZWNlc3NhcnkgdG8KcmVhZCBkaWZmcyB0aGF0IGFkZCwgbW9kaWZ5IG9yIHJlbW92
ZSBhIHNpbmdsZSB0ZXJtIGluIHRoZSBzdW0KKHdoaWNoIGlzIGV4cGVjdGVkIHRvIHRoZSBjb21t
b24gY2FzZSB1bmRlciBtYWludGVuYW5jZSkuCgpUaGlzIHBhdGNoIHJlZmFjdG9ycyB0aGUgY29k
ZSB0byBhZGQgdGhlIHRlcm0gb25lIHBlciBsaW5lLCBmb3IKbWF4aW11bSByZWFkYWJpbGl0eS4K
ClNpZ25lZC1vZmYtYnk6IERhdmUgTWFydGluIDxEYXZlLk1hcnRpbkBhcm0uY29tPgpSZXZpZXdl
ZC1ieTogQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3JnPgotLS0KIGFyY2gvYXJt
NjQva3ZtL2d1ZXN0LmMgfCAxMCArKysrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQva3ZtL2d1ZXN0
LmMgYi9hcmNoL2FybTY0L2t2bS9ndWVzdC5jCmluZGV4IDQ2ZWI4NjcuLjY1ZjQzMzggMTAwNjQ0
Ci0tLSBhL2FyY2gvYXJtNjQva3ZtL2d1ZXN0LmMKKysrIGIvYXJjaC9hcm02NC9rdm0vZ3Vlc3Qu
YwpAQCAtMzEyLDggKzMxMiwxNCBAQCBzdGF0aWMgaW50IGdldF90aW1lcl9yZWcoc3RydWN0IGt2
bV92Y3B1ICp2Y3B1LCBjb25zdCBzdHJ1Y3Qga3ZtX29uZV9yZWcgKnJlZykKICAqLwogdW5zaWdu
ZWQgbG9uZyBrdm1fYXJtX251bV9yZWdzKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkKIHsKLQlyZXR1
cm4gbnVtX2NvcmVfcmVncygpICsga3ZtX2FybV9udW1fc3lzX3JlZ19kZXNjcyh2Y3B1KQotCQkr
IGt2bV9hcm1fZ2V0X2Z3X251bV9yZWdzKHZjcHUpCSsgTlVNX1RJTUVSX1JFR1M7CisJdW5zaWdu
ZWQgbG9uZyByZXMgPSAwOworCisJcmVzICs9IG51bV9jb3JlX3JlZ3MoKTsKKwlyZXMgKz0ga3Zt
X2FybV9udW1fc3lzX3JlZ19kZXNjcyh2Y3B1KTsKKwlyZXMgKz0ga3ZtX2FybV9nZXRfZndfbnVt
X3JlZ3ModmNwdSk7CisJcmVzICs9IE5VTV9USU1FUl9SRUdTOworCisJcmV0dXJuIHJlczsKIH0K
IAogLyoqCi0tIAoyLjEuNAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
