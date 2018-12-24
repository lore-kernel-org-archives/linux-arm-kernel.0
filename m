Return-Path: <SRS0=tR0U=PB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DDCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 07:54:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8480121773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 07:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z3WcesTk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8480121773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DWyMmxldmEDiXM6EgKcDDKxbcHy1syQmmJE8ESsi7dQ=; b=Z3WcesTk5MmhXq
	JYrAsdB5GP43LVbKu20upwH0Vzkbt/RCvVUPxt2KNtjuif593l6EtzYQStI580/Xk/HZ85cGoUCej
	mmmCznO+FSlqwgpDtvsJ93G+IU8NYHH25MCdmxW/wxAvLWs/RrrmLt0rQDNWfzw+jrIy6VfgVoUnV
	pEx1ehg7AREMYkjxFLn/2eesdfoLJpp+v86KyOHis4dhJFsfLPl5+ZLPAKCJt5aHDEHfV5csxa2EM
	/9bTeHJiVwM9guVqqbn5oBQSvBXLgduzpwo3lWaFfA3k7mBEUx4s1d16ato9EOe0xs3EWSE0J2Kwb
	du6sVWg+vJQU1JA+38+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbL4d-0001QF-1I; Mon, 24 Dec 2018 07:54:51 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbL4Z-0001On-BD; Mon, 24 Dec 2018 07:54:48 +0000
Received: from [46.183.103.8] (helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gbL4K-0003Aj-4f; Mon, 24 Dec 2018 08:54:32 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: "zhangqing@rock-chips.com" <zhangqing@rock-chips.com>
Subject: Re: [PATCH] clk: rockchip: fix frac settings of GPLL clock for rk3328
Date: Mon, 24 Dec 2018 08:54:31 +0100
Message-ID: <2107849.4rvOjsJc15@phil>
In-Reply-To: <20181224154804602776216@rock-chips.com>
References: <20181222164249.25620-1-katsuhiro@katsuster.net>
 <1587344.DIk9eYpvKM@phil> <20181224154804602776216@rock-chips.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181223_235447_538412_D8B09D5A 
X-CRM114-Status: GOOD (  21.94  )
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
Cc: Katsuhiro Suzuki <katsuhiro@katsuster.net>,
 linux-rockchip <linux-rockchip@lists.infradead.org>,
 Finley Xiao <finley.xiao@rock-chips.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgRWxhaW5lLAoKQW0gTW9udGFnLCAyNC4gRGV6ZW1iZXIgMjAxOCwgMDg6NDg6MDUgQ0VUIHNj
aHJpZWIgemhhbmdxaW5nQHJvY2stY2hpcHMuY29tOgo+IEhpOiBIZWlrbzoKPiAKPiBUaGlzIGV4
cGxhbmF0aW9uIGFuZCB0aGUgY2hhbmdlIGlzIE9LLiBUaGFua3MgZm9yIEthdHN1aGlybydzIGNv
cnJlY3Rpb24uCgp0aGFua3MgZm9yIHlvdXIgcXVpY2sgY29uZmlybWF0aW9uLiBDYW4gSSBtYWtl
IHRoaXMgYW4KCkFja2VkLWJ5OiBFbGFpbmUgWmhhbmcgPHpoYW5ncWluZ0Byb2NrLWNoaXBzLmNv
bT4KCndoZW4gYXBwbHlpbmcgdGhlIHBhdGNoPwoKVGhhbmtzCkhlaWtvCgoKPiDlvKDmmbQKPiDn
po/lt57nkZ7oiq/lvq7nlLXlrZDogqHku73mnInpmZDlhazlj7gKPiBGdXpob3UgUm9ja2NoaXAg
RWxlY3Ryb25pY3MgQ28uLEx0ZAo+IOWcsOWdgO+8muemj+W7uuecgeemj+W3nuW4gumTnOebmOi3
r+i9r+S7tuWkp+mBkzg55Y+36L2v5Lu25ZutQeWMujIx5Y+35qW8Cj4gQWRkOk5vLjIxIEJ1aWxk
aW5nLCBBIERpc3RyaWN0LCBOby44OSBTb2Z0d2FyZSBCb3VsZXZhcmQgRnV6aG91LCBGdWppYW4g
MzUwMDAzLCBQLlIuQ2hpbmEKPiBUZWw6Kzg2LTA1OTEtODM5OTE5MDYtODYwMQo+IOmCrue8lu+8
mjM1MDAwMwo+IEUtbWFpbDplbGFpbmUuemhhbmdAcm9jay1jaGlwcy5jb20KPiAgCj4gRnJvbTog
SGVpa28gU3R1ZWJuZXIKPiBEYXRlOiAyMDE4LTEyLTI0IDE1OjM0Cj4gVG86IEthdHN1aGlybyBT
dXp1a2k7IEZpbmxleSBYaWFvOyBFbGFpbmUgWmhhbmcKPiBDQzogbGludXgtcm9ja2NoaXA7IGxp
bnV4LWFybS1rZXJuZWw7IGxpbnV4LWtlcm5lbAo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGNsazog
cm9ja2NoaXA6IGZpeCBmcmFjIHNldHRpbmdzIG9mIEdQTEwgY2xvY2sgZm9yIHJrMzMyOAo+IEhp
LAo+ICAKPiBBbSBTYW1zdGFnLCAyMi4gRGV6ZW1iZXIgMjAxOCwgMTc6NDI6NDkgQ0VUIHNjaHJp
ZWIgS2F0c3VoaXJvIFN1enVraToKPiA+IFRoaXMgcGF0Y2ggZml4ZXMgc2V0dGluZ3Mgb2YgR1BM
TCBmcmVxdWVuY3kgaW4gZnJhY3Rpb25hbCBtb2RlIGZvcgo+ID4gcmszMzI4LiBJbiB0aGlzIG1v
ZGUsIEZPVVRWQ08gaXMgY2FsY3VyYXRlZCBieSBmb2xsb3dpbmcgZm9ybXVsYToKPiA+ICAgRk9V
VFZDTyA9IEZSRUYgKiBGQkRJViAvIFJFRkRJViArICgoRlJFRiAqIEZSQUMgLyBSRUZESVYpID4+
IDI0KQo+ID4gCj4gPiBUaGUgcHJvYmxlbSBpcyBpbiBGUkVGICogRlJBQyA+PiAyNCB0ZXJtLiBU
aGlzIHJlc3VsdCBhbHdheXMgbGFja3MKPiA+IG9uZSBmcm9tIHRhcmdldCB2YWx1ZSBpcyBzcGVj
aWZpZWQgYnkgcmF0ZSBtZW1iZXIuIEZvciBleGFtcGxlIGZpcnN0Cj4gPiBpdG1lIG9mIHJrMzMy
OF9wbGxfZnJhY19yYXRlIG9yaWdpbmFsbHkgaGFzCj4gPiAgIC0gcmF0ZSAgOiAxMDE2MDY0MDAw
Cj4gPiAgIC0gcmVmZGl2OiAzCj4gPiAgIC0gZmJkaXYgOiAxMjcKPiA+ICAgLSBmcmFjICA6IDEz
NDIxNwo+ID4gICAtIEZSRUYgKiBGQkRJViAvIFJFRkRJViAgICAgICAgPSAxMDE2MDAwMDAwCj4g
PiAgIC0gKEZSRUYgKiBGUkFDIC8gUkVGRElWKSA+PiAyNCA9IDYzOTk5Cj4gPiBUaHVzIGNhbGN1
bGF0ZWQgcmF0ZSBpcyAxMDE2MDYzOTk5LiBJdCBzZWVtcyB3cm9uZy4KPiA+IAo+ID4gSWYgZnJh
YyBoYXMgMTM0MjE4IChpdCBpcyBpbmNyZWFzZWQgMSBmcm9tIG9yaWdpbmFsIHZhbHVlKSwgc2Vj
b25kCj4gPiB0ZXJtIGlzIDY0MDAwLiBBbGwgb3RoZXIgaXRlbXMgaGF2ZSBzYW1lIHNpdHVhdGlv
bi4gU28gdGhpcyBwYXRjaAo+ID4gYWRkcyAxIHRvIGZyYWMgbWVtYmVyIGluIGFsbCBpdGVtcyBv
ZiByazMzMjhfcGxsX2ZyYWNfcmF0ZS4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogS2F0c3VoaXJv
IFN1enVraSA8a2F0c3VoaXJvQGthdHN1c3Rlci5uZXQ+Cj4gIAo+IHNvIHdoaWxlIHRoaXMgc291
bmRzIGFsbCBxdWl0ZSByaWdodCB0byBtZSwgSSd2ZSBhZGRlZCBzb21lIFJvY2tjaGlwCj4gcGVv
cGxlIHRoYXQgaGF2ZSBjbG9jayBleHBlcmllbmNlIHRvIGhvcGVmdWxseSBnZXQgYW4gQWNrIG9u
IHRoZQo+IGNoYW5nZSA6LSkKPiAgCj4gQEVsYWluZSArIEZpbmxleTogZG9lcyB0aGlzIGV4cGxh
bmF0aW9uIGFuZCB0aGUgYmVsb3cgY2hhbmdlIGxvb2sgcmlnaHQ/Cj4gIAo+ICAKPiBUaGFua3MK
PiBIZWlrbwo+ICAKPiA+IC0tLQo+ID4gIGRyaXZlcnMvY2xrL3JvY2tjaGlwL2Nsay1yazMzMjgu
YyB8IDEyICsrKysrKy0tLS0tLQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyks
IDYgZGVsZXRpb25zKC0pCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9yb2NrY2hp
cC9jbGstcmszMzI4LmMgYi9kcml2ZXJzL2Nsay9yb2NrY2hpcC9jbGstcmszMzI4LmMKPiA+IGlu
ZGV4IGZhYTk0YWRiMmEzNy4uNjVhYjVjMmY0OGIwIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9j
bGsvcm9ja2NoaXAvY2xrLXJrMzMyOC5jCj4gPiArKysgYi9kcml2ZXJzL2Nsay9yb2NrY2hpcC9j
bGstcmszMzI4LmMKPiA+IEBAIC03OCwxNyArNzgsMTcgQEAgc3RhdGljIHN0cnVjdCByb2NrY2hp
cF9wbGxfcmF0ZV90YWJsZSByazMzMjhfcGxsX3JhdGVzW10gPSB7Cj4gPiAgCj4gPiAgc3RhdGlj
IHN0cnVjdCByb2NrY2hpcF9wbGxfcmF0ZV90YWJsZSByazMzMjhfcGxsX2ZyYWNfcmF0ZXNbXSA9
IHsKPiA+ICAvKiBfbWh6LCBfcmVmZGl2LCBfZmJkaXYsIF9wb3N0ZGl2MSwgX3Bvc3RkaXYyLCBf
ZHNtcGQsIF9mcmFjICovCj4gPiAtIFJLMzAzNl9QTExfUkFURSgxMDE2MDY0MDAwLCAzLCAxMjcs
IDEsIDEsIDAsIDEzNDIxNyksCj4gPiArIFJLMzAzNl9QTExfUkFURSgxMDE2MDY0MDAwLCAzLCAx
MjcsIDEsIDEsIDAsIDEzNDIxOCksCj4gPiAgLyogdmNvID0gMTAxNjA2NDAwMCAqLwo+ID4gLSBS
SzMwMzZfUExMX1JBVEUoOTgzMDQwMDAwLCAyNCwgOTgzLCAxLCAxLCAwLCA2NzEwODgpLAo+ID4g
KyBSSzMwMzZfUExMX1JBVEUoOTgzMDQwMDAwLCAyNCwgOTgzLCAxLCAxLCAwLCA2NzEwODkpLAo+
ID4gIC8qIHZjbyA9IDk4MzA0MDAwMCAqLwo+ID4gLSBSSzMwMzZfUExMX1JBVEUoNDkxNTIwMDAw
LCAyNCwgOTgzLCAyLCAxLCAwLCA2NzEwODgpLAo+ID4gKyBSSzMwMzZfUExMX1JBVEUoNDkxNTIw
MDAwLCAyNCwgOTgzLCAyLCAxLCAwLCA2NzEwODkpLAo+ID4gIC8qIHZjbyA9IDk4MzA0MDAwMCAq
Lwo+ID4gLSBSSzMwMzZfUExMX1JBVEUoNjE0NDAwMDAsIDYsIDIxNSwgNywgMiwgMCwgNjcxMDg4
KSwKPiA+ICsgUkszMDM2X1BMTF9SQVRFKDYxNDQwMDAwLCA2LCAyMTUsIDcsIDIsIDAsIDY3MTA4
OSksCj4gPiAgLyogdmNvID0gODYwMTU2MDAwICovCj4gPiAtIFJLMzAzNl9QTExfUkFURSg1NjQ0
ODAwMCwgMTIsIDQ1MSwgNCwgNCwgMCwgOTc5Nzg5NCksCj4gPiArIFJLMzAzNl9QTExfUkFURSg1
NjQ0ODAwMCwgMTIsIDQ1MSwgNCwgNCwgMCwgOTc5Nzg5NSksCj4gPiAgLyogdmNvID0gOTAzMTY4
MDAwICovCj4gPiAtIFJLMzAzNl9QTExfUkFURSg0MDk2MDAwMCwgMTIsIDQwOSwgNCwgNSwgMCwg
MTAwNjYzMjkpLAo+ID4gKyBSSzMwMzZfUExMX1JBVEUoNDA5NjAwMDAsIDEyLCA0MDksIDQsIDUs
IDAsIDEwMDY2MzMwKSwKPiA+ICAvKiB2Y28gPSA4MTkyMDAwMDAgKi8KPiA+ICB7IC8qIHNlbnRp
bmVsICovIH0sCj4gPiAgfTsKPiA+IAo+ICAKPiAgCj4gIAo+ICAKPiAgCj4gCgoKCgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5l
bCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
