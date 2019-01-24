Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DF4C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:31:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 424F3218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZhOc7WKs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 424F3218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XlqKxZA0xsHQYqZCKzGeEPFLwdfNeoLOy7uevNbzV/4=; b=ZhOc7WKs6bRVbN
	vu6mcuWKnfPZRvl72GTPfGEkDzG1+InQfhbRGEv4F+p3NL7d4Pnb+zTAAd6OQgRUWi5+GUuKqQOKM
	vck805/geoBFV5JBQKvEUcxvmlsWjbI2SRmbMQCL4Ap69hLyvvE1If/o3BOtk2K/IXNU+G0LLXyGM
	V8PnzUgyBfZU1UDk9vyV4T9FdBx1u5esCrFQeHCa2EmYV52rPVdVWqtasty+sCI+OiNNrzxE04B56
	GCVur/GwvWSFauuLu4fg1Hmrrh8GApL7sX3Fh4CeIKLGAMyvtJpHyUga2DQAbTkoK9d15agkMHK46
	lzBeOiJWYnkt9z1HqLgA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmbLw-0007uX-21; Thu, 24 Jan 2019 09:31:16 +0000
Received: from mail.netline.ch ([148.251.143.178]
 helo=netline-mail3.netline.ch)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmbLs-0007u7-E4
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 09:31:14 +0000
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 26AA72A6056;
 Thu, 24 Jan 2019 10:31:09 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 7iihVwdqjhc9; Thu, 24 Jan 2019 10:31:08 +0100 (CET)
Received: from thor (39.1.199.178.dynamic.wline.res.cust.swisscom.ch
 [178.199.1.39])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id 5D1C22A6054;
 Thu, 24 Jan 2019 10:31:07 +0100 (CET)
Received: from [::1] by thor with esmtp (Exim 4.92-RC4)
 (envelope-from <michel@daenzer.net>)
 id 1gmbLm-0000IY-Sy; Thu, 24 Jan 2019 10:31:06 +0100
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Christoph Hellwig <hch@infradead.org>
References: <ccc775d3-3053-ab79-dac8-4feb28e8e690@daenzer.net>
 <CAKv+Gu-9VKL5RjScbKss4YfH1Cb8WbXmzU_0UsStnoXJcML7Rg@mail.gmail.com>
 <850b6aee-0040-c333-b125-45211c18ada5@daenzer.net>
 <CAKv+Gu99zHqcQtj6TiOXAr3Qa6WWhKem+DHVA_mAQ0-Bc0Vbqw@mail.gmail.com>
 <047667fd-17be-1c37-5d2a-26768cfd6ab8@daenzer.net>
 <CAKv+Gu_VBd8agHASc5RS0eCgyXP64Lt_i4yPuBjKwGQ+5Lpd5Q@mail.gmail.com>
 <CADnq5_O1uxCrSksfF127AZTfbmdukxmqGdh2Ee0zM6CqgG_Mhg@mail.gmail.com>
 <CAKv+Gu-4uYh_HD_5Ry_L80Nf5zpRhT4oJYhhG5_8g3gSzBs2tg@mail.gmail.com>
 <20190123071521.GB20526@infradead.org>
 <CAKv+Gu8+77uZHJ6ZYjGNcKQL8C3cT5Ree+TcTVmkQXAHV-ADyg@mail.gmail.com>
 <20190123164428.GA9367@infradead.org>
 <CAKv+Gu-9vEKu8mG-o+-4M1ZcgZmTTJVfEdNS9R27AFX8P5sqyQ@mail.gmail.com>
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
Message-ID: <ee261b46-1a83-6af2-31fe-fb9f30894c1e@daenzer.net>
Date: Thu, 24 Jan 2019 10:31:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-9vEKu8mG-o+-4M1ZcgZmTTJVfEdNS9R27AFX8P5sqyQ@mail.gmail.com>
Content-Language: en-CA
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_013112_775720_49CBD080 
X-CRM114-Status: GOOD (  13.41  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, David Airlie <airlied@linux.ie>,
 Huang Rui <ray.huang@amd.com>, dri-devel <dri-devel@lists.freedesktop.org>,
 Junwei Zhang <Jerry.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Sean Paul <sean@poorly.run>, Christian Koenig <christian.koenig@amd.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMjAxOS0wMS0yMyA1OjUyIHAubS4sIEFyZCBCaWVzaGV1dmVsIHdyb3RlOgo+IE9uIFdlZCwg
MjMgSmFuIDIwMTkgYXQgMTc6NDQsIENocmlzdG9waCBIZWxsd2lnIDxoY2hAaW5mcmFkZWFkLm9y
Zz4gd3JvdGU6Cj4+Cj4+IEkgdGhpbmsgd2UganVzdCB3YW50IGEgZHJpdmVyLWxvY2FsIGNoZWNr
IGZvciB0aG9zZSBjb21iaW5hdGlvbnMKPj4gd2hlcmUgd2Uga25vdyB0aGlzIGhhY2sgYWN0dWFs
bHkgd29ya3MsIHdoaWNoIHJlYWxseSBqdXN0IHNlZW1zCj4+IHRvIGJlIHg4Ni02NCB3aXRoIFBB
VC4gU29tZXRoaW5nIGxpa2UgdGhlIHBhdGNoIGJlbG93LCBidXQgbWF5YmUgd2l0aAo+PiBldmVu
IG1vcmUgc3Ryb25nIHdhcm5pbmdzIHRvIG5vdCBkbyBzb21ldGhpbmcgbGlrZSB0aGlzIGVsc2V3
aGVyZToKPiAKPiBJIGFncmVlIHRoYXQgeW91ciBwYXRjaCBzZWVtcyBsaWtlIHRoZSByaWdodCB3
YXkgdG8gZW5zdXJlIHRoYXQgdGhlIFdDCj4gb3B0aW1pemF0aW9uIGhhY2sgaXMgb25seSB1c2Vk
IHdoZXJlIHdlIGtub3cgaXQgd29ya3MuCj4gCj4gQnV0IG15IGNvbmNlcm4gaXMgdGhhdCBpdCBz
ZWVtcyBsaWtlbHkgdGhhdCBub24tY2FjaGUgY29oZXJlbnQKPiBpbXBsZW1lbnRhdGlvbnMgYXJl
IHJlbHlpbmcgb24gdGhpcyBoYWNrIGFzIHdlbGwuCgpJJ3ZlIGJlZW4gdHJ5aW5nIHRvIHRlbGwg
eW91IHRoZXkgY2FuJ3QgcmVseSBvbiB0aGF0LCBiZWNhdXNlIHRoZSBhbWRncHUKZHJpdmVyIGRv
ZXNuJ3QgdXNlIHRoaXMgZnVuY3Rpb25hbGl0eSBmb3IgZnVuZGFtZW50YWxzIHN1Y2ggYXMgcmlu
ZwpidWZmZXJzIHVzZWQgZm9yIGZlZWRpbmcgdGhlIGhhcmR3YXJlIHdpdGggY29tbWFuZHMuIElu
c3RlYWQsIGZvciB0aG9zZQppdCByZWxpZXMgb24gc25vb3BlZCBQQ0llIHRyYW5zZmVycyBiZWlu
ZyBjb2hlcmVudCB3aXRoIHRoZSBDUFUgY2FjaGVzLgoKCj4+IC0jZWxpZiBkZWZpbmVkKENPTkZJ
R19YODYpICYmICFkZWZpbmVkKENPTkZJR19YODZfUEFUKQo+PiAtICAgICAgIC8qIERvbid0IHRy
eSB0byBlbmFibGUgd3JpdGUtY29tYmluaW5nIHdoZW4gaXQgY2FuJ3Qgd29yaywgb3IgdGhpbmdz
Cj4+IC0gICAgICAgICogbWF5IGJlIHNsb3cKPj4gLSAgICAgICAgKiBTZWUgaHR0cHM6Ly9idWdz
LmZyZWVkZXNrdG9wLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9ODg3NTgKPj4gLSAgICAgICAgKi8KPj4g
LQo+PiAtI2lmbmRlZiBDT05GSUdfQ09NUElMRV9URVNUCj4+IC0jd2FybmluZyBQbGVhc2UgZW5h
YmxlIENPTkZJR19NVFJSIGFuZCBDT05GSUdfWDg2X1BBVCBmb3IgYmV0dGVyIHBlcmZvcm1hbmNl
IFwKPj4gLSAgICAgICAgdGhhbmtzIHRvIHdyaXRlLWNvbWJpbmluZwo+PiAtI2VuZGlmCj4+IC0K
Pj4gLSAgICAgICBpZiAoYm8tPmZsYWdzICYgQU1ER1BVX0dFTV9DUkVBVEVfQ1BVX0dUVF9VU1dD
KQo+PiAtICAgICAgICAgICAgICAgRFJNX0lORk9fT05DRSgiUGxlYXNlIGVuYWJsZSBDT05GSUdf
TVRSUiBhbmQgQ09ORklHX1g4Nl9QQVQgZm9yICIKPj4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgImJldHRlciBwZXJmb3JtYW5jZSB0aGFua3MgdG8gd3JpdGUtY29tYmluaW5nXG4iKTsK
CkZXSVcsIHBsZWFzZSBkb24ndCBkcm9wIHRoZXNlIGNvbXBpbGUgYW5kIGJ1aWxkIHRpbWUgd2Fy
bmluZ3Mgd2hlcmUgd2UKY29udGludWUgdG8gdGFrZSBhZHZhbnRhZ2Ugb2YgUEFULgoKCi0tIApF
YXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0
cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAg
ICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
