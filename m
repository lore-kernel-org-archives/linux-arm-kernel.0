Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E72C6786C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:00:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C292920811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NflZ9Tlq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MQPiB4Ac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C292920811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2lLgiVAJpymN6ru05+lk6qoBs/amj7lb7E4HjYmvYmc=; b=NflZ9Tlq4XpgJf
	86R73ZWRiDeQKMCe0ZtzAp/N/+RjQPwTDSPK/mwOsZMWb+yKdD82QUN5nyzhoo1TW8Xzi69dqkMUC
	hCfzC+4F0k8i8/H8B0db8Fa391H2UrptXBW3Lc2ZRXh82DKWhlWWOqUrfg8ua/vDjBOzi91owabW1
	dc8v4b1ugx6m1ylcp9hZVAOHru1fIK1w7BOj1J+2QIWojbWsvcI8s3PfbE5xlgo4rDjITUAowqe6Y
	33/riY8aURt1H1ClMkqARmzv0yzR2MSlYlOjXMAd3tQAiP8P0Oger64YF7/W4xz0cBpzo1GFvMtPA
	TDjampeC9hgg00FzSgyw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXkGm-0005H7-3g; Fri, 14 Dec 2018 10:00:32 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXkGh-0005G1-PI
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 10:00:30 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c137f2b0000>; Fri, 14 Dec 2018 02:00:11 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Fri, 14 Dec 2018 02:00:16 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Fri, 14 Dec 2018 02:00:16 -0800
Received: from [10.26.11.153] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 14 Dec
 2018 10:00:14 +0000
Subject: Re: [PATCH V2 08/21] clk: tegra: dfll: round down voltages based on
 alignment
To: Joseph Lo <josephl@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, 
 Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20181213093438.29621-1-josephl@nvidia.com>
 <20181213093438.29621-9-josephl@nvidia.com>
 <c1ce50e0-fccf-aa37-361c-4dd9367b092d@nvidia.com>
 <b9f473fc-d1e8-6d80-be20-d9884960dc16@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <c2aac384-e892-9c17-a58a-0e0f52ee0901@nvidia.com>
Date: Fri, 14 Dec 2018 10:00:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <b9f473fc-d1e8-6d80-be20-d9884960dc16@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1544781611; bh=wpYoAmY+SqAKLOvmf9mEQ56GYzo6rZBE3LACJDn04RA=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=MQPiB4AcTv7dQnPkeevTKdwRBUiB1egr4KuposqHkJUj5cl+Jrvelvc411wFd7myI
 A4Bh95KqXH7PQcIHyHy7x1AFULtTj8t3mWCZLh1FZgNb/umYKE5yYr+Ovwcx84gP9l
 6jPNXVnPuOIOwvc5NEEzT/vxtcHqqGXaOGW9eDF+HsRBPtUkaBTRGwEbGgXVPuwD6P
 BxY0vSeScq882LlmWONHSaplhYi5Swcie3CELEQtZOx2fAEsQ5j6sUdAnZFn9hkFfc
 puLZ9Bv+0Nym27CVcRYWpysL2k293hd31/NVxCOSfbNkkiSzCQgTy1F3KhnxqqA2Gz
 NnStcSYmdsvtQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_020027_828850_FF60810D 
X-CRM114-Status: GOOD (  15.71  )
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
Cc: linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Ck9uIDE0LzEyLzIwMTggMDc6MTgsIEpvc2VwaCBMbyB3cm90ZToKPiBPbiAxMi8xMy8xOCA3OjQ2
IFBNLCBKb24gSHVudGVyIHdyb3RlOgo+Pgo+PiBPbiAxMy8xMi8yMDE4IDA5OjM0LCBKb3NlcGgg
TG8gd3JvdGU6Cj4+PiBXaGVuIGdlbmVyYXRpbmcgdGhlIE9QUCB0YWJsZSwgdGhlIHZvbHRhZ2Vz
IGFyZSByb3VuZCBkb3duIHdpdGggdGhlCj4+PiBhbGlnbm1lbnQgZnJvbSB0aGUgcmVndWxhdG9y
LiBUaGUgYWxpZ25tZW50IHNob3VsZCBiZSBhcHBsaWVkIGZvcgo+Pj4gdm9sdGFnZXMgbG9vayB1
cCBhcyB3ZWxsLgo+Pj4KPj4+IEJhc2VkIG9uIHRoZSB3b3JrIG9mIFBlbm55IENoaXUgPHBjaGl1
QG52aWRpYS5jb20+Lgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IEpvc2VwaCBMbyA8am9zZXBobEBu
dmlkaWEuY29tPgo+Pj4gLS0tCj4+PiAqVjI6Cj4+PiDCoCAtIHMvYWxpZ25fdm9sdC9hbGlnbl9z
dGVwLwo+Pj4gwqAgLSBzL3JlZ192b2x0L3JlZ192b2x0X2lkLwo+Pj4gLS0tCj4+PiDCoCBkcml2
ZXJzL2Nsay90ZWdyYS9jbGstZGZsbC5jIHwgMjYgKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0K
Pj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkK
Pj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvdGVncmEvY2xrLWRmbGwuYyBiL2RyaXZl
cnMvY2xrL3RlZ3JhL2Nsay1kZmxsLmMKPj4+IGluZGV4IDcyZTAyODk4MDA2Yy4uYjM2NjgwNzNk
OWI0IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9jbGsvdGVncmEvY2xrLWRmbGwuYwo+Pj4gKysr
IGIvZHJpdmVycy9jbGsvdGVncmEvY2xrLWRmbGwuYwo+Pj4gQEAgLTgwNCwxNyArODA0LDE3IEBA
IHN0YXRpYyB2b2lkIGRmbGxfaW5pdF9vdXRfaWYoc3RydWN0IHRlZ3JhX2RmbGwKPj4+ICp0ZCkK
Pj4+IMKgIHN0YXRpYyBpbnQgZmluZF9sdXRfaW5kZXhfZm9yX3JhdGUoc3RydWN0IHRlZ3JhX2Rm
bGwgKnRkLCB1bnNpZ25lZAo+Pj4gbG9uZyByYXRlKQo+Pj4gwqAgewo+Pj4gwqDCoMKgwqDCoCBz
dHJ1Y3QgZGV2X3BtX29wcCAqb3BwOwo+Pj4gLcKgwqDCoCBpbnQgaSwgdXY7Cj4+PiArwqDCoMKg
IGludCBpLCBhbGlnbl9zdGVwOwo+Pj4gwqAgwqDCoMKgwqDCoCBvcHAgPSBkZXZfcG1fb3BwX2Zp
bmRfZnJlcV9jZWlsKHRkLT5zb2MtPmRldiwgJnJhdGUpOwo+Pj4gwqDCoMKgwqDCoCBpZiAoSVNf
RVJSKG9wcCkpCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIFBUUl9FUlIob3BwKTsKPj4+
IMKgIC3CoMKgwqAgdXYgPSBkZXZfcG1fb3BwX2dldF92b2x0YWdlKG9wcCk7Cj4+PiArwqDCoMKg
IGFsaWduX3N0ZXAgPSBkZXZfcG1fb3BwX2dldF92b2x0YWdlKG9wcCkgLwo+Pj4gdGQtPnNvYy0+
YWxpZ25tZW50LnN0ZXBfdXY7Cj4+PiDCoMKgwqDCoMKgIGRldl9wbV9vcHBfcHV0KG9wcCk7Cj4+
PiDCoCDCoMKgwqDCoMKgIGZvciAoaSA9IHRkLT5sdXRfYm90dG9tOyBpIDwgdGQtPmx1dF9zaXpl
OyBpKyspIHsKPj4+IC3CoMKgwqDCoMKgwqDCoCBpZiAodGQtPmx1dF91dltpXSA+PSB1dikKPj4+
ICvCoMKgwqDCoMKgwqDCoCBpZiAoKHRkLT5sdXRfdXZbaV0gLyB0ZC0+c29jLT5hbGlnbm1lbnQu
c3RlcF91dikgPj0gYWxpZ25fc3RlcCkKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJl
dHVybiBpOwo+Pj4gwqDCoMKgwqDCoCB9Cj4+PiDCoCBAQCAtMTUzMiwxNSArMTUzMiwxNyBAQCBz
dGF0aWMgaW50IGRmbGxfaW5pdChzdHJ1Y3QgdGVncmFfZGZsbCAqdGQpCj4+PiDCoMKgICovCj4+
PiDCoCBzdGF0aWMgaW50IGZpbmRfdmRkX21hcF9lbnRyeV9leGFjdChzdHJ1Y3QgdGVncmFfZGZs
bCAqdGQsIGludCB1VikKPj4+IMKgIHsKPj4+IC3CoMKgwqAgaW50IGksIG5fdm9sdGFnZXMsIHJl
Z191VjsKPj4+ICvCoMKgwqAgaW50IGksIG5fdm9sdGFnZXMsIHJlZ192b2x0X2lkLCBhbGlnbl9z
dGVwOwo+Pj4gwqAgK8KgwqDCoCBhbGlnbl9zdGVwID0gdVYgLyB0ZC0+c29jLT5hbGlnbm1lbnQu
c3RlcF91djsKPj4+IMKgwqDCoMKgwqAgbl92b2x0YWdlcyA9IHJlZ3VsYXRvcl9jb3VudF92b2x0
YWdlcyh0ZC0+dmRkX3JlZyk7Cj4+PiDCoMKgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBuX3ZvbHRh
Z2VzOyBpKyspIHsKPj4+IC3CoMKgwqDCoMKgwqDCoCByZWdfdVYgPSByZWd1bGF0b3JfbGlzdF92
b2x0YWdlKHRkLT52ZGRfcmVnLCBpKTsKPj4+IC3CoMKgwqDCoMKgwqDCoCBpZiAocmVnX3VWIDwg
MCkKPj4+ICvCoMKgwqDCoMKgwqDCoCByZWdfdm9sdF9pZCA9IHJlZ3VsYXRvcl9saXN0X3ZvbHRh
Z2UodGQtPnZkZF9yZWcsIGkpIC8KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHRkLT5zb2MtPmFsaWdubWVudC5zdGVwX3V2Owo+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmIChy
ZWdfdm9sdF9pZCA8IDApCj4+Cj4+IEkgZG9uJ3QgdGhpbmsgdGhhdCB0aGlzIHdpbGwgd29yay4g
SWYgdGhlIHN0ZXAgaXMgc2F5IDEwMDAwIGFuZCB3ZQo+PiByZXR1cm4gYW4gZXJyb3IgY29kZSBn
cmVhdGVyIHRoYW4gLTEwMDAwLCB3ZSB3aWxsIGVuZCB1cCB3aXRoIDAuCj4gCj4gQWgsSSB0aGlu
ayB5b3UgbWVhbiB3aGVuIHRoZSBlcnJvciBjb2RlIHNtYWxsZXIgdGhhbiBzdGVwX3V2LiBZZXMs
IGl0Cj4gd2lsbCBiZSAwIGluIHRoYXQgY2FzZS4gSSB0aGluayBJIHdpbGwganVzdCByZW1vdmUg
dGhlICdpZicgY2xhdXNlLCB0aGVuCj4gaXQgd2lsbCBub3QgbWF0Y2ggYW55dGhpbmcgYW5kIGxl
YXZlIHRoZSBmb3IgbG9vcC4gQW5kIHJldHVybiBlcnJvciBpZgo+IGl0IGNvdWxkbid0IGZpbmQg
YW55dGhpbmcuIFNhbWUgYXMgYmVsb3cuCgpMb29rcyBsaWtlIGlmIHlvdSByZW1vdmUgdGhlIGlm
IGNsYXVzZSB0aGVuIGlmIHdpbGwgdHJ5IHRvIGxvb2sgdXAKYW5vdGhlciB2b2x0YWdlLiBTZWVt
cyB0byBtZSB0aGF0IHdlIHNob3VsZCBqdXN0IGJyZWFrIG91dCB0aGUgbG9vcCBvbgp0aGUgZmly
c3QgZmFpbHVyZSBhcyBpdCBkb2VzIHRvZGF5LgoKQ2hlZXJzCkpvbgotLSAKbnZwdWJsaWMKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1r
ZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJu
ZWwK
