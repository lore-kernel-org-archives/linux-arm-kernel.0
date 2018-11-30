Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F047AC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:39:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C152F20834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rOdiQ7UF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C152F20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=+sxwg5qPD4n/s/kG7+BXd8qU/rZSF4xWYITkcq63KNg=; b=rOdiQ7UFxWTAho
	T8wpEiT9u9kH3dcJRZ93OTU8wSSrH1A/NdMJPJrepqo2UnkEAbJ7qkn7CbH3nHmKT99x75zxiiWsX
	jP8r2kqlnBiaiwcP1278GbzGd5A59GK9W+TAUql+JiW8cbDYxvqVW5hy9gGyiwzg6Fmg4x5rdd/4N
	5mRH8q1jczbnbcvLPE+ERFEuCYJchjY76nBzvXGtgo9aT2H1QCK/0D5fF0kSFa6S7L07ZXMqMe7vj
	pcwsL28PH3+q5KegnbNgUGwLBkqroxa3Uw2sKi09pHnL3w1DrtZIX2kOiv9k4Z8dckiUr7PW4PBNj
	vxuP6ytI9PZur8cMYEzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSksw-0007sv-CV; Fri, 30 Nov 2018 15:39:18 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSksc-0007ab-Q8
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 15:39:00 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id BC07820D0E; Fri, 30 Nov 2018 16:38:47 +0100 (CET)
Received: from localhost.localdomain (unknown [91.224.148.103])
 by mail.bootlin.com (Postfix) with ESMTPSA id C2A9C20743;
 Fri, 30 Nov 2018 16:38:36 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jens Axboe <axboe@kernel.dk>, Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 0/6] Bring suspend to RAM support to MVEBU SATA
Date: Fri, 30 Nov 2018 16:38:27 +0100
Message-Id: <20181130153833.11421-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_073858_991357_519A488B 
X-CRM114-Status: GOOD (  17.05  )
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
qGwKCkNoYW5nZXMgc2luY2UgdjE6Cj09PT09PT09PT09PT09PT09CiogVGhlIGNsb2NrIGlzIGF1
dG9tYXRpY2FsbHkgcmVxdWVzdGVkIGJ5IHRoZSBsaWJhaGNpX3BsYXRmb3JtLmMKICBkcml2ZXIs
IGRvaW5nIGl0IGluIHRoZSBtdmVidSBkcml2ZXIgaXMgcmVkdW5kYW50LCByZW1vdmUgdGhlIHBh
dGNoCiAgYWRkaW5nIGNsb2NrIHN1cHBvcnQgYXMgY2xvY2sgc3VwcG9ydCBhbHJlYWR5IGV4aXN0
cy4KKiBDaGFuZ2VkIGF1dGhvcnNoaXAgb2YgcGF0Y2ggYWRkaW5nIGEgU0FUQSBlbnVtIGluIHRo
ZSBQSFkgY29yZS4KKiBBZGRlZCBTdWdnZXN0ZWQtYnkgdGFnIHRvIHRoZSBwYXRjaCBmaXhpbmcg
dGhlIFNBVEEgbm9kZSBzY29wZSBpbiBEVCwKICB0byB0aGUgcGF0Y2ggYWRkaW5nIFBIWSBmcmFt
ZXdvcmsgY29tcGxpYW5jZSB0byB0aGUKICBsaWJhaGNpX3BsYXRmb3JtIGRyaXZlciBhbmQgdG8g
dGhlIERUIHBhdGNoIGFkZGluZyB0aGUgU0FUQSBQSFkKICBwcm9wZXJ0eS4KKiBBZGQgYSBmbGFn
IHRvIGRvIG5vdCBkaXNhYmxlL2VuYWJsZSB0aGUgUEhZIGZvciBjb21wYXRpYmlsaXR5CiAgcmVh
c29ucyBhbmQgdG8gYXZvaWQgdG8gYnJlYWsgdW50ZXN0ZWQgYm9hcmRzIHdpdGggdGhpcyBjaGFu
Z2UuCiAgVGhlIGZsYWcgaXMgY2FsbGVkIEFIQ0lfSEZMQUdfTUFOQUdFX1BIWVMuCiogVGhlIG12
ZWJ1IGFoY2kgZHJpdmVyIGlzIGVkaXRlZCB0byBlbmFibGUgdGhpcyBmbGFnIG9ubHkgb24gQTM3
MDAuCgoKTWlxdWVsIFJheW5hbCAoNik6CiAgYXRhOiBsaWJhaGNpX3BsYXRmb3JtOiBjb21wbHkg
dG8gUEhZIGZyYW1ld29yawogIGF0YTogYWhjaTogbXZlYnU6IHJlbW92ZSBzdGFsZSBjb21tZW50
CiAgYXRhOiBhaGNpOiBtdmVidTogZG8gQXJtYWRhIDM4eCBjb25maWd1cmF0aW9uIG9ubHkgb24g
cmVsZXZhbnQgU29DcwogIGF0YTogYWhjaTogbXZlYnU6IGFkZCBBcm1hZGEgMzcwMCBpbml0aWFs
aXphdGlvbiBuZWVkZWQgZm9yIFMyUkFNCiAgQVJNNjQ6IGR0czogbWFydmVsbDogYXJtYWRhLTM3
eHg6IGRlY2xhcmUgU0FUQSBjbG9jawogIEFSTTY0OiBkdHM6IG1hcnZlbGw6IGFybWFkYS0zNzIw
LWVzcHJlc3NvYmluOiBkZWNsYXJlIFNBVEEgUEhZCiAgICBwcm9wZXJ0eQoKIC4uLi9kdHMvbWFy
dmVsbC9hcm1hZGEtMzcyMC1lc3ByZXNzb2Jpbi5kdHMgICB8ICAyICsKIGFyY2gvYXJtNjQvYm9v
dC9kdHMvbWFydmVsbC9hcm1hZGEtMzd4eC5kdHNpICB8ICAxICsKIGRyaXZlcnMvYXRhL2FoY2ku
aCAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyICsKIGRyaXZlcnMvYXRhL2FoY2lfbXZl
YnUuYyAgICAgICAgICAgICAgICAgICAgICB8IDg4ICsrKysrKysrKysrKysrLS0tLS0KIGRyaXZl
cnMvYXRhL2xpYmFoY2lfcGxhdGZvcm0uYyAgICAgICAgICAgICAgICB8IDE5ICsrKy0KIDUgZmls
ZXMgY2hhbmdlZCwgODcgaW5zZXJ0aW9ucygrKSwgMjUgZGVsZXRpb25zKC0pCgotLSAKMi4xOS4x
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
YXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJt
LWtlcm5lbAo=
