Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FA5C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:42:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 505A7222C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W9OERAAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 505A7222C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FB18TcYgjKXJe34QFeh2TiqMl9mac2cIE/xMGC7XluM=; b=W9OERAAcLnea1Y
	MrgTOigxzpAbaoV+kR4hwKINcFGpBnzc1790z2ts4cUNI85OLDznpupTULzHh6vMPu/hhMHVE+FT5
	w65hVBnC5EVwbaO3nMqSYj+Yq4/dEDfQwo0P0m5ywl7Z2oHPjFc46WpePsYYWatfUMTjVgBCyjzre
	8cvEV7OSpb+kEg+QuKbMJIi6uEEy7LNDEqmgeN+/MxUItitNtZAgm+WrFqChdeQFYk5+yYpTkESsn
	GB475v+NHF5xeH6oH6gaPBBkPDrhexitAno294TE9V893GSFydQuFrD6CeKOYq2bw3iArt8KylYs9
	gHjVZQE/Co/9VrQgAHIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtq7R-0006XB-3S; Wed, 13 Feb 2019 08:42:13 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtq7N-0006U5-Ar
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 08:42:11 +0000
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id CFAB6A304565D0E3E695;
 Wed, 13 Feb 2019 16:41:59 +0800 (CST)
Received: from [127.0.0.1] (10.40.74.132) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Wed, 13 Feb 2019
 16:41:49 +0800
Subject: Re: [PATCH v3] arm64: lib: accelerate do_csum with NEON instruction
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <1546739729-17234-1-git-send-email-huanglingyan2@huawei.com>
 <CAKv+Gu_wsK1UNXSp=5Hvd7XCHKC3cVkYjTYHhvqM4Xt09A9iKg@mail.gmail.com>
 <9129b882-60f3-8046-0cb9-e0b2452a118d@huawei.com>
 <20190108135444.GB14476@fuggles.cambridge.arm.com>
 <cd5bb83e-bb0e-b348-5365-095c5fcd9648@huawei.com>
 <20190116164657.GA1910@brain-police>
 <58c28adf-a01a-bb36-4def-866375e93aac@huawei.com>
 <CAKv+Gu-MUDT-pAE4kwHbCsW2MSYBCDB3N1reRgeFL1EwiNQvxQ@mail.gmail.com>
 <d97f1ba1-1b73-1bde-cd8f-de55115acd9e@huawei.com>
 <CAKv+Gu_jzU934k=SU-0bpF7NrqZ-KW2u_G3a+WDkxs+O6bzQow@mail.gmail.com>
From: "huanglingyan (A)" <huanglingyan2@huawei.com>
Message-ID: <f42aa98b-3d43-8f63-7636-9fa630a060e4@huawei.com>
Date: Wed, 13 Feb 2019 16:42:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu_jzU934k=SU-0bpF7NrqZ-KW2u_G3a+WDkxs+O6bzQow@mail.gmail.com>
X-Originating-IP: [10.40.74.132]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_004209_542122_C9AADC07 
X-CRM114-Status: GOOD (  16.96  )
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
Cc: Zhangshaokun <zhangshaokun@hisilicon.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Ck9uIDIwMTkvMi8xMiAxNTowNywgQXJkIEJpZXNoZXV2ZWwgd3JvdGU6Cj4gT24gVHVlLCAxMiBG
ZWIgMjAxOSBhdCAwMzoyNSwgaHVhbmdsaW5neWFuIChBKSA8aHVhbmdsaW5neWFuMkBodWF3ZWku
Y29tPiB3cm90ZToKPj4KPj4gT24gMjAxOS8xLzE4IDE5OjE0LCBBcmQgQmllc2hldXZlbCB3cm90
ZToKPj4+IE9uIEZyaSwgMTggSmFuIDIwMTkgYXQgMDI6MDcsIGh1YW5nbGluZ3lhbiAoQSkgPGh1
YW5nbGluZ3lhbjJAaHVhd2VpLmNvbT4gd3JvdGU6Cj4+Pj4gT24gMjAxOS8xLzE3IDA6NDYsIFdp
bGwgRGVhY29uIHdyb3RlOgo+Pj4+PiBPbiBXZWQsIEphbiAwOSwgMjAxOSBhdCAxMDowMzowNUFN
ICswODAwLCBodWFuZ2xpbmd5YW4gKEEpIHdyb3RlOgo+Pj4+Pj4gT24gMjAxOS8xLzggMjE6NTQs
IFdpbGwgRGVhY29uIHdyb3RlOgo+Pj4+Pj4+IFtyZS1hZGRpbmcgQXJkIGFuZCBMQUtNTCAtLSBu
b3Qgc3VyZSB3aHkgdGhlIGhlYWRlcnMgYXJlIHNvIG11bmdlZF0KPj4+Pj4+Pgo+Pj4+Pj4+IE9u
IE1vbiwgSmFuIDA3LCAyMDE5IGF0IDEwOjM4OjU1QU0gKzA4MDAsIGh1YW5nbGluZ3lhbiAoQSkg
d3JvdGU6Cj4+Pj4+Pj4+IE9uIDIwMTkvMS82IDE2OjI2LCBBcmQgQmllc2hldXZlbCB3cm90ZToK
Pj4+Pj4+Pj4gICAgIFBsZWFzZSBjaGFuZ2UgdGhpcyBpbnRvCj4+Pj4+Pj4+Cj4+Pj4+Pj4+ICAg
ICBpZiAoSVNfRU5BQkxFRChDT05GSUdfS0VSTkVMX01PREVfTkVPTikgJiYKPj4+Pj4+Pj4gICAg
ICAgICBsZW4gPj0gQ1NVTV9ORU9OX1RIUkVTSE9MRCAmJgo+Pj4+Pj4+PiAgICAgICAgIG1heV91
c2Vfc2ltZCgpKSB7Cj4+Pj4+Pj4+ICAgICAgICAgICAgIGtlcm5lbF9uZW9uX2JlZ2luKCk7Cj4+
Pj4+Pj4+ICAgICAgICAgICAgIHJlcyA9IGRvX2NzdW1fbmVvbihidWZmLCBsZW4pOwo+Pj4+Pj4+
PiAgICAgICAgICAgICBrZXJuZWxfbmVvbl9lbmQoKTsKPj4+Pj4+Pj4gICAgICAgICB9Cj4+Pj4+
Pj4+Cj4+Pj4+Pj4+ICAgICBhbmQgZHJvcCB0aGUgaW50ZXJtZWRpYXRlIGRvX2NzdW1fYXJtKCkK
Pj4+Pj4+Pj4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gICAgICAgICArICAgICAgICAgICAgICAgcmV0dXJu
IGRvX2NzdW1fYXJtKGJ1ZmYsIGxlbik7Cj4+Pj4+Pj4+ICAgICAgICAgKyNlbmRpZiAgLyogQ09O
RklHX0tFUk5FTF9NT0RFX05FT04gKi8KPj4+Pj4+Pj4KPj4+Pj4+Pj4gICAgIE5vIGVsc2U/IFdo
YXQgaGFwcGVucyBpZiBsZW4gPCBDU1VNX05FT05fVEhSRVNIT0xEID8KPj4+Pj4+Pj4KPj4+Pj4+
Pj4KPj4+Pj4+Pj4gICAgICAgICArI3VuZGVmIGRvX2NzdW0KPj4+Pj4+Pj4KPj4+Pj4+Pj4gICAg
IENhbiB3ZSBkcm9wIHRoaXM/Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+IFVzaW5nIE5FT04gaW5zdHJ1Y3Rp
b25zIHdpbGwgYnJpbmcgc29tZSBjb3N0cy4gVGhlIHNwZW5kaW5nIG1heWJlIGludHJvZHVjZWQK
Pj4+Pj4+Pj4gd2hlbiByZXNlcnZlcmluZy9yZXN0b3JpbmcKPj4+Pj4+Pj4gbmVvbiByZWdpc3Rl
cnMgd2l0aCBrZXJuZWxfbmVvbl9iZWdpbigpL2tlcm5lbF9uZW9uX2VuZCgpLiBUaGVyZWZvcmUg
TkVPTiBjb2RlCj4+Pj4+Pj4+IGlzIE9ubHkgdXNlZCB3aGVuCj4+Pj4+Pj4+IHRoZSBsZW5ndGgg
ZXhjZWVkcyBDU1VNX05FT05fVEhSRVNIT0xELiBHZW5lcmFsIGRvIGNzdW0oKSBjb2RlcyBpbiBs
aWIvCj4+Pj4+Pj4+IGNoZWNrc3VtLmMgd2lsbCBiZSB1c2VkIGluCj4+Pj4+Pj4+IHNob3J0ZXIg
bGVuZ3RoLiBUbyBhY2hpZXZlIHRoaXMgZ29hbCwgSSB1c2UgdGhlICIjdW5kZWYgZG9fY3N1bSIg
aW4gZWxzZSBjbGF1c2UKPj4+Pj4+Pj4gdG8gaGF2ZSB0aGUgb3Bwb3R1bml0eSB0bwo+Pj4+Pj4+
PiB1dGlsaXplIHRoZSBnZW5lcmFsIGNvZGVzLgo+Pj4+Pj4+IEkgZG9uJ3QgdGhpbmsgdGhhdCdz
IGhvdyBpdCB3b3JrcyA6Lwo+Pj4+Pj4+Cj4+Pj4+Pj4gQmVmb3JlIHdlIGdldCBkZWVwZXIgaW50
byB0aGUgaW1wbGVtZW50YXRpb24sIHBsZWFzZSBjb3VsZCB5b3UganVzdGlmeSB0aGUKPj4+Pj4+
PiBuZWVkIGZvciBhIENQVS1vcHRpbWlzZWQgY2hlY2tzdW0gaW1wbGVtZW50YXRpb24gYXQgYWxs
PyBJIHRob3VnaHQgdGhpcyB3YXMKPj4+Pj4+PiB1c3VhbGx5IG9mZmxvYWRlZCB0byB0aGUgTklD
Pwo+Pj4+Pj4+Cj4+Pj4+Pj4gV2lsbAo+Pj4+Pj4+Cj4+Pj4+Pj4gLgo+Pj4+Pj4gVGhpcyBwcm9i
bGVtIGlzIGludHJvZHVjZWQgd2hlbiB0ZXN0aW5nIEludGVsIHg3MTAgbmV0d29yayBjYXJkIG9u
IG15IEFSTSBzZXJ2ZXIuCj4+Pj4+PiBJcCBmb3J3YXJkIGlzIHNldCBmb3IgZWFzZSBvZiB0ZXN0
aW5nLiBUaGVuIHNlbmQgbG90cyBvZiBwYWNrYWdlcyB0byBzZXJ2ZXIgYnkgVGVzZ2luZQo+Pj4+
Pj4gbWFjaGluZSBhbmQgdGhlbiByZWNlaXZlLgo+Pj4+PiBJbiB0aGUgbWFya2V0aW5nIGJsdXJi
LCB0aGF0IGNhcmQgYm9hc3RzOgo+Pj4+Pgo+Pj4+PiAgIGBUeC9SeCBJUCwgU0NUUCwgVENQLCBh
bmQgVURQIGNoZWNrc3VtIG9mZmxvYWRpbmcgKElQdjQsIElQdjYpIGNhcGFiaWxpdGllcycKPj4+
Pj4KPj4+Pj4gc28gd2Ugc2hvdWxkbid0IG5lZWQgdG8gcnVuIHRoaXMgb24gdGhlIENQVS4gQWdh
aW4sIEknbSBub3Qga2VlbiB0byBvcHRpbWlzZQo+Pj4+PiB0aGlzIGdpdmVuIHRoYXQgaXQgL3Jl
YWxseS8gc2hvdWxkbid0IGJlIHVzZWQgb24gYXJtNjQgbWFjaGluZXMgdGhhdCBjYXJlCj4+Pj4+
IGFib3V0IG5ldHdvcmsgcGVyZm9ybWFuY2UuCj4+Pj4+Cj4+Pj4+IFdpbGwKPj4+Pj4KPj4+Pj4g
Lgo+Pj4+IFllYWgsIHlvdSBhcmUgcmlnaHQuIENoZWNrc3VtIGlzIHVzdWFsbHkgZG9uZSBpbiBu
ZXR3b3JrIGNhcmQgd2hpY2ggaXMgdG9sZCBieQo+Pj4+IHNvbWVvbmUgZmFtaWxpYXIgd2l0aCBO
SUMuIEhvd2V2ZXIsIGl0IG1heSBiZSB1c2VkIGluIHRlc3Rpbmcgc2NlbmFyaWVzIGFuZAo+Pj4+
IHNvbWUgcHJpbWFyeSBuZXR3b3JrIGNhcmRzLiBJIHRoaW5rIGl0J3Mgbm8gaGFybSB0byBvcHRp
bWl6ZSB0aGlzIGNvZGUgd2hpbGUKPj4+PiBvdGhlciBBUkNIcyBoYXZlIHRoZWlyIG93biBvcHRp
bWl6ZWQgdmVyc2lvbnMuCj4+PiBJIGRpc2FncmVlLiBJZiB0aGlzIGNvZGUgcGF0aCBpcyBuZXZl
ciBleGVyY2lzZWQsIHdlIHNob3VsZCBub3QKPj4+IGluY2x1ZGUgaXQuIFdlIGNhbiByZXZpc2l0
IHRoaXMgZGVjaXNpb24gd2hlbiB0aGVyZSBpcyBhIHVzZSBjYXNlCj4+PiB3aGVyZSB0aGUgY2hl
Y2tzdW1taW5nIHBlcmZvcm1hbmNlIGlzIGFuIGFjdHVhbCBib3R0bGVuZWNrLgo+Pj4KPj4+IC4K
Pj4gVGhlIG1haW5zdHJlYW0gbmV0d29yayBjYXJkcyBoYXMgYW4gb3B0aW9uIHRvIHN3aXRjaCB0
aGUgY3N1bSBwYXR0ZXJuLgo+PiBVc2VycyBjYW4gZGV0ZXJtaW5lIHRoZSBvbmUgd2hvIGNhbGN1
bGF0ZSBjc3VtLCBoYXJkd2FyZSBvciBzb2Z0d2FyZS4KPj4KPj4gICAgICAgICBldGh0b29sIC1L
IGV0aDAgcngtY2hlY2tzdW0gb2ZmCj4+ICAgICAgICAgZXRodG9vbCAtSyBldGgwIHR4LWNoZWNr
c3VtLWlwLWdlbmVyaWMgb2ZmCj4+Cj4+IFdoYXQncyBtb3JlLCB0aGVyZSdzIHNvbWUgbmV0d29y
ayBmZWF0dXJlcyB0aGF0IG1heSBjYXVzZSBoYXJkd2FyZQo+PiBjaGVja3N1bSBub3Qgd29yaywg
bGlrZSBnc28gKCBub3Qgc28gc3VyZSkuIFdoaWNoIG1lYW5zLCB0aGUgc29mdHdhcmUKPj4gY2hl
Y2tzdW0gaGFzIGl0cyBleGlzdGluZyBtZWFuaW5nLgo+Pgo+IFRoaXMgZG9lcyBub3QgbWFrZSBh
bnkgc2Vuc2UgdG8gbWUuIFNlZ21lbnRhdGlvbiBvZmZsb2FkIHJlbGllcyBvbiB0aGUKPiBoYXJk
d2FyZSBnZW5lcmF0aW5nIHRoZSBhY3R1YWwgcGFja2V0cywgYW5kIEkgZG9uJ3Qgc2VlIGhvdyBp
dCB3b3VsZAo+IGJlIGFibGUgdG8gZG8gdGhhdCBpZiBpdCBjYW5ub3QgZ2VuZXJhdGUgdGhlIGNo
ZWNrc3VtIGFzIHdlbGwuCkkgdGVzdCBvbiBteSBwbGF0Zm9ybSBvZsKgIElQLWZvcndhcmQgc2Nl
bmVyeS7CoCBUaGUgbmV0d29yayBjYXJkIGhhcyBjaGVja3N1bSBjYXBhYmlsaXR5LgpUaGUgaGFy
ZHdhcmUgZG8gY2hlY2tzdW0gd2hlbiBncm8gZmVhdHVyZSBpcyBvZmYuIEhvd2V2ZXIsIGNoZWNr
c3VtIGlzIGRvbmUgYnkKc29mdHdhcmUgd2hlbiBncm8gaXMgb24uIEluIHRoaXMgc2NlbmV5LCBk
b19jc3VtIGZ1bmN0aW9uIGhhcyA2MCUgcGVyY2VudGFnZSBvZiBDUFUgbG9hZAphbmQgdGhlIHBl
cmZvcm1hbmNlIGRlY3JlYXNlcyAyMCUgZHVlIHRvIHNvZnR3YXJlIGNoZWNrc3VtLgoKVGhlIGNv
bW1hbmQgSSB1c2UgaXMKwqDCoMKgIMKgwqDCoCBldGh0b29sIC1LIGV0aDAgZ3JvIG9mZgoKPiAu
Cj4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1h
cm0ta2VybmVsCg==
