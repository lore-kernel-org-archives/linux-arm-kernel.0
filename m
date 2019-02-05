Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1488C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:25:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 823E320818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KDIzu8Ta";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kqQNlbtD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 823E320818
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FzsePN4xkkDx/MXRAohP2c2cGCmQ1Zm6uj5V21mcdZY=; b=KDIzu8TaPX129X8LtpUFh8u70
	XFiXr0dEDOKYzszDLqATaWagn2CRa//woVh2Iw869576uAqe4QycyJRhPAEu3rfmOyNVgOPujjzKI
	cMANSj9M8/93ku0w+RORNkDKjtL1tbJG7u3tWhzCASmjvm3MT0JkUnGnXx+y88MNz9yiTEIZxOyvn
	UDC3T1Pso8fuV5z5ilhBOWC/WXs4hf3W7CWaOVly3gA3fjxplEQI/cYGoDELqvmY4DOD43rOuM/JF
	cJMaQdIucoKSXig75WcLcqQMOPqfhf5OZDXcpAZuNG1cmYq878ykbOj0aw5VgmgL5Y17Kmg9mxIvV
	pHvmvJdgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqw3F-00048h-Le; Tue, 05 Feb 2019 08:25:53 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqw3C-00048O-LK
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 08:25:52 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x158PktV054017;
 Tue, 5 Feb 2019 02:25:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1549355146;
 bh=apsimjGOulbG5cd0suNZuc2Hq0fT7VdOYLfT/vjrt5I=;
 h=Subject:From:To:CC:References:Date:In-Reply-To;
 b=kqQNlbtDQ8PDzAvccPmevPAHdm5zP9DTZuXq/lG5V2fIZoPoYprpeVHrhMthUSeHX
 zN35Q/rCCXB0BTsPUnR3ZfdxD+eN0WZd7FDEh0+tl9TRyuJ3J0zO24G3xzIdbiUf+8
 r2/PKT3ppC0Fw5HE83U6nK5v0Oyafx4+DKMBgIfY=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x158PkuE126744
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 5 Feb 2019 02:25:46 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 5
 Feb 2019 02:25:44 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 5 Feb 2019 02:25:44 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x158Pf8Z015976;
 Tue, 5 Feb 2019 02:25:42 -0600
Subject: Re: [PATCH 1/3] dt-bindings: clock: ti,sci-clk: Add support for
 parsing clock info from DT
From: Tero Kristo <t-kristo@ti.com>
To: Rob Herring <robh@kernel.org>
References: <1546954223-9738-1-git-send-email-t-kristo@ti.com>
 <1546954223-9738-2-git-send-email-t-kristo@ti.com>
 <20190121210449.GB7851@bogus> <7ce7bd25-b5c4-f99d-fda6-0f21376f2204@ti.com>
Message-ID: <ab8707fb-e632-5be9-9fdb-4b1fb3cb26ba@ti.com>
Date: Tue, 5 Feb 2019 10:25:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <7ce7bd25-b5c4-f99d-fda6-0f21376f2204@ti.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_002550_798733_92C8D5B4 
X-CRM114-Status: GOOD (  24.24  )
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
Cc: devicetree@vger.kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
 ssantosh@kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMjIvMDEvMjAxOSAwOTozMywgVGVybyBLcmlzdG8gd3JvdGU6Cj4gT24gMjEvMDEvMjAxOSAy
MzowNCwgUm9iIEhlcnJpbmcgd3JvdGU6Cj4+IE9uIFR1ZSwgSmFuIDA4LCAyMDE5IGF0IDAzOjMw
OjIxUE0gKzAyMDAsIFRlcm8gS3Jpc3RvIHdyb3RlOgo+Pj4gQnkgZGVmYXVsdCwgdGhlIGF2YWls
YWJsZSBjbG9jayBpbmZvIGlzIHF1ZXJpZWQgZnJvbSBmaXJtd2FyZSwgd2hpY2ggY2FuCj4+PiBi
ZSBxdWl0ZSBhIGxlbmd0aHkgb3BlcmF0aW9uIGlmIHRoZXJlIGlzIGEgdmVyeSBsYXJnZSBhbW91
bnQgb2YgY2xvY2tzCj4+PiBhdmFpbGFibGUuIEFkZCBvcHRpb24gZm9yIHBhcnNpbmcgdGhlIHVz
ZWQgY2xvY2tzIGZyb20gRFQgaW5zdGVhZCwgYW5kCj4+PiBvbmx5IHJlZ2lzdGVyIHRoZXNlIHdo
aWNoIGNhbiBpbXByb3ZlIHRoZSBib290IHRpbWUgb2YgdGhlIGRldmljZSBxdWl0ZQo+Pj4gYSBs
b3QuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogVGVybyBLcmlzdG8gPHQta3Jpc3RvQHRpLmNvbT4K
Pj4+IC0tLQo+Pj4gwqAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL3Rp
LHNjaS1jbGsudHh0IHwgNyArKysrKysrCj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRp
b25zKCspCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9jbG9jay90aSxzY2ktY2xrLnR4dCAKPj4+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2Nsb2NrL3RpLHNjaS1jbGsudHh0Cj4+PiBpbmRleCA0ZTU5ZGM2Li5jNzU3YWUx
IDEwMDY0NAo+Pj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2Nr
L3RpLHNjaS1jbGsudHh0Cj4+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvY2xvY2svdGksc2NpLWNsay50eHQKPj4+IEBAIC0xOCw2ICsxOCwxMyBAQCBSZXF1aXJlZCBw
cm9wZXJ0aWVzOgo+Pj4gwqDCoMKgIGFuZCBjbG9ja3MgSURzIGZvciA2NkFLMkcgU29DIGFyZSBk
b2N1bWVudGVkIGF0Cj4+PiDCoMKgwqAgaHR0cDovL3Byb2Nlc3NvcnMud2lraS50aS5jb20vaW5k
ZXgucGhwL1RJU0NJIzY2QUsyRzAyX0RhdGEKPj4+ICtPcHRpb25hbCBwcm9wZXJ0aWVzOgo+Pj4g
Ky0tLS0tLS0tLS0tLS0tLS0tLS0KPj4+ICstIHRpLHNjYW4tY2xvY2tzLWZyb20tZHQ6IFNjYW4g
Y2xvY2sgdHJlZSBpbmZvIGZyb20gRFQuIEJ5IGRlZmF1bHQsCj4+PiArwqAgY2xvY2tzIGFyZSBx
dWVyaWVkIGZyb20gZmlybXdhcmUsIHdoaWNoIGNhbiBiZSByYXRoZXIgc2xvdyBvcGVyYXRpb24s
Cj4+PiArwqAgZXNwZWNpYWxseSBpZiB0aGVyZSBpcyBhIHJlYWxseSBsYXJnZSBudW1iZXIgb2Yg
Y2xvY2tzIGF2YWlsYWJsZSBvdXQKPj4+ICvCoCBvZiB3aGljaCBvbmx5IGEgaGFuZGZ1bCBhcmUg
ZXZlciB1c2VkIGJ5IGtlcm5lbC4KPj4KPj4gQXQgZmlyc3QsIEkgdGhvdWdodCB0aGlzIHdhcyBh
biBlaXRoZXIvb3IgdGhpbmcuIFVzZSBmaXJtd2FyZSBvciB1c2UgRFQsCj4+IGJ1dCBpdCBpcyBy
ZWFsbHkgb25seSBnZXQgdGhlIGNsb2NrcyB1c2VkIGluIHRoZSBEVCBmcm9tIGZpcm13YXJlLgo+
Pgo+PiBXaHkgd291bGRuJ3QgeW91IGp1c3QgYWx3YXlzIGRvIHRoYXQ/IEkgY2FuIHRoaW5rIG9m
IDMgY2FzZXM6Cj4+IHJlcGFyZW50aW5nLCBkZWJ1ZyBhbmQgb3ZlcmxheXMuIFRoaXMgYnJlYWtz
IHJlcGFyZW50aW5nIGFuZCBvdmVybGF5cywKPj4gcmlnaHQ/IERlYnVnIGNvdWxkIGJlIGhhbmRs
ZWQgd2l0aCBzb21lIHVzZXJzcGFjZSB0cmlnZ2VyIHRvIGdldCBhbGwgdGhlCj4+IGNsb2Nrcy4K
PiAKPiBSZS1wYXJlbnRpbmcgdGhpcyBkb2VzIG5vdCBicmVhaywgYXMgdGhlIHNjYW4gc3RpbGwg
Y2hlY2tzIGV2ZXJ5IAo+IHBvc3NpYmxlIHBhcmVudCBvZiBhIGNsb2NrIHNjYW5uZWQuIE92ZXJs
YXlzIGFyZSBicm9rZW4gZm9yIHN1cmUsIGFzIHdlIAo+IGRvbid0IGtub3cgd2hpY2ggb3Zlcmxh
eXMgd2Ugd291bGQgYmUgYXBwbHlpbmcsIGFuZCB3aGF0IGNsb2NrcyB3b3VsZCBiZSAKPiBpbiB0
aGVtLiBEZWJ1ZyBpcyBraW5kIG9mIGJyb2tlbiBhcyB3ZSBvbmx5IHNjYW4gYSBzbWFsbCBwb3J0
aW9uIG9mIHRoZSAKPiBjbG9ja3MuCj4gCj4+Cj4+IFdoeSBzY2FuIGFueSBvZiB0aGUgY2xvY2tz
IHVwIGZyb250PyBXaHkgbm90IGp1c3QgY3JlYXRlIHRoZSBjbG9ja3Mgb24KPj4gZGVtYW5kPyBJ
ZiBhbiB1bmtub3duIGNsb2NrIGlkIGlzIHJlcXVlc3RlZCwgdGhlbiBjcmVhdGUgdGhlIGNsb2Nr
IGFuZAo+PiBxdWVyeSB0aGUgZmlybXdhcmUgYXQgdGhhdCBwb2ludC4gVGhhdCB3b3VsZCBhdm9p
ZCB0aGUgRFQgc2NhbiB0b28uCj4+IE1heWJlIHRoZXJlJ3Mgc29tZSBpc3N1ZXMgaW4gdGhlIGNs
ayBmcmFtZXdvcmsgcHJldmVudGluZyB0aGF0LCBidXQKPj4gdGhhdCdzIG5vdCByZWFsbHkgYSBE
VCBwcm9ibGVtLgo+IAo+IFRoZSB2ZXJ5IGluaXRpYWwgdmVyc2lvbiBJIGRpZCBhIGNvdXBsZSBv
ZiB5ZWFycyBiYWNrLCBkaWQgc2NhbiB0aGUgCj4gY2xvY2tzIGJhc2VkIG9uIG5lZWQsIGFuZCBy
ZWdpc3RlcmVkIHRoZW0gZHluYW1pY2FsbHkuIFN0ZXBoZW4gc2hvdCBkb3duIAo+IHRoaXMgYmFz
ZWQgb24gdGhlIGFzc2Vzc21lbnQgdGhhdCB0aGVyZSBtaWdodCBiZSBsb2NraW5nIGlzc3VlcyB3
aXRoIHRoZSAKPiBjb21tb24gY2xvY2sgZnJhbWV3b3JrIHdpdGggdGhpcyBhcHByb2FjaCBsZWFk
aW5nIGludG8gcG90ZW50aWFsIAo+IGRlYWRsb2NrIHNpdHVhdGlvbnMuCgpTbyBSb2IsIHdoYXQg
aXMgdGhlIGZpbmFsIGNhbGwgb24gdGhpcyBiaW5kaW5nPyBBY2svTkFLPyBJZiBOQUssIHNoYWxs
IEkgCmltcGxlbWVudCBhIGtlcm5lbCBjbWRsaW5lIHBhcmFtIHRvIHNlbGVjdCB0aGUgcGFyc2lu
ZyBtZXRob2Qgb3Igd2hhdCBpcyAKcHJlZmVycmVkPyBEb2luZyBpdCBidWlsZCB0aW1lIHdpdGgg
YSBzaW1wbGUgS2NvbmZpZyBzZWVtcyB0b28gbGltaXRpbmcuCgotVGVybwotLQpUZXhhcyBJbnN0
cnVtZW50cyBGaW5sYW5kIE95LCBQb3Jra2FsYW5rYXR1IDIyLCAwMDE4MCBIZWxzaW5raS4gWS10
dW5udXMvQnVzaW5lc3MgSUQ6IDA2MTU1MjEtNC4gS290aXBhaWtrYS9Eb21pY2lsZTogSGVsc2lu
a2kKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4
LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFy
bS1rZXJuZWwK
