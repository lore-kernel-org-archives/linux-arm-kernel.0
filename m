Return-Path: <SRS0=qjmB=PN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9839C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 02:26:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69CDB218DE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 02:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NFpAsGbK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69CDB218DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BTeaBSyKSzzjMtFwIPVnfo/Q0DXbZayR8zBNUyimIIs=; b=NFpAsGbKn0/hVq
	PANN7VsRYQucT1ItGvQWCTlYemUB11Kgs4MXcACCOF9hr4QvFiwSVLfqqX9Fnhk49Bhtw3mwU3tE+
	WrFzOQh5JzoEPohAEZaAaKAquE1JGv/YogHQEhB93WNXyERaPA0uYtN/cHJBwT6MfMr97iHk19Jbj
	dWebbfGd4seAJvKHjHPPQJrm2cHXHTizBfkFdUNc/v8bLBOlcRg9u3rrc5FOPRM4yb8qX8FVAhH+T
	lWMXXhNHLUb3uHr/XGfGku1O93PFpQWpyDb8aHmi46EhZgpWSDU1uBtRG8ZCgT+GvYLtnQW387VJE
	ZR50OyRMsl2sEXQjs8EQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfbfB-00080m-Fw; Sat, 05 Jan 2019 02:26:13 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfbf7-00080O-JK
 for linux-arm-kernel@lists.infradead.org; Sat, 05 Jan 2019 02:26:11 +0000
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id B389A178BDC2B;
 Sat,  5 Jan 2019 10:26:06 +0800 (CST)
Received: from [127.0.0.1] (10.40.74.132) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Sat, 5 Jan 2019
 10:26:03 +0800
Subject: Re: [PATCH v2] arm64: lib: accelerate do_csum with NEON instruction
To: Will Deacon <will.deacon@arm.com>
References: <1546417860-30214-1-git-send-email-huanglingyan2@huawei.com>
 <20190103154444.GD16311@edgewater-inn.cambridge.arm.com>
From: "huanglingyan (A)" <huanglingyan2@huawei.com>
Message-ID: <38c214ce-a030-b7c7-298f-b235277e5386@huawei.com>
Date: Sat, 5 Jan 2019 10:27:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20190103154444.GD16311@edgewater-inn.cambridge.arm.com>
X-Originating-IP: [10.40.74.132]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_182609_810214_B63DF612 
X-CRM114-Status: GOOD (  11.95  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CtTaIDIwMTkvMS8zIDIzOjQ0LCBXaWxsIERlYWNvbiDQtLXAOgo+IE9uIFdlZCwgSmFuIDAyLCAy
MDE5IGF0IDA0OjMxOjAwUE0gKzA4MDAsIExpbmd5YW4gSHVhbmcgd3JvdGU6Cj4+IEZ1bmN0aW9u
IGRvX2NzdW0oKSBpbiBsaWIvY2hlY2tzdW0uYyBpcyB1c2VkIHRvIGNvbXB1dGUgY2hlY2tzdW0s
Cj4+IHdoaWNoIGlzIHR1cm5lZCBvdXQgdG8gYmUgc2xvd2x5IGFuZCBjb3N0cyBhIGxvdCBvZiBy
ZXNvdXJjZXMuCj4+IExldCdzIHVzZSBuZW9uIGluc3RydWN0aW9ucyB0byBhY2NlbGVyYXRlIHRo
ZSBjaGVja3N1bSBjb21wdXRhdGlvbgo+PiBmb3IgYXJtNjQuCj4+Cj4+IC0tLS0tLQo+PiBWMSA9
PT4gVjI6Cj4+ICAgICBDaGFuZ2UgTkVPTiBhc3NlbWJseSBjb2RlIHRvIE5FT04gaW50cmluc2lj
IGNvZGUgd2hpY2ggaXMgYnVpbHQKPj4gICAgIG9uIHRvcCBvZiBhcm1fbmVvbi5oIHRvIGF2b2lk
IGRyb3BwaW5nIGludG8gYXNzZW1ibHkuCj4+IC0tLS0tLQo+Pgo+PiBIZXJlIGlzIHRoZSBjb21w
YXJpc29uIHJlc3VsdHMgb2YgZnVuY3Rpb24gaXBfY29tcHV0ZV9jc3VtKCkgYmV0d2Vlbgo+PiBn
ZW5lcmFsIGRvX2NzdW0oKSBhbmQgbmVvbiBpbnN0cnVjdGlvbiBkb19jc3VtKCkuCj4+Cj4+ICAg
ICAgICAgbGVuKDEwMDBjeWNsZSkgICAgICBnZW5lcmFsKG5zKSAgICAgICAgZG9fY3N1bV9uZW9u
KG5zKQo+PiAgICAgICAgICAgNjRCOiAgICAgICAgICAgICAgICA1ODA2MCAgICAgICAgICAgICAg
ICAgNTk0NjAKPj4gICAgICAgICAgMTI4QjogICAgICAgICAgICAgICAgODI5MzAgICAgICAgICAg
ICAgICAgIDgzOTMwCj4+ICAgICAgICAgIDI1NkI6ICAgICAgICAgICAgICAgMTMyNDgwICAgICAg
ICAgICAgICAgICA3MzU3MAo+PiAgICAgICAgICA1MTJCOiAgICAgICAgICAgICAgIDIzMDEwMCAg
ICAgICAgICAgICAgICAgODYyMzAKPj4gICAgICAgICAxMDI0QjogICAgICAgICAgICAgICA0MjY2
MDAgICAgICAgICAgICAgICAgIDk4MjAwCj4+Cj4+Cj4+IENjOiBDYXRhbGluIE1hcmluYXMgPGNh
dGFsaW4ubWFyaW5hc0Bhcm0uY29tPgo+PiBDYzogV2lsbCBEZWFjb24gPHdpbGwuZGVhY29uQGFy
bS5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6IExpbmd5YW4gSHVhbmcgPGh1YW5nbGluZ3lhbjJAaHVh
d2VpLmNvbT4KPj4gLS0tCj4+ICBhcmNoL2FybTY0L2xpYi9NYWtlZmlsZSAgICAgICAgfCAgIDQg
KysKPj4gIGFyY2gvYXJtNjQvbGliL2NoZWNrc3VtLmMgICAgICB8IDE0MCArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+PiAgaW5jbHVkZS9hc20tZ2VuZXJpYy9jaGVj
a3N1bS5oIHwgICAxICsKPj4gIGxpYi9jaGVja3N1bS5jICAgICAgICAgICAgICAgICB8ICAgOCAr
Ky0KPj4gIDQgZmlsZXMgY2hhbmdlZCwgMTUyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkK
Pj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybTY0L2xpYi9jaGVja3N1bS5jCj4gSSByZWNl
aXZlZCBmaXZlIGNvcGllcyBvZiB0aGlzIHBhdGNoIDovCj4KPiBDYW4geW91IHNlbmQgYSB2MyAo
anVzdCBvbmNlKSBzbyBpdCdzIGNsZWFyIHdoaWNoIGlzIHRoZSBsYXRlc3QgdmVyc2lvbiwKPiBw
bGVhc2U/Cj4KPiBXaWxsCj4KPiAuCgoKSSdtIHNvIHNvcnJ5IGZvciB0aGUgdHJvdWJsZSBJIGNh
dXNlZC4gSXQgc2VlbXMgbXkgbWFpbCBzZXJ2ZXIgaGFkIHNvbWUgcHJvYmxlbXMuIFRoZSB2MwoK
dmVyc2lvbiBpcyBvbiB0aGUgd2F5LiBMb29raW5nIGZvcndhcmQgdG8geW91ciBzdWdnZXN0aW9u
cy4KCkRlZXBseSBzb3JyeSBmb3IgdGhpcyBhY2NpZGVudC4KCi0gTGluZ3lhbiBIdWFuZwoKCgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJt
LWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtl
cm5lbAo=
