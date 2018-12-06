Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3458C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:14:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91E5220850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DAiWa9Ou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E5220850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WHIeNgI1HB/uXxQoqJ0K81oSu+HNRyCqtXuylEop/6s=; b=DAiWa9OuGYKFlACpMTcoVePit
	efKVU82SNC7kzR9BmXbjDgKrxetolqu8RsBarSkQy4SxfMXmirkfAS4EJMbB/vw/mz1nTWu24crE9
	bnmNBipHLDQcF/tjzEx5JzbVIgy8DlZnie1Mulsy3PKnjPolzrgwnHyhyKDEcTVgI+QCar9Ioz++S
	GKkwDvUWc2R0rpe9JQDDPnLlvx+B6dSH8XqxbZOJrxnPeeAMMI/LPPjPt/hio8uzyyrJPxwkBerfQ
	dZmBUnoYwqTnA9RECtDcSTjsS36YWNAF8wGhiD5+46XQNa/iHtv7/Xgm7KalB5hMnb3zYAoqU7FhP
	CisaSHRgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV02Y-0008E1-Vl; Thu, 06 Dec 2018 20:14:30 +0000
Received: from pegase1.c-s.fr ([93.17.236.30])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV02P-000846-5l; Thu, 06 Dec 2018 20:14:22 +0000
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 439myn3XkTz9tyh6;
 Thu,  6 Dec 2018 21:14:09 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id ihVLVx7cdeCk; Thu,  6 Dec 2018 21:14:09 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 439myn28CBz9tyh5;
 Thu,  6 Dec 2018 21:14:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 5BFF68B89D;
 Thu,  6 Dec 2018 21:14:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id qQSpKWnuL71A; Thu,  6 Dec 2018 21:14:09 +0100 (CET)
Received: from [192.168.232.3] (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7622D8B88E;
 Thu,  6 Dec 2018 21:14:05 +0100 (CET)
Subject: Re: [PATCH 1/2] mips/kgdb: prepare arch_kgdb_ops for constness
To: Daniel Thompson <daniel.thompson@linaro.org>
References: <75bbcdd1e9277d66ebb06e349dda304bd01ce761.1543957194.git.christophe.leroy@c-s.fr>
 <20181206140902.ea6jlwqrbcwyxp5r@holly.lan>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <77351ea7-e153-d293-1016-2dd45cf96fee@c-s.fr>
Date: Thu, 6 Dec 2018 21:14:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181206140902.ea6jlwqrbcwyxp5r@holly.lan>
Content-Language: fr
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_121421_508915_F8F4F02C 
X-CRM114-Status: GOOD (  17.07  )
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
Cc: Rich Felker <dalias@libc.org>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 linux-hexagon@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 x86@kernel.org, Russell King <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>,
 James Hogan <jhogan@kernel.org>, linux-snps-arc@lists.infradead.org,
 uclinux-h8-devel@lists.sourceforge.jp, linux-mips@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, nios2-dev@lists.rocketboards.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Michal Simek <monstr@monstr.eu>, Vineet Gupta <vgupta@synopsys.com>,
 Randy Dunlap <rdunlap@infradead.org>, Douglas Anderson <dianders@chromium.org>,
 Ralf Baechle <ralf@linux-mips.org>, Richard Kuo <rkuo@codeaurora.org>,
 Paul Burton <paul.burton@mips.com>, Jason Wessel <jason.wessel@windriver.com>,
 kgdb-bugreport@lists.sourceforge.net, Ley Foon Tan <lftan@altera.com>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CgpMZSAwNi8xMi8yMDE4IMOgIDE1OjA5LCBEYW5pZWwgVGhvbXBzb24gYSDDqWNyaXTCoDoKPiBP
biBXZWQsIERlYyAwNSwgMjAxOCBhdCAwNDo0MTowOUFNICswMDAwLCBDaHJpc3RvcGhlIExlcm95
IHdyb3RlOgo+PiBNSVBTIGlzIHRoZSBvbmx5IGFyY2hpdGVjdHVyZSBtb2RpZnlpbmcgYXJjaF9r
Z2RiX29wcyBkdXJpbmcgaW5pdC4KPj4gVGhpcyBwYXRjaCBtYWtlcyB0aGUgaW5pdCBzdGF0aWMs
IHNvIHRoYXQgaXQgY2FuIGJlIGNoYW5nZWQgdG8KPj4gY29uc3QgaW4gZm9sbG93aW5nIHBhdGNo
LCBhcyByZWNvbW1lbmRlZCBieSBjaGVja3BhdGNoLnBsCj4+Cj4+IFN1Z2dlc3RlZC1ieTogUGF1
bCBCdXJ0b24gPHBhdWwuYnVydG9uQG1pcHMuY29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3Rv
cGhlIExlcm95IDxjaHJpc3RvcGhlLmxlcm95QGMtcy5mcj4KPiAKPiAgRnJvbSBteSBzaWRlIHRo
aXMgaXMKPiBBY2tlZC1ieTogRGFuaWVsIFRob21wc29uIDxkYW5pZWwudGhvbXBzb25AbGluYXJv
Lm9yZz4KPiAKPiBTaW5jZSB0aGlzIGlzIGEgZGVwZW5kZW5jeSBmb3IgdGhlIG5leHQgcGF0Y2gg
SSdkIGJlIGhhcHB5IHRvIHRha2UgdmlhCj4gbXkgdHJlZS4uLiBidXQgd291bGQgbmVlZCBhbiBh
Y2sgZnJvbSB0aGUgTUlQUyBndXlzIHRvIGRvIHRoYXQuCgpHb3QgYW4gYWNrIGZyb20gTUlQUzoK
QWNrZWQtYnk6IFBhdWwgQnVydG9uIDxwYXVsLmJ1cnRvbkBtaXBzLmNvbT4KCkluY2x1ZGVkIGlu
IGNvbW1pdCB0ZXh0IHYyCgpDaHJpc3RvcGhlCgo+IAo+IAo+IERhbmllbC4KPiAKPj4gLS0tCj4+
ICAgYXJjaC9taXBzL2tlcm5lbC9rZ2RiLmMgfCAxNiArKysrKysrLS0tLS0tLS0tCj4+ICAgMSBm
aWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAt
LWdpdCBhL2FyY2gvbWlwcy9rZXJuZWwva2dkYi5jIGIvYXJjaC9taXBzL2tlcm5lbC9rZ2RiLmMK
Pj4gaW5kZXggZWI2YzBkNTgyNjI2Li4zMWVmZjFiZWM1NzcgMTAwNjQ0Cj4+IC0tLSBhL2FyY2gv
bWlwcy9rZXJuZWwva2dkYi5jCj4+ICsrKyBiL2FyY2gvbWlwcy9rZXJuZWwva2dkYi5jCj4+IEBA
IC0zOTQsMTggKzM5NCwxNiBAQCBpbnQga2dkYl9hcmNoX2hhbmRsZV9leGNlcHRpb24oaW50IHZl
Y3RvciwgaW50IHNpZ25vLCBpbnQgZXJyX2NvZGUsCj4+ICAgCXJldHVybiAtMTsKPj4gICB9Cj4+
ICAgCj4+IC1zdHJ1Y3Qga2dkYl9hcmNoIGFyY2hfa2dkYl9vcHM7Cj4+ICtzdHJ1Y3Qga2dkYl9h
cmNoIGFyY2hfa2dkYl9vcHMgPSB7Cj4+ICsjaWZkZWYgQ09ORklHX0NQVV9CSUdfRU5ESUFOCj4+
ICsJLmdkYl9icHRfaW5zdHIgPSB7IHNwZWNfb3AgPDwgMiwgMHgwMCwgMHgwMCwgYnJlYWtfb3Ag
fSwKPj4gKyNlbHNlCj4+ICsJLmdkYl9icHRfaW5zdHIgPSB7IGJyZWFrX29wLCAweDAwLCAweDAw
LCBzcGVjX29wIDw8IDIgfSwKPj4gKyNlbmRpZgo+PiArfTsKPj4gICAKPj4gICBpbnQga2dkYl9h
cmNoX2luaXQodm9pZCkKPj4gICB7Cj4+IC0JdW5pb24gbWlwc19pbnN0cnVjdGlvbiBpbnNuID0g
ewo+PiAtCQkucl9mb3JtYXQgPSB7Cj4+IC0JCQkub3Bjb2RlID0gc3BlY19vcCwKPj4gLQkJCS5m
dW5jCT0gYnJlYWtfb3AsCj4+IC0JCX0KPj4gLQl9Owo+PiAtCW1lbWNweShhcmNoX2tnZGJfb3Bz
LmdkYl9icHRfaW5zdHIsIGluc24uYnl0ZSwgQlJFQUtfSU5TVFJfU0laRSk7Cj4+IC0KPj4gICAJ
cmVnaXN0ZXJfZGllX25vdGlmaWVyKCZrZ2RiX25vdGlmaWVyKTsKPj4gICAKPj4gICAJcmV0dXJu
IDA7Cj4+IC0tIAo+PiAyLjEzLjMKPj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
