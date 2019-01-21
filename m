Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA12DC282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:56:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95FDE2084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m/E3fpPA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95FDE2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ND31DQSdmpUnAUVDBJ/69LXUHbUBsMgDW8/WUFH9PPI=; b=m/E3fpPARDSTna
	s8tcPdk8ofl+YTbzx9wupCLPtmmyPaoj04ID9Bbi0Esds5YDkAARrVjzN9EaN5KJ/5mkAUxBokQXv
	hhmow2jpV49TuZOPzbyT7fskPjMhtBISIdCJbDz2vz40aCVLRfSC48sPbya8jwTaTYCEBfgj6dLvo
	Z6hK+0Z3Z44UQPwF2Wmd6CcLeiBjlH5lRiCTcK8zr9k/NOLdWfz2Kvm6yDUElWsWkFd95lPZFxV0h
	84x93Qxyk8vbIdxFO1934wAI3r0xGPetv99pdPDA/5D2tOG0vujcgOoYExLERkVjwvSYxpsCzbZvW
	8IRiKsKgzcLnjjPxEemg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glWJT-0001pX-DY; Mon, 21 Jan 2019 09:56:15 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glWJP-0001pC-IS
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 09:56:12 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 0F98320A2E; Mon, 21 Jan 2019 10:56:10 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr
 [90.88.156.87])
 by mail.bootlin.com (Postfix) with ESMTPSA id 9B2F52078C;
 Mon, 21 Jan 2019 10:55:59 +0100 (CET)
Date: Mon, 21 Jan 2019 10:55:59 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH v2 03/10] usb: ehci-orion: avoid double PHY initialization
Message-ID: <20190121105559.1fd49dc8@xps13>
In-Reply-To: <874la6lypx.fsf@FE-laptop>
References: <20190111133133.24803-1-miquel.raynal@bootlin.com>
 <20190111133133.24803-4-miquel.raynal@bootlin.com>
 <874la6lypx.fsf@FE-laptop>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_015611_747491_670E024C 
X-CRM114-Status: GOOD (  15.44  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>, Mathias Nyman <mathias.nyman@intel.com>,
 devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 Kishon Vijay Abraham I <kishon@ti.com>, Nadav Haklai <nadavh@marvell.com>,
 Rob Herring <robh+dt@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgR3JlZ29yeSwKCkdyZWdvcnkgQ0xFTUVOVCA8Z3JlZ29yeS5jbGVtZW50QGJvb3RsaW4uY29t
PiB3cm90ZSBvbiBGcmksIDE4IEphbiAyMDE5CjE3OjI1OjMwICswMTAwOgoKPiBIaSBNaXF1ZWws
Cj4gIAo+ICBPbiB2ZW4uLCBqYW52LiAxMSAyMDE5LCBNaXF1ZWwgUmF5bmFsIDxtaXF1ZWwucmF5
bmFsQGJvb3RsaW4uY29tPiB3cm90ZToKPiAKPiA+IE5vIG5lZWQgdG8gaW5pdGlhbGl6ZSB0aGUg
UEhZIGZyb20gdGhlIGRyaXZlcidzIHByb2JlLiBJdCBpcyBkb25lIGJ5Cj4gPiB0aGUgY29yZSBh
dXRvbWF0aWNhbGx5IGFuZCBkb2luZyBpdCB0d2ljZSB3b3VsZCBpbmNyZW1lbnQgdGhlICAKPiAK
PiBEbyB5b3Uga25vdyBleGFjdGx5IHdoaWNoIGNvcmUgdGFrZSBjYXJlIG9mIGl0PwoKVGhlIE9y
aW9uJ3MgcHJvYmUgZnVuY3Rpb24gY2FsbHMgdXNiX2FkZF9oY2QoKSB3aGljaCBoYW5kbGVzIFBI
WQppbml0aWFsaXphdGlvbiAoaW5pdCwgc2V0IG1vZGUsIHBvd2VyIG9uKS4KCj4gCj4gV2hlbiB0
aGUgcGh5IHN1cHBvcnQgd2FzIGFkZGVkIHRvIHRoaXMgZHJpdmVyIHRoZXJlIHdhcyBub3Qgc3Vj
aAo+IGZlYXR1cmUuIEkgbWFkZSBzb21lIHJlc2VhcmNoIGFuZCBmb3VuZCB0aGF0IHJlY2VudGx5
IChsZXNzIHRoYW4gb25lCj4geWVhciBhZ28pIGEgc2VyaWVzIHdhcyBhZGRlZCB0byBpbml0aWFs
aXplIFBIWXMgYXQgSENEIGxldmVsWzFdLiBJIHRoaW5rCj4gdGhhdCBvdXIgcGxhdGZvcm0gd2Fz
IGZvcmdvdHRlbiBpbiB0aGUgY29udmVyc2lvbi4KCkFGQUlDUyB0aGUgY29udmVyc2lvbiB3YXMg
YXBwbGllZCB0byBlaGNpLXBsYXRmb3JtLmMgYnV0IG5vdCB0byBvdGhlcgpkcml2ZXJzIHNvIHll
cywgdGhpcyBvbmUgd2FzIGxlZnQgYXNpZGUgYnV0IHRoZXJlIGFyZSBtYXliZSBvdGhlcnMgaW4K
dGhlIHNhbWUgc2l0dWF0aW9uLgoKPiAKPiBDb3VsZCB5b3UgY2hlY2sgdGhhdCB3ZSBhcmUgbm93
IGFsaWduZWQgd2l0aCB0aGUgcmVxdWlyZW1lbnQgb2YgdGhpcwo+IHNlcmllcz8KClRoZXJlIGhh
cyBiZWVuIHF1aXRlIGEgZmV3IGV2b2x1dGlvbnMgc2luY2UgdGhpcyBzZXJpZXMgYnV0IGZvciB3
aGF0IEkKdW5kZXJzdGFuZCwgeWVzIHdlIGFyZS4KCgpUaGFua3MsCk1pcXXDqGwKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
