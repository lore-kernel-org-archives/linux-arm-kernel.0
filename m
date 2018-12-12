Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC95C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:38:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 623612084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N6dPVfxx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 623612084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=VLQZIKIXxRsTxAZcMyJo3YpU5TXvNX6IqE4r0FpcqNo=; b=N6dPVfxxlSQ7OJ
	FnbHVIDnYQ0DbXLW8rihIuybRRtZvpPg5QlcY//HBejA8aHn2/k8LtL6/E4grJjiD+FwtIJb8AdMB
	9iAU7IXBct381gb8kGhp7w9CofY708RVc/67kuuTeobRaI3ZLik6nkk3mfg9QcSHiHfnYVorbiRFE
	nBlrtXWmmkG1LOTTZp6B73R7nL80Or++zfwkwETi/lZneY+rT+0F6i/8JZ8mJGzv8xsCv8QhG1vi0
	efmj4TK4Nc1/AqTkHuN167kdpF9UXSrez9gtFAhEtRlIMLi+ycJ8zI/CzeuXubme2UtIKh29DGtfw
	WDBOyH2i7ZeXROc/Td1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX0yF-00050y-TI; Wed, 12 Dec 2018 09:38:23 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX0xl-0004aL-D9
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 09:37:56 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 1D76B20C4D; Wed, 12 Dec 2018 10:37:42 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr [90.88.30.7])
 by mail.bootlin.com (Postfix) with ESMTPSA id 06DE320DC3;
 Wed, 12 Dec 2018 10:36:47 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v4 0/6] Add hw overheat IRQ support to Marvell thermal driver
Date: Wed, 12 Dec 2018 10:36:39 +0100
Message-Id: <20181212093645.14752-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_013753_760149_725D1180 
X-CRM114-Status: GOOD (  17.63  )
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
w6hsCgpDaGFuZ2VzIHNpbmNlIHYzOgo9PT09PT09PT09PT09PT09PQoqIEFkZGVkIFJvYidzIFJl
dmlld2VkLWJ5IG9uIGNwMTEwIGJpbmRpbmdzLgoqIEFkZHJlc3NlZCBSb2IgY29tbWVudCBvbiBh
cDgwNiBiaW5kaW5ncyBieSByZW1vdmluZyB0aGUgcmVmZXJlbmNlIHRvCiAgdGhlIGludGVycnVw
dCBwYXJlbnQuCgpDaGFuZ2VzIHNpbmNlIHYyOgo9PT09PT09PT09PT09PT09PQoqIFJlbW92ZSB1
c2VsZXNzIGdvdG8gc3RhdGVtZW50LgoqIE1vdmUgdGhlIGh5c3RlcmVzaXMgYXJyYXkgb3V0IG9m
IHRoZSBmdW5jdGlvbiB1c2luZyBpdCBhbmQgZGVjbGFyZQogIHRoZSBhcnJheSBzdGF0aWNhbGx5
IGluc3RlYWQgdGhhdCBkb2luZyBzbyBvbiB0aGUgc3RhY2suCiogUmVtb3ZlIHVubmVjZXNzYXJ5
IGNhc3QuCiogT24gZXJyb3IsIGF2b2lkIHJldHVybmluZyBhIHZhbHVlIG5vdCBjb21wYXRpYmxl
IHdpdGggaXJxcmV0dXJuX3QgaW4KICB0aGUgSVJRIGhhbmRsZXIgKGFuZCB3aGVuIGRvaW5nIHNv
LCByZS1lbmFibGUgaW50ZXJydXB0cwogIGZpcnN0KS4gVGhpcyBpcyBzaW1wbHkgaGFuZGxlZCB3
aXRoIGEgZ290byBzdGF0ZW1lbnQuCiogMCBpcyBub3QgYSB2YWxpZCBpbnRlcnJ1cHQsIHRha2Ug
dGhpcyBpbnRvIGFjY291bnQgZHVyaW5nIHZhcmlhYmxlcwogIHZhbGlkYXRpb24uCgpDaGFuZ2Vz
ICpub3QqIGFkZHJlc3NlZCBzaW5jZSB2MjoKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0KKiBPdmVyaGVhdCBpbnRlcnJ1cHQgY29uZmlndXJhdGlvbiBoYXMgY2VydGFpbiBsaW1pdGF0
aW9ucyBvbiB3aGljaAogIE1hcmMgYXNrZWQgcXVlc3Rpb25zLiBJIGRvbid0IGtub3cgaWYvd2hh
dCBJIG5lZWQgdG8gY2hhbmdlIHNvCiAga2VlcGluZyBpdCBsaWtlIHRoaXMgZm9yIHRoaXMgdmVy
c2lvbi4KKiBFZHVhcmRvIHBvaW50ZWQgdGhhdCBvbmNlIGEgY3JpdGljYWwgbGV2ZWwgaGFzIGJl
ZW4gcmVhY2hlZCwgdGhlcmUKICBpcyBubyB3YXkgYmFjaywgdGhlIHN5c3RlbSB3aWxsIHNodXRk
b3duLiBJIGRlc2lnbmVkIHRoZSBoYW5kbGVyIHRvCiAgcmVjb3ZlciBmcm9tIHRoYXQgYW5kIHRv
IGVuYWJsZSB0aGUgSVJRIGFnYWluIGlmIG5lZWRlZCwgYnV0IG1heWJlCiAgdGhpcyBpcyB1c2Vs
ZXNzIGFuZCBzaG91bGQgYmUgcmVtb3ZlZC4gV2hpbGUgd2FpdGluZyBmb3IgaGlzIGFuc3dlciwK
ICBJIGFtIHNlbmRpbmcgYW5vdGhlciB2ZXJzaW9uIGFuZCB3aWxsIGNvcnJlY3QgaW4gYSB2NCBp
ZiBuZWVkZWQuCgpDaGFuZ2VzIHNpbmNlIHYxOgo9PT09PT09PT09PT09PT09PQoqIFVzZSBhIHRo
cmVhZGVkIElSUSBoYW5kbGVyIHRvIGF2b2lkIGEgcG90ZW50aWFsIGxvY2sgZGVwZW5jeSB3aGVu
CiAgbm90aWZ5aW5nIHRoZSBjb3JlIG9mIGFuIG92ZXJoZWF0IHNpdHVhdGlvbi4KCgpNaXF1ZWwg
UmF5bmFsICg2KToKICB0aGVybWFsOiBhcm1hZGE6IGFkZCBvdmVyaGVhdCBpbnRlcnJ1cHQgc3Vw
cG9ydAogIE1BSU5UQUlORVJTOiB0aGVybWFsOiBhZGQgZW50cnkgZm9yIE1hcnZlbGwgTVZFQlUg
dGhlcm1hbCBkcml2ZXIKICBkdC1iaW5kaW5nczogYXA4MDY6IGRvY3VtZW50IHRoZSB0aGVybWFs
IGludGVycnVwdCBjYXBhYmlsaXRpZXMKICBkdC1iaW5kaW5nczogY3AxMTA6IGRvY3VtZW50IHRo
ZSB0aGVybWFsIGludGVycnVwdCBjYXBhYmlsaXRpZXMKICBhcm02NDogZHRzOiBtYXJ2ZWxsOiBh
ZGQgaW50ZXJydXB0IHN1cHBvcnQgdG8gYXA4MDYgdGhlcm1hbCBub2RlCiAgYXJtNjQ6IGR0czog
bWFydmVsbDogYWRkIGludGVycnVwdCBzdXBwb3J0IHRvIGNwMTEwIHRoZXJtYWwgbm9kZQoKIC4u
Li9hcm0vbWFydmVsbC9hcDgwNi1zeXN0ZW0tY29udHJvbGxlci50eHQgICB8ICAgNyArCiAuLi4v
YXJtL21hcnZlbGwvY3AxMTAtc3lzdGVtLWNvbnRyb2xsZXIudHh0ICAgfCAgIDkgKwogTUFJTlRB
SU5FUlMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA1ICsKIGFyY2gvYXJt
NjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtYXA4MDYuZHRzaSB8ICAxOCArLQogYXJjaC9hcm02
NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS1jcDExMC5kdHNpIHwgIDE1ICstCiBkcml2ZXJzL3Ro
ZXJtYWwvYXJtYWRhX3RoZXJtYWwuYyAgICAgICAgICAgICAgfCAyNzAgKysrKysrKysrKysrKysr
KystCiA2IGZpbGVzIGNoYW5nZWQsIDMxNyBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQoK
LS0gCjIuMTkuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LWFybS1rZXJuZWwK
