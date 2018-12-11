Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A5BC6783B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:30:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 472FC20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mV4mnLwN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 472FC20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fNP/USliQOJJm/qN/rKAf4v9ogvAQ8sX7BVT6GLY0Is=; b=mV4mnLwNtsUgpc
	BjmLfiF/UdttznSVsnete1cCPo21+WHbXkFofk7ZUj4+Oqr+flWuxGRk9daxkJFho0L7I6vhy6SIO
	g9KbTVEt9eZNd+zI/CJZDsSn0GTZEfukSOifwk0bs+cuPvcXyAlNixd6z8VGQVvqeP3cfSg8+9z2K
	bk8Q5yZB9HlJSndc3sne57VulOzPUFNkzn6O5M4JFxl0/skTTWcjoyjhXNQfeKp/qYAIMsMIrlZTp
	8/499BrllYPnoYBFMxIHXTRbg6Jr7kivPk/Fp6BxIz3tQJwJeU0+2vh5n6buFC9GBhAc4vQmszzL2
	kdIfSZjpq2ym9PuJofLg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWrTa-0004GE-DN; Tue, 11 Dec 2018 23:30:06 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWrTV-0003mU-O4
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 23:30:03 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C6061596;
 Tue, 11 Dec 2018 15:29:55 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BF5973F614;
 Tue, 11 Dec 2018 15:29:53 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [RFC PATCH v3 03/24] KVM: arm64: Refactor kvm_arm_num_regs() for
 easier maintenance
Date: Tue, 11 Dec 2018 23:28:40 +0000
Message-Id: <1544570941-7377-4-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1544570941-7377-1-git-send-email-Dave.Martin@arm.com>
References: <1544570941-7377-1-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_153001_917111_B627192C 
X-CRM114-Status: GOOD (  14.81  )
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
LmMgYi9hcmNoL2FybTY0L2t2bS9ndWVzdC5jCmluZGV4IDFkNTQ3ZGIuLjBiZjBlZDMgMTAwNjQ0
Ci0tLSBhL2FyY2gvYXJtNjQva3ZtL2d1ZXN0LmMKKysrIGIvYXJjaC9hcm02NC9rdm0vZ3Vlc3Qu
YwpAQCAtMzA4LDggKzMwOCwxNCBAQCBzdGF0aWMgaW50IGdldF90aW1lcl9yZWcoc3RydWN0IGt2
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
