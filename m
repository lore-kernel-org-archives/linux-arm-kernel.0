Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99D9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 23:23:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70EFB217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 23:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UFWiZOgr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9uPPvzl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70EFB217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:Message-ID:References:To:
	Subject:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s8/3rkhuo4Wy4C0bBQMEDUVobgcANLnK9I7LM+23O64=; b=UFWiZOgr0sT0zQ
	1gLJSbfiFLse8Qjt/gqjg/YrAB0vdDh5HOQ3lkdkJD9Ik7zLolpHpIhuZMpaPh33fMZ2uhERfabhe
	xAlvMK/ybj1EvVu+8cYJhrgvRQZ4iZRhQPTxUuDzjLxFG61DM0+/SyjCs0c3rIDuPI6lgzRulVS4o
	j1NDw2zuS0zmrIU95WdbxJUFzWJblQT0l94WtpS4XeVbtR8DcSYF+rmhPATcgNovCdl4vs9at31n0
	wUGCF2k2ZeEfXPqRQQfVlf4+ZNb3rWyXPmgvOG7S3bf6xkeAlhl7UVYS1lRSTZiHRZfN61ZwwC1Qy
	iDYk/mvOsQkwzQj9jfFw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ2E5-0002aH-Hq; Mon, 17 Dec 2018 23:23:05 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ2E1-0002WM-SB
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 23:23:03 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 14BB3217D9;
 Mon, 17 Dec 2018 23:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545088971;
 bh=Pbkn77VnmHy+IrCyan//pg8ndlbcTqyxPTXl+/bE+ng=;
 h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
 b=L9uPPvzlx90iEhF7IoX9wZ8maK3sNPOXJdiIdMmnyGyNFpPALy+6p7fNLERy+pLq1
 fuvabFRVGxmcGxpG9aSJIQzsL8oAhyE3qyDZsv9lWfx4Ur0Y5uNlb82bzn+YUI7zUH
 4uMkWvl7pzZqDX5Kq/qosRPV+7bSPUkYv5e2FdPs=
MIME-Version: 1.0
In-Reply-To: <772b3869cc992d894d8c1b4296f21100bcbed30d.1545075103.git.mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH] clk: at91: optimize clk_round_rate() for AUDIO_PLL
To: Michał Mirosław <mirq-linux@rere.qmqm.pl>, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
References: <772b3869cc992d894d8c1b4296f21100bcbed30d.1545075103.git.mirq-linux@rere.qmqm.pl>
Message-ID: <154508897026.19322.14961293619238289668@swboyd.mtv.corp.google.com>
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Date: Mon, 17 Dec 2018 15:22:50 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_152301_926921_F1E60B0C 
X-CRM114-Status: GOOD (  12.62  )
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
Cc: Michael Turquette <mturquette@baylibre.com>,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

UXVvdGluZyBNaWNoYcWCIE1pcm9zxYJhdyAoMjAxOC0xMi0xNyAxMTozNzowNSkKPiBUaGlzIG1h
a2VzIGZvciAzIGNsa19yb3VuZF9yYXRlKCkgY2FsbHMgaW5zdGVhZCBvZiA2NCBvZiB0aGVtIG9u
Cj4gU0FNQTVEMi1iYXNlZCBib2FyZCB3aGVuIHNlYXJjaGluZyBmb3IgMTIuMjg4TUh6IGNsb2Nr
LgoKT2ssIGJ1dCBpcyB0aGF0IGJldHRlcj8gV29yc2U/IENhbiB5b3UgbW9yZSBjbGVhcmx5IGRl
c2NyaWJlIHdoYXQgeW91J3JlCmRvaW5nIGhlcmU/IEFuZCBpdCdzIG5vdCBicmVha2luZyBzb21l
IG90aGVyIGNvcm5lciBjYXNlPwoKPiAKPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYVx1MDE0MiBNaXJv
c1x1MDE0MmF3IDxtaXJxLWxpbnV4QHJlcmUucW1xbS5wbD4KClRoaXMgZ290IGFsbCBicm9rZW4u
IFNvbWV0aGluZyBvbiB5b3VyIGVuZD8KCj4gLS0tCj4gIGRyaXZlcnMvY2xrL2F0OTEvY2xrLWF1
ZGlvLXBsbC5jIHwgOCArKysrKysrLQo+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2F0OTEvY2xrLWF1
ZGlvLXBsbC5jIGIvZHJpdmVycy9jbGsvYXQ5MS9jbGstYXVkaW8tcGxsLmMKPiBpbmRleCAzNmQ3
NzE0NmEzYmQuLjNhMzU4MjgyNzg0ZSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2Nsay9hdDkxL2Ns
ay1hdWRpby1wbGwuYwo+ICsrKyBiL2RyaXZlcnMvY2xrL2F0OTEvY2xrLWF1ZGlvLXBsbC5jCj4g
QEAgLTM0MCw3ICszNDAsMTEgQEAgc3RhdGljIGxvbmcgY2xrX2F1ZGlvX3BsbF9wbWNfcm91bmRf
cmF0ZShzdHJ1Y3QgY2xrX2h3ICpodywgdW5zaWduZWQgbG9uZyByYXRlLAo+ICAgICAgICAgcHJf
ZGVidWcoIkEgUExML1BNQzogJXMsIHJhdGUgPSAlbHUgKHBhcmVudF9yYXRlID0gJWx1KVxuIiwg
X19mdW5jX18sCj4gICAgICAgICAgICAgICAgICByYXRlLCAqcGFyZW50X3JhdGUpOwo+ICAKPiAt
ICAgICAgIGZvciAoZGl2ID0gMTsgZGl2IDw9IEFVRElPX1BMTF9RRFBNQ19NQVg7IGRpdisrKSB7
Cj4gKyAgICAgICBpZiAoIXJhdGUpCj4gKyAgICAgICAgICAgICAgIHJldHVybiAwOwo+ICsKPiAr
ICAgICAgIGJlc3RfcGFyZW50X3JhdGUgPSBjbGtfcm91bmRfcmF0ZShwY2xrLT5jbGssIDEpOwo+
ICsgICAgICAgZm9yIChkaXYgPSBtYXgoYmVzdF9wYXJlbnRfcmF0ZSAvIHJhdGUsIDF1bCk7IGRp
diA8PSBBVURJT19QTExfUURQTUNfTUFYOyBkaXYrKykgewoKTml0cGljazogU3R5bGUgaXMgdXN1
YWxseSAxVUwgaW5zdGVhZCBvZiBsb3dlcmNhc2UgMXVsLgoKPiAgICAgICAgICAgICAgICAgYmVz
dF9wYXJlbnRfcmF0ZSA9IGNsa19yb3VuZF9yYXRlKHBjbGstPmNsaywgcmF0ZSAqIGRpdik7Cj4g
ICAgICAgICAgICAgICAgIHRtcF9yYXRlID0gYmVzdF9wYXJlbnRfcmF0ZSAvIGRpdjsKPiAgICAg
ICAgICAgICAgICAgdG1wX2RpZmYgPSBhYnMocmF0ZSAtIHRtcF9yYXRlKTsKPiBAQCAtMzUwLDYg
KzM1NCw4IEBAIHN0YXRpYyBsb25nIGNsa19hdWRpb19wbGxfcG1jX3JvdW5kX3JhdGUoc3RydWN0
IGNsa19odyAqaHcsIHVuc2lnbmVkIGxvbmcgcmF0ZSwKPiAgICAgICAgICAgICAgICAgICAgICAg
ICBiZXN0X3JhdGUgPSB0bXBfcmF0ZTsKPiAgICAgICAgICAgICAgICAgICAgICAgICBiZXN0X2Rp
ZmYgPSB0bXBfZGlmZjsKPiAgICAgICAgICAgICAgICAgICAgICAgICB0bXBfcWQgPSBkaXY7Cj4g
KyAgICAgICAgICAgICAgICAgICAgICAgaWYgKCFiZXN0X2RpZmYpCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBicmVhazsgIC8qIGdvdCBleGFjdCBtYXRjaCAqLwoKU2VlbXMgc2Vu
c2libGUgdG8gYnJlYWsgaW1tZWRpYXRlbHkgaWYgZXhhY3QgbWF0Y2ggaXMgZm91bmQuCmAKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1r
ZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJu
ZWwK
