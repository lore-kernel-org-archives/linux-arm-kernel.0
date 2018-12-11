Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA860C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:32:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CB2520672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VHwB6exC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB2520672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cSO1ZOqugCy7hzkpclb5OidAJ2NI02J4cRo4HlMvsMI=; b=VHwB6exCxvbpUt
	ZXRbsWsoZeN9crc204DKOSwrRXocr3EeFc7bfgMxkOlZ1dQ0QDve0oKKJ7WvXw1RWYTvoEiYFF/8X
	XPR42sOk21AiSmppJNJngswsZf4BYpsaKMb2L5k/0kC7omeIJr/Yy7s7e8m7/lYcaxMMGFOhJ5uf3
	Ma6rAZETbFj1R2UeTqOnec718JjWNbhy3ZLjDlQz+NCAslsXodYQUM/lAjoWD3FP63LybgS1g8j6s
	VGsrwyJEgY1K8G+jMS14LvxhRTXmrLi4dGtxp9b83SZLpVqBKExawfxGYSjKBsmeBwiwNENc3uppH
	JsBmEkPXXlOofQ2hBjvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWrVi-0006zh-Ax; Tue, 11 Dec 2018 23:32:18 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWrTh-0004GB-RF
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 23:30:24 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0B94A78;
 Tue, 11 Dec 2018 15:30:05 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C9F513F614;
 Tue, 11 Dec 2018 15:30:03 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [RFC PATCH v3 08/24] KVM: arm64: Add a vcpu flag to control SVE
 visibility for the guest
Date: Tue, 11 Dec 2018 23:28:45 +0000
Message-Id: <1544570941-7377-9-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1544570941-7377-1-git-send-email-Dave.Martin@arm.com>
References: <1544570941-7377-1-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_153014_572383_833AB3C0 
X-CRM114-Status: GOOD (  10.69  )
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

U2luY2UgU1ZFIHdpbGwgYmUgZW5hYmxlZCBvciBkaXNhYmxlZCBvbiBhIHBlci12Y3B1IGJhc2lz
LCBhIGZsYWcKaXMgbmVlZGVkIGluIG9yZGVyIHRvIHRyYWNrIHdoaWNoIHZjcHVzIGhhdmUgaXQg
ZW5hYmxlZC4KClRoaXMgcGF0Y2ggYWRkcyBhIHN1aXRhYmxlIGZsYWcgYW5kIGEgaGVscGVyIGZv
ciBjaGVja2luZyBpdC4KClNpZ25lZC1vZmYtYnk6IERhdmUgTWFydGluIDxEYXZlLk1hcnRpbkBh
cm0uY29tPgpSZXZpZXdlZC1ieTogQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3Jn
PgotLS0KIGFyY2gvYXJtNjQvaW5jbHVkZS9hc20va3ZtX2hvc3QuaCB8IDQgKysrKwogMSBmaWxl
IGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvaW5jbHVk
ZS9hc20va3ZtX2hvc3QuaCBiL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20va3ZtX2hvc3QuaAppbmRl
eCAzNjYyZWUwLi5jOThmNzU3IDEwMDY0NAotLS0gYS9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL2t2
bV9ob3N0LmgKKysrIGIvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9rdm1faG9zdC5oCkBAIC0zMDks
NiArMzA5LDEwIEBAIHN0cnVjdCBrdm1fdmNwdV9hcmNoIHsKICNkZWZpbmUgS1ZNX0FSTTY0X0ZQ
X0hPU1QJCSgxIDw8IDIpIC8qIGhvc3QgRlAgcmVncyBsb2FkZWQgKi8KICNkZWZpbmUgS1ZNX0FS
TTY0X0hPU1RfU1ZFX0lOX1VTRQkoMSA8PCAzKSAvKiBiYWNrdXAgZm9yIGhvc3QgVElGX1NWRSAq
LwogI2RlZmluZSBLVk1fQVJNNjRfSE9TVF9TVkVfRU5BQkxFRAkoMSA8PCA0KSAvKiBTVkUgZW5h
YmxlZCBmb3IgRUwwICovCisjZGVmaW5lIEtWTV9BUk02NF9HVUVTVF9IQVNfU1ZFCQkoMSA8PCA1
KSAvKiBTVkUgZXhwb3NlZCB0byBndWVzdCAqLworCisjZGVmaW5lIHZjcHVfaGFzX3N2ZSh2Y3B1
KSAoc3lzdGVtX3N1cHBvcnRzX3N2ZSgpICYmIFwKKwkJCSAgICAoKHZjcHUpLT5hcmNoLmZsYWdz
ICYgS1ZNX0FSTTY0X0dVRVNUX0hBU19TVkUpKQogCiAjZGVmaW5lIHZjcHVfZ3BfcmVncyh2KQkJ
KCYodiktPmFyY2guY3R4dC5ncF9yZWdzKQogCi0tIAoyLjEuNAoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBs
aXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
