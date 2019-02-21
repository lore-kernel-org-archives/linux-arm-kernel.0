Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB38C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:39:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D93A52086A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OrGhcmE1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D93A52086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QKq9qTiqp6d8ktC0cIP0rAcGcT7j9fQDt+1RLMTGdeY=; b=OrGhcmE1nk5ZfJ2AtRVFuKMPb
	9zxYK9PMIfsMMcnT9EafpbzI/h3NFRB8k/vsJbd3W1mOX9yz90O5CJl1F6yjNyVewjbPq+Kgu16r8
	S+ef2MPwz3DUxF1hDGqnHVsLGweW2E+deqD6SSVIpB6JMO4CrsSKlx8dHxc6ubg4LcmAdN0guQr9U
	mreJS6IjDzeOetbqBo3Sm6rrq3Nc/784lu3EtFootwDImt+9ybCKelRZrhJu64/CHksPJNGssUxt4
	c76SXka5y7jXGVjSw7ex57G9peYL8yiYHpAvPo7/osE9VGmoFF9gI/PEy/orMKFXUrlVpa9u7S8do
	gm9xXVXAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwndj-0003FZ-2w; Thu, 21 Feb 2019 12:39:47 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwndg-0003Ev-OK
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 12:39:46 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAAF880D;
 Thu, 21 Feb 2019 04:39:43 -0800 (PST)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B0353F575;
 Thu, 21 Feb 2019 04:39:41 -0800 (PST)
Subject: Re: [PATCH v5 02/26] arm64: fpsimd: Always set TIF_FOREIGN_FPSTATE on
 task state flush
To: Dave Martin <Dave.Martin@arm.com>, kvmarm@lists.cs.columbia.edu
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
 <1550519559-15915-3-git-send-email-Dave.Martin@arm.com>
From: Julien Grall <julien.grall@arm.com>
Message-ID: <7e358d11-4896-1f09-0496-70a78eb60736@arm.com>
Date: Thu, 21 Feb 2019 12:39:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1550519559-15915-3-git-send-email-Dave.Martin@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_043944_797570_BF7728E7 
X-CRM114-Status: GOOD (  19.77  )
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
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgRGF2ZSwKCk9uIDE4LzAyLzIwMTkgMTk6NTIsIERhdmUgTWFydGluIHdyb3RlOgo+IFRoaXMg
cGF0Y2ggdXBkYXRlcyBmcHNpbWRfZmx1c2hfdGFza19zdGF0ZSgpIHRvIG1pcnJvciB0aGUgbmV3
Cj4gc2VtYW50aWNzIG9mIGZwc2ltZF9mbHVzaF9jcHVfc3RhdGUoKSBpbnRyb2R1Y2VkIGJ5IGNv
bW1pdAo+IGQ4YWQ3MWZhMzhhOSAoImFybTY0OiBmcHNpbWQ6IEZpeCBUSUZfRk9SRUlHTl9GUFNU
QVRFIGFmdGVyCj4gaW52YWxpZGF0aW5nIGNwdSByZWdzIikuICBCb3RoIGZ1bmN0aW9ucyBub3cg
aW1wbGljaXRseSBzZXQKCk5JVDogRG91YmxlLXNwYWNlIGJlZm9yZSAiQm90aCIKCj4gVElGX0ZP
UkVJR05fRlBTVEFURSB0byBpbmRpY2F0ZSB0aGF0IHRoZSB0YXNrJ3MgRlBTSU1EIHN0YXRlIGlz
IG5vdAo+IGxvYWRlZCBpbnRvIHRoZSBjcHUuCj4gCj4gQXMgYSBzaWRlLWVmZmVjdCwgZnBzaW1k
X2ZsdXNoX3Rhc2tfc3RhdGUoKSBub3cgc2V0cwo+IFRJRl9GT1JFSUdOX0ZQU1RBVEUgZXZlbiBm
b3Igbm9uLXJ1bm5pbmcgdGFza3MuICBJbiB0aGUgY2FzZSBvZgoKTklUOiBEb3VibGUgc3BwYWNl
IGJlZm9yZSAiSW4iLgoKPiBub24tcnVubmluZyB0YXNrcyB0aGlzIGlzIG5vdCB1c2VmdWwgYnV0
IGFsc28gaGFybWxlc3MsIGJlY2F1c2UgdGhlCj4gZmxhZyBpcyBsaXZlIG9ubHkgd2hpbGUgdGhl
IGNvcnJlc3BvbmRpbmcgdGFzayBpcyBydW5uaW5nLiAgVGhpcwo+IGZ1bmN0aW9uIGlzIG5vdCBj
YWxsZWQgZnJvbSBmYXN0IHBhdGhzLCBzbyBzcGVjaWFsLWNhc2luZyB0aGlzIGZvcgo+IHRoZSB0
YXNrID09IGN1cnJlbnQgY2FzZSBpcyBub3QgcmVhbGx5IHdvcnRoIGl0Lgo+IAo+IENvbXBpbGVy
IGJhcnJpZXJzIHByZXZpb3VzbHkgcHJlc2VudCBpbiByZXN0b3JlX3N2ZV9mcHNpbWRfY29udGV4
dCgpCj4gYXJlIHB1bGxlZCBpbnRvIGZwc2ltZF9mbHVzaF90YXNrX3N0YXRlKCkgc28gdGhhdCBp
dCBjYW4gYmUgc2FmZWx5Cj4gY2FsbGVkIHdpdGggcHJlZW1wdGlvbiBlbmFibGVkIGlmIG5lY2Vz
c2FyeS4KPiAKPiBFeHBsaWNpdCBjYWxscyB0byBzZXQgVElGX0ZPUkVJR05fRlBTVEFURSB0aGF0
IGFjY29tcGFueQo+IGZwc2ltZF9mbHVzaF90YXNrX3N0YXRlKCkgY2FsbHMgYW5kIGFyZSBub3cg
cmVkdW5kYW50IGFyZSByZW1vdmVkCj4gYXMgYXBwcm9wcmlhdGUuCj4gCj4gZnBzaW1kX2ZsdXNo
X3Rhc2tfc3RhdGUoKSBpcyB1c2VkIHRvIGdldCBleGNsdXNpdmUgYWNjZXNzIHRvIHRoZQo+IHJl
cHJlc2VudGF0aW9uIG9mIHRoZSB0YXNrJ3Mgc3RhdGUgdmlhIHRhc2tfc3RydWN0LCBmb3IgdGhl
IHB1cnBvc2UKPiBvZiByZXBsYWNpbmcgdGhlIHN0YXRlLiAgVGh1cywgdGhlIGNhbGwgdG8gdGhp
cyBmdW5jdGlvbiBzaG91bGQKCk5JVDogRG91YmxlLXNwYWNlIGJlZm9yZSAiVGh1cyIuCgo+IGhh
cHBlbiBiZWZvcmUgbWFuaXB1bGF0aW5nIGZwc2ltZF9zdGF0ZSBvciBzdmVfc3RhdGUgZXRjLiBp
bgo+IHRhc2tfc3RydWN0LiAgQW5vbWFsb3VzIGNhc2VzIGFyZSByZW9yZGVyZWQgYXBwcm9wcmlh
dGVseSBpbiBvcmRlcgoKTklUOiBEb3VibGUtc3BhY2UgYmVmb3JlICJBbm9tYWxvdXMiLgoKPiB0
byBtYWtlIHRoZSBjb2RlIG1vcmUgY29uc2lzdGVudCwgYWx0aG91Z2ggdGhlcmUgc2hvdWxkIGJl
IG5vCj4gZnVuY3Rpb25hbCBkaWZmZXJlbmNlIHNpbmNlIHRoZXNlIGNhc2VzIGFyZSBwcm90ZWN0
ZWQgYnkKPiBsb2NhbF9iaF9kaXNhYmxlKCkgYW55d2F5Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IERh
dmUgTWFydGluIDxEYXZlLk1hcnRpbkBhcm0uY29tPgo+IFJldmlld2VkLWJ5OiBBbGV4IEJlbm7D
qWUgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+CgpSZXZpZXdlZC1ieTogSnVsaWVuIEdyYWxsIDxq
dWxpZW4uZ3JhbGxAYXJtLmNvbT4KCkNoZWVycywKCi0tIApKdWxpZW4gR3JhbGwKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
