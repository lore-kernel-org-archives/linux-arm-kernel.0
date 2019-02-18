Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1E2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:54:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 762B0217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gifL9lRp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 762B0217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gsS8/J/+IeeotMMltkAdQI2HWQewAYaoi9+Z4b0GwHQ=; b=gifL9lRp/18e7F
	IYSm+1sPhmhEi/ipH/j6chpxc6x4wJ5YLjQ+d20OIcXMUp38fgRPvzRMbNG5cMeSqMJf3JU4XmoaD
	2vrlQsGHgbItY07UXmQfezXWJ7poW3HI1G+ZNxLB0RBCQC8CLRVhjjlw2aKS8rxPjcZ83iYP10vWa
	hsGm2ierYkbEuYgQthbH8CrahXtXxma0k8IRH8Wk7hilNF+kfisdM4OUKBmk5tzNCwCtPIN6X1DUC
	K5EitCxuaKPLc0D9WABHxvdgCqaECSFIhWD3wwwN/j/ZVkjSp1KPSYgHc7mmPYCeK3YA5Kg9pDYwK
	NEiWY2YInXLPPQtWqQbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvozu-000579-IW; Mon, 18 Feb 2019 19:54:38 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvozT-0004Xm-SX
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 19:54:17 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF55A15AD;
 Mon, 18 Feb 2019 11:53:51 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 05E5F3F740;
 Mon, 18 Feb 2019 11:53:29 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v5 02/26] arm64: fpsimd: Always set TIF_FOREIGN_FPSTATE on
 task state flush
Date: Mon, 18 Feb 2019 19:52:15 +0000
Message-Id: <1550519559-15915-3-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_115412_241059_39FC0D99 
X-CRM114-Status: GOOD (  15.87  )
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

VGhpcyBwYXRjaCB1cGRhdGVzIGZwc2ltZF9mbHVzaF90YXNrX3N0YXRlKCkgdG8gbWlycm9yIHRo
ZSBuZXcKc2VtYW50aWNzIG9mIGZwc2ltZF9mbHVzaF9jcHVfc3RhdGUoKSBpbnRyb2R1Y2VkIGJ5
IGNvbW1pdApkOGFkNzFmYTM4YTkgKCJhcm02NDogZnBzaW1kOiBGaXggVElGX0ZPUkVJR05fRlBT
VEFURSBhZnRlcgppbnZhbGlkYXRpbmcgY3B1IHJlZ3MiKS4gIEJvdGggZnVuY3Rpb25zIG5vdyBp
bXBsaWNpdGx5IHNldApUSUZfRk9SRUlHTl9GUFNUQVRFIHRvIGluZGljYXRlIHRoYXQgdGhlIHRh
c2sncyBGUFNJTUQgc3RhdGUgaXMgbm90CmxvYWRlZCBpbnRvIHRoZSBjcHUuCgpBcyBhIHNpZGUt
ZWZmZWN0LCBmcHNpbWRfZmx1c2hfdGFza19zdGF0ZSgpIG5vdyBzZXRzClRJRl9GT1JFSUdOX0ZQ
U1RBVEUgZXZlbiBmb3Igbm9uLXJ1bm5pbmcgdGFza3MuICBJbiB0aGUgY2FzZSBvZgpub24tcnVu
bmluZyB0YXNrcyB0aGlzIGlzIG5vdCB1c2VmdWwgYnV0IGFsc28gaGFybWxlc3MsIGJlY2F1c2Ug
dGhlCmZsYWcgaXMgbGl2ZSBvbmx5IHdoaWxlIHRoZSBjb3JyZXNwb25kaW5nIHRhc2sgaXMgcnVu
bmluZy4gIFRoaXMKZnVuY3Rpb24gaXMgbm90IGNhbGxlZCBmcm9tIGZhc3QgcGF0aHMsIHNvIHNw
ZWNpYWwtY2FzaW5nIHRoaXMgZm9yCnRoZSB0YXNrID09IGN1cnJlbnQgY2FzZSBpcyBub3QgcmVh
bGx5IHdvcnRoIGl0LgoKQ29tcGlsZXIgYmFycmllcnMgcHJldmlvdXNseSBwcmVzZW50IGluIHJl
c3RvcmVfc3ZlX2Zwc2ltZF9jb250ZXh0KCkKYXJlIHB1bGxlZCBpbnRvIGZwc2ltZF9mbHVzaF90
YXNrX3N0YXRlKCkgc28gdGhhdCBpdCBjYW4gYmUgc2FmZWx5CmNhbGxlZCB3aXRoIHByZWVtcHRp
b24gZW5hYmxlZCBpZiBuZWNlc3NhcnkuCgpFeHBsaWNpdCBjYWxscyB0byBzZXQgVElGX0ZPUkVJ
R05fRlBTVEFURSB0aGF0IGFjY29tcGFueQpmcHNpbWRfZmx1c2hfdGFza19zdGF0ZSgpIGNhbGxz
IGFuZCBhcmUgbm93IHJlZHVuZGFudCBhcmUgcmVtb3ZlZAphcyBhcHByb3ByaWF0ZS4KCmZwc2lt
ZF9mbHVzaF90YXNrX3N0YXRlKCkgaXMgdXNlZCB0byBnZXQgZXhjbHVzaXZlIGFjY2VzcyB0byB0
aGUKcmVwcmVzZW50YXRpb24gb2YgdGhlIHRhc2sncyBzdGF0ZSB2aWEgdGFza19zdHJ1Y3QsIGZv
ciB0aGUgcHVycG9zZQpvZiByZXBsYWNpbmcgdGhlIHN0YXRlLiAgVGh1cywgdGhlIGNhbGwgdG8g
dGhpcyBmdW5jdGlvbiBzaG91bGQKaGFwcGVuIGJlZm9yZSBtYW5pcHVsYXRpbmcgZnBzaW1kX3N0
YXRlIG9yIHN2ZV9zdGF0ZSBldGMuIGluCnRhc2tfc3RydWN0LiAgQW5vbWFsb3VzIGNhc2VzIGFy
ZSByZW9yZGVyZWQgYXBwcm9wcmlhdGVseSBpbiBvcmRlcgp0byBtYWtlIHRoZSBjb2RlIG1vcmUg
Y29uc2lzdGVudCwgYWx0aG91Z2ggdGhlcmUgc2hvdWxkIGJlIG5vCmZ1bmN0aW9uYWwgZGlmZmVy
ZW5jZSBzaW5jZSB0aGVzZSBjYXNlcyBhcmUgcHJvdGVjdGVkIGJ5CmxvY2FsX2JoX2Rpc2FibGUo
KSBhbnl3YXkuCgpTaWduZWQtb2ZmLWJ5OiBEYXZlIE1hcnRpbiA8RGF2ZS5NYXJ0aW5AYXJtLmNv
bT4KUmV2aWV3ZWQtYnk6IEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9yZz4KLS0t
CiBhcmNoL2FybTY0L2tlcm5lbC9mcHNpbWQuYyB8IDI1ICsrKysrKysrKysrKysrKysrKystLS0t
LS0KIGFyY2gvYXJtNjQva2VybmVsL3NpZ25hbC5jIHwgIDUgLS0tLS0KIDIgZmlsZXMgY2hhbmdl
ZCwgMTkgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9h
cm02NC9rZXJuZWwvZnBzaW1kLmMgYi9hcmNoL2FybTY0L2tlcm5lbC9mcHNpbWQuYwppbmRleCA1
ZWJlNzNiLi42MmMzN2YwIDEwMDY0NAotLS0gYS9hcmNoL2FybTY0L2tlcm5lbC9mcHNpbWQuYwor
KysgYi9hcmNoL2FybTY0L2tlcm5lbC9mcHNpbWQuYwpAQCAtNTUwLDcgKzU1MCw2IEBAIGludCBz
dmVfc2V0X3ZlY3Rvcl9sZW5ndGgoc3RydWN0IHRhc2tfc3RydWN0ICp0YXNrLAogCQlsb2NhbF9i
aF9kaXNhYmxlKCk7CiAKIAkJZnBzaW1kX3NhdmUoKTsKLQkJc2V0X3RocmVhZF9mbGFnKFRJRl9G
T1JFSUdOX0ZQU1RBVEUpOwogCX0KIAogCWZwc2ltZF9mbHVzaF90YXNrX3N0YXRlKHRhc2spOwpA
QCAtODE2LDEyICs4MTUsMTEgQEAgYXNtbGlua2FnZSB2b2lkIGRvX3N2ZV9hY2ModW5zaWduZWQg
aW50IGVzciwgc3RydWN0IHB0X3JlZ3MgKnJlZ3MpCiAJbG9jYWxfYmhfZGlzYWJsZSgpOwogCiAJ
ZnBzaW1kX3NhdmUoKTsKLQlmcHNpbWRfdG9fc3ZlKGN1cnJlbnQpOwogCiAJLyogRm9yY2UgcmV0
X3RvX3VzZXIgdG8gcmVsb2FkIHRoZSByZWdpc3RlcnM6ICovCiAJZnBzaW1kX2ZsdXNoX3Rhc2tf
c3RhdGUoY3VycmVudCk7Ci0Jc2V0X3RocmVhZF9mbGFnKFRJRl9GT1JFSUdOX0ZQU1RBVEUpOwog
CisJZnBzaW1kX3RvX3N2ZShjdXJyZW50KTsKIAlpZiAodGVzdF9hbmRfc2V0X3RocmVhZF9mbGFn
KFRJRl9TVkUpKQogCQlXQVJOX09OKDEpOyAvKiBTVkUgYWNjZXNzIHNob3VsZG4ndCBoYXZlIHRy
YXBwZWQgKi8KIApAQCAtODk0LDkgKzg5Miw5IEBAIHZvaWQgZnBzaW1kX2ZsdXNoX3RocmVhZCh2
b2lkKQogCiAJbG9jYWxfYmhfZGlzYWJsZSgpOwogCisJZnBzaW1kX2ZsdXNoX3Rhc2tfc3RhdGUo
Y3VycmVudCk7CiAJbWVtc2V0KCZjdXJyZW50LT50aHJlYWQudXcuZnBzaW1kX3N0YXRlLCAwLAog
CSAgICAgICBzaXplb2YoY3VycmVudC0+dGhyZWFkLnV3LmZwc2ltZF9zdGF0ZSkpOwotCWZwc2lt
ZF9mbHVzaF90YXNrX3N0YXRlKGN1cnJlbnQpOwogCiAJaWYgKHN5c3RlbV9zdXBwb3J0c19zdmUo
KSkgewogCQljbGVhcl90aHJlYWRfZmxhZyhUSUZfU1ZFKTsKQEAgLTkzMyw4ICs5MzEsNiBAQCB2
b2lkIGZwc2ltZF9mbHVzaF90aHJlYWQodm9pZCkKIAkJCWN1cnJlbnQtPnRocmVhZC5zdmVfdmxf
b25leGVjID0gMDsKIAl9CiAKLQlzZXRfdGhyZWFkX2ZsYWcoVElGX0ZPUkVJR05fRlBTVEFURSk7
Ci0KIAlsb2NhbF9iaF9lbmFibGUoKTsKIH0KIApAQCAtMTA0MywxMiArMTAzOSwyOSBAQCB2b2lk
IGZwc2ltZF91cGRhdGVfY3VycmVudF9zdGF0ZShzdHJ1Y3QgdXNlcl9mcHNpbWRfc3RhdGUgY29u
c3QgKnN0YXRlKQogCiAvKgogICogSW52YWxpZGF0ZSBsaXZlIENQVSBjb3BpZXMgb2YgdGFzayB0
J3MgRlBTSU1EIHN0YXRlCisgKgorICogVGhpcyBmdW5jdGlvbiBtYXkgYmUgY2FsbGVkIHdpdGgg
cHJlZW1wdGlvbiBlbmFibGVkLiAgVGhlIGJhcnJpZXIoKQorICogZW5zdXJlcyB0aGF0IHRoZSBh
c3NpZ25tZW50IHRvIGZwc2ltZF9jcHUgaXMgdmlzaWJsZSB0byBhbnkKKyAqIHByZWVtcHRpb24v
c29mdGlycSB0aGF0IGNvdWxkIHJhY2Ugd2l0aCBzZXRfdHNrX3RocmVhZF9mbGFnKCksIHNvCisg
KiB0aGF0IFRJRl9GT1JFSUdOX0ZQU1RBVEUgY2Fubm90IGJlIHNwdXJpb3VzbHkgcmUtY2xlYXJl
ZC4KKyAqCisgKiBUaGUgZmluYWwgYmFycmllciBlbnN1cmVzIHRoYXQgVElGX0ZPUkVJR05fRlBT
VEFURSBpcyBzZWVuIHNldCBieSBhbnkKKyAqIHN1YnNlcXVlbnQgY29kZS4KICAqLwogdm9pZCBm
cHNpbWRfZmx1c2hfdGFza19zdGF0ZShzdHJ1Y3QgdGFza19zdHJ1Y3QgKnQpCiB7CiAJdC0+dGhy
ZWFkLmZwc2ltZF9jcHUgPSBOUl9DUFVTOworCisJYmFycmllcigpOworCXNldF90c2tfdGhyZWFk
X2ZsYWcodCwgVElGX0ZPUkVJR05fRlBTVEFURSk7CisKKwliYXJyaWVyKCk7CiB9CiAKKy8qCisg
KiBJbnZhbGlkYXRlIGFueSB0YXNrJ3MgRlBTSU1EIHN0YXRlIHRoYXQgaXMgcHJlc2VudCBvbiB0
aGlzIGNwdS4KKyAqIFRoaXMgZnVuY3Rpb24gbXVzdCBiZSBjYWxsZWQgd2l0aCBzb2Z0aXJxcyBk
aXNhYmxlZC4KKyAqLwogdm9pZCBmcHNpbWRfZmx1c2hfY3B1X3N0YXRlKHZvaWQpCiB7CiAJX190
aGlzX2NwdV93cml0ZShmcHNpbWRfbGFzdF9zdGF0ZS5zdCwgTlVMTCk7CmRpZmYgLS1naXQgYS9h
cmNoL2FybTY0L2tlcm5lbC9zaWduYWwuYyBiL2FyY2gvYXJtNjQva2VybmVsL3NpZ25hbC5jCmlu
ZGV4IDg2N2E3Y2UuLmE5YjA0ODUgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtNjQva2VybmVsL3NpZ25h
bC5jCisrKyBiL2FyY2gvYXJtNjQva2VybmVsL3NpZ25hbC5jCkBAIC0yOTYsMTEgKzI5Niw2IEBA
IHN0YXRpYyBpbnQgcmVzdG9yZV9zdmVfZnBzaW1kX2NvbnRleHQoc3RydWN0IHVzZXJfY3R4cyAq
dXNlcikKIAkgKi8KIAogCWZwc2ltZF9mbHVzaF90YXNrX3N0YXRlKGN1cnJlbnQpOwotCWJhcnJp
ZXIoKTsKLQkvKiBGcm9tIG5vdywgZnBzaW1kX3RocmVhZF9zd2l0Y2goKSB3b24ndCBjbGVhciBU
SUZfRk9SRUlHTl9GUFNUQVRFICovCi0KLQlzZXRfdGhyZWFkX2ZsYWcoVElGX0ZPUkVJR05fRlBT
VEFURSk7Ci0JYmFycmllcigpOwogCS8qIEZyb20gbm93LCBmcHNpbWRfdGhyZWFkX3N3aXRjaCgp
IHdvbid0IHRvdWNoIHRocmVhZC5zdmVfc3RhdGUgKi8KIAogCXN2ZV9hbGxvYyhjdXJyZW50KTsK
LS0gCjIuMS40CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtYXJtLWtlcm5lbAo=
