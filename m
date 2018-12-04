Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEDFC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:10:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F409F2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p6lTB620"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F409F2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=wD5/B2wU497KHVzf1URZkaoPrv5ia+Mj0XlH9FLZE/U=; b=p6lTB620gFFtXU
	tdEXI4rgZSH/eRBojM0nUAyuKOfPfdMqbLOV1b9UjX6UbhehCiK4js46PTtC3q6TtscFbusUm9zY1
	FZI07Rjmq3WPd00LlwhR6/WskvNYGAunctIQ/DTZCXjF1YJuTwvaeCLst8v09hSsuauQgdFsEaHlS
	m06/tB4GRTGT4GCPehROE+8DbYmb7/8w3onK/hK3TsRPngJogBMQtpXxOLHBx78mTbOJDHV8smqEL
	aOAv58kmoYms2/pjwFuzTj6fDVA+hPlg8z7ubgXoWyDZW3ShZoy0Ynsg4FviEz9IbIZjm7kAsyMx2
	C7HPa7+kIAUsMxsrcKrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUG5d-00073Z-RT; Tue, 04 Dec 2018 19:10:37 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUFzA-0001hc-75
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 19:03:59 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id B7E3520A5A; Tue,  4 Dec 2018 20:03:44 +0100 (CET)
Received: from localhost.localdomain (unknown [91.224.148.103])
 by mail.bootlin.com (Postfix) with ESMTPSA id 8B2F72074D;
 Tue,  4 Dec 2018 20:03:33 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v3 0/6] Add hw overheat IRQ support to Marvell thermal driver
Date: Tue,  4 Dec 2018 20:03:26 +0100
Message-Id: <20181204190332.10351-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_110356_610065_6469A8AB 
X-CRM114-Status: GOOD (  17.48  )
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
 linux-pm@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Marc Zyngier <marc.zyngier@arm.com>,
 David Sniatkiwicz <davidsn@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGVsbG8sCgpUaGlzIGlzIHRoZSBsYXN0IGJhdGNoIG9mIHBhdGNoZXMgYWJvdXQgdGhlIHRoZXJt
YWwgZHJpdmVyIHRoYXQgd2FzCnN1c3BlbmRlZCwgd2FpdGluZyBmb3IgdGhlIElDVS9TRUkgc2Vy
aWVzIHRvIGJlIG1lcmdlZC4gTm93IHRoYXQKZXZlcnl0aGluZyBpcyByZWFkeSBpbiBtYWlubGlu
ZSwgbGV0J3MgYWRkIGhhcmR3YXJlIG92ZXJoZWF0IGludGVycnVwdApzdXBwb3J0IHRvIHRoaXMg
ZHJpdmVyLgoKQmluZGluZ3MgYW5kIERUIGFyZSB1cGRhdGVkIGFjY29yZGluZ2x5LiBUaGUgaW50
ZXJydXB0IHdpbGwgb25seSBiZQp0cmlnZ2VyZWQgaWYgdGhlIHBsYXRmb3JtIGdvZXMgYWJvdmUg
fjEwMsKwQyAodGhyZXNob2xkIHNldCB0byAxMDDCsEMsCmh5c3RlcmVzaXMgdG8gPiAywrBDKS4g
VGhlIGludGVycnVwdCBwcm9wZXJ0eSBpcyBvZiBjb3Vyc2Ugbm90Cm1hbmRhdG9yeS4KCkluIHRo
ZSBtZWFuIHRpbWUsIEkgYWRkIG15c2VsZiB0byB0aGUgTUFJTlRBSU5FUlMgZmlsZSB0byByZWNl
aXZlIGFuZApyZXZpZXcgcG9zc2libGUgZml4ZXMvbmV3IGZlYXR1cmVzLgoKVGhhbmtzLApNaXF1
w6hsCgpDaGFuZ2VzIHNpbmNlIHYyOgo9PT09PT09PT09PT09PT09PQoqIFJlbW92ZSB1c2VsZXNz
IGdvdG8gc3RhdGVtZW50LgoqIE1vdmUgdGhlIGh5c3RlcmVzaXMgYXJyYXkgb3V0IG9mIHRoZSBm
dW5jdGlvbiB1c2luZyBpdCBhbmQgZGVjbGFyZQogIHRoZSBhcnJheSBzdGF0aWNhbGx5IGluc3Rl
YWQgdGhhdCBkb2luZyBzbyBvbiB0aGUgc3RhY2suCiogUmVtb3ZlIHVubmVjZXNzYXJ5IGNhc3Qu
CiogT24gZXJyb3IsIGF2b2lkIHJldHVybmluZyBhIHZhbHVlIG5vdCBjb21wYXRpYmxlIHdpdGgg
aXJxcmV0dXJuX3QgaW4KICB0aGUgSVJRIGhhbmRsZXIgKGFuZCB3aGVuIGRvaW5nIHNvLCByZS1l
bmFibGUgaW50ZXJydXB0cwogIGZpcnN0KS4gVGhpcyBpcyBzaW1wbHkgaGFuZGxlZCB3aXRoIGEg
Z290byBzdGF0ZW1lbnQuCiogMCBpcyBub3QgYSB2YWxpZCBpbnRlcnJ1cHQsIHRha2UgdGhpcyBp
bnRvIGFjY291bnQgZHVyaW5nIHZhcmlhYmxlcwogIHZhbGlkYXRpb24uCgpDaGFuZ2VzICpub3Qq
IGFkZHJlc3NlZCBzaW5jZSB2MjoKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KKiBP
dmVyaGVhdCBpbnRlcnJ1cHQgY29uZmlndXJhdGlvbiBoYXMgY2VydGFpbiBsaW1pdGF0aW9ucyBv
biB3aGljaAogIE1hcmMgYXNrZWQgcXVlc3Rpb25zLiBJIGRvbid0IGtub3cgaWYvd2hhdCBJIG5l
ZWQgdG8gY2hhbmdlIHNvCiAga2VlcGluZyBpdCBsaWtlIHRoaXMgZm9yIHRoaXMgdmVyc2lvbi4K
KiBFZHVhcmRvIHBvaW50ZWQgdGhhdCBvbmNlIGEgY3JpdGljYWwgbGV2ZWwgaGFzIGJlZW4gcmVh
Y2hlZCwgdGhlcmUKICBpcyBubyB3YXkgYmFjaywgdGhlIHN5c3RlbSB3aWxsIHNodXRkb3duLiBJ
IGRlc2lnbmVkIHRoZSBoYW5kbGVyIHRvCiAgcmVjb3ZlciBmcm9tIHRoYXQgYW5kIHRvIGVuYWJs
ZSB0aGUgSVJRIGFnYWluIGlmIG5lZWRlZCwgYnV0IG1heWJlCiAgdGhpcyBpcyB1c2VsZXNzIGFu
ZCBzaG91bGQgYmUgcmVtb3ZlZC4gV2hpbGUgd2FpdGluZyBmb3IgaGlzIGFuc3dlciwKICBJIGFt
IHNlbmRpbmcgYW5vdGhlciB2ZXJzaW9uIGFuZCB3aWxsIGNvcnJlY3QgaW4gYSB2NCBpZiBuZWVk
ZWQuCgpDaGFuZ2VzIHNpbmNlIHYxOgo9PT09PT09PT09PT09PT09PQoqIFVzZSBhIHRocmVhZGVk
IElSUSBoYW5kbGVyIHRvIGF2b2lkIGEgcG90ZW50aWFsIGxvY2sgZGVwZW5jeSB3aGVuCiAgbm90
aWZ5aW5nIHRoZSBjb3JlIG9mIGFuIG92ZXJoZWF0IHNpdHVhdGlvbi4KCgpNaXF1ZWwgUmF5bmFs
ICg2KToKICB0aGVybWFsOiBhcm1hZGE6IGFkZCBvdmVyaGVhdCBpbnRlcnJ1cHQgc3VwcG9ydAog
IE1BSU5UQUlORVJTOiB0aGVybWFsOiBhZGQgZW50cnkgZm9yIE1hcnZlbGwgTVZFQlUgdGhlcm1h
bCBkcml2ZXIKICBkdC1iaW5kaW5nczogYXA4MDY6IGRvY3VtZW50IHRoZSB0aGVybWFsIGludGVy
cnVwdCBjYXBhYmlsaXRpZXMKICBkdC1iaW5kaW5nczogY3AxMTA6IGRvY3VtZW50IHRoZSB0aGVy
bWFsIGludGVycnVwdCBjYXBhYmlsaXRpZXMKICBhcm02NDogZHRzOiBtYXJ2ZWxsOiBhZGQgaW50
ZXJydXB0IHN1cHBvcnQgdG8gYXA4MDYgdGhlcm1hbCBub2RlCiAgYXJtNjQ6IGR0czogbWFydmVs
bDogYWRkIGludGVycnVwdCBzdXBwb3J0IHRvIGNwMTEwIHRoZXJtYWwgbm9kZQoKIC4uLi9hcm0v
bWFydmVsbC9hcDgwNi1zeXN0ZW0tY29udHJvbGxlci50eHQgICB8ICAgOCArCiAuLi4vYXJtL21h
cnZlbGwvY3AxMTAtc3lzdGVtLWNvbnRyb2xsZXIudHh0ICAgfCAgIDkgKwogTUFJTlRBSU5FUlMg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA1ICsKIGFyY2gvYXJtNjQvYm9v
dC9kdHMvbWFydmVsbC9hcm1hZGEtYXA4MDYuZHRzaSB8ICAxOCArLQogYXJjaC9hcm02NC9ib290
L2R0cy9tYXJ2ZWxsL2FybWFkYS1jcDExMC5kdHNpIHwgIDE1ICstCiBkcml2ZXJzL3RoZXJtYWwv
YXJtYWRhX3RoZXJtYWwuYyAgICAgICAgICAgICAgfCAyNzAgKysrKysrKysrKysrKysrKystCiA2
IGZpbGVzIGNoYW5nZWQsIDMxOCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQoKLS0gCjIu
MTkuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxp
bnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LWFybS1rZXJuZWwK
