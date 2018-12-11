Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07967C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:31:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C823920672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NiohIH6T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C823920672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Q7EjCkq1+wl1689QLXaEqjLlKz9jSK7Qnwfarp4nEHA=; b=NiohIH6T3cIYrd
	iw+oxdrlr2XJJGmTpGqMKdPZhDi9zRA95HCz8o8w79sjMHvuSQ+YqBXuZsFVFL8QQhVMBToNnKjbu
	icXxQ+RpQj/oQGytP4zXIY9evBL/7zoVby+VvDnKq5HD88FYROLCnhCqufDsOIzFJLSURhKwm8WTz
	brVKgxjQoeNxWMvz4IoHe/G5iA0z/vkHdPN+vKQu0eCuGuItF3gcqfhm4deMmo6yh0Tx7sX3ml0pU
	Ztq44QV7+//RnjDza5M58iPiv+SbZe7KQObff3NP6hIeo6rIjjxJA7I4PRX7rsQN3UTE787N8cCGH
	fhsYBh1bzQ7zP2j/EPFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWrUR-0005ow-Ra; Tue, 11 Dec 2018 23:30:59 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWrTV-0003mI-OJ
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 23:30:05 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A41780D;
 Tue, 11 Dec 2018 15:29:51 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C06F93F614;
 Tue, 11 Dec 2018 15:29:49 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [RFC PATCH v3 01/24] arm64: fpsimd: Always set TIF_FOREIGN_FPSTATE on
 task state flush
Date: Tue, 11 Dec 2018 23:28:38 +0000
Message-Id: <1544570941-7377-2-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1544570941-7377-1-git-send-email-Dave.Martin@arm.com>
References: <1544570941-7377-1-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_153001_933066_1EF39A32 
X-CRM114-Status: GOOD (  15.69  )
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

VGhpcyBwYXRjaCB1cGRhdGVzIGZwc2ltZF9mbHVzaF90YXNrX3N0YXRlKCkgdG8gbWlycm9yIHRo
ZSBuZXcKc2VtYW50aWNzIG9mIGZwc2ltZF9mbHVzaF9jcHVfc3RhdGUoKTogYm90aCBmdW5jdGlv
bnMgbm93CmltcGxpY2l0bHkgc2V0IFRJRl9GT1JFSUdOX0ZQU1RBVEUgdG8gaW5kaWNhdGUgdGhh
dCB0aGUgdGFzaydzCkZQU0lNRCBzdGF0ZSBpcyBub3QgbG9hZGVkIGludG8gdGhlIGNwdS4KCkFz
IGEgc2lkZS1lZmZlY3QsIGZwc2ltZF9mbHVzaF90YXNrX3N0YXRlKCkgbm93IHNldHMKVElGX0ZP
UkVJR05fRlBTVEFURSBldmVuIGZvciBub24tcnVubmluZyB0YXNrcy4gIEluIHRoZSBjYXNlIG9m
Cm5vbi1ydW5uaW5nIHRhc2tzIHRoaXMgaXMgbm90IHVzZWZ1bCBidXQgYWxzbyBoYXJtbGVzcywg
YmVjYXVzZSB0aGUKZmxhZyBpcyBsaXZlIG9ubHkgd2hpbGUgdGhlIGNvcnJlc3BvbmRpbmcgdGFz
ayBpcyBydW5uaW5nLiAgVGhpcwpmdW5jdGlvbiBpcyBub3QgY2FsbGVkIGZyb20gZmFzdCBwYXRo
cywgc28gc3BlY2lhbC1jYXNpbmcgdGhpcyBmb3IKdGhlIHRhc2sgPT0gY3VycmVudCBjYXNlIGlz
IG5vdCByZWFsbHkgd29ydGggaXQuCgpDb21waWxlciBiYXJyaWVycyBwcmV2aW91c2x5IHByZXNl
bnQgaW4gcmVzdG9yZV9zdmVfZnBzaW1kX2NvbnRleHQoKQphcmUgcHVsbGVkIGludG8gZnBzaW1k
X2ZsdXNoX3Rhc2tfc3RhdGUoKSBzbyB0aGF0IGl0IGNhbiBiZSBzYWZlbHkKY2FsbGVkIHdpdGgg
cHJlZW1wdGlvbiBlbmFibGVkIGlmIG5lY2Vzc2FyeS4KCkV4cGxpY2l0IGNhbGxzIHRvIHNldCBU
SUZfRk9SRUlHTl9GUFNUQVRFIHRoYXQgYWNjb21wYW55CmZwc2ltZF9mbHVzaF90YXNrX3N0YXRl
KCkgY2FsbHMgYW5kIGFyZSBub3cgcmVkdW5kYW50IGFyZSByZW1vdmVkCmFzIGFwcHJvcHJpYXRl
LgoKZnBzaW1kX2ZsdXNoX3Rhc2tfc3RhdGUoKSBpcyB1c2VkIHRvIGdldCBleGNsdXNpdmUgYWNj
ZXNzIHRvIHRoZQpyZXByZXNlbnRhdGlvbiBvZiB0aGUgdGFzaydzIHN0YXRlIHZpYSB0YXNrX3N0
cnVjdCwgZm9yIHRoZSBwdXJwb3NlCm9mIHJlcGxhY2luZyB0aGUgc3RhdGUuICBUaHVzLCB0aGUg
Y2FsbCB0byB0aGlzIGZ1bmN0aW9uIHNob3VsZApoYXBwZW4gYmVmb3JlIG1hbmlwdWxhdGluZyBm
cHNpbWRfc3RhdGUgb3Igc3ZlX3N0YXRlIGV0Yy4gaW4KdGFza19zdHJ1Y3QuICBBbm9tYWxvdXMg
Y2FzZXMgYXJlIHJlb3JkZXJlZCBhcHByb3ByaWF0ZWx5IGluIG9yZGVyCnRvIG1ha2UgdGhlIGNv
ZGUgbW9yZSBjb25zaXN0ZW50LCBhbHRob3VnaCB0aGVyZSBzaG91bGQgYmUgbm8KZnVuY3Rpb25h
bCBkaWZmZXJlbmNlIHNpbmNlIHRoZXNlIGNhc2VzIGFyZSBwcm90ZWN0ZWQgYnkKbG9jYWxfYmhf
ZGlzYWJsZSgpIGFueXdheS4KClNpZ25lZC1vZmYtYnk6IERhdmUgTWFydGluIDxEYXZlLk1hcnRp
bkBhcm0uY29tPgpSZXZpZXdlZC1ieTogQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8u
b3JnPgotLS0KIGFyY2gvYXJtNjQva2VybmVsL2Zwc2ltZC5jIHwgMjUgKysrKysrKysrKysrKysr
KysrKy0tLS0tLQogYXJjaC9hcm02NC9rZXJuZWwvc2lnbmFsLmMgfCAgNSAtLS0tLQogMiBmaWxl
cyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9hcmNoL2FybTY0L2tlcm5lbC9mcHNpbWQuYyBiL2FyY2gvYXJtNjQva2VybmVsL2Zwc2ltZC5j
CmluZGV4IDVlYmU3M2IuLjYyYzM3ZjAgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtNjQva2VybmVsL2Zw
c2ltZC5jCisrKyBiL2FyY2gvYXJtNjQva2VybmVsL2Zwc2ltZC5jCkBAIC01NTAsNyArNTUwLDYg
QEAgaW50IHN2ZV9zZXRfdmVjdG9yX2xlbmd0aChzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRhc2ssCiAJ
CWxvY2FsX2JoX2Rpc2FibGUoKTsKIAogCQlmcHNpbWRfc2F2ZSgpOwotCQlzZXRfdGhyZWFkX2Zs
YWcoVElGX0ZPUkVJR05fRlBTVEFURSk7CiAJfQogCiAJZnBzaW1kX2ZsdXNoX3Rhc2tfc3RhdGUo
dGFzayk7CkBAIC04MTYsMTIgKzgxNSwxMSBAQCBhc21saW5rYWdlIHZvaWQgZG9fc3ZlX2FjYyh1
bnNpZ25lZCBpbnQgZXNyLCBzdHJ1Y3QgcHRfcmVncyAqcmVncykKIAlsb2NhbF9iaF9kaXNhYmxl
KCk7CiAKIAlmcHNpbWRfc2F2ZSgpOwotCWZwc2ltZF90b19zdmUoY3VycmVudCk7CiAKIAkvKiBG
b3JjZSByZXRfdG9fdXNlciB0byByZWxvYWQgdGhlIHJlZ2lzdGVyczogKi8KIAlmcHNpbWRfZmx1
c2hfdGFza19zdGF0ZShjdXJyZW50KTsKLQlzZXRfdGhyZWFkX2ZsYWcoVElGX0ZPUkVJR05fRlBT
VEFURSk7CiAKKwlmcHNpbWRfdG9fc3ZlKGN1cnJlbnQpOwogCWlmICh0ZXN0X2FuZF9zZXRfdGhy
ZWFkX2ZsYWcoVElGX1NWRSkpCiAJCVdBUk5fT04oMSk7IC8qIFNWRSBhY2Nlc3Mgc2hvdWxkbid0
IGhhdmUgdHJhcHBlZCAqLwogCkBAIC04OTQsOSArODkyLDkgQEAgdm9pZCBmcHNpbWRfZmx1c2hf
dGhyZWFkKHZvaWQpCiAKIAlsb2NhbF9iaF9kaXNhYmxlKCk7CiAKKwlmcHNpbWRfZmx1c2hfdGFz
a19zdGF0ZShjdXJyZW50KTsKIAltZW1zZXQoJmN1cnJlbnQtPnRocmVhZC51dy5mcHNpbWRfc3Rh
dGUsIDAsCiAJICAgICAgIHNpemVvZihjdXJyZW50LT50aHJlYWQudXcuZnBzaW1kX3N0YXRlKSk7
Ci0JZnBzaW1kX2ZsdXNoX3Rhc2tfc3RhdGUoY3VycmVudCk7CiAKIAlpZiAoc3lzdGVtX3N1cHBv
cnRzX3N2ZSgpKSB7CiAJCWNsZWFyX3RocmVhZF9mbGFnKFRJRl9TVkUpOwpAQCAtOTMzLDggKzkz
MSw2IEBAIHZvaWQgZnBzaW1kX2ZsdXNoX3RocmVhZCh2b2lkKQogCQkJY3VycmVudC0+dGhyZWFk
LnN2ZV92bF9vbmV4ZWMgPSAwOwogCX0KIAotCXNldF90aHJlYWRfZmxhZyhUSUZfRk9SRUlHTl9G
UFNUQVRFKTsKLQogCWxvY2FsX2JoX2VuYWJsZSgpOwogfQogCkBAIC0xMDQzLDEyICsxMDM5LDI5
IEBAIHZvaWQgZnBzaW1kX3VwZGF0ZV9jdXJyZW50X3N0YXRlKHN0cnVjdCB1c2VyX2Zwc2ltZF9z
dGF0ZSBjb25zdCAqc3RhdGUpCiAKIC8qCiAgKiBJbnZhbGlkYXRlIGxpdmUgQ1BVIGNvcGllcyBv
ZiB0YXNrIHQncyBGUFNJTUQgc3RhdGUKKyAqCisgKiBUaGlzIGZ1bmN0aW9uIG1heSBiZSBjYWxs
ZWQgd2l0aCBwcmVlbXB0aW9uIGVuYWJsZWQuICBUaGUgYmFycmllcigpCisgKiBlbnN1cmVzIHRo
YXQgdGhlIGFzc2lnbm1lbnQgdG8gZnBzaW1kX2NwdSBpcyB2aXNpYmxlIHRvIGFueQorICogcHJl
ZW1wdGlvbi9zb2Z0aXJxIHRoYXQgY291bGQgcmFjZSB3aXRoIHNldF90c2tfdGhyZWFkX2ZsYWco
KSwgc28KKyAqIHRoYXQgVElGX0ZPUkVJR05fRlBTVEFURSBjYW5ub3QgYmUgc3B1cmlvdXNseSBy
ZS1jbGVhcmVkLgorICoKKyAqIFRoZSBmaW5hbCBiYXJyaWVyIGVuc3VyZXMgdGhhdCBUSUZfRk9S
RUlHTl9GUFNUQVRFIGlzIHNlZW4gc2V0IGJ5IGFueQorICogc3Vic2VxdWVudCBjb2RlLgogICov
CiB2b2lkIGZwc2ltZF9mbHVzaF90YXNrX3N0YXRlKHN0cnVjdCB0YXNrX3N0cnVjdCAqdCkKIHsK
IAl0LT50aHJlYWQuZnBzaW1kX2NwdSA9IE5SX0NQVVM7CisKKwliYXJyaWVyKCk7CisJc2V0X3Rz
a190aHJlYWRfZmxhZyh0LCBUSUZfRk9SRUlHTl9GUFNUQVRFKTsKKworCWJhcnJpZXIoKTsKIH0K
IAorLyoKKyAqIEludmFsaWRhdGUgYW55IHRhc2sncyBGUFNJTUQgc3RhdGUgdGhhdCBpcyBwcmVz
ZW50IG9uIHRoaXMgY3B1LgorICogVGhpcyBmdW5jdGlvbiBtdXN0IGJlIGNhbGxlZCB3aXRoIHNv
ZnRpcnFzIGRpc2FibGVkLgorICovCiB2b2lkIGZwc2ltZF9mbHVzaF9jcHVfc3RhdGUodm9pZCkK
IHsKIAlfX3RoaXNfY3B1X3dyaXRlKGZwc2ltZF9sYXN0X3N0YXRlLnN0LCBOVUxMKTsKZGlmZiAt
LWdpdCBhL2FyY2gvYXJtNjQva2VybmVsL3NpZ25hbC5jIGIvYXJjaC9hcm02NC9rZXJuZWwvc2ln
bmFsLmMKaW5kZXggNWRjYzk0Mi4uN2RjZjBmMSAxMDA2NDQKLS0tIGEvYXJjaC9hcm02NC9rZXJu
ZWwvc2lnbmFsLmMKKysrIGIvYXJjaC9hcm02NC9rZXJuZWwvc2lnbmFsLmMKQEAgLTI5NiwxMSAr
Mjk2LDYgQEAgc3RhdGljIGludCByZXN0b3JlX3N2ZV9mcHNpbWRfY29udGV4dChzdHJ1Y3QgdXNl
cl9jdHhzICp1c2VyKQogCSAqLwogCiAJZnBzaW1kX2ZsdXNoX3Rhc2tfc3RhdGUoY3VycmVudCk7
Ci0JYmFycmllcigpOwotCS8qIEZyb20gbm93LCBmcHNpbWRfdGhyZWFkX3N3aXRjaCgpIHdvbid0
IGNsZWFyIFRJRl9GT1JFSUdOX0ZQU1RBVEUgKi8KLQotCXNldF90aHJlYWRfZmxhZyhUSUZfRk9S
RUlHTl9GUFNUQVRFKTsKLQliYXJyaWVyKCk7CiAJLyogRnJvbSBub3csIGZwc2ltZF90aHJlYWRf
c3dpdGNoKCkgd29uJ3QgdG91Y2ggdGhyZWFkLnN2ZV9zdGF0ZSAqLwogCiAJc3ZlX2FsbG9jKGN1
cnJlbnQpOwotLSAKMi4xLjQKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
