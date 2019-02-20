Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1E3C10F01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:49:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E0C52089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pr9KMyeK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E0C52089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KIYewbY+bHcvByzj8+Q61naVo+7mi7651EB3WzZpNC0=; b=pr9KMyeKGllw5h
	pCancR6e/PTpb+YmjlSlSlhwWf+1BpAbcK3aHnXG+SfSpI/Ty9+xITN6j/SMJLMM0NW7r9v2bhIrF
	hKdudyvavL5Tfnl23rDZfb2obeiOFR4uneOnPKvc3hA6xfuS7SsgeyNII9abYGWQxIViI6keLjzM/
	0ugbESDEcvZtWEEm0eHx7+t0oy1kAiGyMqU/zOHN2GjZIxnVsYV3X22uQF+K8c5bc2DnPcQ8eKmmY
	ur4PvSH8RAb74xmImSKSDswidFpMBhOnTEcOQRUxzvwMsJ5lEV3ae0Gi7J7cHGaFybBrhGjDnAu+x
	tpjiWHQslVE7jtgK6v6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwOV4-0005hE-5A; Wed, 20 Feb 2019 09:49:10 +0000
Received: from relay12.mail.gandi.net ([217.70.178.232])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwOUq-0005SB-Eo
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 09:48:58 +0000
Received: from localhost (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr
 [90.88.23.190]) (Authenticated sender: thomas.petazzoni@bootlin.com)
 by relay12.mail.gandi.net (Postfix) with ESMTPSA id 77F8B200012;
 Wed, 20 Feb 2019 09:48:53 +0000 (UTC)
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pci@vger.kernel.org
Subject: [PATCH 2/2] PCI: pci-bridge-emul: Extend pci_bridge_emul_init() with
 flags
Date: Wed, 20 Feb 2019 10:48:41 +0100
Message-Id: <20190220094841.11129-3-thomas.petazzoni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220094841.11129-1-thomas.petazzoni@bootlin.com>
References: <20190220094841.11129-1-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_014856_783149_B9872C79 
X-CRM114-Status: GOOD (  12.93  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King <linux@arm.linux.org.uk>,
 Jason Cooper <jason@lakedaemon.net>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Leigh Brown <leigh@solinno.co.uk>,
 =?UTF-8?q?Lu=C3=ADs=20Mendes?= <luis.p.mendes@gmail.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

RGVwZW5kaW5nIG9uIHRoZSBjYXBhYmlsaXRpZXMgb2YgdGhlIFBDSSBjb250cm9sbGVyL3BsYXRm
b3JtLCB0aGUKUENJLXRvLVBDSSBicmlkZ2UgZW11bGF0aW9uIGJlaGF2aW9yIG1pZ2h0IG5lZWQg
dG8gYmUgZGlmZmVyZW50LiBGb3IKZXhhbXBsZSwgb24gcGxhdGZvcm1zIHRoYXQgdXNlIHRoZSBw
Y2ktbXZlYnUgY29kZSwgd2UgY3VycmVudGx5IGRvbid0CnN1cHBvcnQgcHJlZmV0Y2hhYmxlIG1l
bW9yeSBCQVJzLCBzbyB0aGUgY29ycmVzcG9uZGluZyBmaWVsZHMgaW4gdGhlClBDSS10by1QQ0kg
YnJpZGdlIGNvbmZpZ3VyYXRpb24gc3BhY2Ugc2hvdWxkIGJlIHJlYWQtb25seS4KClRvIGltcGxl
bWVudCB0aGlzLCB0aGlzIGNvbW1pdCBleHRlbmRzIHBjaV9icmlkZ2VfZW11bF9pbml0KCkgdG8g
dGFrZQphICJmbGFncyIgYXJndW1lbnQsIHdpdGggY3VycmVudGx5IG9uZSBmbGFnIHN1cHBvcnRl
ZDoKUENJX0JSSURHRV9FTVVMX05PX1BSRUZFVENIQUJMRV9CQVIsIHRoYXQgd2lsbCBtYWtlIHRo
ZSBwcmVmZXRjaGFibGUKbWVtb3J5IGJhc2UgYW5kIGxpbWl0IHJlZ2lzdGVycyByZWFkLW9ubHku
CgpUaGUgcGNpLW12ZWJ1IGFuZCBwY2ktYWFyZHZhcmsgZHJpdmVycyBhcmUgdXBkYXRlZCBhY2Nv
cmRpbmdseS4KClJlcG9ydGVkLWJ5OiBMdcOtcyBNZW5kZXMgPGx1aXMucC5tZW5kZXNAZ21haWwu
Y29tPgpSZXBvcnRlZC1ieTogTGVpZ2ggQnJvd24gPGxlaWdoQHNvbGlubm8uY28udWs+CkNjOiBM
dcOtcyBNZW5kZXMgPGx1aXMucC5tZW5kZXNAZ21haWwuY29tPgpDYzogTGVpZ2ggQnJvd24gPGxl
aWdoQHNvbGlubm8uY28udWs+CkZpeGVzOiAxZjA4NjczZWVmMTIzICgiUENJOiBtdmVidTogQ29u
dmVydCB0byBQQ0kgZW11bGF0ZWQgYnJpZGdlIGNvbmZpZyBzcGFjZSIpClNpZ25lZC1vZmYtYnk6
IFRob21hcyBQZXRhenpvbmkgPHRob21hcy5wZXRhenpvbmlAYm9vdGxpbi5jb20+Ci0tLQogZHJp
dmVycy9wY2kvY29udHJvbGxlci9wY2ktYWFyZHZhcmsuYyB8IDIgKy0KIGRyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvcGNpLW12ZWJ1LmMgICAgfCAyICstCiBkcml2ZXJzL3BjaS9wY2ktYnJpZGdlLWVt
dWwuYyAgICAgICAgIHwgOCArKysrKysrLQogZHJpdmVycy9wY2kvcGNpLWJyaWRnZS1lbXVsLmgg
ICAgICAgICB8IDcgKysrKysrLQogNCBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpLWFh
cmR2YXJrLmMgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaS1hYXJkdmFyay5jCmluZGV4IDc1
MDA4MWMxY2I0OC4uNmVlY2FlNDQ3YWYzIDEwMDY0NAotLS0gYS9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL3BjaS1hYXJkdmFyay5jCisrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpLWFhcmR2
YXJrLmMKQEAgLTQ5OSw3ICs0OTksNyBAQCBzdGF0aWMgdm9pZCBhZHZrX3N3X3BjaV9icmlkZ2Vf
aW5pdChzdHJ1Y3QgYWR2a19wY2llICpwY2llKQogCWJyaWRnZS0+ZGF0YSA9IHBjaWU7CiAJYnJp
ZGdlLT5vcHMgPSAmYWR2a19wY2lfYnJpZGdlX2VtdWxfb3BzOwogCi0JcGNpX2JyaWRnZV9lbXVs
X2luaXQoYnJpZGdlKTsKKwlwY2lfYnJpZGdlX2VtdWxfaW5pdChicmlkZ2UsIDApOwogCiB9CiAK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpLW12ZWJ1LmMgYi9kcml2ZXJz
L3BjaS9jb250cm9sbGVyL3BjaS1tdmVidS5jCmluZGV4IGZhMGZjNDZlZGIwYy4uZDNhMDQxOWU0
MmYyIDEwMDY0NAotLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaS1tdmVidS5jCisrKyBi
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpLW12ZWJ1LmMKQEAgLTU4Myw3ICs1ODMsNyBAQCBz
dGF0aWMgdm9pZCBtdmVidV9wY2lfYnJpZGdlX2VtdWxfaW5pdChzdHJ1Y3QgbXZlYnVfcGNpZV9w
b3J0ICpwb3J0KQogCWJyaWRnZS0+ZGF0YSA9IHBvcnQ7CiAJYnJpZGdlLT5vcHMgPSAmbXZlYnVf
cGNpX2JyaWRnZV9lbXVsX29wczsKIAotCXBjaV9icmlkZ2VfZW11bF9pbml0KGJyaWRnZSk7CisJ
cGNpX2JyaWRnZV9lbXVsX2luaXQoYnJpZGdlLCBQQ0lfQlJJREdFX0VNVUxfTk9fUFJFRkVUQ0hB
QkxFX0JBUik7CiB9CiAKIHN0YXRpYyBpbmxpbmUgc3RydWN0IG12ZWJ1X3BjaWUgKnN5c190b19w
Y2llKHN0cnVjdCBwY2lfc3lzX2RhdGEgKnN5cykKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3Bj
aS1icmlkZ2UtZW11bC5jIGIvZHJpdmVycy9wY2kvcGNpLWJyaWRnZS1lbXVsLmMKaW5kZXggZGQ4
ZDgwNjAzMTdlLi44M2ZiMDc3ZDBiNDEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGNpL3BjaS1icmlk
Z2UtZW11bC5jCisrKyBiL2RyaXZlcnMvcGNpL3BjaS1icmlkZ2UtZW11bC5jCkBAIC0yNjcsNyAr
MjY3LDggQEAgY29uc3Qgc3RhdGljIHN0cnVjdCBwY2lfYnJpZGdlX3JlZ19iZWhhdmlvciBwY2ll
X2NhcF9yZWdzX2JlaGF2aW9yW10gPSB7CiAgKiAodHlwaWNhbGx5IGF0IGxlYXN0IHZlbmRvciwg
ZGV2aWNlLCByZXZpc2lvbiksIHRoZSAtPm9wcyBwb2ludGVyLAogICogYW5kIG9wdGlvbmFsbHkg
LT5kYXRhIGFuZCAtPmhhc19wY2llLgogICovCi1pbnQgcGNpX2JyaWRnZV9lbXVsX2luaXQoc3Ry
dWN0IHBjaV9icmlkZ2VfZW11bCAqYnJpZGdlKQoraW50IHBjaV9icmlkZ2VfZW11bF9pbml0KHN0
cnVjdCBwY2lfYnJpZGdlX2VtdWwgKmJyaWRnZSwKKwkJCSB1bnNpZ25lZCBpbnQgZmxhZ3MpCiB7
CiAJYnJpZGdlLT5jb25mLmNsYXNzX3JldmlzaW9uIHw9IFBDSV9DTEFTU19CUklER0VfUENJIDw8
IDE2OwogCWJyaWRnZS0+Y29uZi5oZWFkZXJfdHlwZSA9IFBDSV9IRUFERVJfVFlQRV9CUklER0U7
CkBAIC0yOTUsNiArMjk2LDExIEBAIGludCBwY2lfYnJpZGdlX2VtdWxfaW5pdChzdHJ1Y3QgcGNp
X2JyaWRnZV9lbXVsICpicmlkZ2UpCiAJCX0KIAl9CiAKKwlpZiAoZmxhZ3MgJiBQQ0lfQlJJREdF
X0VNVUxfTk9fUFJFRkVUQ0hBQkxFX0JBUikgeworCQlicmlkZ2UtPnBjaV9yZWdzX2JlaGF2aW9y
W1BDSV9QUkVGX01FTU9SWV9CQVNFIC8gNF0ucm8gPSB+MDsKKwkJYnJpZGdlLT5wY2lfcmVnc19i
ZWhhdmlvcltQQ0lfUFJFRl9NRU1PUllfQkFTRSAvIDRdLnJ3ID0gMDsKKwl9CisKIAlyZXR1cm4g
MDsKIH0KIApkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcGNpLWJyaWRnZS1lbXVsLmggYi9kcml2
ZXJzL3BjaS9wY2ktYnJpZGdlLWVtdWwuaAppbmRleCBmMDQ2MzdiYjMyMjIuLmU2NWIxYjc5ODk5
ZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9wY2kvcGNpLWJyaWRnZS1lbXVsLmgKKysrIGIvZHJpdmVy
cy9wY2kvcGNpLWJyaWRnZS1lbXVsLmgKQEAgLTExOSw3ICsxMTksMTIgQEAgc3RydWN0IHBjaV9i
cmlkZ2VfZW11bCB7CiAJYm9vbCBoYXNfcGNpZTsKIH07CiAKLWludCBwY2lfYnJpZGdlX2VtdWxf
aW5pdChzdHJ1Y3QgcGNpX2JyaWRnZV9lbXVsICpicmlkZ2UpOworZW51bSB7CisJUENJX0JSSURH
RV9FTVVMX05PX1BSRUZFVENIQUJMRV9CQVIgPSBCSVQoMCksCit9OworCitpbnQgcGNpX2JyaWRn
ZV9lbXVsX2luaXQoc3RydWN0IHBjaV9icmlkZ2VfZW11bCAqYnJpZGdlLAorCQkJIHVuc2lnbmVk
IGludCBmbGFncyk7CiB2b2lkIHBjaV9icmlkZ2VfZW11bF9jbGVhbnVwKHN0cnVjdCBwY2lfYnJp
ZGdlX2VtdWwgKmJyaWRnZSk7CiAKIGludCBwY2lfYnJpZGdlX2VtdWxfY29uZl9yZWFkKHN0cnVj
dCBwY2lfYnJpZGdlX2VtdWwgKmJyaWRnZSwgaW50IHdoZXJlLAotLSAKMi4yMC4xCgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5l
bCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
