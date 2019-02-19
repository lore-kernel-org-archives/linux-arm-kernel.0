Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F519C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:46:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E296421773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LhNtLMDE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E296421773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nlPeE2OyZp/Tde8fXv72bVAzq0CSYMg1VQgR4ZVAdE4=; b=LhNtLMDEwnMduL
	DVbG41bFGRhDOqE8L1KCjIkdjSdN1Oxu4UFdk/iTPl/TdSmJjBDHhZ/PTKkqnVvvS2LmXUQs+rhFI
	ibob3Bw2M/0c2dSgr1J1WuJNXGB41CnQXthGIk8QA6NFJne0sGnEnuLqfq/NFj+5lM2x6OiLgVpjI
	vdoB/SGKV4jdqrTjbgJEt0YP4fOKNu71n7JSRb7OLObQ05OGwQKwDd2s9hooZOBdplNhwrx86kaKe
	qlX0h43VJ4fb9Vjel/xIIYnR1uM+3gsw4wjbFmBLfE0Hx41kRh+IUw8M4AXnrS6aHV6RH1TTUDV5n
	lDO1xhNOafKgV4J3WOtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvvQj-000329-0A; Tue, 19 Feb 2019 02:46:45 +0000
Received: from terminus.zytor.com ([198.137.202.136] helo=mail.zytor.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvvQZ-0002sN-Ma
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 02:46:40 +0000
Received: from carbon-x1.hos.anvin.org
 ([IPv6:2601:646:8680:2bb1:1b64:2c6c:6ec3:aa41])
 (authenticated bits=0)
 by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x1J2kB1h2852107
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
 Mon, 18 Feb 2019 18:46:12 -0800
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
To: Andy Lutomirski <luto@amacapital.net>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20190213140025.GB6346@brain-police>
 <20190213142524.GW32494@hirez.programming.kicks-ass.net>
 <dd33cc20-f335-0e4c-e3f4-02497ecc3710@arm.com>
 <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net>
 <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net>
 <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
 <20190214101429.GD32494@hirez.programming.kicks-ass.net>
 <20ABBED1-E505-45F6-8520-FB93786DF9A9@zytor.com>
 <20190216103044.GR32494@hirez.programming.kicks-ass.net>
 <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
 <CAHk-=wj4Ws1s3iw+w62jcFdnarWhiVxs9zCBjoo7WysxRVZAgQ@mail.gmail.com>
 <573ACC45-4537-46D0-93D9-4091D7CB6090@amacapital.net>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <3b98220d-5c2e-b769-1f55-ceb9565379a2@zytor.com>
Date: Mon, 18 Feb 2019 18:46:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <573ACC45-4537-46D0-93D9-4091D7CB6090@amacapital.net>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_184636_053369_55468A6F 
X-CRM114-Status: GOOD (  13.75  )
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
Cc: Denys Vlasenko <dvlasenk@redhat.com>,
 Julien Thierry <julien.thierry@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Will Deacon <will.deacon@arm.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 valentin.schneider@arm.com, Ingo Molnar <mingo@redhat.com>,
 James Morse <james.morse@arm.com>, Andrew Lutomirski <luto@kernel.org>,
 Brian Gerst <brgerst@gmail.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMi8xOC8xOSA2OjIwIFBNLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6Cj4gCj4gCj4+IE9uIEZl
YiAxOCwgMjAxOSwgYXQgNDoyNCBQTSwgTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4LWZv
dW5kYXRpb24ub3JnPiB3cm90ZToKPj4KPj4+IE9uIE1vbiwgRmViIDE4LCAyMDE5IGF0IDI6MzEg
UE0gSC4gUGV0ZXIgQW52aW4gPGhwYUB6eXRvci5jb20+IHdyb3RlOgo+Pj4KPj4+IFRoZSBxdWVz
dGlvbiBpcyB3aGF0ICJmaXggaXQiIG1lYW5zLiBJJ20gcmVhbGx5IGNvbmNlcm5lZCBhYm91dCBB
QyBlc2NhcGVzLAo+Pj4gYW5kIGV2ZXJ5b25lIGVsc2Ugc2hvdWxkIGJlLCB0b28uCj4+Cj4+IEkg
ZG8gdGhpbmsgdGhhdCBpdCBtaWdodCBiZSB0aGUgcmlnaHQgdGhpbmcgdG8gZG8gdG8gYWRkIHNv
bWUga2luZCBvZgo+PiBXQVJOX09OX09OQ0UoKSBmb3IgQUMgYmVpbmcgc2V0IGluIHZhcmlvdXMg
Y2FuLXJlc2NoZWR1bGUgc2l0dWF0aW9ucy4KPj4KPj4gV2UnZCBqdXN0IGhhdmUgdG8gYWJzdHJh
Y3QgaXQgc2FuZWx5LiBJJ20gc3VyZSBhcm02NCBoYXMgdGhlIGV4YWN0Cj4+IHNhbWUgaXNzdWUg
d2l0aCBQQU4gLSBtYXliZSBpdCBzYXZlcyBwcm9wZXJseSwgYnV0IHRoZSBzYW1lICJ3ZQo+PiB3
b3VsZG4ndCB3YW50IHRvIGdvIHRocm91Z2ggdGhlIHNjaGVkdWxlciB3aXRoIFBBTiBjbGVhciIu
Cj4+Cj4+IE9uIHg4Niwgd2UgbWlnaHQgYXMgd2VsbCBjaGVjayBERiBhdCB0aGUgc2FtZSB0aW1l
IGFzIEFDLgo+Pgo+IAo+IGhwYSBpcyByaWdodCwgdGhvdWdoIOKAlCBjYWxsaW5nIGludG8gdHJh
Y2luZyBjb2RlIHdpdGggQUMgc2V0IGlzIG5vdCByZWFsbHkgc28gZ29vZC4gIEFuZCBjYWxsaW5n
IHNjaGVkdWxlKCkgKHZpYSBwcmVlbXB0X2VuYWJsZSgpIG9yIHdoYXRldmVyKSBpcyBhbHNvIGJh
ZCBiZWNhdXNlIGl0IHJ1bnMgYWxsIHRoZSBzY2hlZHVsZXIgY29kZSB3aXRoIEFDIG9uLiAgQWRt
aXR0ZWRseSwgdGhlIHNjaGVkdWxlciBpcyBub3QgKnRoYXQqIGludGVyZXN0aW5nIG9mIGFuIGF0
dGFjayBzdXJmYWNlLgo+IAoKTm90IGp1c3QgdGhhdCwgYnV0IHRoZSBvdGhlciBxdWVzdGlvbiBp
cyBqdXN0IGhvdyBtdWNoIGNvZGUgd2UgYXJlIHJ1bm5pbmcKd2l0aCBBQyBvcGVuLiBJdCByZWFs
bHkgc2hvdWxkIG9ubHkgYmUgZG9uZSBpbiBzb21lIHZlcnkgc21hbGwgcmVnaW9ucy4KCgktaHBh
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
YXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJt
LWtlcm5lbAo=
