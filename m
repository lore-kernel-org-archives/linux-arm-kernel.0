Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11C3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:33:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80D7B206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cx8vnzD+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D7B206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=3oowBqkFtBeKP/rbgiER8epinC6D0fowAImlWJuG4Q0=; b=Cx8vnzD+GggJpN
	Mz8Ip+cvffvZOrA4jBN2xcFJtkjNuKMvLwro114cpQavcPw7uVNtbshO+mmqkW847OfTibmK+2EUn
	1XQv2FXPQL8LTT+E3VpS0PpS7F0/BpWlNDFfnP2ccuZ3PkIGEHfugZYY/VArkrjNGBvuvAWkaTs8J
	bSBobs/LMWBLcMXMMnbkmZPHYCbHQDs7b9ewRPsdSymHK81JtNhkacbvYmOYD9TEZuquVtR0qTxoW
	Gvhi10UT9JVAzlklIeEFuIIT6GW+9FzFXXx/IcRjzIl87eFhmuZ/sPiZrD8oAang2iYmGA/4aOTKw
	6SwRo30+fzhJKTmFj+7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghww5-0007Nv-EQ; Fri, 11 Jan 2019 13:33:21 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghwuT-0005pL-AS
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 13:31:43 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 2D5D320A7A; Fri, 11 Jan 2019 14:31:35 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr [90.88.163.241])
 by mail.bootlin.com (Postfix) with ESMTPSA id B4A6C20A2D;
 Fri, 11 Jan 2019 14:31:34 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v2 00/10] A3700 USB S2RAM support
Date: Fri, 11 Jan 2019 14:31:23 +0100
Message-Id: <20190111133133.24803-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_053141_654250_5C3B1704 
X-CRM114-Status: GOOD (  18.92  )
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
Cc: devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 linux-usb@vger.kernel.org, Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGVsbG8sCgpBcyBwYXJ0IG9mIGFuIGVmZm9ydCB0byBicmluZyBzdXNwZW5kIHRvIFJBTSBzdXBw
b3J0IHRvIEFybWFkYSAzNzAwClNvQ3MgKG1haW4gdGFyZ2V0OiBFU1BSRVNTT2JpbiksIHRoaXMg
c2VyaWVzIGhhbmRsZXMgdGhlIHdvcmsgYXJvdW5kCnRoZSBVU0IyIGFuZCBVU0IzMiBJUHMuCgpG
aXJzdCwgYSBjaGFuZ2UgaW4gdGhlIGNvcmUgYWRkcyBzdXBwb3J0IGZvciB0aGUgbmV3IFBIWSBm
cmFtZXdvcmsgYnkKZm9sbG93aW5nIHRoZSBwaHlfc2V0X21vZGUoKS9waHlfcG93ZXJfb24oKSBz
ZXF1ZW5jZSAocGF0Y2ggMSkuIFRoZQpzZWNvbmQgY2hhbmdlIG5lZWRlZCBpcyB0byB1cGRhdGUg
dGhlIHhIQ0kgTVZFQlUgZHJpdmVyIChwYXRjaCAyKSB3aXRoCnRoZSBYSENJX1JFU0VUX09OX1JF
U1VNRSBxdWlyayB0aGF0IHdpbGwgZG8gbW9zdCBvZiB0aGUKcmVjb25maWd1cmF0aW9uIHdvcmsg
d2hlbiByZXN1bWluZy4KClRoZW4sIGJlY2F1c2Ugb2YgdGhlIGFzeW5jaHJvbm91cyBzdXNwZW5k
IGZlYXR1cmUgaW1wbGVtZW50ZWQgbGF0ZWx5LAp0aGUgeEhDSSBkcml2ZXIgd2FzIGJsb2NraW5n
IGR1cmluZyB0aGUgUzJSQU0gb3BlcmF0aW9uLCBwcm9iYWJseSBkdWUKdG8gYSByZWdpc3RlciBh
Y2Nlc3Mgd2hpbGUgdGhlIGNsb2NrIHdhcyBub3QgZW5hYmxlZC4gQSBmaXJzdCBwYXRjaApoYXMg
YmVlbiB3cml0dGVuIGZvciB0aGF0LCBhZGRpbmcgYSBuZXcgcXVpcmsgdG8gaWdub3JlIHRoZQph
c3luY2hyb25vdXMgc2V0dGluZyBbMV0gd2hpY2ggaGFzIGJlY29tZSB1c2VsZXNzIG9uY2UgY2xv
Y2sgbGlua3MKd2l0aCBjb25zdW1lciBoYXZlIGJlZW4gY29udHJpYnV0ZWQgWzJdIChzZXJpZXMg
bm90IG1lcmdlZCB5ZXQpLgoKVGhlbiwgdGhlIE9IQ0kgT3Jpb24gKFVTQjIgaG9zdCBjb250cm9s
bGVyKSBkcml2ZXIgaXMgdXBkYXRlZCB0byBhdm9pZApkb2luZyB0d2ljZSB0aGUgUEhZIG1hbmFn
ZW1lbnQgKHBhdGNoIDMpIGFuZCB1cGdyYWRlZCB3aXRoIHRyYWRpdGlvbmFsClMyUkFNIGNhbGxi
YWNrcyAocGF0Y2ggNCkuCgpUaGUgbGFzdCBtaXNzaW5nIHBlYWNlIGlzIGEgVVRNSSBQSFkgZHJp
dmVyIGZvciB0aGUgVVNCMiBwYXJ0IG9mIGVhY2gKY29udHJvbGxlciwgd2hpY2ggaXMgYWRkZWQg
aW4gcGF0Y2ggNSAoc2VlIHBhdGNoIDYgZm9yIHRoZSBiaW5kaW5ncykuCgpGaW5hbGx5LCB0aGUg
QTM3MDAgZGV2aWNlIHRyZWUgaXMgdXBkYXRlZCAocGF0Y2ggNywgOCwgOSkgdG8gcmVmZXJlbmNl
CnRoZSBQSFlzLiB4SENJIGJpbmRpbmdzIGFscmVhZHkgZG9jdW1lbnQgdGhlIFBIWSBzbyBubyB1
cGRhdGUgaXMgbmVlZGVkCm9uIHRoaXMgcmVnYXJkLgoKWzFdIGh0dHA6Ly9jb2RlLmJ1bGl4Lm9y
Zy9zMmNjZDQtNTExMTk4ClsyXSBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9waXBlcm1haWwv
bGludXgtYXJtLWtlcm5lbC8yMDE5LUphbnVhcnkvNjIzODg1Lmh0bWwKClRoYW5rcywKTWlxdcOo
bAoKQ2hhbmdlcyBzaW5jZSB2MToKPT09PT09PT09PT09PT09PT0KKiBBZGQgVVRNSSBQSFkgZHJp
dmVyL2JpbmRpbmdzL0RUIGNoYW5nZXMgdG8gYnJpbmcgUzJSQU0gc3VwcG9ydCB0bwogIGJvdGgg
VVNCIHBvcnRzIGF2YWlsYWJsZSBvbiB0aGUgQTM3MDAgU29DLgoqIFVwZGF0ZXMgdG8gdGhlIE9I
Q0kgT3Jpb24gZHJpdmVyIHRvIGF2b2lkIGRvaW5nIHRoZSBQSFkKICBpbml0aWFsaXphdGlvbiB0
d2ljZS4KKiBVcGdyYWRlIG9mIHRoZSBPSENJIE9yaW9uIGRyaXZlciB3aXRoIFMyUkFNIGNhbGxi
YWNrcy4KKiBBZGRlZCBhIHJlZmVyZW5jZSB0byB0aGUgQTM3MDAgU29DIGluIHRoZSBVU0IgSG9z
dCBLY29uZmlnIHByb21wdAogIChub3Qgb25seSBpbiB0aGUgaGVscCBzZWN0aW9uKS4KKiBSZWJh
c2VkIG9uIHRvcCBvZiB2NS4wLXJjMS4KCgpNaXF1ZWwgUmF5bmFsICg5KToKICB1c2I6IGNvcmU6
IGNvbXBseSB0byBQSFkgZnJhbWV3b3JrCiAgdXNiOiBlaGNpLW9yaW9uOiBhdm9pZCBkb3VibGUg
UEhZIGluaXRpYWxpemF0aW9uCiAgdXNiOiBlaGNpLW9yaW9uOiBhZGQgUzJSQU0gc3VwcG9ydAog
IHBoeTogYWRkIEEzNzAwIFVUTUkgUEhZIGRyaXZlcgogIGR0LWJpbmRpbmdzOiBwaHk6IG12ZWJ1
LXV0bWk6IGFkZCBVVE1JIFBIWSBiaW5kaW5ncwogIE1BSU5UQUlORVJTOiBwaHk6IGZpbGwgQXJt
YWRhIDM3MDAgUEhZIGRyaXZlcnMgZW50cnkKICBBUk02NDogZHRzOiBtYXJ2ZWxsOiBhcm1hZGEt
Mzd4eDogZml4IFVTQjIgbWVtb3J5IHJlZ2lvbgogIEFSTTY0OiBkdHM6IG1hcnZlbGw6IGFybWFk
YS0zN3h4OiBkZWNsYXJlIFVTQjIgVVRNSSBQSFlzCiAgQVJNNjQ6IGR0czogbWFydmVsbDogYXJt
YWRhLTM3eHg6IGxpbmsgVVNCIGhvc3RzIHdpdGggdGhlaXIgUEhZcwoKT2ZlciBIZWlmZXR6ICgx
KToKICB1c2I6IGhvc3Q6IHhoY2k6IG12ZWJ1OiBhZGQgcmVzZXQgb24gcmVzdW1lIHF1aXJrCgog
Li4uL2JpbmRpbmdzL3BoeS9waHktbXZlYnUtdXRtaS50eHQgICAgICAgICAgIHwgIDM3ICsrKwog
TUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA0ICstCiBh
cmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLTM3eHguZHRzaSAgfCAgMzIgKy0KIGRy
aXZlcnMvcGh5L21hcnZlbGwvS2NvbmZpZyAgICAgICAgICAgICAgICAgICB8ICAgOSArCiBkcml2
ZXJzL3BoeS9tYXJ2ZWxsL01ha2VmaWxlICAgICAgICAgICAgICAgICAgfCAgIDEgKwogZHJpdmVy
cy9waHkvbWFydmVsbC9waHktbXZlYnUtYTM3MDAtdXRtaS5jICAgIHwgMjk3ICsrKysrKysrKysr
KysrKysrKwogZHJpdmVycy91c2IvY29yZS9oY2QuYyAgICAgICAgICAgICAgICAgICAgICAgIHwg
ICA1ICsKIGRyaXZlcnMvdXNiL2NvcmUvcGh5LmMgICAgICAgICAgICAgICAgICAgICAgICB8ICAy
OCArKwogZHJpdmVycy91c2IvY29yZS9waHkuaCAgICAgICAgICAgICAgICAgICAgICAgIHwgICAy
ICsKIGRyaXZlcnMvdXNiL2hvc3QvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICB8ICAgNCAr
LQogZHJpdmVycy91c2IvaG9zdC9laGNpLW9yaW9uLmMgICAgICAgICAgICAgICAgIHwgIDUxICst
LQogZHJpdmVycy91c2IvaG9zdC94aGNpLW12ZWJ1LmMgICAgICAgICAgICAgICAgIHwgIDExICsK
IGRyaXZlcnMvdXNiL2hvc3QveGhjaS1tdmVidS5oICAgICAgICAgICAgICAgICB8ICAgNiArCiBk
cml2ZXJzL3VzYi9ob3N0L3hoY2ktcGxhdC5jICAgICAgICAgICAgICAgICAgfCAgIDcgKwogMTQg
ZmlsZXMgY2hhbmdlZCwgNDY3IGluc2VydGlvbnMoKyksIDI3IGRlbGV0aW9ucygtKQogY3JlYXRl
IG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvcGh5LW12
ZWJ1LXV0bWkudHh0CiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9waHkvbWFydmVsbC9waHkt
bXZlYnUtYTM3MDAtdXRtaS5jCgotLSAKMi4xOS4xCgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
