Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C55C10F00
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:21:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9BB920663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bSbE1Np9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9BB920663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fG7vrG6GxbLucZKXFhUhtQ4k9ECDCUtMU7ZF8aW6hzg=; b=bSbE1Np9hUI6dU
	dyXiAZFIi2kRWd7qkL2uOzS4OA3ROM37e1qN4Xpsref+R5yXQVAPAL1ykUWujcg2llItj9lHlh1LJ
	wA0zmz3nLkhJ5Mf58yGAmUIHMxtOi74ixgTKlA+VjOYL9sJk+7kgILXqOfYpLp9qQkItu+/mQMZCZ
	5EQ76tfLpkmMC0DnZ+zvWYWGppcNdZCVmBB4+XvjVnGgBr8z9xPb+04gUw4rnLcYsHbvpvi0oqT9O
	F1NVtgcigNmbPoyMVMAmJdmR1tIbyyBRv8wq285VRMdnAgCYI8pSwKIBjXmQ2EgqXgz92+1Wl3lSa
	lRqdjpvUto9RZSPhVDog==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyGBx-0001x8-3u; Mon, 25 Feb 2019 13:21:09 +0000
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyGBu-0001wS-DG; Mon, 25 Feb 2019 13:21:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id A112F236F9A0D; Mon, 25 Feb 2019 14:21:03 +0100 (CET)
Date: Mon, 25 Feb 2019 14:21:03 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: hpa@zytor.com
Subject: Re: [RFC][PATCH] objtool: STAC/CLAC validation
Message-ID: <20190225132103.GD32494@hirez.programming.kicks-ass.net>
References: <20190219124808.GG8501@fuggles.cambridge.arm.com>
 <f8e99706-4e3b-68ec-7a3e-6e6dd876ad2f@zytor.com>
 <cb221e71-243d-fdbd-1d18-b175bc88979b@arm.com>
 <alpine.DEB.2.21.1902212231490.1612@nanos.tec.linutronix.de>
 <CAHk-=wh1B9eRG=gj7wsFVC5XNEedk8Edive-2cQok6T2dNq2aQ@mail.gmail.com>
 <alpine.DEB.2.21.1902221853330.1666@nanos.tec.linutronix.de>
 <20190222222635.GK14054@worktop.programming.kicks-ass.net>
 <CE650687-ECB3-4A7C-96BA-A061D54AEF40@zytor.com>
 <20190223083942.GF32477@hirez.programming.kicks-ass.net>
 <15DE0017-9AE5-4E7A-96CD-E5E9F5B72516@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <15DE0017-9AE5-4E7A-96CD-E5E9F5B72516@zytor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Julien Thierry <julien.thierry@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, valentin.schneider@arm.com,
 Will Deacon <will.deacon@arm.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>,
 James Morse <james.morse@arm.com>, Andrew Lutomirski <luto@kernel.org>,
 Brian Gerst <brgerst@gmail.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>,
 "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gTW9uLCBGZWIgMjUsIDIwMTkgYXQgMTI6NDc6MDBBTSAtMDgwMCwgaHBhQHp5dG9yLmNvbSB3
cm90ZToKPiBJdCBkb2Vzbid0IGhhdmUgdG8gdW5kZXJzdGFuZCB0aGUgY29udGVudHMgb2YgdGhl
IG1lbW9wLCBidXQgaXQgc2VlbXMKPiB0aGF0IHRoZSBwcmVzZW5jZSBvZiBhIG1vZHJtIHdpdGgg
bW9kZSDiiaAgMyBzaG91bGQgYmUgcGxlbnR5LiBJdCBuZWVkcwo+IHRvIGtub3cgdGhhdCBtdWNo
IGluIG9yZGVyIHRvIGtub3cgdGhlIGxlbmd0aCBvZiBpbnN0cnVjdGlvbnMgYW55d2F5Lgo+IEZv
ciBleHRyYSBjcmVkaXQsIGlnbm9yZSBMRUEgb3IgaGludGluZyBpbnN0cnVjdGlvbnMuCgpBIGxp
dHRsZSBzb21ldGhpbmcgbGlrZSBzbyB0aGVuPwoKYXJjaC94ODYva2VybmVsL2ZwdS9zaWduYWwu
bzogd2FybmluZzogb2JqdG9vbDogLmFsdGluc3RyX3JlcGxhY2VtZW50KzB4OWM6IFVBQ0NFU1Mg
ZGlzYWJsZSB3aXRob3V0IE1FTU9QczogY29weV9mcHN0YXRlX3RvX3NpZ2ZyYW1lKCkKCjAwMDAw
MDAwMDIzYyAgMDAwMjAwMDAwMDAyIFJfWDg2XzY0X1BDMzIgICAgIDAwMDAwMDAwMDAwMDAwMDAg
LnRleHQgKyA2MDQKMDAwMDAwMDAwMjQwICAwMDA3MDAwMDAwMDIgUl9YODZfNjRfUEMzMiAgICAg
MDAwMDAwMDAwMDAwMDAwMCAuYWx0aW5zdHJfcmVwbGFjZW1lbnQgKyA5OQowMDAwMDAwMDAyNDkg
IDAwMDIwMDAwMDAwMiBSX1g4Nl82NF9QQzMyICAgICAwMDAwMDAwMDAwMDAwMDAwIC50ZXh0ICsg
NjEwCjAwMDAwMDAwMDI0ZCAgMDAwNzAwMDAwMDAyIFJfWDg2XzY0X1BDMzIgICAgIDAwMDAwMDAw
MDAwMDAwMDAgLmFsdGluc3RyX3JlcGxhY2VtZW50ICsgOWMKCi50ZXh0Cgo2MDQ6ICAgOTAgICAg
ICAgICAgICAgICAgICAgICAgbm9wCjYwNTogICA5MCAgICAgICAgICAgICAgICAgICAgICBub3AK
NjA2OiAgIDkwICAgICAgICAgICAgICAgICAgICAgIG5vcAo2MDc6ICAgODMgY2UgMDMgICAgICAg
ICAgICAgICAgb3IgICAgICQweDMsJWVzaQo2MGE6ICAgODkgYjMgMDAgMDIgMDAgMDAgICAgICAg
bW92ICAgICVlc2ksMHgyMDAoJXJieCkKNjEwOiAgIDkwICAgICAgICAgICAgICAgICAgICAgIG5v
cAo2MTE6ICAgOTAgICAgICAgICAgICAgICAgICAgICAgbm9wCjYxMjogICA5MCAgICAgICAgICAg
ICAgICAgICAgICBub3AKCi5hbHRpbnN0cl9yZXBsYWNlbWVudAoKOTk6ICAgMGYgMDEgY2IgICAg
ICAgICAgICAgICAgc3RhYwo5YzogICAwZiAwMSBjYSAgICAgICAgICAgICAgICBjbGFjCgpXaGlj
aCBsb29rcyBsaWtlIHRoZSB0b29sIGZhaWxlZCB0byByZWNvZ25pc2UgdGhhdCBNT1YgYXMgYSBt
ZW1vcC4KCgoKLS0tCi0tLSBhL3Rvb2xzL29ianRvb2wvYXJjaC5oCisrKyBiL3Rvb2xzL29ianRv
b2wvYXJjaC5oCkBAIC0zNyw3ICszNyw4IEBACiAjZGVmaW5lIElOU05fQ0xBQwkJMTIKICNkZWZp
bmUgSU5TTl9TVEQJCTEzCiAjZGVmaW5lIElOU05fQ0xECQkxNAotI2RlZmluZSBJTlNOX09USEVS
CQkxNQorI2RlZmluZSBJTlNOX01FTU9QCQkxNQorI2RlZmluZSBJTlNOX09USEVSCQkxNgogI2Rl
ZmluZSBJTlNOX0xBU1QJCUlOU05fT1RIRVIKIAogZW51bSBvcF9kZXN0X3R5cGUgewotLS0gYS90
b29scy9vYmp0b29sL2FyY2gveDg2L2RlY29kZS5jCisrKyBiL3Rvb2xzL29ianRvb2wvYXJjaC94
ODYvZGVjb2RlLmMKQEAgLTEyMyw2ICsxMjMsOSBAQCBpbnQgYXJjaF9kZWNvZGVfaW5zdHJ1Y3Rp
b24oc3RydWN0IGVsZiAqCiAJCW1vZHJtX21vZCA9IFg4Nl9NT0RSTV9NT0QobW9kcm0pOwogCQlt
b2RybV9yZWcgPSBYODZfTU9EUk1fUkVHKG1vZHJtKTsKIAkJbW9kcm1fcm0gPSBYODZfTU9EUk1f
Uk0obW9kcm0pOworCisJCWlmIChtb2RybV9tb2QgIT0gMykKKwkJCSp0eXBlID0gSU5TTl9NRU1P
UDsKIAl9CiAKIAlpZiAoaW5zbi5zaWIubmJ5dGVzKQotLS0gYS90b29scy9vYmp0b29sL2NoZWNr
LmMKKysrIGIvdG9vbHMvb2JqdG9vbC9jaGVjay5jCkBAIC0yMDQ3LDYgKzIwNDcsNyBAQCBzdGF0
aWMgaW50IHZhbGlkYXRlX2JyYW5jaChzdHJ1Y3Qgb2JqdG9vCiAJCQkJV0FSTl9GVU5DKCJyZWN1
cnNpdmUgVUFDQ0VTUyBlbmFibGUiLCBzZWMsIGluc24tPm9mZnNldCk7CiAKIAkJCXN0YXRlLnVh
Y2Nlc3MgPSB0cnVlOworCQkJc3RhdGUubWVtb3AgPSBmYWxzZTsKIAkJCWJyZWFrOwogCiAJCWNh
c2UgSU5TTl9DTEFDOgpAQCAtMjA1OCw2ICsyMDU5LDkgQEAgc3RhdGljIGludCB2YWxpZGF0ZV9i
cmFuY2goc3RydWN0IG9ianRvbwogCQkJCWJyZWFrOwogCQkJfQogCisJCQlpZiAoIXN0YXRlLm1l
bW9wICYmIGluc24tPmZ1bmMpCisJCQkJV0FSTl9GVU5DKCJVQUNDRVNTIGRpc2FibGUgd2l0aG91
dCBNRU1PUHM6ICVzKCkiLCBzZWMsIGluc24tPm9mZnNldCwgaW5zbi0+ZnVuYy0+bmFtZSk7CisK
IAkJCXN0YXRlLnVhY2Nlc3MgPSBmYWxzZTsKIAkJCWJyZWFrOwogCkBAIC0yMDc1LDYgKzIwNzks
MTAgQEAgc3RhdGljIGludCB2YWxpZGF0ZV9icmFuY2goc3RydWN0IG9ianRvbwogCQkJc3RhdGUu
ZGYgPSBmYWxzZTsKIAkJCWJyZWFrOwogCisJCWNhc2UgSU5TTl9NRU1PUDoKKwkJCXN0YXRlLm1l
bW9wID0gdHJ1ZTsKKwkJCWJyZWFrOworCiAJCWRlZmF1bHQ6CiAJCQlicmVhazsKIAkJfQotLS0g
YS90b29scy9vYmp0b29sL2NoZWNrLmgKKysrIGIvdG9vbHMvb2JqdG9vbC9jaGVjay5oCkBAIC0z
MSw3ICszMSw3IEBAIHN0cnVjdCBpbnNuX3N0YXRlIHsKIAlpbnQgc3RhY2tfc2l6ZTsKIAl1bnNp
Z25lZCBjaGFyIHR5cGU7CiAJYm9vbCBicF9zY3JhdGNoOwotCWJvb2wgZHJhcCwgZW5kLCB1YWNj
ZXNzLCB1YWNjZXNzX3NhZmUsIGRmOworCWJvb2wgZHJhcCwgZW5kLCB1YWNjZXNzLCB1YWNjZXNz
X3NhZmUsIGRmLCBtZW1vcDsKIAlpbnQgZHJhcF9yZWcsIGRyYXBfb2Zmc2V0OwogCXN0cnVjdCBj
ZmlfcmVnIHZhbHNbQ0ZJX05VTV9SRUdTXTsKIH07CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
