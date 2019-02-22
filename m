Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12982C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:54:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7DF12075A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VZASi8NC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7DF12075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=thSY8jjjoml1FSWqvjN+G4haathLvbGUenOa4cPgFIY=; b=VZASi8NC+1cudK
	mgJYTAYLz5quDl7UdTY1Dmc6TodLxFdFmXiDBKfB2hL3jtoEKc8ihB4Mvt3cy+5KKLC56B5HH7l56
	jtBFbkcFemBCSGO1+HwuIWnu75/T9YkXWYacm7lIvZ/cdpsbzkvlj+AL7Z0YBa/qAccC3cGd6PngI
	2x1aByYZ3MdRhszGUIDKJZtcUdw5YYsVcbCjFSQm749oEGZLjvmmNRpW/GUIgl7KVTp32nuRikkzD
	Rhr6HIEBHTqYuhcvQP3Fv+tgyoCM1AqmZCr6A1Upjs+VYLsEbzX27P4fKwFd+ceu6rRbihVsascVP
	E+J9NLQGewXuFzPcwJFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxCDj-0001NA-OS; Fri, 22 Feb 2019 14:54:35 +0000
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxCDP-000123-2Y
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 14:54:17 +0000
X-Originating-IP: 90.88.23.190
Received: from localhost.localdomain
 (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
 (Authenticated sender: miquel.raynal@bootlin.com)
 by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 763A060008;
 Fri, 22 Feb 2019 14:53:59 +0000 (UTC)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jens Axboe <axboe@kernel.dk>, Hans de Goede <hdegoede@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 0/5] Enable per-port SATA interrupts and drop an hack in the
 IRQ subsystem
Date: Fri, 22 Feb 2019 15:53:51 +0100
Message-Id: <20190222145356.23072-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_065415_266967_8228B2DA 
X-CRM114-Status: GOOD (  12.94  )
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
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, linux-ide@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGVsbG8sCgpTb21lIHRpbWUgYWdvLCB3aGVuIHRoZSBpbml0aWFsIHN1cHBvcnQgZm9yIEFybWFk
YSBDUDExMCB3YXMKY29udHJpYnV0ZWQsIHRoZSBTQVRBIGNvcmUgd2FzIG5vdCBhYmxlIHRvIGhh
bmRsZSBwZXItcG9ydAppbnRlcnJ1cHRzLiBEZXNwaXRlIHRoZSBoYXJkd2FyZSByZWFsaXR5LCB0
aGUgZGV2aWNlIHRyZWUgb25seQpyZXByZXNlbnRzIG9uZSBtYWluIGludGVycnVwdCBmb3IgdGhl
IHR3byBwb3J0cy4gSGF2aW5nIGJvdGggU0FUQQpwb3J0cyBlbmFibGVkIGF0IHRoZSBzYW1lIHRp
bWUgaGFzIGJlZW4gYWNoaWV2ZWQgYnkgYSBoYWNrIGluIHRoZSBJQ1UKZHJpdmVyKDEpIHRoYXQg
ZmFrZWQgdGhlIHVzZSBvZiB0aGUgdHdvIGludGVycnVwdHMsIG5vIG1hdHRlciB3aGljaApTQVRB
IHBvcnQgd2FzIGluIHVzZS4KCk5vdyB0aGF0IHRoZSBTQVRBIGNvcmUgaXMgcmVhZHkgdG8gaGFu
ZGxlIG1vcmUgdGhhbiBvbmUgaW50ZXJydXB0LAp0aGlzIHNlcmllcyBhZGRzIHN1cHBvcnQgZm9y
IGl0IGluIHRoZSBsaWJhaGNpX3BsYXRmb3JtIGNvZGUuIFRoZQpDUDExMCBkZXZpY2UgdHJlZSBt
dXN0IGJlIHVwZGF0ZWQgdG8gcmVmbGVjdCB0aGUgdHdvIFNBVEEgcG9ydHMKYXZhaWxhYmxlIGFu
ZCB0aGVpciByZXNwZWN0aXZlIGludGVycnVwdHMuIFRvIGRvIG5vdCBicmVhayBEVCBiYWNrd2Fy
ZApjb21wYXRpYmlsaXR5LCB0aGUgYWhjaV9wbGF0Zm9ybSBkcml2ZXIgbm93IGVtYmVkcyBhIHNw
ZWNpYWwgcXVpcmsKd2hpY2ggY2hlY2tzIGlmIHRoZSBEVCBpcyB2YWxpZCAob25seSBmb3IgQThr
IGNvbXBhdGlibGUpIGFuZCwgaWYKbmVlZGVkLCBjcmVhdGVzIHRoZSB0d28gbWlzc2luZyBzdWIt
bm9kZXMsIGFuZCBhc3NpZ24gdGhlbSB0aGUKcmVsZXZhbnQgInJlZyIgYW5kICJpbnRlcnJ1cHRz
IiBwcm9wZXJ0aWVzLCBiZWZvcmUgcmVtb3ZpbmcgdGhlIG1haW4KU0FUQSBub2RlICJpbnRlcnJ1
cHRzIiBvbmUuCgoKVGhhbmtzLApNaXF1w6hsCgooMSkgVGhlIElDVSBpcyBhbiBpcnFjaGlwIGFn
Z3JlZ2F0aW5nIHRoZSBDUDExMCAoc291dGgtYnJpZGdlKQppbnRlcnJ1cHRzIGludG8gTVNJcyBm
b3IgdGhlIEFQODA2IChub3J0aC1icmlkZ2UpLgoKCk1pcXVlbCBSYXluYWwgKDQpOgogIGF0YTog
bGliYWhjaTogRW5zdXJlIHRoZSBob3N0IGludGVycnVwdCBzdGF0dXMgYml0cyBhcmUgY2xlYXJl
ZAogIGF0YTogbGliYWhjaV9wbGF0Zm9ybTogU3VwcG9ydCBwZXItcG9ydCBpbnRlcnJ1cHRzCiAg
aXJxY2hpcC9pcnEtbXZlYnUtaWN1OiBNb3ZlIHRoZSBkb3VibGUgU0FUQSBwb3J0cyBpbnRlcnJ1
cHQgaGFjawogIGFybTY0OiBkdHM6IG1hcnZlbGw6IGFybWFkYS04MDQwLWNsZWFyZm9nOiBEcm9w
IG5vbi1leGlzdGVudCBTQVRBIHBvcnQKClRob21hcyBQZXRhenpvbmkgKDEpOgogIGFybTY0OiBk
dHM6IG1hcnZlbGw6IGFybWFkYS1jcDExMDogU3dpdGNoIHRvIHBlci1wb3J0IFNBVEEgaW50ZXJy
dXB0cwoKIC4uLi9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS03MDQwLWRiLmR0cyB8ICAg
NyArLQogLi4uL21hcnZlbGwvYXJtYWRhLTgwNDAtY2xlYXJmb2ctZ3QtOGsuZHRzICAgIHwgICA1
IC0KIC4uLi9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS04MDQwLWRiLmR0cyB8ICAxNCAr
LQogYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS1jcDExMC5kdHNpIHwgIDE2ICst
CiBkcml2ZXJzL2F0YS9hY2FyZC1haGNpLmMgICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKy0K
IGRyaXZlcnMvYXRhL2FoY2kuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMiArLQog
ZHJpdmVycy9hdGEvYWhjaS5oICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAzICstCiBk
cml2ZXJzL2F0YS9haGNpX3BsYXRmb3JtLmMgICAgICAgICAgICAgICAgICAgfCAxNzQgKysrKysr
KysrKysrKysrKysrCiBkcml2ZXJzL2F0YS9saWJhaGNpLmMgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgIDkgKy0KIGRyaXZlcnMvYXRhL2xpYmFoY2lfcGxhdGZvcm0uYyAgICAgICAgICAgICAg
ICB8ICA2NiArKysrKy0tCiBkcml2ZXJzL2F0YS9zYXRhX2hpZ2hiYW5rLmMgICAgICAgICAgICAg
ICAgICAgfCAgIDIgKy0KIGRyaXZlcnMvaXJxY2hpcC9pcnEtbXZlYnUtaWN1LmMgICAgICAgICAg
ICAgICB8ICAxOCAtLQogMTIgZmlsZXMgY2hhbmdlZCwgMjc0IGluc2VydGlvbnMoKyksIDQ0IGRl
bGV0aW9ucygtKQoKLS0gCjIuMTkuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
