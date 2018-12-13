Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0527C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:32:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B2FA2080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="anV8A2Lc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B2FA2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=weNh6xWWA0aTLLxAMblEpA+qt7ugdKkUuj06Sa5itbY=; b=anV8A2LcefRsDd0sfbWTUlmU8
	gOgTEH+1/inrkoss5rvI1seO7H1T7uEqVb+0o1GT+szBfq8U7EYwsGX0NfDQo8DPZ4p4YvDnTOPaL
	8uKr+Awf9PER9D8AnRHqxV/2wO8O6/ZeewcRp8dk7Sw4P1LgKA+DkVfOAnFVymcAOiIaL/jqFnc5N
	k4+sZNCqI1WIG420Q6156EdHXMJhcgo2mmX05BuaQcrO+SIYrH5yev0fLE+nsILoUfN9ByNt/X4U4
	9cv+2oWiD6i12ISabWosbxfA4ENgWyd+EFnLRPnI4jS73Sj46b5p1LtZCpAWlccud1awwOrk390d+
	TsivsWurw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXNLq-0006G3-OF; Thu, 13 Dec 2018 09:32:14 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXNLn-0006FB-J1
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 09:32:13 +0000
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 81D26D29227F;
 Thu, 13 Dec 2018 17:31:56 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Thu, 13 Dec 2018
 17:31:47 +0800
Subject: Re: [bug?] poor migrate_pages() performance on arm64
To: Jan Stancek <jstancek@redhat.com>, <linux-mm@kvack.org>,
 <linux-arm-kernel@lists.infradead.org>
References: <1125108393.85764095.1544629302243.JavaMail.zimbra@redhat.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <9291e284-7b9b-3d93-1e79-f01c174d9979@huawei.com>
Date: Thu, 13 Dec 2018 09:31:43 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1125108393.85764095.1544629302243.JavaMail.zimbra@redhat.com>
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_013211_806218_127F5F08 
X-CRM114-Status: GOOD (  14.33  )
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
Cc: Tan Xiaojun <tanxiaojun@huawei.com>, Linuxarm <linuxarm@huawei.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

KyBjYydpbmcgbGludXhhcm1AaHVhd2VpLmNvbQoKSXQgc2VlbXMgdGhhdCB3ZSdyZSBzcGVuZGlu
ZyBtdWNoIHRpbWUgaW4gY2FjaGUgaW52YWxpZGF0ZS4KCldoZW4geW91IHNheSA0IG5vZGVzLCBk
b2VzIHRoYXQgbWVhbiBtZW1vcnkgb24gYWxsIDQgbm9kZXM/CgpUaGFua3MsCkpvaG4KCk9uIDEy
LzEyLzIwMTggMTU6NDEsIEphbiBTdGFuY2VrIHdyb3RlOgo+IEhpLAo+Cj4gSSdtIG9ic2Vydmlu
ZyBtaWdyYXRlX3BhZ2VzKCkgdGFraW5nIHF1aXRlIGxvbmcgdGltZSBvbiBhcm02NAo+IHN5c3Rl
bSAoSHVhd2VpIFRhaVNoYW4gMjI4MCwgNCBub2RlcywgNjQgQ1BVcykuIEknbSB1c2luZyA0LjIw
LjAtcmM2LAo+IGJ1dCBpdCdzIHJlcHJvZHVjaWJsZSB3aXRoIG9sZGVyIGtlcm5lbHMgKDQuMTQp
IGFzIHdlbGwuCj4KPiBUaGUgdGVzdCAoc2VlIFsxXSBiZWxvdyksIGlzIGEgdHJpdmlhbCBDIGFw
cGxpY2F0aW9uLCB0aGF0IG1pZ3JhdGVzCj4gY3VycmVudCBwcm9jZXNzIGZyb20gb25lIG5vZGUg
dG8gYW5vdGhlci4gTW9yZSBjb21wbGljYXRlZCBleGFtcGxlCj4gaXMgYWxzbyBMVFAncyBtaWdy
YXRlX3BhZ2VzMDMsIHdoZXJlIHRoaXMgaGFzIGJlZW4gb3JpZ2luYWxseSByZXBvcnRlZC4KPgo+
IEl0IHRha2VzIDIrIHNlY29uZHMgdG8gbWlncmF0ZSBwcm9jZXNzIGZyb20gb25lIG5vZGUgdG8g
YW5vdGhlcjoKPiAgICMgc3RyYWNlIC1mIC10IC1UIC4vYS5vdXQKPiAgIC4uLgo+ICAgW3BpZCAx
Mzc1NF0gMTA6MTc6MTMgbWlncmF0ZV9wYWdlcygwLCA4LCBbMHgwMDAwMDAwMDAwMDAwMDAyXSwg
WzB4MDAwMDAwMDAwMDAwMDAwMV0pID0gMSA8MC4wNTgxMTU+Cj4gICBbcGlkIDEzNzU0XSAxMDox
NzoxMyBtaWdyYXRlX3BhZ2VzKDAsIDgsIFsweDAwMDAwMDAwMDAwMDAwMDFdLCBbMHgwMDAwMDAw
MDAwMDAwMDAyXSkgPSAxMiA8Mi4zNDgxODY+Cj4gICBbcGlkIDEzNzU0XSAxMDoxNzoxNiBtaWdy
YXRlX3BhZ2VzKDAsIDgsIFsweDAwMDAwMDAwMDAwMDAwMDJdLCBbMHgwMDAwMDAwMDAwMDAwMDAx
XSkgPSAxIDwwLjA1Nzg4OT4KPiAgIFtwaWQgMTM3NTRdIDEwOjE3OjE2IG1pZ3JhdGVfcGFnZXMo
MCwgOCwgWzB4MDAwMDAwMDAwMDAwMDAwMV0sIFsweDAwMDAwMDAwMDAwMDAwMDJdKSA9IDEwIDwy
LjE5NDg5MD4KPiAgIC4uLgo+Cj4gVGhpcyBzY2FsZXMgd2l0aCBudW1iZXIgb2YgY2hpbGRyZW4u
IEZvciBleGFtcGxlIHdpdGggTUFYQ0hJTEQgMTAwMCwKPiBpdCB0YWtlcyB+MzMgc2Vjb25kczoK
PiAgICMgc3RyYWNlIC1mIC10IC1UIC4vYS5vdXQKPiAgIC4uLgo+ICAgW3BpZCAxMzc3M10gMTA6
MTc6NTUgbWlncmF0ZV9wYWdlcygwLCA4LCBbMHgwMDAwMDAwMDAwMDAwMDAxXSwgWzB4MDAwMDAw
MDAwMDAwMDAwMl0pID0gMTEgPDMzLjYxNTU1MD4KPiAgIFtwaWQgMTM3NzNdIDEwOjE4OjI5IG1p
Z3JhdGVfcGFnZXMoMCwgOCwgWzB4MDAwMDAwMDAwMDAwMDAwMl0sIFsweDAwMDAwMDAwMDAwMDAw
MDFdKSA9IDIgPDUuNDYwMjcwPgo+ICAgLi4uCj4KPiBJdCBhcHBlYXJzIHRvIGJlIHJlbGF0ZWQg
dG8gbWlncmF0aW9uIG9mIHNoYXJlZCBwYWdlcywgcHJlc3VtYWJseQo+IGV4ZWN1dGFibGUgY29k
ZSBvZiBnbGliYy4KPgo+IElmIEkgcnVuIFsxXSB3aXRob3V0IENBUF9TWVNfTklDRSwgaXQgY29t
cGxldGVzIHZlcnkgcXVpY2tseToKPiAgICMgc3VkbyAtdSBub2JvZHkgc3RyYWNlIC1mIC10IC1U
IC4vYS5vdXQKPiAgIC4uLgo+ICAgW3BpZCAxNDg0N10gMTA6MjQ6NTcgbWlncmF0ZV9wYWdlcygw
LCA4LCBbMHgwMDAwMDAwMDAwMDAwMDAxXSwgWzB4MDAwMDAwMDAwMDAwMDAwMl0pID0gMCA8MC4w
MDAxNzI+Cj4gICBbcGlkIDE0ODQ3XSAxMDoyNDo1NyBtaWdyYXRlX3BhZ2VzKDAsIDgsIFsweDAw
MDAwMDAwMDAwMDAwMDJdLCBbMHgwMDAwMDAwMDAwMDAwMDAxXSkgPSAwIDwwLjAwMDA5MT4KPiAg
IFtwaWQgMTQ4NDddIDEwOjI0OjU3IG1pZ3JhdGVfcGFnZXMoMCwgOCwgWzB4MDAwMDAwMDAwMDAw
MDAwMV0sIFsweDAwMDAwMDAwMDAwMDAwMDJdKSA9IDAgPDAuMDAwMDc0Pgo+ICAgW3BpZCAxNDg0
N10gMTA6MjQ6NTcgbWlncmF0ZV9wYWdlcygwLCA4LCBbMHgwMDAwMDAwMDAwMDAwMDAyXSwgWzB4
MDAwMDAwMDAwMDAwMDAwMV0pID0gMCA8MC4wMDAwNjk+Cj4gICAuLi4KPgo+Cj4gTG9va2luZyBh
dCBwZXJmLCBtb3N0IG9mIHRpbWUgaXMgc3BlbnQgaW52YWxpZGF0aW5nIGljYWNoZS4KPgo+IC0g
IDEwMC4wMCUgICAgIDAuMDAlICBhLm91dCAgICBba2VybmVsLmthbGxzeW1zXSAgW2tdIF9fc3lz
X3RyYWNlX3JldHVybgo+ICAgIC0gX19zeXNfdHJhY2VfcmV0dXJuCj4gICAgICAgLSAxMDAuMDAl
IF9fc2Vfc3lzX21pZ3JhdGVfcGFnZXMKPiAgICAgICAgICAgIGRvX21pZ3JhdGVfcGFnZXMucGFy
dC45Cj4gICAgICAgICAgLSBtaWdyYXRlX3BhZ2VzCj4gICAgICAgICAgICAgLSA5OS45MiUgcm1h
cF93YWxrCj4gICAgICAgICAgICAgICAgLSA5OS45MiUgcm1hcF93YWxrX2ZpbGUKPiAgICAgICAg
ICAgICAgICAgICAtIDk5LjkwJSByZW1vdmVfbWlncmF0aW9uX3B0ZQo+ICAgICAgICAgICAgICAg
ICAgICAgIC0gOTkuODUlIF9fc3luY19pY2FjaGVfZGNhY2hlCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICBfX2ZsdXNoX2NhY2hlX3VzZXJfcmFuZ2UKPgo+IFBlcmNlbnTilIIgICAgICBub3AK
PiAgICAgICAg4pSCICAgICAgdWJmeCAgIHgzLCB4MywgIzE2LCAjNAo+ICAgICAgICDilIIgICAg
ICBtb3YgICAgeDIsICMweDQgICAgICAgICAgICAgICAgICAgICAgICAvLyAjNAo+ICAgICAgICDi
lIIgICAgICBsc2wgICAgeDIsIHgyLCB4Mwo+ICAgICAgICDilIIgICAgICBzdWIgICAgeDMsIHgy
LCAjMHgxCj4gICAgICAgIOKUgiAgICAgIGJpYyAgICB4NCwgeDAsIHgzCj4gICAxLjgyIOKUgiAg
ICAgIGRjICAgICBjdmF1LCB4NAo+ICAgICAgICDilIIgICAgICBhZGQgICAgeDQsIHg0LCB4Mgo+
ICAgICAgICDilIIgICAgICBjbXAgICAgeDQsIHgxCj4gICAgICAgIOKUgiAgICDihpIgYi5jYyAg
IDB4ZmZmZjAwMDAwODA5ZWZjOCAgLy8gYi5sbywgYi51bCwgZmZmZmY3ZjYxMDY3Cj4gICAgICAg
IOKUgiAgICAgIGRzYiAgICBpc2gKPiAgICAgICAg4pSCICAgICAgbm9wCj4gICAwLjA3IOKUgiAg
ICAgIG5vcAo+ICAgICAgICDilIIgICAgICBtcnMgICAgeDMsIGN0cl9lbDAKPiAgICAgICAg4pSC
ICAgICAgbm9wCj4gICAgICAgIOKUgiAgICAgIGFuZCAgICB4MywgeDMsICMweGYKPiAgICAgICAg
4pSCICAgICAgbW92ICAgIHgyLCAjMHg0ICAgICAgICAgICAgICAgICAgICAgICAgLy8gIzQKPiAg
ICAgICAg4pSCICAgICAgbHNsICAgIHgyLCB4MiwgeDMKPiAgICAgICAg4pSCICAgICAgc3ViICAg
IHgzLCB4MiwgIzB4MQo+ICAgICAgICDilIIgICAgICBiaWMgICAgeDMsIHgwLCB4Mwo+ICA5Ni4x
NyDilIIgICAgICBpYyAgICAgaXZhdSwgeDMKPiAgICAgICAg4pSCICAgICAgYWRkICAgIHgzLCB4
MywgeDIKPiAgICAgICAg4pSCICAgICAgY21wICAgIHgzLCB4MQo+ICAgICAgICDilIIgICAg4oaS
IGIuY2MgICAweGZmZmYwMDAwMDgwOWYwMDAgIC8vIGIubG8sIGIudWwsIGZmZmZmN2Y2MTA2Nwo+
ICAgMC4xMCDilIIgICAgICBkc2IgICAgaXNoCj4gICAgICAgIOKUgiAgICAgIGlzYgo+ICAgMS44
NSDilIIgICAgICBtb3YgICAgeDAsICMweDAgICAgICAgICAgICAgICAgICAgICAgICAvLyAjMAo+
ICAgICAgICDilII3ODog4oaQIHJldAo+ICAgICAgICDilIIgICAgICBtb3YgICAgeDAsICMweGZm
ZmZmZmZmZmZmZmZmZjIgICAgICAgICAvLyAjLTE0Cj4gICAgICAgIOKUgiAgICDihpEgYiAgICAg
IDc4Cj4KPiBSZWdhcmRzLAo+IEphbgo+Cj4gWzFdCj4gLS0tLS0gODwgLS0tLS0KPiAjaW5jbHVk
ZSA8c2lnbmFsLmg+Cj4gI2luY2x1ZGUgPHN0ZGlvLmg+Cj4gI2luY2x1ZGUgPHN0ZGxpYi5oPgo+
ICNpbmNsdWRlIDx1bmlzdGQuaD4KPiAjaW5jbHVkZSA8c3lzL3N5c2NhbGwuaD4KPgo+ICNkZWZp
bmUgTUFYQ0hJTEQgMTAKPgo+IGludCBtYWluKHZvaWQpCj4gewo+IAlsb25nIG5vZGUxID0gMSwg
bm9kZTIgPSAyOwo+IAlpbnQgaSwgY2hpbGQ7Cj4gCWludCBwaWRzW01BWENISUxEXTsKPgo+IAlm
b3IgKGkgPSAwOyBpIDwgTUFYQ0hJTEQ7IGkrKykgewo+IAkJY2hpbGQgPSBmb3JrKCk7Cj4gCQlp
ZiAoY2hpbGQgPT0gMCkgewo+IAkJCXNsZWVwKDYwMCk7Cj4gCQkJZXhpdCgwKTsKPiAJCX0KPiAJ
CXBpZHNbaV0gPSBjaGlsZDsKPiAJfQo+Cj4gCWZvciAoaSA9IDA7IGkgPCA1OyBpKyspIHsKPiAJ
CXN5c2NhbGwoX19OUl9taWdyYXRlX3BhZ2VzLCAwLCA4LCAmbm9kZTEsICZub2RlMik7Cj4gCQlz
eXNjYWxsKF9fTlJfbWlncmF0ZV9wYWdlcywgMCwgOCwgJm5vZGUyLCAmbm9kZTEpOwo+IAl9Cj4K
PiAJZm9yIChpID0gMDsgaSA8IE1BWENISUxEOyBpKyspIHsKPiAJCWtpbGwocGlkc1tpXSwgU0lH
S0lMTCk7Cj4gCX0KPgo+IAlyZXR1cm4gMDsKPiB9Cj4gLS0tLS0gPjggLS0tLS0KPgo+IF9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gbGludXgtYXJtLWtl
cm5lbCBtYWlsaW5nIGxpc3QKPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcK
PiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1r
ZXJuZWwKPgoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1hcm0ta2VybmVsCg==
