Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69030C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:14:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 365A6222B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cv9jpj9S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365A6222B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wjMsQQHUQrdFn3OPWXqCAZX/rtAHocmg2Jl6hpa4uR0=; b=Cv9jpj9SjC1a8E
	XkuQfrLPzkD8cj2oSfMk6eqwRdZ0tyLVVa1/vtiuqhI7aYnzNfX+9Dyf1EONhhc0JtoCrKNVh/UGv
	QKAJlVSjPjjL/UcN1VGY8r/lNWyltqS3i/g5meURFoBJCvNomMAqsLVc4iTzxZ0bxLyORuqq+BWgm
	y/AVauS2NW9szfiNJdFNo8O+Ca3A2kAGx0+/xiexaisriafslvO3UMtaQF+zgXxydaY3JZhQFM4Cv
	+SAWnndhKcmRmaXWt29/Y1fgBiSE+As+3fFTEWmWqXjkSoiVJ1xHY5ttDTLh0iiWDpjwqPv6m9t3y
	jQIVIlHwY1QCsBSepGwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guE2N-0007X4-7u; Thu, 14 Feb 2019 10:14:35 +0000
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guE2K-0007WI-00; Thu, 14 Feb 2019 10:14:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id D036D20298375; Thu, 14 Feb 2019 11:14:29 +0100 (CET)
Date: Thu, 14 Feb 2019 11:14:29 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH] sched/x86: Save [ER]FLAGS on context switch
Message-ID: <20190214101429.GD32494@hirez.programming.kicks-ass.net>
References: <1c2429a4-9df9-40a3-98e0-51577de4bd6a@arm.com>
 <20190213131720.GU32494@hirez.programming.kicks-ass.net>
 <20190213140025.GB6346@brain-police>
 <20190213142524.GW32494@hirez.programming.kicks-ass.net>
 <dd33cc20-f335-0e4c-e3f4-02497ecc3710@arm.com>
 <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net>
 <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net>
 <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: dvlasenk@redhat.com, brgerst@gmail.com,
 Julien Thierry <julien.thierry@arm.com>, catalin.marinas@arm.com,
 jpoimboe@redhat.com, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, valentin.schneider@arm.com, mingo@redhat.com,
 james.morse@arm.com, luto@kernel.org, hpa@zytor.com, bp@alien8.de,
 tglx@linutronix.de, torvalds@linux-foundation.org,
 Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gV2VkLCBGZWIgMTMsIDIwMTkgYXQgMDI6NDk6NDdQTSAtMDgwMCwgQW5keSBMdXRvbWlyc2tp
IHdyb3RlOgoKPiBEbyB3ZSBuZWVkIHRvIGJhY2twb3J0IHRoaXMgdGhpbmc/CgpQb3NzaWJseSwg
anVzdCB0byBiZSBzYWZlLgoKPiBUaGUgcHJvYmxlbSBjYW7igJl0IGJlIHRvbyB3aWRlc3ByZWFk
IG9yIHdlIHdvdWxkIGhhdmUgaGVhcmQgb2YgaXQgYmVmb3JlLgoKWWVzLCBzbyBmYXIgd2UndmUg
YmVlbiBsdWNreS4KCi0tLQpTdWJqZWN0OiBzY2hlZC94ODY6IFNhdmUgW0VSXUZMQUdTIG9uIGNv
bnRleHQgc3dpdGNoCkZyb206IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4K
RGF0ZTogVGh1IEZlYiAxNCAxMDozMDo1MiBDRVQgMjAxOQoKRWZmZWN0aXZlbHkgcmV2ZXJ0IGNv
bW1pdDoKCiAgMmM3NTc3YTc1ODM3ICgic2NoZWQveDg2XzY0OiBEb24ndCBzYXZlIGZsYWdzIG9u
IGNvbnRleHQgc3dpdGNoIikKClNwZWNpZmljYWxseSBiZWNhdXNlIFNNQVAgdXNlcyBGTEFHUy5B
QyB3aGljaCBpbnZhbGlkYXRlcyB0aGUgY2xhaW0KdGhhdCB0aGUga2VybmVsIGhhcyBjbGVhbiBm
bGFncy4KCkluIHBhcnRpY3VsYXI7IHdoaWxlIHByZWVtcHRpb24gZnJvbSBpbnRlcnJ1cHQgcmV0
dXJuIGlzIGZpbmUgKHRoZQpJUkVUIGZyYW1lIG9uIHRoZSBleGNlcHRpb24gc3RhY2sgY29udGFp
bnMgRkxBR1MpIGl0IGJyZWFrcyBhbnkgY29kZQp0aGF0IGRvZXMgc3luY2hvbm91cyBzY2hlZHVs
aW5nLCBpbmNsdWRpbmcgcHJlZW1wdF9lbmFibGUoKS4KClRoaXMgaGFzIGJlY29tZSBhIHNpZ25p
ZmljYW50IGlzc3VlIGV2ZXIgc2luY2UgY29tbWl0OgoKICA1YjI0YTdhMmFhMjAgKCJBZGQgJ3Vu
c2FmZScgdXNlciBhY2Nlc3MgZnVuY3Rpb25zIGZvciBiYXRjaGVkIGFjY2Vzc2VzIikKCnByb3Zp
ZGVkIGZvciBtZWFucyBvZiBoYXZpbmcgJ25vcm1hbCcgQyBjb2RlIGJldHdlZW4gU1RBQyAvIENM
QUMsCmV4cG9zaW5nIHRoZSBGTEFHUy5BQyBzdGF0ZS4gU28gZmFyIHRoaXMgaGFzbid0IGxlZCB0
byB0cm91YmxlLApob3dldmVyIGZpeCBpdCBiZWZvcmUgaXQgY29tZXMgYXBhcnQuCgpGaXhlczog
NWIyNGE3YTJhYTIwICgiQWRkICd1bnNhZmUnIHVzZXIgYWNjZXNzIGZ1bmN0aW9ucyBmb3IgYmF0
Y2hlZCBhY2Nlc3NlcyIpCkFja2VkLWJ5OiBBbmR5IEx1dG9taXJza2kgPGx1dG9AYW1hY2FwaXRh
bC5uZXQ+ClJlcG9ydGVkLWJ5OiBKdWxpZW4gVGhpZXJyeSA8anVsaWVuLnRoaWVycnlAYXJtLmNv
bT4KU2lnbmVkLW9mZi1ieTogUGV0ZXIgWmlqbHN0cmEgKEludGVsKSA8cGV0ZXJ6QGluZnJhZGVh
ZC5vcmc+Ci0tLQogYXJjaC94ODYvZW50cnkvZW50cnlfMzIuUyAgICAgICAgfCAgICAyICsrCiBh
cmNoL3g4Ni9lbnRyeS9lbnRyeV82NC5TICAgICAgICB8ICAgIDIgKysKIGFyY2gveDg2L2luY2x1
ZGUvYXNtL3N3aXRjaF90by5oIHwgICAgMSArCiAzIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9u
cygrKQoKLS0tIGEvYXJjaC94ODYvZW50cnkvZW50cnlfMzIuUworKysgYi9hcmNoL3g4Ni9lbnRy
eS9lbnRyeV8zMi5TCkBAIC02NTAsNiArNjUwLDcgQEAgRU5UUlkoX19zd2l0Y2hfdG9fYXNtKQog
CXB1c2hsCSVlYngKIAlwdXNobAklZWRpCiAJcHVzaGwJJWVzaQorCXB1c2hmbAogCiAJLyogc3dp
dGNoIHN0YWNrICovCiAJbW92bAklZXNwLCBUQVNLX3RocmVhZHNwKCVlYXgpCkBAIC02NzIsNiAr
NjczLDcgQEAgRU5UUlkoX19zd2l0Y2hfdG9fYXNtKQogI2VuZGlmCiAKIAkvKiByZXN0b3JlIGNh
bGxlZS1zYXZlZCByZWdpc3RlcnMgKi8KKwlwb3BmbAogCXBvcGwJJWVzaQogCXBvcGwJJWVkaQog
CXBvcGwJJWVieAotLS0gYS9hcmNoL3g4Ni9lbnRyeS9lbnRyeV82NC5TCisrKyBiL2FyY2gveDg2
L2VudHJ5L2VudHJ5XzY0LlMKQEAgLTI5MSw2ICsyOTEsNyBAQCBFTlRSWShfX3N3aXRjaF90b19h
c20pCiAJcHVzaHEJJXIxMwogCXB1c2hxCSVyMTQKIAlwdXNocQklcjE1CisJcHVzaGZxCiAKIAkv
KiBzd2l0Y2ggc3RhY2sgKi8KIAltb3ZxCSVyc3AsIFRBU0tfdGhyZWFkc3AoJXJkaSkKQEAgLTMx
Myw2ICszMTQsNyBAQCBFTlRSWShfX3N3aXRjaF90b19hc20pCiAjZW5kaWYKIAogCS8qIHJlc3Rv
cmUgY2FsbGVlLXNhdmVkIHJlZ2lzdGVycyAqLworCXBvcGZxCiAJcG9wcQklcjE1CiAJcG9wcQkl
cjE0CiAJcG9wcQklcjEzCi0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3N3aXRjaF90by5oCisr
KyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3N3aXRjaF90by5oCkBAIC00MCw2ICs0MCw3IEBAIGFz
bWxpbmthZ2Ugdm9pZCByZXRfZnJvbV9mb3JrKHZvaWQpOwogICogb3JkZXIgb2YgdGhlIGZpZWxk
cyBtdXN0IG1hdGNoIHRoZSBjb2RlIGluIF9fc3dpdGNoX3RvX2FzbSgpLgogICovCiBzdHJ1Y3Qg
aW5hY3RpdmVfdGFza19mcmFtZSB7CisJdW5zaWduZWQgbG9uZyBmbGFnczsKICNpZmRlZiBDT05G
SUdfWDg2XzY0CiAJdW5zaWduZWQgbG9uZyByMTU7CiAJdW5zaWduZWQgbG9uZyByMTQ7CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2Vy
bmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVs
Cg==
