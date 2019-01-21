Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCCAC31681
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:55:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E256E2084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WnpBkfXR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E256E2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+GgjEWTjOyRn1igHQSKUMN1bVJ2D5b+6zAjOncu6zeM=; b=WnpBkfXRlhN8h3
	u2i+X5jhQ2d6TCnR3Q6APbwx4IFmokCWGSFWBlk1o2SdKgx2TgtI01MlkhxNa0OGzHt/jpVbyBpkv
	27NwmmhTcu7UIUszC5wplOJLdAxr1LLPGcQKk5zicS007kPIJRNl8TW0MMG5CHwOYUM/xNvlx/oAo
	eI/Ez9/qw6f1RgaX4KdT1pPW/6jKN/2VMNNt51W/bk+dg0Q3nsFNCmOl9jpCXGocidzsFlxReTJpt
	SzBtNWRVDniiXJmGq9Ov8cSCuFYhsaSakRXWDzIvHO4H77PhGuxzl4X2JKMCNvWHJz4dIskhxbQMM
	n0Nd+of6T2Q3zBvsfaMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gldnA-00058N-JO; Mon, 21 Jan 2019 17:55:24 +0000
Received: from mail.netline.ch ([148.251.143.178]
 helo=netline-mail3.netline.ch)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gldn6-00056w-3I
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 17:55:22 +0000
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 9FB932A6055;
 Mon, 21 Jan 2019 18:55:13 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id oDS3HFlYredT; Mon, 21 Jan 2019 18:55:13 +0100 (CET)
Received: from thor (39.1.199.178.dynamic.wline.res.cust.swisscom.ch
 [178.199.1.39])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id DFE7B2A6054;
 Mon, 21 Jan 2019 18:55:10 +0100 (CET)
Received: from [::1] by thor with esmtp (Exim 4.92-RC4)
 (envelope-from <michel@daenzer.net>)
 id 1gldmv-0002S7-83; Mon, 21 Jan 2019 18:55:09 +0100
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Christoph Hellwig <hch@infradead.org>
References: <20190121100617.2311-1-ard.biesheuvel@linaro.org>
 <20190121150734.GA30582@infradead.org>
 <CAKv+Gu-hR=uieOeg7QheA5yfAycUoi2vjZsDUvROKVjW4eUNqw@mail.gmail.com>
 <20190121155908.GA8084@infradead.org>
 <CAKv+Gu8LzS9OgvVnzUT8BZWVgDmx4OfqNiPSf+8=riY_LByN-g@mail.gmail.com>
 <20190121162238.GA17651@infradead.org>
 <CAKv+Gu-5V-UjP_YzZBCEsa+o_G6BRSVw2ZimYGNEfRGf-aRPNg@mail.gmail.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Openpgp: preference=signencrypt
Autocrypt: addr=michel@daenzer.net; prefer-encrypt=mutual; keydata=
 mQGiBDsehS8RBACbsIQEX31aYSIuEKxEnEX82ezMR8z3LG8ktv1KjyNErUX9Pt7AUC7W3W0b
 LUhu8Le8S2va6hi7GfSAifl0ih3k6Bv1Itzgnd+7ZmSrvCN8yGJaHNQfAevAuEboIb+MaVHo
 9EMJj4ikOcRZCmQWw7evu/D9uQdtkCnRY9iJiAGxbwCguBHtpoGMxDOINCr5UU6qt+m4O+UD
 /355ohBBzzyh49lTj0kTFKr0Ozd20G2FbcqHgfFL1dc1MPyigej2gLga2osu2QY0ObvAGkOu
 WBi3LTY8Zs8uqFGDC4ZAwMPoFy3yzu3ne6T7d/68rJil0QcdQjzzHi6ekqHuhst4a+/+D23h
 Za8MJBEcdOhRhsaDVGAJSFEQB1qLBACOs0xN+XblejO35gsDSVVk8s+FUUw3TSWJBfZa3Imp
 V2U2tBO4qck+wqbHNfdnU/crrsHahjzBjvk8Up7VoY8oT+z03sal2vXEonS279xN2B92Tttr
 AgwosujguFO/7tvzymWC76rDEwue8TsADE11ErjwaBTs8ZXfnN/uAANgPLQjTWljaGVsIERh
 ZW56ZXIgPG1pY2hlbEBkYWVuemVyLm5ldD6IXgQTEQIAHgUCQFXxJgIbAwYLCQgHAwIDFQID
 AxYCAQIeAQIXgAAKCRBaga+OatuyAIrPAJ9ykonXI3oQcX83N2qzCEStLNW47gCeLWm/QiPY
 jqtGUnnSbyuTQfIySkK5AQ0EOx6FRRAEAJZkcvklPwJCgNiw37p0GShKmFGGqf/a3xZZEpjI
 qNxzshFRFneZze4f5LhzbX1/vIm5+ZXsEWympJfZzyCmYPw86QcFxyZflkAxHx9LeD+89Elx
 bw6wT0CcLvSv8ROfU1m8YhGbV6g2zWyLD0/naQGVb8e4FhVKGNY2EEbHgFBrAAMGA/0VktFO
 CxFBdzLQ17RCTwCJ3xpyP4qsLJH0yCoA26rH2zE2RzByhrTFTYZzbFEid3ddGiHOBEL+bO+2
 GNtfiYKmbTkj1tMZJ8L6huKONaVrASFzLvZa2dlc2zja9ZSksKmge5BOTKWgbyepEc5qxSju
 YsYrX5xfLgTZC5abhhztpYhGBBgRAgAGBQI7HoVFAAoJEFqBr45q27IAlscAn2Ufk2d6/3p4
 Cuyz/NX7KpL2dQ8WAJ9UD5JEakhfofed8PSqOM7jOO3LCA==
Message-ID: <59ccf85d-b99d-b5c8-ea87-66c2a892e197@daenzer.net>
Date: Mon, 21 Jan 2019 18:55:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-5V-UjP_YzZBCEsa+o_G6BRSVw2ZimYGNEfRGf-aRPNg@mail.gmail.com>
Content-Language: en-CA
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_095520_440331_FE6FDD5F 
X-CRM114-Status: GOOD (  12.13  )
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
Cc: David Zhou <David1.Zhou@amd.com>, Michel Daenzer <michel.daenzer@amd.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Will Deacon <will.deacon@arm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 Huang Rui <ray.huang@amd.com>, dri-devel <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Junwei Zhang <Jerry.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Sean Paul <sean@poorly.run>, Christian Koenig <christian.koenig@amd.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMjAxOS0wMS0yMSA1OjMwIHAubS4sIEFyZCBCaWVzaGV1dmVsIHdyb3RlOgo+IE9uIE1vbiwg
MjEgSmFuIDIwMTkgYXQgMTc6MjIsIENocmlzdG9waCBIZWxsd2lnIDxoY2hAaW5mcmFkZWFkLm9y
Zz4gd3JvdGU6Cj4gCj4+IFVudGlsIHRoYXQgaGFwcGVucyB3ZSBzaG91bGQganVzdCBjaGFuZ2Ug
dGhlIGRyaXZlciBpZmRlZnMgdG8gZGVmYXVsdAo+PiB0aGUgaGFja3MgdG8gb2ZmIGFuZCBvbmx5
IGVuYWJsZSB0aGVtIG9uIHNldHVwcyB3aGVyZSB3ZSAxMDAlCj4+IHBvc2l0aXZlbHkga25vdyB0
aGF0IHRoZXkgYWN0dWFsbHkgd29yay4gIEFuZCBkb2N1bWVudCB0aGF0IGZhY3QKPj4gaW4gYmln
IGZhdCBjb21tZW50cy4KPiAKPiBXZWxsLCBhcyBJIG1lbnRpb25lZCBpbiBteSBjb21taXQgbG9n
IGFzIHdlbGwsIGlmIHdlIGRlZmF1bHQgdG8gb2ZmCj4gdW5sZXNzIENPTkZJR19YODYsIHdlIG1h
eSBicmVhayB3b3JraW5nIHNldHVwcyBvbiBNSVBTIGFuZCBQb3dlciB3aGVyZQo+IHRoZSBkZXZp
Y2UgaXMgaW4gZmFjdCBub24tY2FjaGUgY29oZXJlbnQsIGFuZCByZWxpZXMgb24gdGhpcwo+ICdv
cHRpbWl6YXRpb24nIHRvIGdldCB0aGluZ3Mgd29ya2luZy4KCkZXSVcsIHRoZSBhbWRncHUgZHJp
dmVyIGRvZXNuJ3QgcmVseSBvbiBub24tc25vb3BlZCB0cmFuc2ZlcnMgZm9yCmNvcnJlY3QgYmFz
aWMgb3BlcmF0aW9uICh0aGUgc2NlbmFyaW8gQ2hyaXN0aWFuIGJyb3VnaHQgdXAgaXMgYSB2ZXJ5
CnNwZWNpYWxpemVkIHVzZS1jYXNlKSwgc28gdGhhdCBzaG91bGRuJ3QgYmUgYW4gaXNzdWUuCgoK
LS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAg
ICBodHRwOi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAg
ICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
