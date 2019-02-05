Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A201EC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:38:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 666C6206DD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qh5PCcp1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 666C6206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sO56ORr/2Qd5Eb8V4L7bjI9GZlHm+k1yqtsx0zFVuh4=; b=qh5PCcp1f2ioP/
	e8Q9wbutcjSJWrjbkWWMZ7I14hyR5erNrwTinKjWkINRx/e2DOx7/C1cyNaR9Xj3zAjOYyhp5P6oP
	xMmo5tr71RAFsczBPBxyuQmoslLEohAlCfbgAN8PEiccOUn6MhyCEaDEhufLKHLMi3NBWfyEiJ3C/
	HToGHqWCwcZnHass1ElMnWsFMhcucgPXhMlDLDJtb8pO9d5Eki6XDyWksZYs/WEhbqzZtmPHNtxQT
	evlcnPfrnolxRibHiKIXM3gBhf0xMr4ppDh2vaPLPY/goX1lNrSW/z6ZTAyJLcexL/9cFQzu+ChAp
	B9BKOTWMxta08nevhlig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr1rO-0003N7-K9; Tue, 05 Feb 2019 14:38:02 +0000
Received: from relay6-d.mail.gandi.net ([217.70.183.198])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr1rK-0003Mj-3J; Tue, 05 Feb 2019 14:37:59 +0000
X-Originating-IP: 90.88.22.177
Received: from xps13 (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr
 [90.88.22.177]) (Authenticated sender: miquel.raynal@bootlin.com)
 by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id B32E3C000B;
 Tue,  5 Feb 2019 14:37:46 +0000 (UTC)
Date: Tue, 5 Feb 2019 15:37:45 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Wen Yang <yellowriver2010@hotmail.com>
Subject: Re: [PATCH v3] mtd: rawnand: atmel: fix possible object reference leak
Message-ID: <20190205153745.45598bc8@xps13>
In-Reply-To: <HK0PR02MB36344D81C6E66666EB60849DB26E0@HK0PR02MB3634.apcprd02.prod.outlook.com>
References: <HK0PR02MB36344D81C6E66666EB60849DB26E0@HK0PR02MB3634.apcprd02.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_063758_288342_D32EA54A 
X-CRM114-Status: GOOD (  12.39  )
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
Cc: "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
 "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
 "richard@nod.at" <richard@nod.at>,
 "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
 "ludovic.desroches@microchip.com" <ludovic.desroches@microchip.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgV2VuLAoKV2VuIFlhbmcgPHllbGxvd3JpdmVyMjAxMEBob3RtYWlsLmNvbT4gd3JvdGUgb24g
VHVlLCA1IEZlYiAyMDE5CjE0OjMyOjQxICswMDAwOgoKPiBvZl9maW5kX2RldmljZV9ieV9ub2Rl
KCkgdGFrZXMgYSByZWZlcmVuY2UgdG8gdGhlIHN0cnVjdCBkZXZpY2UKPiB3aGVuIGl0IGZpbmRz
IGEgbWF0Y2ggdmlhIGdldF9kZXZpY2UsIHRoZXJlIGlzIG5vIG5lZWQgdG8gY2FsbAo+IGdldF9k
ZXZpY2UoKSB0d2ljZS4KPiBXZSBhbHNvIHNob3VsZCBtYWtlIHN1cmUgdG8gZHJvcCB0aGUgcmVm
ZXJlbmNlIHRvIHRoZSBkZXZpY2UKPiB0YWtlbiBieSBvZl9maW5kX2RldmljZV9ieV9ub2RlKCkg
b24gZHJpdmVyIHVuYmluZC4KPiAKPiBGaXhlczogZjg4ZmMxMjJjYzM0ICgibXRkOiBuYW5kOiBD
bGVhbnVwL3Jld29yayB0aGUgYXRtZWxfbmFuZCBkcml2ZXIiKQo+IFNpZ25lZC1vZmYtYnk6IFdl
biBZYW5nIDx5ZWxsb3dyaXZlcjIwMTBAaG90bWFpbC5jb20+Cj4gU3VnZ2VzdGVkLWJ5OiBCb3Jp
cyBCcmV6aWxsb24gPGJicmV6aWxsb25Aa2VybmVsLm9yZz4KPiBSZXZpZXdlZC1ieTogQm9yaXMg
QnJlemlsbG9uIDxiYnJlemlsbG9uQGtlcm5lbC5vcmc+Cj4gUmV2aWV3ZWQtYnk6IE1pcXVlbCBS
YXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+CgpQbGVhc2Ugc3RvcCBhZGRpbmcgIlJl
dmlld2VkLWJ5IiB0YWdzIGZyb20gdXMgaWYgd2UgZGlkIG5vdCB3cml0ZSB0aGVtIQoKPiBBY2tl
ZC1ieTogTWlxdWVsIFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4KPiBDYzogVHVk
b3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPgo+IENjOiBCb3JpcyBCcmV6
aWxsb24gPGJicmV6aWxsb25Aa2VybmVsLm9yZz4KPiBDYzogTWlxdWVsIFJheW5hbCA8bWlxdWVs
LnJheW5hbEBib290bGluLmNvbT4KPiBDYzogUmljaGFyZCBXZWluYmVyZ2VyIDxyaWNoYXJkQG5v
ZC5hdD4KPiBDYzogRGF2aWQgV29vZGhvdXNlIDxkd213MkBpbmZyYWRlYWQub3JnPgo+IENjOiBC
cmlhbiBOb3JyaXMgPGNvbXB1dGVyc2ZvcnBlYWNlQGdtYWlsLmNvbT4KPiBDYzogTWFyZWsgVmFz
dXQgPG1hcmVrLnZhc3V0QGdtYWlsLmNvbT4KPiBDYzogTmljb2xhcyBGZXJyZSA8bmljb2xhcy5m
ZXJyZUBtaWNyb2NoaXAuY29tPgo+IENjOiBBbGV4YW5kcmUgQmVsbG9uaSA8YWxleGFuZHJlLmJl
bGxvbmlAYm9vdGxpbi5jb20+Cj4gQ2M6IEx1ZG92aWMgRGVzcm9jaGVzIDxsdWRvdmljLmRlc3Jv
Y2hlc0BtaWNyb2NoaXAuY29tPgo+IENjOiBsaW51eC1tdGRAbGlzdHMuaW5mcmFkZWFkLm9yZwo+
IENjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKPiBDYzogbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZwo+IC0tLQoKQW5kIGZvciB0aGUgb3RoZXIgcGF0Y2hlcywgcGxl
YXNlIGFwcGVuZCBhIGNoYW5nZWxvZyBleHBsYWluaW5nIHRoZQpldm9sdXRpb25zIG9mIHRoZSBw
YXRjaCB0aHJvdWdoIHRoZSB2ZXJzaW9ucyBiZWxvdyB0aGUgdGhyZWUgZGFzaGVzCictLS0nLgoK
ClRoYW5rcywKTWlxdcOobAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtYXJtLWtlcm5lbAo=
