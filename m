Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2A1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:04:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B146E20660
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AFLJSMOx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B146E20660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rwSB07Zcp1vWZEL/N5NfFRDOIr3lkJQYLtb2K6wsq5o=; b=AFLJSMOxtxF8QP
	MqC9JmisiFB7zPrp8iBcotpR4S5esa51H9ftyxwJ/rjvqfl3C4+Y4qWuEWpCm9JqrRES0z25LvBJf
	wjcZJe2fynYHAPBJoDUjjVbRKsjoXVq1XxGHQa5KsDGX6tLxddTE8IYB3V2EoMWk9F8su40BJTWeU
	bQB2I/ifdMfTqMFUaWPsIrWbtZJzjDET+RoaBCi5Ez+Xsyp8uFUVpElXCabisToQgny7zdQdE21nE
	l7+XuNEASxH7VSBnF7tk+M1twnHPfof/+Xx+pOSiffg5SjIItHX1RDMj6q63JJuAfyHwqbYUcYSdm
	s8aHf/dgI7WqZN79f+kg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghawQ-0002w7-3q; Thu, 10 Jan 2019 14:04:14 +0000
Received: from orcrist.hmeau.com ([104.223.48.154] helo=deadmen.hmeau.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghawL-0002va-Cn
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 14:04:11 +0000
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
 by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
 id 1ghaw6-0002fn-Gb; Thu, 10 Jan 2019 22:03:54 +0800
Received: from herbert by gondobar with local (Exim 4.89)
 (envelope-from <herbert@gondor.apana.org.au>)
 id 1ghaw1-0004Ap-L4; Thu, 10 Jan 2019 22:03:49 +0800
Date: Thu, 10 Jan 2019 22:03:49 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Subject: Re: [PATCH] crypto: caam - fix zero-length buffer DMA mapping
Message-ID: <20190110140349.izbgn6jvab4r56at@gondor.apana.org.au>
References: <20181219143644.22089-1-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181219143644.22089-1-horia.geanta@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_060409_698507_6FE82F57 
X-CRM114-Status: UNSURE (   7.45  )
X-CRM114-Notice: Please train this message.
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
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>, Christoph Hellwig <hch@lst.de>,
 linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gV2VkLCBEZWMgMTksIDIwMTggYXQgMDQ6MzY6NDRQTSArMDIwMCwgSG9yaWEgR2VhbnTEgyB3
cm90ZToKPiBGcm9tOiBBeW1lbiBTZ2hhaWVyIDxheW1lbi5zZ2hhaWVyQG54cC5jb20+Cj4gCj4g
UmVjZW50IGNoYW5nZXMgLSBwcm9iYWJseSBETUEgQVBJIHJlbGF0ZWQgKGdlbmVyaWMgYW5kL29y
IGFybTY0LXNwZWNpZmljKSAtCj4gZXhwb3NlZCBhIGNhc2Ugd2hlcmUgZHJpdmVyIG1hcHMgYSB6
ZXJvLWxlbmd0aCBidWZmZXI6Cj4gYWhhc2hfaW5pdCgpLT5haGFzaF91cGRhdGUoKS0+YWhhc2hf
ZmluYWwoKSB3aXRoIGEgemVyby1sZW5ndGggc3RyaW5nIHRvCj4gaGFzaAo+IAo+IGtlcm5lbCBC
VUcgYXQga2VybmVsL2RtYS9zd2lvdGxiLmM6NDc1IQo+IEludGVybmFsIGVycm9yOiBPb3BzIC0g
QlVHOiAwIFsjMV0gUFJFRU1QVCBTTVAKPiBNb2R1bGVzIGxpbmtlZCBpbjoKPiBDUFU6IDIgUElE
OiAxODIzIENvbW06IGNyeXB0b21ncl90ZXN0IE5vdCB0YWludGVkIDQuMjAuMC1yYzEtMDAxMDgt
ZzAwYzlmZTM3YTdmMiAjMQo+IEhhcmR3YXJlIG5hbWU6IExTMTA0NkEgUkRCIEJvYXJkIChEVCkK
PiBwc3RhdGU6IDgwMDAwMDA1IChOemN2IGRhaWYgLVBBTiAtVUFPKQo+IHBjIDogc3dpb3RsYl90
YmxfbWFwX3NpbmdsZSsweDE3MC8weDJiOAo+IGxyIDogc3dpb3RsYl9tYXBfcGFnZSsweDEzNC8w
eDFmOAo+IHNwIDogZmZmZjAwMDAwZjc5YjhmMAo+IHgyOTogZmZmZjAwMDAwZjc5YjhmMCB4Mjg6
IDAwMDAwMDAwMDAwMDAwMDAKPiB4Mjc6IGZmZmYwMDAwMDkzZDAwMDAgeDI2OiAwMDAwMDAwMDAw
MDAwMDAwCj4geDI1OiAwMDAwMDAwMDAwMWYzZmZlIHgyNDogMDAwMDAwMDAwMDIwMDAwMAo+IHgy
MzogMDAwMDAwMDAwMDAwMDAwMCB4MjI6IDAwMDAwMDA5ZjJjNTM4YzAKPiB4MjE6IGZmZmY4MDA5
NzBhZWI0MTAgeDIwOiAwMDAwMDAwMDAwMDAwMDAxCj4geDE5OiBmZmZmODAwOTcwYWViNDEwIHgx
ODogMDAwMDAwMDAwMDAwMDAwNwo+IHgxNzogMDAwMDAwMDAwMDAwMDAwZSB4MTY6IDAwMDAwMDAw
MDAwMDAwMDEKPiB4MTU6IDAwMDAwMDAwMDAwMDAwMTkgeDE0OiBjMzJjYjgyMThhMTY3ZmU4Cj4g
eDEzOiBmZmZmZmZmZjAwMDAwMDAwIHgxMjogZmZmZjgwMDk3ZmRhZTM0OAo+IHgxMTogMDAwMDgw
MDk3NmJjYTAwMCB4MTA6IDAwMDAwMDAwMDAwMDAwMTAKPiB4OSA6IDAwMDAwMDAwMDAwMDAwMDAg
eDggOiBmZmZmMDAwMDA5MWZkNmM4Cj4geDcgOiAwMDAwMDAwMDAwMDAwMDAwIHg2IDogMDAwMDAw
MDlmMmM1MzhiZgo+IHg1IDogMDAwMDAwMDAwMDAwMDAwMCB4NCA6IDAwMDAwMDAwMDAwMDAwMDEK
PiB4MyA6IDAwMDAwMDAwMDAwMDAwMDAgeDIgOiAwMDAwMDAwOWYyYzUzOGMwCj4geDEgOiAwMDAw
MDAwMGY5ZmZmMDAwIHgwIDogMDAwMDAwMDAwMDAwMDAwMAo+IFByb2Nlc3MgY3J5cHRvbWdyX3Rl
c3QgKHBpZDogMTgyMywgc3RhY2sgbGltaXQgPSAweChfX19fcHRydmFsX19fXykpCj4gQ2FsbCB0
cmFjZToKPiAgc3dpb3RsYl90YmxfbWFwX3NpbmdsZSsweDE3MC8weDJiOAo+ICBzd2lvdGxiX21h
cF9wYWdlKzB4MTM0LzB4MWY4Cj4gIGFoYXNoX2ZpbmFsX25vX2N0eCsweGM0LzB4NmNjCj4gIGFo
YXNoX2ZpbmFsKzB4MTAvMHgxOAo+ICBjcnlwdG9fYWhhc2hfb3ArMHgzMC8weDg0Cj4gIGNyeXB0
b19haGFzaF9maW5hbCsweDE0LzB4MWMKPiAgX190ZXN0X2hhc2grMHg1NzQvMHhlMGMKPiAgdGVz
dF9oYXNoKzB4MjgvMHg4MAo+ICBfX2FsZ190ZXN0X2hhc2grMHg4NC8weGQwCj4gIGFsZ190ZXN0
X2hhc2grMHg3OC8weDE0NAo+ICBhbGdfdGVzdC5wYXJ0LjMwKzB4MTJjLzB4MmI0Cj4gIGFsZ190
ZXN0KzB4M2MvMHg2OAo+ICBjcnlwdG9tZ3JfdGVzdCsweDQ0LzB4NGMKPiAga3RocmVhZCsweGZj
LzB4MTI4Cj4gIHJldF9mcm9tX2ZvcmsrMHgxMC8weDE4Cj4gQ29kZTogZDM0YmZjMTggMmExYTAz
ZjcgMWE5Zjg2OTQgMzVmZmY4OWEgKGQ0MjEwMDAwKQo+IAo+IENjOiA8c3RhYmxlQHZnZXIua2Vy
bmVsLm9yZz4KPiBTaWduZWQtb2ZmLWJ5OiBBeW1lbiBTZ2hhaWVyIDxheW1lbi5zZ2hhaWVyQG54
cC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogSG9yaWEgR2VhbnTEgyA8aG9yaWEuZ2VhbnRhQG54cC5j
b20+CgpQYXRjaCBhcHBsaWVkLiAgVGhhbmtzLgotLSAKRW1haWw6IEhlcmJlcnQgWHUgPGhlcmJl
cnRAZ29uZG9yLmFwYW5hLm9yZy5hdT4KSG9tZSBQYWdlOiBodHRwOi8vZ29uZG9yLmFwYW5hLm9y
Zy5hdS9+aGVyYmVydC8KUEdQIEtleTogaHR0cDovL2dvbmRvci5hcGFuYS5vcmcuYXUvfmhlcmJl
cnQvcHVia2V5LnR4dAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtYXJtLWtlcm5lbAo=
