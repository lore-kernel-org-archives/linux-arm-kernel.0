Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E93C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:02:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 060DD20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OpbbvMvx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 060DD20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9qk3AKgcBnZJm3gZcUoIVCA1hzY0ckGu7ACOhvkWmkY=; b=OpbbvMvxlv+WP6
	KAHvr5RyIMHSHPvrRodmvzX1VLyLaB+v/Oz0l/YfYl8pPcNO+JSRcMPUeTWLTSaC6cew1ejYKhtL4
	W10VIIG82unCL/t0q5xN7vjorkusJFv1I4e6ehc6y1VTqwSwWtT4afTJrRD5tYguCyBASLnfor7oK
	mH8jLByY4oGIthS3+5mFpJLZwKC26fxv/TqRU7ZzVnEFh5f1RDmWzLARR+9PUv/+ibaJBRUyq1B6x
	ZTIEDzEstVc/GZYXQkSCwJxWn+7UDwynJU8X5oE2+pS6DQulSIwFjmFS3r6K8xoCX/iYSG3w+ZdhT
	H1qCspyH0T53pm/GMldw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkEQC-000453-Gs; Thu, 17 Jan 2019 20:37:52 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkENR-0000C5-7T
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 20:35:39 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 028EE1596;
 Thu, 17 Jan 2019 12:35:01 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 08F173F819;
 Thu, 17 Jan 2019 12:34:58 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v4 15/25] KVM: Allow 2048-bit register access via ioctl
 interface
Date: Thu, 17 Jan 2019 20:33:29 +0000
Message-Id: <1547757219-19439-16-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1547757219-19439-1-git-send-email-Dave.Martin@arm.com>
References: <1547757219-19439-1-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_123501_860445_8BF4FC88 
X-CRM114-Status: GOOD (  11.42  )
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
 Will Deacon <will.deacon@arm.com>, Julien Grall <Julien.Grall@arm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhlIEFybSBTVkUgYXJjaGl0ZWN0dXJlIGRlZmluZXMgcmVnaXN0ZXJzIHRoYXQgYXJlIHVwIHRv
IDIwNDggYml0cwppbiBzaXplICh3aXRoIHNvbWUgcG9zc2liaWxpdHkgb2YgZnVydGhlciBmdXR1
cmUgZXhwYW5zaW9uKS4KCkluIG9yZGVyIHRvIGF2b2lkIHRoZSBuZWVkIGZvciBhbiBleGNlc3Np
dmVseSBsYXJnZSBudW1iZXIgb2YKaW9jdGxzIHdoZW4gc2F2aW5nIGFuZCByZXN0b3JpbmcgYSB2
Y3B1J3MgcmVnaXN0ZXJzLCB0aGlzIHBhdGNoCmFkZHMgYSAjZGVmaW5lIHRvIG1ha2Ugc3VwcG9y
dCBmb3IgaW5kaXZpZHVhbCAyMDQ4LWJpdCByZWdpc3RlcnMKdGhyb3VnaCB0aGUgS1ZNX3tHRVQs
U0VUfV9PTkVfUkVHIGlvY3RsIGludGVyZmFjZSBvZmZpY2lhbC4gIFRoaXMKd2lsbCBhbGxvdyBl
YWNoIFNWRSByZWdpc3RlciB0byBiZSBhY2Nlc3NlZCBpbiBhIHNpbmdsZSBjYWxsLgoKVGhlcmUg
YXJlIHN1ZmZpY2llbnQgc3BhcmUgYml0cyBpbiB0aGUgcmVnaXN0ZXIgaWQgc2l6ZSBmaWVsZCBm
b3IKdGhpcyBjaGFuZ2UsIHNvIHRoZXJlIGlzIG5vIEFCSSBpbXBhY3QgcHJvdmlkaW5nIHRoYXQK
S1ZNX0dFVF9SRUdfTElTVCBkb2VzIG5vdCBlbnVtZXJhdGUgYW55IDIwNDgtYml0IHJlZ2lzdGVy
IHVubGVzcwp1c2Vyc3BhY2UgZXhwbGljaXRseSBvcHRzIGluIHRvIHRoZSByZWxldmFudCBhcmNo
aXRlY3R1cmUtc3BlY2lmaWMKZmVhdHVyZXMuCgpTaWduZWQtb2ZmLWJ5OiBEYXZlIE1hcnRpbiA8
RGF2ZS5NYXJ0aW5AYXJtLmNvbT4KUmV2aWV3ZWQtYnk6IEFsZXggQmVubsOpZSA8YWxleC5iZW5u
ZWVAbGluYXJvLm9yZz4KLS0tCiBpbmNsdWRlL3VhcGkvbGludXgva3ZtLmggfCAxICsKIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51
eC9rdm0uaCBiL2luY2x1ZGUvdWFwaS9saW51eC9rdm0uaAppbmRleCA2ZDRlYTRiLi5kYzc3YTVh
IDEwMDY0NAotLS0gYS9pbmNsdWRlL3VhcGkvbGludXgva3ZtLmgKKysrIGIvaW5jbHVkZS91YXBp
L2xpbnV4L2t2bS5oCkBAIC0xMTQ1LDYgKzExNDUsNyBAQCBzdHJ1Y3Qga3ZtX2RpcnR5X3RsYiB7
CiAjZGVmaW5lIEtWTV9SRUdfU0laRV9VMjU2CTB4MDA1MDAwMDAwMDAwMDAwMFVMTAogI2RlZmlu
ZSBLVk1fUkVHX1NJWkVfVTUxMgkweDAwNjAwMDAwMDAwMDAwMDBVTEwKICNkZWZpbmUgS1ZNX1JF
R19TSVpFX1UxMDI0CTB4MDA3MDAwMDAwMDAwMDAwMFVMTAorI2RlZmluZSBLVk1fUkVHX1NJWkVf
VTIwNDgJMHgwMDgwMDAwMDAwMDAwMDAwVUxMCiAKIHN0cnVjdCBrdm1fcmVnX2xpc3QgewogCV9f
dTY0IG47IC8qIG51bWJlciBvZiByZWdzICovCi0tIAoyLjEuNAoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBs
aXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
