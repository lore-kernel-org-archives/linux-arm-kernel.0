Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA62C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:25:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0CDC218A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rY/GQK14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0CDC218A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=eyGEoHvYIfp+57Ux+YlwA22/pKjzCmXq7FqsrndP3rM=; b=rY/GQK14HLgT7j
	qKpC0cbuQkWd4wwp3Rvc7U6eOFbdv2L93ZlK1FYIrBY+YE+sfm+LWxhR4RdC0DgbXUAM5zkCD0NCi
	qrIxuOToiE1VhQc56s5BV8b4IPY2wU/k2q9hyB90bfl4hwzOlZFDCn6v/avmiZTLUHCN9qbjPxqYd
	KLpkraw6HVhI1HD+xQkiTbHEvXKBnPLvWPGmmaI8VhRvZ2dqUyHdUVNYR5AvexXkiGqUWY6M3RiuJ
	yIO1dkTqiJL4lojimFZJbPxaK+XkXgIlAvYjVUtEIm/Ir6vUCgIgg3ZuJaMSIARSnPDB+5gcF/Xm5
	ajxtklsVAlHEV4OHtqFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gguBd-0000tK-Sd; Tue, 08 Jan 2019 16:25:05 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gguBK-0000aW-8a
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 16:24:48 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 1325D209D7; Tue,  8 Jan 2019 17:24:45 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr [90.88.163.241])
 by mail.bootlin.com (Postfix) with ESMTPSA id A4EDE207A3;
 Tue,  8 Jan 2019 17:24:44 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 00/15] Bring suspend to RAM support to PCIe Aardvark driver
Date: Tue,  8 Jan 2019 17:24:25 +0100
Message-Id: <20190108162441.5278-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_082446_613242_C0CD14C8 
X-CRM114-Status: GOOD (  16.38  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Antoine Tenart <antoine.tenart@bootlin.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGVsbG8sCgpBcyBwYXJ0IG9mIGFuIGVmZm9ydCB0byBicmluZyBzdXNwZW5kIHRvIFJBTSBzdXBw
b3J0IHRvIEFybWFkYSAzNzAwClNvQ3MgKG1haW4gdGFyZ2V0OiBFU1BSRVNTT2JpbiksIHRoaXMg
c2VyaWVzIGhhbmRsZXMgdGhlIHdvcmsgYXJvdW5kCnRoZSBQQ0llIElQLgoKRmlyc3QsIG1vcmUg
Y29uZmlndXJhdGlvbiBpcyBkb25lIGluIHRoZSAnc2V0dXAnIGhlbHBlciBhcyBpbnNwaXJlZApm
cm9tIHRoZSBVLUJvb3QgZHJpdmVyLiBUaGlzIGlzIG5lZWRlZCB0byBlbnRpcmVseSBpbml0aWFs
aXplIHRoZSBJUApkdXJpbmcgZnV0dXJlIHJlc3VtZSBvcGVyYXRpb24gKHBhdGNoIDEpLgoKVGhl
biwgcmVzZXQgR1BJTywgUEhZIGFuZCBjbG9jayBzdXBwb3J0IGFyZSBpbnRyb2R1Y2VkIChwYXRj
aCAyLTQpLiBBcwpjdXJyZW50IGRldmljZSB0cmVlcyBkbyBub3QgcHJvdmlkZSB0aGUgY29ycmVz
cG9uZGluZyBwcm9wZXJ0aWVzLCBub3QKZmluZGluZyBvbmUgb2YgdGhlc2UgcHJvcGVydGllcyBp
cyBub3QgYW4gZXJyb3IgYW5kIGp1c3QgcHJvZHVjZXMgYQp3YXJuaW5nLiBIb3dldmVyLCBpZiB0
aGUgcHJvcGVydHkgaXMgcHJlc2VudCwgYW4gZXJyb3IgZHVyaW5nIFBIWQppbml0aWFsaXphdGlv
biB3aWxsIGZhaWwgdGhlIHByb2JlIG9mIHRoZSBkcml2ZXIuCgpOb3RlOiBUbyBiZSBzdXJlIHRo
ZSBjbG9jayB3aWxsIGJlIHJlc3VtZWQgYmVmb3JlIHRoaXMgZHJpdmVyLCBhIGZpcnN0CnNlcmll
cyBhZGRpbmcgbGlua3MgYmV0d2VlbiBjbG9ja3MgYW5kIGNvbnN1bWVycyBoYXMgYmVlbiBzdWJt
aXR0ZWQsCnNlZSBbMV0uIEFueXdheSwgaGF2aW5nIHRoZSBjbG9jayBzZXJpZXMgYXBwbGllZCBm
aXJzdCBpcyBub3QgbmVlZGVkLgoKUGF0Y2ggNSBhZGRzIHN1c3BlbmQvcmVzdW1lIGhvb2tzLCBy
ZS11c2luZyBhbGwgdGhlIGFib3ZlLgoKRmluYWxseSwgYmluZGluZ3MgYW5kIGRldmljZSB0cmVl
cyBhcmUgdXBkYXRlZCB0byByZWZsZWN0IHRoZSBoYXJkd2FyZQoocGF0Y2ggNi0xMikuIFdoaWxl
IHRoZSBjbG9jayBkZXBlbmRzIG9uIHRoZSBTb0MsIHRoZSByZXNldCBHUElPIGFuZAp0aGUgUEhZ
IGRlcGVuZHMgb24gdGhlIGJvYXJkIHNvIHRoZSBjbG9jayBpcyBhZGRlZCBpbiB0aGUKYXJtYWRh
LTM3eHguZHRzaSBmaWxlIHdoaWxlIHRoZSB0d28gb3RoZXIgcHJvcGVydGllcyBhcmUgYWRkZWQg
aW4KYXJtYWRhLTM3MjAtZXNwcmVzc29iaW4uZHRzLgoKWzFdIGh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL3BpcGVybWFpbC9saW51eC1hcm0ta2VybmVsLzIwMTktSmFudWFyeS82MjM4ODUuaHRt
bAoKVGhhbmtzLApNaXF1w6hsCgoKQ2hhbmdlcyBzaW5jZSB2MjoKPT09PT09PT09PT09PT09PT0K
KiBNaW5vciBwYXRjaGVzIHJlb3JkZXJpbmcuCiogQWRkZWQgcGluY3RybCBwYXRjaGVzIGZyb20g
R3JlZ29yeSBDbGVtZW50IGZpeGluZyB0aGUgUENJZSBwaW5zLiBIaXMKICBjaGFuZ2VzIGltcGxp
ZWQgbW9kaWZpY2F0aW9ucyBpbiB0aGUgRFQvYmluZGluZ3MgcGF0Y2hlcyBhZGRpbmcgUENJZQog
IHJlc2V0IHBpbiBzdXBwb3J0LgoqIEFkZGVkIGEgbmV3IHBhdGNoIHRoYXQgZW5sYXJnZXMgdGhl
IFBJTyB0aW1lb3V0IG9mIHRoZSBkcml2ZXIKICAoZXhwbGFuYXRpb25zIGluIHRoZSBjb21taXQg
bG9nKS4KKiBXaXRoIHRoZSB0aW1lb3V0IGNoYW5nZWQsIHJlbW92ZWQgdGhlICJleHBlcmltZW50
YWwgZGVsYXkiIHRoYXQgd2FzCiAgbmVlZGVkIGF0IHJlc3VtZSB0aW1lIGJlZm9yZSBhY2Nlc3Np
bmcgYW55IHJlZ2lzdGVyLgoKQ2hhbmdlcyBzaW5jZSB2MToKPT09PT09PT09PT09PT09PT0KKiBD
aGFuZ2UgdGhlIGNhcGl0YWxpemF0aW9uIGluIGNvbW1pdCB0aXRsZXMgdG8gZm9sbG93IHRoZSBQ
Q0kKICBzdWJzeXN0ZW0gcnVsZXMuCiogQWRkZWQgU3VnZ2VzdGVkLWJ5IHRhZyB0byB0aGUgcGF0
Y2ggYWRkaW5nIFBIWSBzdXBwb3J0IGFuZCB0byB0aGUKICBwYXRjaCBhZGRpbmcgdGhlIFBIWSBw
cm9wZXJ0eSBpbiB0aGUgRFQuCiogQWRkZWQgUm9iJ3MgUmV2aWV3ZWQtYnkgdGFncyBvbiBiaW5k
aW5ncy4KKiBJIGFtIGZvbGxvd2luZyB0aGUgZGlzY3Vzc2lvbiBhYm91dCBjYWxsaW5nIGZ1bmN0
aW9ucyB0aGF0IG1pZ2h0CiAgc2xlZXAgaW4gYSBOT0lSUSBjb250ZXh0LiBBcyB0aGVyZSBpcyBu
byByZWFsIHByb2JsZW0geWV0IChhcyBwZXIgbXkKICB1bmRlcnN0YW5kaW5nKSwgSSBkaWQgbm90
IGNoYW5nZSBhbnl0aGluZyBvbiB0aGlzIHJlZ2FyZC4KCgpNaXF1ZWwgUmF5bmFsICgxNSk6CiAg
UENJOiBhYXJkdmFyazogRW5sYXJnZSBQSU8gdGltZW91dAogIFBDSTogYWFyZHZhcms6IENvbmZp
Z3VyZSBtb3JlIHJlZ2lzdGVycyBpbiB0aGUgY29uZmlndXJhdGlvbiBoZWxwZXIKICBQQ0k6IGFh
cmR2YXJrOiBBZGQgY2xvY2sgc3VwcG9ydAogIFBDSTogYWFyZHZhcms6IEFkZCBQSFkgc3VwcG9y
dAogIFBDSTogYWFyZHZhcms6IEFkZCBQQ0llIHdhcm0gcmVzZXQgc3VwcG9ydAogIFBDSTogYWFy
ZHZhcms6IEFkZCBleHRlcm5hbCByZXNldCBHUElPIHN1cHBvcnQKICBQQ0k6IGFhcmR2YXJrOiBB
ZGQgc3VzcGVuZCB0byBSQU0gc3VwcG9ydAogIGR0LWJpbmRpbmdzOiBQQ0k6IGFhcmR2YXJrOiBE
ZXNjcmliZSB0aGUgY2xvY2tzIHByb3BlcnR5CiAgZHQtYmluZGluZ3M6IFBDSTogYWFyZHZhcms6
IERlc2NyaWJlIHRoZSBQSFkgcHJvcGVydHkKICBkdC1iaW5kaW5nczogUENJOiBhYXJkdmFyazog
RGVzY3JpYmUgdGhlIFBDSWUgZW5kcG9pbnQgY2FyZCByZXNldCBwaW5zCiAgZHQtYmluZGluZ3M6
IFBDSTogYWFyZHZhcms6IERlc2NyaWJlIHRoZSByZXNldC1ncGlvcyBwcm9wZXJ0eQogIEFSTTY0
OiBkdHM6IG1hcnZlbGw6IGFybWFkYS0zN3h4OiBkZWNsYXJlIFBDSWUgY2xvY2sKICBBUk02NDog
ZHRzOiBtYXJ2ZWxsOiBhcm1hZGEtMzcyMC1lc3ByZXNzb2JpbjogZGVjbGFyZSBQQ0llIFBIWQog
IEFSTTY0OiBkdHM6IG1hcnZlbGw6IGFybWFkYS0zN3h4OiBkZWNsYXJlIFBDSWUgcmVzZXQgcGlu
CiAgQVJNNjQ6IGR0czogbWFydmVsbDogYXJtYWRhLTM3MjAtZXNwcmVzc29iaW46IGRlY2xhcmUg
UENJZSB3YXJtIHJlc2V0CiAgICBwaW4KCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvYWFy
ZHZhcmstcGNpLnR4dCAgfCAgMTQgKysKIC4uLi9kdHMvbWFydmVsbC9hcm1hZGEtMzcyMC1lc3By
ZXNzb2Jpbi5kdHMgICB8ICAgMyArCiBhcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRh
LTM3eHguZHRzaSAgfCAgMTAgKwogZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ktYWFyZHZhcmsu
YyAgICAgICAgIHwgMjE3ICsrKysrKysrKysrKysrKysrLQogNCBmaWxlcyBjaGFuZ2VkLCAyNDMg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKLS0gCjIuMTkuMQoKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGlu
ZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
