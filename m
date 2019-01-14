Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E56C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:01:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FE692086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Exff1rjV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE692086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q2EBncsC8KDm+5C0Vw85HaKGyGqWfB4LdcuknrRoTUc=; b=Exff1rjVgKrt2F
	KhvUG7Uvm62VYMNq06xpzEK42PQyLGxjdoeoR6ccaRbjJ8K0z6aWbjVA2MHv3LD5J9yYau6kMXmtl
	J5nvvWytI6eo5TD4PG3TIirO0vc2p8RbJGfWv8pHjnkErwCvIAqL4wYMZMYsN3cAfqFSesc0/B1IO
	MVkYV9JfifbVOJLLVsrKUomfIjUtVlu1JItcaigcYv7e9iBzsVh5F1KdWT3/3cVJNgyKOMzj7PhFF
	LxMK3vHvwPormv/vMyFC0OBKRjYFGHGN8MUp9Bi+sQdpbtJv/pZsptiBqyqVz6XF4tiBNvreCfZtH
	9QltWyBEj0YwPGqAYZSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giz44-0006vh-IM; Mon, 14 Jan 2019 10:01:52 +0000
Received: from ozlabs.org ([2401:3900:2:1::2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giz1M-0002zm-N5
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 09:59:28 +0000
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43dTSt3ZpZz9sBQ;
 Mon, 14 Jan 2019 20:58:54 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/15] arch: add split IPC system calls where needed
In-Reply-To: <87pnsz28k2.fsf@concordia.ellerman.id.au>
References: <20190110162435.309262-1-arnd@arndb.de>
 <20190110162435.309262-15-arnd@arndb.de>
 <87pnsz28k2.fsf@concordia.ellerman.id.au>
Date: Mon, 14 Jan 2019 20:58:52 +1100
Message-ID: <87muo31rxf.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_015905_452392_489F9848 
X-CRM114-Status: UNSURE (   9.18  )
X-CRM114-Notice: Please train this message.
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
Cc: dalias@libc.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 catalin.marinas@arm.com, will.deacon@arm.com, linux@dominikbrodowski.net,
 jcmvbkbc@gmail.com, deepa.kernel@gmail.com, hpa@zytor.com,
 sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, dave@stgolabs.net,
 deller@gmx.de, x86@kernel.org, linux@armlinux.org.uk, mingo@redhat.com,
 geert@linux-m68k.org, firoz.khan@linaro.org, mattst88@gmail.com,
 fenghua.yu@intel.com, Arnd Bergmann <arnd@arndb.de>, heiko.carstens@de.ibm.com,
 linux-m68k@lists.linux-m68k.org, ink@jurassic.park.msu.ru, luto@kernel.org,
 tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, monstr@monstr.eu,
 tony.luck@intel.com, linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org,
 paul.burton@mips.com, ebiederm@xmission.com, linux-alpha@vger.kernel.org,
 schwidefsky@de.ibm.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

TWljaGFlbCBFbGxlcm1hbiA8bXBlQGVsbGVybWFuLmlkLmF1PiB3cml0ZXM6Cj4gSGkgQXJuZCwK
Pgo+IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+IHdyaXRlczoKPj4gVGhlIElQQyBzeXN0
ZW0gY2FsbCBoYW5kbGluZyBpcyBoaWdobHkgaW5jb25zaXN0ZW50IGFjcm9zcyBhcmNoaXRlY3R1
cmVzLAo+PiBzb21lIHVzZSBzeXNfaXBjLCBzb21lIHVzZSBzZXBhcmF0ZSBjYWxscywgYW5kIHNv
bWUgdXNlIGJvdGguICBXZSBhbHNvCj4+IGhhdmUgc29tZSBhcmNoaXRlY3R1cmVzIHRoYXQgcmVx
dWlyZSBwYXNzaW5nIElQQ182NCBpbiB0aGUgZmxhZ3MsIGFuZAo+PiBvdGhlcnMgdGhhdCBzZXQg
aXQgaW1wbGljaXRseS4KLi4uCj4KPiBXZSBhbHJlYWR5IGhhdmUgYSBnYXAgYXQgMzY2LTM3NyBm
cm9tIHdoZW4gd2UgdHJpZWQgdG8gYWRkIHRoZSBzcGxpdCBJUEMKPiBjYWxscyBhIGZldyB5ZWFy
cyBiYWNrLgo+Cj4gSSBndWVzcyBJIGRvbid0IG1pbmQgbGVhdmluZyB0aGF0IGdhcCBhbmQgdXNp
bmcgdGhlIGNvbW1vbiBudW1iZXJzIGFzCj4geW91J3ZlIGRvbmUgaGVyZS4KPgo+IEJ1dCBpdCB3
b3VsZCBiZSBnb29kIHRvIGFkZCBhIGNvbW1lbnQgcG9pbnRpbmcgb3V0IHRoYXQgd2UgaGF2ZSBy
b29tCj4gYXQgMzY2IGZvciBtb3JlIGFyY2ggc3BlY2lmaWMgc3lzY2FsbHMgYXMgd2VsbC4KPgo+
IGNoZWVycwoKR3Vlc3MgSSBzZW50IHRoYXQgb25lIHR3aWNlLiDwn6SmCgpjaGVlcnMKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJu
ZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
