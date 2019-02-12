Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CEEC282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 02:25:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8754621B18
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 02:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nVqH9xtX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8754621B18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P+7breVzYyrDmQgsiAXYUgTcH73Mo/6Uy0hLJ8Q6Ev4=; b=nVqH9xtX5bfw55
	kYWgvHrHXrJ9/sOfhTjeT6h4l0bQnhi5/44hz1tIKYHPLXPMvU8QeFmsVqNXjtrWKY0wivbqjwEpj
	gcqgmk0ldepLmtY3Wai4Zm6a/fGvoJ2ch+yQ5Xjj3hSL3New3MdoAko2dmK6iU8jE6yEaT9kB5sGp
	bcAqjdB22OqJ3GK7nS7TapBTgHJKlLs0rTgCaRNJBiZ/NX7dhE0j4wqe2bZ4rgoUfKr/nnlfcReQW
	5+TQgz6Qk3v2T9KEKLiy0+9UZNwyNvYt3ZRLxSeIjOgKISryaWwro03anDhV84STxdoFFlsSmReDm
	c2TVykTSBSssHKIV+2BA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtNlT-0004t5-0d; Tue, 12 Feb 2019 02:25:39 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtNlQ-0004sE-BT
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 02:25:38 +0000
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 0BFAA2D61AE7173FF9F9;
 Tue, 12 Feb 2019 10:25:28 +0800 (CST)
Received: from [127.0.0.1] (10.40.74.132) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Tue, 12 Feb 2019
 10:25:20 +0800
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
From: "huanglingyan (A)" <huanglingyan2@huawei.com>
Message-ID: <d97f1ba1-1b73-1bde-cd8f-de55115acd9e@huawei.com>
Date: Tue, 12 Feb 2019 10:26:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-MUDT-pAE4kwHbCsW2MSYBCDB3N1reRgeFL1EwiNQvxQ@mail.gmail.com>
X-Originating-IP: [10.40.74.132]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_182536_564087_564475CC 
X-CRM114-Status: GOOD (  14.30  )
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

Ck9uIDIwMTkvMS8xOCAxOToxNCwgQXJkIEJpZXNoZXV2ZWwgd3JvdGU6Cj4gT24gRnJpLCAxOCBK
YW4gMjAxOSBhdCAwMjowNywgaHVhbmdsaW5neWFuIChBKSA8aHVhbmdsaW5neWFuMkBodWF3ZWku
Y29tPiB3cm90ZToKPj4KPj4gT24gMjAxOS8xLzE3IDA6NDYsIFdpbGwgRGVhY29uIHdyb3RlOgo+
Pj4gT24gV2VkLCBKYW4gMDksIDIwMTkgYXQgMTA6MDM6MDVBTSArMDgwMCwgaHVhbmdsaW5neWFu
IChBKSB3cm90ZToKPj4+PiBPbiAyMDE5LzEvOCAyMTo1NCwgV2lsbCBEZWFjb24gd3JvdGU6Cj4+
Pj4+IFtyZS1hZGRpbmcgQXJkIGFuZCBMQUtNTCAtLSBub3Qgc3VyZSB3aHkgdGhlIGhlYWRlcnMg
YXJlIHNvIG11bmdlZF0KPj4+Pj4KPj4+Pj4gT24gTW9uLCBKYW4gMDcsIDIwMTkgYXQgMTA6Mzg6
NTVBTSArMDgwMCwgaHVhbmdsaW5neWFuIChBKSB3cm90ZToKPj4+Pj4+IE9uIDIwMTkvMS82IDE2
OjI2LCBBcmQgQmllc2hldXZlbCB3cm90ZToKPj4+Pj4+ICAgICBQbGVhc2UgY2hhbmdlIHRoaXMg
aW50bwo+Pj4+Pj4KPj4+Pj4+ICAgICBpZiAoSVNfRU5BQkxFRChDT05GSUdfS0VSTkVMX01PREVf
TkVPTikgJiYKPj4+Pj4+ICAgICAgICAgbGVuID49IENTVU1fTkVPTl9USFJFU0hPTEQgJiYKPj4+
Pj4+ICAgICAgICAgbWF5X3VzZV9zaW1kKCkpIHsKPj4+Pj4+ICAgICAgICAgICAgIGtlcm5lbF9u
ZW9uX2JlZ2luKCk7Cj4+Pj4+PiAgICAgICAgICAgICByZXMgPSBkb19jc3VtX25lb24oYnVmZiwg
bGVuKTsKPj4+Pj4+ICAgICAgICAgICAgIGtlcm5lbF9uZW9uX2VuZCgpOwo+Pj4+Pj4gICAgICAg
ICB9Cj4+Pj4+Pgo+Pj4+Pj4gICAgIGFuZCBkcm9wIHRoZSBpbnRlcm1lZGlhdGUgZG9fY3N1bV9h
cm0oKQo+Pj4+Pj4KPj4+Pj4+Cj4+Pj4+PiAgICAgICAgICsgICAgICAgICAgICAgICByZXR1cm4g
ZG9fY3N1bV9hcm0oYnVmZiwgbGVuKTsKPj4+Pj4+ICAgICAgICAgKyNlbmRpZiAgLyogQ09ORklH
X0tFUk5FTF9NT0RFX05FT04gKi8KPj4+Pj4+Cj4+Pj4+PiAgICAgTm8gZWxzZT8gV2hhdCBoYXBw
ZW5zIGlmIGxlbiA8IENTVU1fTkVPTl9USFJFU0hPTEQgPwo+Pj4+Pj4KPj4+Pj4+Cj4+Pj4+PiAg
ICAgICAgICsjdW5kZWYgZG9fY3N1bQo+Pj4+Pj4KPj4+Pj4+ICAgICBDYW4gd2UgZHJvcCB0aGlz
Pwo+Pj4+Pj4KPj4+Pj4+IFVzaW5nIE5FT04gaW5zdHJ1Y3Rpb25zIHdpbGwgYnJpbmcgc29tZSBj
b3N0cy4gVGhlIHNwZW5kaW5nIG1heWJlIGludHJvZHVjZWQKPj4+Pj4+IHdoZW4gcmVzZXJ2ZXJp
bmcvcmVzdG9yaW5nCj4+Pj4+PiBuZW9uIHJlZ2lzdGVycyB3aXRoIGtlcm5lbF9uZW9uX2JlZ2lu
KCkva2VybmVsX25lb25fZW5kKCkuIFRoZXJlZm9yZSBORU9OIGNvZGUKPj4+Pj4+IGlzIE9ubHkg
dXNlZCB3aGVuCj4+Pj4+PiB0aGUgbGVuZ3RoIGV4Y2VlZHMgQ1NVTV9ORU9OX1RIUkVTSE9MRC4g
R2VuZXJhbCBkbyBjc3VtKCkgY29kZXMgaW4gbGliLwo+Pj4+Pj4gY2hlY2tzdW0uYyB3aWxsIGJl
IHVzZWQgaW4KPj4+Pj4+IHNob3J0ZXIgbGVuZ3RoLiBUbyBhY2hpZXZlIHRoaXMgZ29hbCwgSSB1
c2UgdGhlICIjdW5kZWYgZG9fY3N1bSIgaW4gZWxzZSBjbGF1c2UKPj4+Pj4+IHRvIGhhdmUgdGhl
IG9wcG90dW5pdHkgdG8KPj4+Pj4+IHV0aWxpemUgdGhlIGdlbmVyYWwgY29kZXMuCj4+Pj4+IEkg
ZG9uJ3QgdGhpbmsgdGhhdCdzIGhvdyBpdCB3b3JrcyA6Lwo+Pj4+Pgo+Pj4+PiBCZWZvcmUgd2Ug
Z2V0IGRlZXBlciBpbnRvIHRoZSBpbXBsZW1lbnRhdGlvbiwgcGxlYXNlIGNvdWxkIHlvdSBqdXN0
aWZ5IHRoZQo+Pj4+PiBuZWVkIGZvciBhIENQVS1vcHRpbWlzZWQgY2hlY2tzdW0gaW1wbGVtZW50
YXRpb24gYXQgYWxsPyBJIHRob3VnaHQgdGhpcyB3YXMKPj4+Pj4gdXN1YWxseSBvZmZsb2FkZWQg
dG8gdGhlIE5JQz8KPj4+Pj4KPj4+Pj4gV2lsbAo+Pj4+Pgo+Pj4+PiAuCj4+Pj4gVGhpcyBwcm9i
bGVtIGlzIGludHJvZHVjZWQgd2hlbiB0ZXN0aW5nIEludGVsIHg3MTAgbmV0d29yayBjYXJkIG9u
IG15IEFSTSBzZXJ2ZXIuCj4+Pj4gSXAgZm9yd2FyZCBpcyBzZXQgZm9yIGVhc2Ugb2YgdGVzdGlu
Zy4gVGhlbiBzZW5kIGxvdHMgb2YgcGFja2FnZXMgdG8gc2VydmVyIGJ5IFRlc2dpbmUKPj4+PiBt
YWNoaW5lIGFuZCB0aGVuIHJlY2VpdmUuCj4+PiBJbiB0aGUgbWFya2V0aW5nIGJsdXJiLCB0aGF0
IGNhcmQgYm9hc3RzOgo+Pj4KPj4+ICAgYFR4L1J4IElQLCBTQ1RQLCBUQ1AsIGFuZCBVRFAgY2hl
Y2tzdW0gb2ZmbG9hZGluZyAoSVB2NCwgSVB2NikgY2FwYWJpbGl0aWVzJwo+Pj4KPj4+IHNvIHdl
IHNob3VsZG4ndCBuZWVkIHRvIHJ1biB0aGlzIG9uIHRoZSBDUFUuIEFnYWluLCBJJ20gbm90IGtl
ZW4gdG8gb3B0aW1pc2UKPj4+IHRoaXMgZ2l2ZW4gdGhhdCBpdCAvcmVhbGx5LyBzaG91bGRuJ3Qg
YmUgdXNlZCBvbiBhcm02NCBtYWNoaW5lcyB0aGF0IGNhcmUKPj4+IGFib3V0IG5ldHdvcmsgcGVy
Zm9ybWFuY2UuCj4+Pgo+Pj4gV2lsbAo+Pj4KPj4+IC4KPj4gWWVhaCwgeW91IGFyZSByaWdodC4g
Q2hlY2tzdW0gaXMgdXN1YWxseSBkb25lIGluIG5ldHdvcmsgY2FyZCB3aGljaCBpcyB0b2xkIGJ5
Cj4+IHNvbWVvbmUgZmFtaWxpYXIgd2l0aCBOSUMuIEhvd2V2ZXIsIGl0IG1heSBiZSB1c2VkIGlu
IHRlc3Rpbmcgc2NlbmFyaWVzIGFuZAo+PiBzb21lIHByaW1hcnkgbmV0d29yayBjYXJkcy4gSSB0
aGluayBpdCdzIG5vIGhhcm0gdG8gb3B0aW1pemUgdGhpcyBjb2RlIHdoaWxlCj4+IG90aGVyIEFS
Q0hzIGhhdmUgdGhlaXIgb3duIG9wdGltaXplZCB2ZXJzaW9ucy4KPiBJIGRpc2FncmVlLiBJZiB0
aGlzIGNvZGUgcGF0aCBpcyBuZXZlciBleGVyY2lzZWQsIHdlIHNob3VsZCBub3QKPiBpbmNsdWRl
IGl0LiBXZSBjYW4gcmV2aXNpdCB0aGlzIGRlY2lzaW9uIHdoZW4gdGhlcmUgaXMgYSB1c2UgY2Fz
ZQo+IHdoZXJlIHRoZSBjaGVja3N1bW1pbmcgcGVyZm9ybWFuY2UgaXMgYW4gYWN0dWFsIGJvdHRs
ZW5lY2suCj4KPiAuClRoZSBtYWluc3RyZWFtIG5ldHdvcmsgY2FyZHMgaGFzIGFuIG9wdGlvbiB0
byBzd2l0Y2ggdGhlIGNzdW0gcGF0dGVybi4KVXNlcnMgY2FuIGRldGVybWluZSB0aGUgb25lIHdo
byBjYWxjdWxhdGUgY3N1bSwgaGFyZHdhcmUgb3Igc29mdHdhcmUuCgrCoMKgwqAgwqDCoMKgIGV0
aHRvb2wgLUsgZXRoMCByeC1jaGVja3N1bSBvZmYKwqDCoMKgIMKgwqDCoCBldGh0b29sIC1LIGV0
aDAgdHgtY2hlY2tzdW0taXAtZ2VuZXJpYyBvZmYKCldoYXQncyBtb3JlLCB0aGVyZSdzIHNvbWUg
bmV0d29yayBmZWF0dXJlcyB0aGF0IG1heSBjYXVzZSBoYXJkd2FyZQpjaGVja3N1bSBub3Qgd29y
aywgbGlrZSBnc28gKCBub3Qgc28gc3VyZSkuIFdoaWNoIG1lYW5zLCB0aGUgc29mdHdhcmUKY2hl
Y2tzdW0gaGFzIGl0cyBleGlzdGluZyBtZWFuaW5nLgoKLgoKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
