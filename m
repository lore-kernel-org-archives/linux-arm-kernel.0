Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58845C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:29:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 250512082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lp/4IhKW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 250512082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=PqIaO1znsnyJigEphZOa2OZY+LQmVVWXYCniMTp6a/Y=; b=lp/4IhKWvIeN4W
	vNKSHgMzjNjsR28+4TvOyooNGIROHpE2xvyDYU4n2gvtSG5cUTQHCQrlKWZwtBc8QyYH413Bt7v7Y
	5j/2y6xbGe3utZVZZeVwozKPsdoXLpd+eNTG3rkbR6GQkO21ebHvuZAAkPn77GlnSDzUNirGII3km
	d8zaTcQ5YVHdVTaHtPOStYkisWfI3Mw11XQ906WvhXhjuOqYG5n93DOL2rquFyDsYzNRv8fh9+rV1
	BZIQ3D5t6uMzEv1XyuKdYIAQgpXo8O7cZkDPH+GtpHYGZDMHwJCufnklOV/J1kKVUzzW2CexY5usW
	Rkq3mz1XkRkINCWd/aAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUGNr-0000sS-BG; Tue, 04 Dec 2018 19:29:27 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUGNK-0000Jz-Vl
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 19:28:58 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id A22E120A5F; Tue,  4 Dec 2018 20:28:43 +0100 (CET)
Received: from localhost.localdomain (unknown [91.224.148.103])
 by mail.bootlin.com (Postfix) with ESMTPSA id A7AE1207A8;
 Tue,  4 Dec 2018 20:28:32 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jens Axboe <axboe@kernel.dk>, Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 0/7] Bring suspend to RAM support to MVEBU SATA
Date: Tue,  4 Dec 2018 20:28:24 +0100
Message-Id: <20181204192831.12440-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_112855_336149_93924233 
X-CRM114-Status: GOOD (  16.97  )
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
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, linux-ide@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGVsbG8sCgpBcyBwYXJ0IG9mIGFuIGVmZm9ydCB0byBicmluZyBzdXNwZW5kIHRvIFJBTSBzdXBw
b3J0IHRvIEFybWFkYSAzNzAwClNvQ3MgKG1haW4gdGFyZ2V0OiBFU1BSRVNTT2JpbiksIHRoaXMg
c2VyaWVzIGhhbmRsZXMgdGhlIHdvcmsgYXJvdW5kCnRoZSBTQVRBIElQLgoKRmlyc3QsIGEgY2hh
bmdlIGluIHRoZSBsaWJhaGNpIHBsYXRmb3JtIGFkZHMgc3VwcG9ydCBmb3IgdGhlIG5ldyBQSFkK
ZnJhbWV3b3JrIGJ5IGZvbGxvd2luZyB0aGUgcGh5X3NldF9tb2RlKCkvcGh5X3Bvd2VyX29uKCkK
c2VxdWVuY2UuIFRoZW4sIHRoZSBBSENJIE1WRUJVIGRyaXZlciBpcyBhIGJpdCB1cGRhdGVkIChw
YXRjaCAyICYgMykKYW5kIGEgbWlzc2luZyBpbml0aWFsaXphdGlvbiBpcyBhZGRlZCBmb3IgdGhl
IEEzNzAwIGluIHBhdGNoIDQgKG9ubHkKZG9uZSBieSB0aGUgQm9vdGxvYWRlciBiZWZvcmUpLiBN
aXNzaW5nIGNsb2NrIHN1cHBvcnQgaXMgaW1wbGVtZW50ZWQKaW4gcGF0Y2ggNSB0byBiZSBzdXJl
IHRoZSBjbG9jayB3aWxsIGJlIHJlc3VtZWQgYmVmb3JlIHRoaXMgZHJpdmVyCihzZWUgWzFdIGZv
ciB0aGUgc2VyaWVzIGFkZGluZyBkZXZpY2UgbGlua3MgdG8gdGhlIGNsb2NrIGNvcmUpLgoKRmlu
YWxseSwgZGV2aWNlIHRyZWVzIGFyZSB1cGRhdGVkIHRvIHJlZmxlY3QgdGhlIGhhcmR3YXJlOiB0
aGUgbWlzc2luZwpQSFkgaXMgYWRkZWQgdG8gdGhlIEVTUFJFU1NPYmluIERULCBhbmQgdGhlIGNs
b2NrIGlzIGFkZGVkIHRvIHRoZSBTb0MKRFQgKHBhdGNoIDYgJiA3KS4gQmluZGluZ3MgYWxyZWFk
eSBkb2N1bWVudCB0aGUgY2xvY2sgYW5kIHRoZSBQSFkgc28Kbm8gdXBkYXRlIGlzIG5lZWRlZCBv
biB0aGlzIHJlZ2FyZC4KClsxXSBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9waXBlcm1haWwv
bGludXgtYXJtLWtlcm5lbC8yMDE4LU5vdmVtYmVyLzYxNDUyNy5odG1sCgpUaGFua3MsCk1pcXXD
qGwKCkNoYW5nZXMgc2luY2UgdjI6Cj09PT09PT09PT09PT09PT09CiogUmVuYW1lIEFIQ0lfSEZM
QUdfTUFOQUdFX1BIWVMgLT4gQUhDSV9IRkxBR19TVVNQRU5EX1BIWVMgdG8gY2xlYXJseQogIHN0
YXRlIHRoYXQgaXQgb25seSBoYXMgYW4gZWZmZWN0IGF0IHN1c3BlbmQvcmVzdW1lIHRpbWUuCiog
VGhlIGhmbGFnIGlzIG5vdCBwYXNzZWQgdG8gYWhjaV9wbGF0Zm9ybV9nZXRfcmVzb3VyY2VzKCkg
YW55bW9yZSBidXQKICBhZGRlZCBtYW51YWxseSBieSB0aGUgdXNlcnMgKGluIG91ciBjYXNlLCBh
aGNpX212ZWJ1LmMpIGluIHRoZQogIHByb2JlLgoqIFJlZmFjdG9yIGEgYml0IHRoZSBwYXRjaCBi
cmluZ2luIFMyUkFNIHN1cHBvcnQgdG8gdGhlIGFoY2lfbXZlYnUKICBkcml2ZXIgYnkgc3BsaXR0
aW5nIHRoZSBjaGFuZ2VzOiBvbmUgcGF0Y2gganVzdCBmb3IgcmVnaXN0ZXJzCiAgaW5pdGlhbGl6
YXRpb24sIGFub3RoZXIgb25lIHRvIG1ha2UgdXNlIG9mIHRoZSBhYm92ZSBoZmxhZy4KCkNoYW5n
ZXMgc2luY2UgdjE6Cj09PT09PT09PT09PT09PT09CiogVGhlIGNsb2NrIGlzIGF1dG9tYXRpY2Fs
bHkgcmVxdWVzdGVkIGJ5IHRoZSBsaWJhaGNpX3BsYXRmb3JtLmMKICBkcml2ZXIsIGRvaW5nIGl0
IGluIHRoZSBtdmVidSBkcml2ZXIgaXMgcmVkdW5kYW50LCByZW1vdmUgdGhlIHBhdGNoCiAgYWRk
aW5nIGNsb2NrIHN1cHBvcnQgYXMgY2xvY2sgc3VwcG9ydCBhbHJlYWR5IGV4aXN0cy4KKiBDaGFu
Z2VkIGF1dGhvcnNoaXAgb2YgcGF0Y2ggYWRkaW5nIGEgU0FUQSBlbnVtIGluIHRoZSBQSFkgY29y
ZS4KKiBBZGRlZCBTdWdnZXN0ZWQtYnkgdGFnIHRvIHRoZSBwYXRjaCBmaXhpbmcgdGhlIFNBVEEg
bm9kZSBzY29wZSBpbiBEVCwKICB0byB0aGUgcGF0Y2ggYWRkaW5nIFBIWSBmcmFtZXdvcmsgY29t
cGxpYW5jZSB0byB0aGUKICBsaWJhaGNpX3BsYXRmb3JtIGRyaXZlciBhbmQgdG8gdGhlIERUIHBh
dGNoIGFkZGluZyB0aGUgU0FUQSBQSFkKICBwcm9wZXJ0eS4KKiBBZGQgYSBmbGFnIHRvIGRvIG5v
dCBkaXNhYmxlL2VuYWJsZSB0aGUgUEhZIGZvciBjb21wYXRpYmlsaXR5CiAgcmVhc29ucyBhbmQg
dG8gYXZvaWQgdG8gYnJlYWsgdW50ZXN0ZWQgYm9hcmRzIHdpdGggdGhpcyBjaGFuZ2UuCiAgVGhl
IGZsYWcgaXMgY2FsbGVkIEFIQ0lfSEZMQUdfTUFOQUdFX1BIWVMuCiogVGhlIG12ZWJ1IGFoY2kg
ZHJpdmVyIGlzIGVkaXRlZCB0byBlbmFibGUgdGhpcyBmbGFnIG9ubHkgb24gQTM3MDAuCgoKTWlx
dWVsIFJheW5hbCAoNyk6CiAgYXRhOiBsaWJhaGNpX3BsYXRmb3JtOiBjb21wbHkgdG8gUEhZIGZy
YW1ld29yawogIGF0YTogYWhjaTogbXZlYnU6IHJlbW92ZSBzdGFsZSBjb21tZW50CiAgYXRhOiBh
aGNpOiBtdmVidTogZG8gQXJtYWRhIDM4eCBjb25maWd1cmF0aW9uIG9ubHkgb24gcmVsZXZhbnQg
U29DcwogIGF0YTogYWhjaTogbXZlYnU6IGFkZCBBcm1hZGEgMzcwMCBpbml0aWFsaXphdGlvbiBu
ZWVkZWQgZm9yIFMyUkFNCiAgYXRhOiBhaGNpOiBtdmVidTogcmVxdWVzdCBQSFkgc3VzcGVuZC9y
ZXN1bWUgZm9yIEFybWFkYSAzNzAwCiAgQVJNNjQ6IGR0czogbWFydmVsbDogYXJtYWRhLTM3eHg6
IGRlY2xhcmUgU0FUQSBjbG9jawogIEFSTTY0OiBkdHM6IG1hcnZlbGw6IGFybWFkYS0zNzIwLWVz
cHJlc3NvYmluOiBkZWNsYXJlIFNBVEEgUEhZCiAgICBwcm9wZXJ0eQoKIC4uLi9kdHMvbWFydmVs
bC9hcm1hZGEtMzcyMC1lc3ByZXNzb2Jpbi5kdHMgICB8ICAyICsKIGFyY2gvYXJtNjQvYm9vdC9k
dHMvbWFydmVsbC9hcm1hZGEtMzd4eC5kdHNpICB8ICAxICsKIGRyaXZlcnMvYXRhL2FoY2kuaCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyICsKIGRyaXZlcnMvYXRhL2FoY2lfbXZlYnUu
YyAgICAgICAgICAgICAgICAgICAgICB8IDg3ICsrKysrKysrKysrKysrLS0tLS0KIGRyaXZlcnMv
YXRhL2xpYmFoY2lfcGxhdGZvcm0uYyAgICAgICAgICAgICAgICB8IDEzICsrKwogNSBmaWxlcyBj
aGFuZ2VkLCA4MiBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlvbnMoLSkKCi0tIAoyLjE5LjEKCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0t
a2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2Vy
bmVsCg==
