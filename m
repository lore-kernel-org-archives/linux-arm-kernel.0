Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D1EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:21:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40EBC21934
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GMBzUKrB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40EBC21934
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WrAxazfxSl87mhmKgAevU3x/eZIIkG2yARofwkOir3U=; b=GMBzUKrBkXOBZI
	4RIVl24gkDaMhEqI2Nf6bg90azWIqBYAvcIdawQ16G9xuuad9JjK5PFWKpzTkc13ofWqQlWzqWnw/
	IHI3Pmk287zqkAfi/z1vw+V9ID4TT0YBVc6OY7ftBaWvqvCCDAZnk6ajMOXkCSDDXwUipHTMMLHFO
	+6WMh4pDzbfPyVxaaPcy+m7uWLS0puMQtlDaGc2jmWse2nXRXos8NjCIfK7ccrAZ+j075Uw5BfLoh
	9UwwExQe8pHB7bZywpij670yApItUYprrI5oDyWeN2RyQR0YNvgf6BbFoVmH1F+vx3TJtZ6xk9EYl
	vIgyYMgrs1JJYL+CNY1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu2ud-0006DR-Pj; Wed, 13 Feb 2019 22:21:51 +0000
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu2ua-0006DD-Qd; Wed, 13 Feb 2019 22:21:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id CECC425E3DE45; Wed, 13 Feb 2019 23:21:46 +0100 (CET)
Date: Wed, 13 Feb 2019 23:21:46 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v3 3/4] uaccess: Check no rescheduling function is called
 in unsafe region
Message-ID: <20190213222146.GC32494@hirez.programming.kicks-ass.net>
References: <a23fdd84-8c4b-0c1f-d877-24d946cff6d0@arm.com>
 <20190213103553.GO32494@hirez.programming.kicks-ass.net>
 <1c2429a4-9df9-40a3-98e0-51577de4bd6a@arm.com>
 <20190213131720.GU32494@hirez.programming.kicks-ass.net>
 <20190213140025.GB6346@brain-police>
 <20190213142524.GW32494@hirez.programming.kicks-ass.net>
 <dd33cc20-f335-0e4c-e3f4-02497ecc3710@arm.com>
 <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net>
 <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
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

T24gV2VkLCBGZWIgMTMsIDIwMTkgYXQgMTA6NTE6MjRBTSAtMDgwMCwgQW5keSBMdXRvbWlyc2tp
IHdyb3RlOgo+ID4gT24gRmViIDEzLCAyMDE5LCBhdCA3OjQ1IEFNLCBQZXRlciBaaWpsc3RyYSA8
cGV0ZXJ6QGluZnJhZGVhZC5vcmc+IHdyb3RlOgoKPiA+IFdoaWNoIEkgc3VwcG9zZSBtZWFucyB0
aGF0IEdDQyBnZW5lcmF0ZXMgdGhlIFBVU0hGL1BPUEYgdG8gcHJlc2VydmUgdGhlCj4gPiBFRkxB
R1MsIHNpbmNlIHdlIG1hcmsgdGhvc2UgZXhwbGljaXRseSBjbG9iYmVyZWQuCj4gPiAKPiAKPiBO
b3QgcXVpdGUuICBBIGZsYWdzIGNsb2JiZXIgZG9lc27igJl0IHNhdmUgdGhlIGNvbnRyb2wgYml0
cyBsaWtlIEFDCj4gZXhjZXB0IG9uIGNlcnRhaW4gcmF0aGVyIGJ1Z2d5IGxsdm0gY29tcGlsZXJz
LiBUaGUgY2hhbmdlIHlvdeKAmXJlCj4gbG9va2luZyBmb3IgaXM6Cj4gCj4gaHR0cDovL2dpdC5r
ZXJuZWwub3JnL3RpcC8yYzc1NzdhNzU4Mzc0N2M5YjcxZjI2ZGNlZDdmNjk2YjczOWRhNzQ1CgpJ
bmRlZWQsIGZhaWxlZCB0byBmaW5kIHRoYXQuCgo+ID4gRm9yIGEgbGl0dGxlIGJpdCBvZiBjb250
ZXh0OyBpdCB0dXJucyBvdXQgdGhhdCB1c2VyX2FjY2Vzc19iZWdpbigpIC8KPiA+IHVzZXJfYWNj
ZXNzX2VuZCgpIHNldHMgRUZMQUdTLkFDIGFuZCBzY2hlZHVsaW5nIGluIGJldHdlZW4gdGhlcmUg
d3JlY2tzCj4gPiB0aGF0IGJlY2F1c2Ugd2UncmUgYXBwYXJlbnRseSBub3Qgc2F2aW5nIHRoYXQg
YW55bW9yZS4KPiAKPiBCdXQgb25seSBleHBsaWNpdCBzY2hlZHVsaW5nIOKAlCBwcmVlbXB0aW9u
IGFuZCBzbGVlcHkgcGFnZSBmYXVsdHMgYXJlCj4gZmluZSBiZWNhdXNlIHRoZSBpbnRlcnJ1cHQg
ZnJhbWUgc2F2ZXMgZmxhZ3MuCgpObywgbGlrZSBwb2ludGVkIG91dCBlbHNld2hlcmUgaW4gdGhp
cyB0aHJlYWQsIGFueXRoaW5nIHRoYXQgZG9lcwpwcmVlbXB0X2Rpc2FibGUoKSBpcyB1dHRlcmx5
IGJyb2tlbiB3aXRoIHRoaXMuCgpCZWNhdXNlIGF0IHRoYXQgcG9pbnQgdGhlIElSUSByZXR1cm4g
cGF0aCBkb2Vzbid0IHJlc2NoZWR1bGUgYnV0CnByZWVtcHRfZW5hYmxlKCkgd2lsbCwgYW5kIHRo
YXQgZG9lc24ndCBwcmVzZXJ2ZSBFRkxBR1MgYWdhaW4uCgo+ID4gTm93LCBJJ20gdGVtcHRlZCB0
byBhZGQgdGhlIFBVU0hGIC8gUE9QRiByaWdodCBiYWNrIGJlY2F1c2Ugb2YgdGhpcywgYnV0Cj4g
PiBmaXJzdCBJIHN1cHBvc2Ugd2UgbmVlZCB0byBmaWd1cmUgb3V0IGlmIHRoYXQgY2hhbmdlIHdh
cyBvbiBwdXJwb3NlIGFuZAo+ID4gd2h5IHRoYXQgd2VudCBtaXNzaW5nIGZyb20gdGhlIENoYW5n
ZWxvZy4KPiAKPiBUaGF04oCZcyBjZXJ0YWlubHkgdGhlIGVhc3kgc29sdXRpb24uIE9yIHdlIGNv
dWxkIHRlYWNoIHRoZSBtaWdodF9zbGVlcAo+IGNoZWNrcyBhYm91dCB0aGlzLCBidXQgdGhhdCBj
b3VsZCBiZSBhIG1lc3MuCgpUaGF0J3Mgbm90IGVub3VnaCwgd2UnZCBoYXZlIHRvIHRlYWNoIHBy
ZWVtcHRfZGlzYWJsZSgpLCBidXQgd29yc2UsCnByZWVtcHRfZGlzYWJsZV9ub3RyYWNlKCkuCgpB
bnl0aGluZyB0aGF0IGxhbmRzIGluIGZ0cmFjZSwgd2hpY2ggX3dpbGxfIHVzZQpwcmVlbXB0X2Rp
c2FibGVfbm90cmFjZSgpLCB3aWxsIHNjcmV3IHRoaXMgdGhpbmcgdXAuCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxp
bmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
