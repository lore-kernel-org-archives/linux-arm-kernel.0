Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D0EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:07:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C27A21904
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AerzhH7r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C27A21904
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=w0uBntwPyatBLvZoXiqLlT32TqH0qZdOisd3Luadna8=; b=AerzhH7r92bCqu
	jwyEwmGVcu80wVhYCw/EObCLNUiUnQtIuBLREVfGa8Cn3pQw9JuW9Oe+3h8dlmgYdTiWlotImZtht
	VJ3o3WhIrmDf5wYJAcc+fxdtAyh6w06A5z7UFVznaN/ApkhagNIwXVQ6E5ls2ufZUCPey8JH8eHun
	hSenWPqDspSo72Qn0SVJdQ8azZ/3MEAzgc/YaeBaq2OzO22HE63osuhLNkFgDXmYTDFjSTc5H/ufu
	Ffk7tm4SJneW8y9YWU92Y85lGWr9TQlFZ3zmwwMM0N4loj2LcyjiksYYv8FxWW8fmLcxJR4oP/OVY
	DkRyt5XPPAzZdsxluX3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw1N9-00030P-0o; Tue, 19 Feb 2019 09:07:27 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw1N5-0002zA-CU
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 09:07:25 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30CEE1596;
 Tue, 19 Feb 2019 01:07:18 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 258213F675;
 Tue, 19 Feb 2019 01:07:02 -0800 (PST)
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
To: "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@amacapital.net>,
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
 <3b98220d-5c2e-b769-1f55-ceb9565379a2@zytor.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <a318033d-cf7a-8506-8ed3-3446d7c9e27d@arm.com>
Date: Tue, 19 Feb 2019 09:07:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <3b98220d-5c2e-b769-1f55-ceb9565379a2@zytor.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_010723_556601_23B7D39A 
X-CRM114-Status: GOOD (  18.02  )
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
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
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

CgpPbiAxOS8wMi8yMDE5IDAyOjQ2LCBILiBQZXRlciBBbnZpbiB3cm90ZToKPiBPbiAyLzE4LzE5
IDY6MjAgUE0sIEFuZHkgTHV0b21pcnNraSB3cm90ZToKPj4KPj4KPj4+IE9uIEZlYiAxOCwgMjAx
OSwgYXQgNDoyNCBQTSwgTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24u
b3JnPiB3cm90ZToKPj4+Cj4+Pj4gT24gTW9uLCBGZWIgMTgsIDIwMTkgYXQgMjozMSBQTSBILiBQ
ZXRlciBBbnZpbiA8aHBhQHp5dG9yLmNvbT4gd3JvdGU6Cj4+Pj4KPj4+PiBUaGUgcXVlc3Rpb24g
aXMgd2hhdCAiZml4IGl0IiBtZWFucy4gSSdtIHJlYWxseSBjb25jZXJuZWQgYWJvdXQgQUMgZXNj
YXBlcywKPj4+PiBhbmQgZXZlcnlvbmUgZWxzZSBzaG91bGQgYmUsIHRvby4KPj4+Cj4+PiBJIGRv
IHRoaW5rIHRoYXQgaXQgbWlnaHQgYmUgdGhlIHJpZ2h0IHRoaW5nIHRvIGRvIHRvIGFkZCBzb21l
IGtpbmQgb2YKPj4+IFdBUk5fT05fT05DRSgpIGZvciBBQyBiZWluZyBzZXQgaW4gdmFyaW91cyBj
YW4tcmVzY2hlZHVsZSBzaXR1YXRpb25zLgo+Pj4KPj4+IFdlJ2QganVzdCBoYXZlIHRvIGFic3Ry
YWN0IGl0IHNhbmVseS4gSSdtIHN1cmUgYXJtNjQgaGFzIHRoZSBleGFjdAo+Pj4gc2FtZSBpc3N1
ZSB3aXRoIFBBTiAtIG1heWJlIGl0IHNhdmVzIHByb3Blcmx5LCBidXQgdGhlIHNhbWUgIndlCj4+
PiB3b3VsZG4ndCB3YW50IHRvIGdvIHRocm91Z2ggdGhlIHNjaGVkdWxlciB3aXRoIFBBTiBjbGVh
ciIuCj4+Pgo+Pj4gT24geDg2LCB3ZSBtaWdodCBhcyB3ZWxsIGNoZWNrIERGIGF0IHRoZSBzYW1l
IHRpbWUgYXMgQUMuCj4+Pgo+Pgo+PiBocGEgaXMgcmlnaHQsIHRob3VnaCDigJQgY2FsbGluZyBp
bnRvIHRyYWNpbmcgY29kZSB3aXRoIEFDIHNldCBpcyBub3QgcmVhbGx5IHNvIGdvb2QuICBBbmQg
Y2FsbGluZyBzY2hlZHVsZSgpICh2aWEgcHJlZW1wdF9lbmFibGUoKSBvciB3aGF0ZXZlcikgaXMg
YWxzbyBiYWQgYmVjYXVzZSBpdCBydW5zIGFsbCB0aGUgc2NoZWR1bGVyIGNvZGUgd2l0aCBBQyBv
bi4gIEFkbWl0dGVkbHksIHRoZSBzY2hlZHVsZXIgaXMgbm90ICp0aGF0KiBpbnRlcmVzdGluZyBv
ZiBhbiBhdHRhY2sgc3VyZmFjZS4KPj4KPiAKPiBOb3QganVzdCB0aGF0LCBidXQgdGhlIG90aGVy
IHF1ZXN0aW9uIGlzIGp1c3QgaG93IG11Y2ggY29kZSB3ZSBhcmUgcnVubmluZwo+IHdpdGggQUMg
b3Blbi4gSXQgcmVhbGx5IHNob3VsZCBvbmx5IGJlIGRvbmUgaW4gc29tZSB2ZXJ5IHNtYWxsIHJl
Z2lvbnMuCgpZZXMsIGJ1dCB3ZSBkb24ndCByZWFsbHkgaGF2ZSBhIHdheSB0byBlbmZvcmNlIHRo
YXQsIGFzIGZhciBhcyBJJ20gYXdhcmUuCgpUaGUgdXNlcl9hY2Nlc3NfYmVnaW4vZW5kKCkgaXMg
Z2VuZXJpYyBBUEksIG1lYW5pbmcgYW55IGFyY2ggaXMgZnJlZSB0bwppbXBsZW1lbnQgaXQuIElm
IHRoZXkgZG9uJ3QgaGF2ZSB0aGUgc2FtZSBoYXJkd2FyZSBiZWhhdmlvdXIgYXMKeDg2L2FybTY0
LCBpdCBtaWdodCBiZSB0aGF0IHRoZWlyIGludGVycnVwdC9leGNlcHRpb24gZW50cnkgY29kZSB3
aWxsCnJ1biB3aXRoIHVzZXJfYWNjZXNzIG9wZW4gdW50aWwgdGhleSByZWFjaCB0aGUgZW50cnkg
Y29kZSB0aGF0IGNsb3NlcyBpdAooYW5kIGVudHJ5IGNvZGUgY291bGQgcG90ZW50aWFsbHkgYmUg
YSBtb3JlIGludGVyZXN0aW5nIGF0dGFjayBzdXJmYWNlCnRoYW4gdGhlIHNjaGVkdWxlcikuIFRo
aXMgY291bGQgYmUgdGhlIGNhc2Ugb2Ygc29mdHdhcmUgZW11bGF0ZWQgUEFOIG9uCmFybS9hcm02
NCAoYWx0aG91Z2ggY3VycmVudGx5IGFybSwgbm9uLTY0Yml0LCBkb2Vzbid0IGhhdmUKdXNlcl9h
Y2Nlc3NfYmVnaW4vZW5kKCkgYXQgdGhlIHRpbWUpLgoKU28gdGhlIHdob2xlICJ2ZXJ5IHNtYWxs
IHJlZ2lvbiIgcmVzdHJpY3Rpb24gc291bmRzIGEgYml0Cmxvb3NlL2FyYml0cmFyeSB0byBtZS4u
LgoKVGhhbmtzLAoKLS0gCkp1bGllbiBUaGllcnJ5CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
