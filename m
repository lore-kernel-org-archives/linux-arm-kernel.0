Return-Path: <SRS0=tR0U=PB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B95C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:30:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF68021721
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QQ6kpzV3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HiBMKHjw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF68021721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4XOTCiN8pK4o6klYDm2aiUtc3MTPW4EoQkcvJBFz/Dw=; b=QQ6kpzV3xSBNSf
	rQUmElV9hpwubuECgXgueGyDOMhhfgk1ZNWALVaIeDuyjM8zkm+vimtTYwZJAZDT1na88+2+Mz11A
	gZFhV+x/TN1DV0I1iW62WqFZDXHvqYbG28vp7/2oS/bCm81KAQ6zGoavt6gXz847HQ5rUHtg6tXO+
	gfHB8y7kmnsgkIiFqClCHu4IiNhPlqTdeWcBKVCRJNVsOKtDwR79h46jr6VA09XJZ6JVcGG3xOf9R
	cJHf2MA0zCKV4CzWTlyHULwQsPs5bW8WYOrScjncU0XnmcLU62EuiMTcSHU4a0ccF+Gti6nhcEHch
	KI/+TJ0KtJSeW7nR/pOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbMZ4-000623-Iq; Mon, 24 Dec 2018 09:30:22 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbMZ0-0004uh-Ad
 for linux-arm-kernel@lists.infradead.org; Mon, 24 Dec 2018 09:30:20 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20181224093002euoutp019a300a538ffe6afdbf6e8395816155e6~zOtlO3Fmq3244432444euoutp01z
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 24 Dec 2018 09:30:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20181224093002euoutp019a300a538ffe6afdbf6e8395816155e6~zOtlO3Fmq3244432444euoutp01z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1545643802;
 bh=uAKEEZEm1A2pmlHTGKCqg24LBajq+uqGaTQ4RjOlC3A=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=HiBMKHjwK8Rlg4AHI5o++ft7OIpIdRgPSM6dBnrGK4U3AR0JdMPNLfbbgibzzRhvZ
 NCorzaaK6ZRmxgTb9TxLPJlHCSOFLJ53euLhMAGRRwwhaeFX/GWpKJJNhuc1vUih21
 7wtjy1DkUnVCyicwGH23UH3/r6Zs928KQIv4V70Y=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20181224093001eucas1p2400b6063cfb3905af1c46c82d78ddfd7~zOtkcTySA0464004640eucas1p2T;
 Mon, 24 Dec 2018 09:30:01 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 59.41.04441.817A02C5; Mon, 24
 Dec 2018 09:30:00 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20181224093000eucas1p2ac8ad8921d120983a3339614f0d2cd95~zOtjmbya40456004560eucas1p2e;
 Mon, 24 Dec 2018 09:30:00 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20181224093000eusmtrp2a6db03670b1c7bd3a73f3b5c3f587745~zOtjXkr_31235812358eusmtrp2K;
 Mon, 24 Dec 2018 09:30:00 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-02-5c20a7189009
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id CC.61.04128.817A02C5; Mon, 24
 Dec 2018 09:30:00 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20181224092959eusmtip1c998ab28f2b2d4b275b38f8f09c5711c~zOti7KvSj2193121931eusmtip1O;
 Mon, 24 Dec 2018 09:29:59 +0000 (GMT)
Subject: Re: [PATCH v4 1/3] driver core: add probe_err log helper
To: Rob Herring <robh@kernel.org>
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <32da3ba6-5662-f468-ae84-debf52f61bd2@samsung.com>
Date: Mon, 24 Dec 2018 10:29:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CABGGisxcHWwhUcQML7XmriK_DLFGjmud3cKt8yp+K4G2CAL=9Q@mail.gmail.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfSxVYRz2Ovece9xcOy52f7usuM3Wx7pY/XG2Gln9cfqnj7W1VlZdnGG5
 6B6EZoy6Ls1HDXERUrumdMvXkNIuc4V8RmimuMrnVFhLk1yH5b/n9zzP+3uf591LYpIuXEaG
 hEWy6jBlqJwQCerafncfAr2rn+erUZqeyWpB9Ms8A07nfDETdHKZgaBLc/WIrpocwumBxkKC
 Nua8RnRl65iQLlrOwej1pnrh8V3MwFAfxjToxoRMVUUqwTQXPRMy1Y8TmMU3gwSTUVOBmKWq
 3WfJS6JjgWxoSDSr9vC+JgqemS4QRNQcjDG0a7BEdFuehmxIoI7Aj6QVLA2JSAlVjiAjM4ng
 h2UE5ukMIT8sIUjOLBVuH9FmabYEPYKW1VlrflhA0KVfQxaXA+ULoz2zm9iRcoM/mlzcYsKo
 RQxSCrOtLQJB7Ye16hHCgsWUN9z7lSewYAHlDvUpZZseJ+oiaMefbnns4V2+edNjQ52DzjuF
 uAVj1B5Iri3AeCyFUXOxNR91RgglBv80RG7gkzC/dIGnHWDWVLPVxgXWG7btCZCU/2HzMYDS
 Imgv0xO8cBRaTH24ZQ+2kdnQ6MHTvvCiL0fIr7eD4QV7PoEd3K97gPG0GLQaCe92g/H3tRiP
 pfCkd4XIQnLdjl66HV10O7ro/t9bggQVSMpGcaoglvMKY28qOKWKiwoLUgSEq6rQxh/r/Gv6
 WY9W+v2NiCKR3FYcI3P1k+DKaC5WZURAYnJH8UO0QYkDlbFxrDr8qjoqlOWMyJkUyKXiW1af
 L0uoIGUke51lI1j1tmpN2sgSUfkJg5I+f0phy0Wk9024ywPinG1by4Pd0k1S07e56DlHqi1h
 cE3RPPVWY9V0ptZqnhmbfrQ8ZO8zudCdF+jk1tOhyPbEDSLwj3c5PdzRuuqQKu5d3Hvja4Ih
 uwBvNK/1X2HrG+/ah8dX7pvQyj5NHR7xCSkref6xGJd9H0h8JBdwwUqvA5iaU/4DOQYAl18D
 AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsVy+t/xu7oSyxViDO6dY7V4OeEwo8XGGetZ
 LaY+fMJm0bx4PZvFwmnLGS02Pb7GanF51xw2i0NT9zJarD1yl91i7pepzBb/9+xgd+D2uHzt
 IrPHzll32T02repk89g/dw27x+Yl9R7v911l8+jbsorR4/MmuQCOKD2bovzSklSFjPziElul
 aEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2Mly9msxRs0a5Yf6KNuYGxRamL
 kZNDQsBEomNCG3sXIxeHkMBSRokzExuYIRLiErvnv4WyhSX+XOtigyh6zShx49ZdsISwgKPE
 rfOvGEFsEQFFid9t01hBipgFPjJLbDz3GqrjFpPE2ts/2UGq2AQ0Jf5uvskGYvMK2ElM/D6D
 BcRmEVCV2NG+mAnEFhWIkDj7ch0jRI2gxMmZT8BqOAUCJU63zmEFsZkF1CX+zLvEDGHLSzRv
 nQ1li0vcejKfaQKj0Cwk7bOQtMxC0jILScsCRpZVjCKppcW56bnFRnrFibnFpXnpesn5uZsY
 gdG77djPLTsYu94FH2IU4GBU4uGtkFKIEWJNLCuuzD3EKMHBrCTCO48RKMSbklhZlVqUH19U
 mpNafIjRFOi5icxSosn5wMSSVxJvaGpobmFpaG5sbmxmoSTOe96gMkpIID2xJDU7NbUgtQim
 j4mDU6qBcYOqd5TjI5Ullxf2HQqUva7G5cIv/27l/emVWfJ6Ml8CDsfbxP584Lv9jVav3YRv
 q1e2yO0IkbnoHqftc1Ugg2Wr6e1bNfn3vdtr256sKAqfYXooz3f7KcGz705tZfob+cl00qNr
 1R2zlhx4xvhh+a599btmNNo/CPqZqu58z3p6/G63x3d4lyixFGckGmoxFxUnAgCBroak9AIA
 AA==
X-CMS-MailID: 20181224093000eucas1p2ac8ad8921d120983a3339614f0d2cd95
X-Msg-Generator: CA
X-RootMTR: 20181220102259eucas1p2f748c68e01cd4e09a266da879722e218
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181220102259eucas1p2f748c68e01cd4e09a266da879722e218
References: <20181220102247.4911-1-a.hajda@samsung.com>
 <CGME20181220102259eucas1p2f748c68e01cd4e09a266da879722e218@eucas1p2.samsung.com>
 <20181220102247.4911-2-a.hajda@samsung.com>
 <20181220111403.GB10978@kroah.com>
 <b9f7cb75-62a0-20f6-0e5b-1553852d81b2@samsung.com>
 <CABGGisxcHWwhUcQML7XmriK_DLFGjmud3cKt8yp+K4G2CAL=9Q@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181224_013018_500344_ABC943CC 
X-CRM114-Status: GOOD (  34.13  )
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
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Mark Brown <broonie@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMjEuMTIuMjAxOCAyMzo0NywgUm9iIEhlcnJpbmcgd3JvdGU6Cj4gT24gVGh1LCBEZWMgMjAs
IDIwMTggYXQgNTozOCBBTSBBbmRyemVqIEhhamRhIDxhLmhhamRhQHNhbXN1bmcuY29tPiB3cm90
ZToKPj4gT24gMjAuMTIuMjAxOCAxMjoxNCwgR3JlZyBLcm9haC1IYXJ0bWFuIHdyb3RlOgo+Pj4g
T24gVGh1LCBEZWMgMjAsIDIwMTggYXQgMTE6MjI6NDVBTSArMDEwMCwgQW5kcnplaiBIYWpkYSB3
cm90ZToKPj4+PiBEdXJpbmcgcHJvYmUgZXZlcnkgdGltZSBkcml2ZXIgZ2V0cyByZXNvdXJjZSBp
dCBzaG91bGQgdXN1YWxseSBjaGVjayBmb3IgZXJyb3IKPj4+PiBwcmludGsgc29tZSBtZXNzYWdl
IGlmIGl0IGlzIG5vdCAtRVBST0JFX0RFRkVSIGFuZCByZXR1cm4gdGhlIGVycm9yLiBUaGlzCj4+
Pj4gcGF0dGVybiBpcyBzaW1wbGUgYnV0IHJlcXVpcmVzIGFkZGluZyBmZXcgbGluZXMgYWZ0ZXIg
YW55IHJlc291cmNlIGFjcXVpc2l0aW9uCj4+Pj4gY29kZSwgYXMgYSByZXN1bHQgaXQgaXMgb2Z0
ZW4gb21pdGVkIG9yIGltcGxlbWVudGVkIG9ubHkgcGFydGlhbGx5Lgo+Pj4+IHByb2JlX2VyciBo
ZWxwcyB0byByZXBsYWNlIHN1Y2ggY29kZSBzZXF1ZW5jZXMgd2l0aCBzaW1wbGUgY2FsbCwgc28g
Y29kZToKPj4+PiAgICAgIGlmIChlcnIgIT0gLUVQUk9CRV9ERUZFUikKPj4+PiAgICAgICAgICAg
ICAgZGV2X2VycihkZXYsIC4uLik7Cj4+Pj4gICAgICByZXR1cm4gZXJyOwo+Pj4+IGJlY29tZXM6
Cj4+Pj4gICAgICByZXR1cm4gcHJvYmVfZXJyKGRldiwgZXJyLCAuLi4pOwo+Pj4gQ2FuIHlvdSBz
aG93IGEgZHJpdmVyIGJlaW5nIGNvbnZlcnRlZCB0byB1c2UgdGhpcyB0byBzaG93IGlmIGl0IHJl
YWxseQo+Pj4gd2lsbCBzYXZlIGEgYnVuY2ggb2YgbGluZXMgYW5kIG1ha2UgdGhpbmdzIHNpbXBs
ZXI/ICBVc3VhbGx5IHlvdSBhcmUKPj4+IHJlcXVlc3RpbmcgbG90cyBvZiByZXNvdXJjZXMgc28g
eW91IG5lZWQgdG8gZG8gbW9yZSB0aGFuIGp1c3QgcmV0dXJuLAo+Pj4geW91IG5lZWQgdG8gY2xl
YW4gc3R1ZmYgdXAgZmlyc3QuCj4+Cj4+IEkgaGF2ZSBwb3N0ZWQgc2FtcGxlIGNvbnZlcnNpb24g
cGF0Y2ggKGdlbmVyYXRlZCBieSBjb2NjaSkgaW4gcHJldmlvdXMKPj4gdmVyc2lvbiBvZiB0aGlz
IHBhdGNoc2V0IFsxXS4KPj4KPj4gSSBkaWQgbm90IHJlLXBvc3RlZCBpdCBhZ2FpbiBhcyBpdCBp
cyBxdWl0ZSBiaWcgcGF0Y2ggYW5kIGl0IHdpbGwgbm90IGJlCj4+IGFwcGxpZWQgd2l0aG91dCBw
cmlvciBzcGxpdHRpbmcgaXQgcGVyIHN1YnN5c3RlbS4KPj4KPj4gUmVnYXJkaW5nIHN0dWZmIGNs
ZWFuaW5nOiBkZXZtXyogdXN1YWxseSBtYWtlcyBpdCB1bm5lY2Vzc2FyeSwgYnV0IGFsc28KPj4g
ZXZlbiB3aXRoIG5lY2Vzc2FyeSBjbGVhbmluZyB5b3UgY2FuIHByb2ZpdCBmcm9tIHByb2JlX2Vy
ciwgeW91IGp1c3QKPj4gY2FsbHMgaXQgd2l0aG91dCBsZWF2aW5nIHByb2JlIC0geW91IGhhdmUg
c3RpbGwgaGFuZGxlZCBjb3JyZWN0bHkgcHJvYmUKPj4gZGVmZXJyaW5nLgo+Pgo+PiBIZXJlIGlz
IHNhbXBsZSB1c2FnZSAodGFrZW4gZnJvbSBiZWdpbm5pbmcgb2YgdGhlIG1lbnRpb25lZCBwYXRj
aCk6Cj4+Cj4+IC0tLQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hdGEvbGliYWhjaV9wbGF0Zm9y
bS5jIGIvZHJpdmVycy9hdGEvbGliYWhjaV9wbGF0Zm9ybS5jCj4+IGluZGV4IDRiOTAwZmM2NTlm
Ny4uNTJlODkxZmUxNTg2IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2F0YS9saWJhaGNpX3BsYXRm
b3JtLmMKPj4gKysrIGIvZHJpdmVycy9hdGEvbGliYWhjaV9wbGF0Zm9ybS5jCj4+IEBAIC01ODEs
MTEgKzU4MSw4IEBAIGludCBhaGNpX3BsYXRmb3JtX2luaXRfaG9zdChzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2LAo+PiAgICAgICAgIGludCBpLCBpcnEsIG5fcG9ydHMsIHJjOwo+Pgo+PiAg
ICAgICAgIGlycSA9IHBsYXRmb3JtX2dldF9pcnEocGRldiwgMCk7Cj4+IC0gICAgICAgaWYgKGly
cSA8PSAwKSB7Cj4+IC0gICAgICAgICAgICAgICBpZiAoaXJxICE9IC1FUFJPQkVfREVGRVIpCj4+
IC0gICAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAibm8gaXJxXG4iKTsKPj4gLSAg
ICAgICAgICAgICAgIHJldHVybiBpcnE7Cj4+IC0gICAgICAgfQo+PiArICAgICAgIGlmIChpcnEg
PD0gMCkKPj4gKyAgICAgICAgICAgICAgIHJldHVybiBwcm9iZV9lcnIoZGV2LCBpcnEsICJubyBp
cnFcbiIpOwo+IFNob3VsZG4ndCBwbGF0Zm9ybV9nZXRfaXJxIChvciB3aGF0IGl0IGNhbGxzKSBw
cmludCB0aGUgZXJyb3IgbWVzc2FnZQo+IChsaWtlIHdlIGRvIGZvciBrbWFsbG9jKSwgcmF0aGVy
IHRoYW4gZXZlcnkgZHJpdmVyPyBXZSBjb3VsZCBnZXQgcmlkCj4gb2YgbG90cyBvZiBlcnJvciBz
dHJpbmdzIHRoYXQgd2F5LiBJIGd1ZXNzIHRoZXJlIGFyZSBjYXNlcyB3aGVyZSBubwo+IGlycSBp
cyBub3QgYW4gZXJyb3IgYW5kIHdlIHdvdWxkbid0IHdhbnQgdG8gYWx3YXlzIHByaW50IGFuIGVy
cm9yLiBJbgo+IHNvbWUgY2FzZXMgbGlrZSB0aGF0LCB3ZSBoYXZlIDIgdmVyc2lvbnMgb2YgdGhl
IGZ1bmN0aW9uLgoKCmttYWxsb2MgcHJpbnRzIGVycm9yIGFuZCBzdGFjayB0cmFjZSBiZWNhdXNl
IGl0IHNob3dzIHNob3J0YWdlIG9mIGNvbW1vbgpyZXNvdXJjZSB1c2VkIGJ5IGV2ZXJ5b25lLCBx
dWl0ZSBkaWZmZXJlbnQgdGhpbmcgdGhhbiBpcnEgc3BlY2lmaWMgZm9yCmdpdmVuIGRldmljZS4g
VXN1YWxseSBvbmx5IGRldmljZSBkcml2ZXIga25vd3MgaWYgZXJyb3IgaW4gaXJxIGFjcXVpcmlu
ZwpzaG91bGQgYmUgcmVwb3J0ZWQgdG8gdXNlciwgYW5kIGhvdyBpdCBzaG91bGQgYmUgcmVwb3J0
ZWQuCgpUaGUgZXhhbXBsZSBpcyBmb3IgaXJxLCBidXQgdGhlIHF1ZXN0aW9uIGFib3V0IHRoZSBi
ZXN0IHdheSBvZiByZXBvcnRpbmcKZXJyb3Igc3RhbmRzIGZvciBhbGwgb3RoZXIgcmVzb3VyY2Ug
YWNxdWlzaXRpb25zOiBncGlvcywgcmVndWxhdG9ycywKY2xvY2tzLC4uLi4KCkFsdGVybmF0aXZl
IHdheXMgSSBzZWUgZm9yIG5vdzoKCjEuIERvIGl0IGluIHRoZSBjb25zdW1lciwgbGlrZSBpdCBp
cyBkb25lIG5vdyAtIGluIHN1Y2ggY2FzZSBwcm9iZV9lcnIKc2VlbXMgdG8gYmUgYSBnb29kIGhl
bHBlci4KCjIuIERvIGl0IGluIHRoZSBwcm92aWRlcidzIGZyYW1ld29yaywgaW4gc3VjaCBjYXNl
IGZyYW1ld29yayBzaG91bGQga25vdwppZiB0aGUgZXJyb3Igc2hvdWxkIGJlIHByaW50ZWQ6CgrC
oCBhKSBieSBjYWxsaW5nIHNwZWNpYWwgdmVyc2lvbnMgb2YgYWxsIGFsbG9jYXRvcnMsCgrCoCBi
KSBieSBhZGRpbmcgZXh0cmEgYXJndW1lbnQgdG8gYWxsIGFsbG9jYXRvcnMsCgrCoCBjKSBhZGRp
bmcgZXh0cmEgZmxhZyB0byBzdHJ1Y3QgZGV2aWNlIChpdCBpcyBwYXNzZWQgdG8gbW9zdCBhbGxv
Y2F0b3JzKQoKMy4gQnkgY3JlYXRpbmcgZ2VuZXJpYyBhbGxvY2F0b3IgZm9yIG11bHRpcGxlIHJl
c291cmNlcywgc29tZXRoaW5nCnNpbWlsYXIgdG8gd2hhdCBJIGhhdmUgcHJvcG9zZWQgZmV3IHll
YXJzIGFnbyBpbiAicmVzb3VyY2UgdHJhY2tpbmciCmZyYW1ld29yayBbMV0uIEZvciBleGFtcGxl
OgoKwqAgcmV0ID0gZGV2bV9yZXNvdXJjZXNfZ2V0KGRldiwKCsKgwqDCoCByZXNfaXJxX2Rlc2Mo
JmN0eC0+aXJxLCAwKSwKCsKgwqDCoCByZXNfY2xrX2Rlc2MoJmN0eC0+Y2xrLCAiYnVzX2NsayIp
LAoKwqDCoMKgIHJlc19ncGlvX2Rlc2MoJmN0eC0+ZW5hYmxlX2dwaW8sICJlbmFibGUiLCBHUElP
RF9PVVRfSElHSCksCgrCoMKgwqAgLi4uCgrCoCApOwoKwqAgRXJyb3IgcmVwb3J0aW5nIHdvdWxk
IGJlIHBlcmZvcm1lZCBpbiB0aGlzIHVuaXZlcnNhbCBhbGxvY2F0b3IuCgoKSWYgd2Ugd2FudCB0
byBwZXJmb3JtIGJyYXZlIGNoYW5nZXMgSSB3b3VsZCBvcHQgZm9yIDMgLSBpdCBpcyB2ZXJ5CmNv
bW1vbiB0byBhbGxvY2F0ZSBtdWx0aXBsZSByZXNvdXJjZXMgaW4gcHJvYmUsIGNvbXBhY3Rpbmcg
aXQgaW50byBvbmUKaGVscGVyIHNob3VsZCBzaWduaWZpY2FudGx5IHNpbXBsaWZ5IHRoZSBjb2Rl
LgoKT3B0aW9uIDEgaXMgdGhlIHNpbXBsZXN0IG9uZSAtIHdlIGRvIG5vdCBjaGFuZ2UgZXhpc3Rp
bmcgcHJhY3RpY2VzIC0gc28KaXQgaXMgdGhlIGJlc3QgaW4gY2FzZSBvZiBjb25zZXJ2YXRpdmUg
YXBwcm9hY2guCgpJIGhhdmUgbWl4ZWQgZmVlbGluZ3MgYWJvdXQgMmMsIHByYWN0aWNhbGx5IGl0
IGxvb2tzIHF1aXRlIHRlbXB0aW5nIC0gd2UKZ2V0IHdoYXQgd2Ugd2FudCB3aXRoIG1pbmltYWwg
ZWZmb3J0LCBidXQgSSBhbSBub3Qgc3VyZSBpZiBwb2xsdXRpbmcKc3RydWN0IGRldmljZSB3aXRo
ICdwcmVzZW50YXRpb24nIGxheWVyIGlzIGEgZ29vZCBzb2x1dGlvbi4KCkkgZG8gbm90IGxpa2Ug
MmEgbmVpdGhlciAyYiAtIGFsdGVybmF0aXZlcyBiZXR3ZWVuIGZ1bmN0aW9uIG5hbWVzcGFjZQpw
b2xsdXRpb24gYW5kIGFyZ3VtZW50IGxpc3QgcG9sbHV0aW9uLgoKClsxXTogaHR0cHM6Ly9sd24u
bmV0L0FydGljbGVzLzYyNTQ1NC8KCgo+IE5vdCB3aGF0IHlvdSdyZSBhZGRyZXNzaW5nIGhlcmUg
ZXhhY3RseSwgYnV0IHdoYXQgSSdkIGxpa2UgdG8gc2VlIGlzCj4gdGhlIGFiaWxpdHkgdG8gcHJp
bnQgdGhlIGV4YWN0IGxvY2F0aW9ucyBnZW5lcmF0aW5nIGVycm9ycyBpbiB0aGUKPiBmaXJzdCBw
bGFjZS4gVGhhdCB3b3VsZCByZXF1aXJlIHdyYXBwaW5nIGFsbCB0aGUgZXJyb3IgY29kZQo+IGFz
c2lnbm1lbnRzIGFuZCByZXR1cm5zIChvciBhdCBsZWFzdCB0aGUgY29tbW9uIHNvdXJjZXMpLiBJ
ZiB3ZSdyZQo+IGdvaW5nIHRvIG1ha2UgdHJlZSB3aWRlIGNoYW5nZXMsIHRoZW4gdGhhdCBtaWdo
dCBiZSB0aGUgYmV0dGVyIHBsYWNlCj4gdG8gcHV0IHRoZSBlZmZvcnQuIElmIHdlIGhhZCB0aGF0
LCB0aGVuIG1heWJlIHdlJ2QgbmVlZCBhIGxvdCBmZXdlcgo+IGVycm9yIG1lc3NhZ2VzIGluIGRy
aXZlcnMuIEkgZGlkIGEgcHJvdG90eXBlIGltcGxlbWVudGF0aW9uIGFuZAo+IGNvY2NpbmVsbGUg
c2NyaXB0IGEgd2hpbGUgYmFjayB0aGF0IEkgY291bGQgZHVzdCBvZmYgaWYgdGhlcmUncwo+IGlu
dGVyZXN0LiBJdCB3YXMgaGVscGZ1bCBpbiBmaW5kaW5nIHRoZSBzb3VyY2Ugb2YgZXJyb3JzLCBi
dXQgZGlkIGhhdmUKPiBzb21lIGZhbHNlIHBvc2l0aXZlcyBwcmludGVkLgoKCkkgZ3Vlc3MgdGhh
dCBpbiBjYXNlIG9mIHJlc291cmNlIGFjcXVpc2l0aW9uIGl0IGlzIHVzdWFsbHkgZWFzeSB0bwps
b2NhdGUgcGxhY2UgdGhlIGVycm9yIHdhcyByZXBvcnRlZCwgaWYgdGhlIGVycm9yIG1lc3NhZ2Ug
aXMgaW5mb3JtYXRpdmUKZW5vdWdoLCBleGFjdCBsaW5lIG51bWJlci9mdW5jdGlvbiBuYW1lIHNl
ZW1zIHRvIG1lIG92ZXJraWxsLgoKClJlZ2FyZHMKCkFuZHJ6ZWoKCgoKPgo+IFJvYgo+Cj4KCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0t
a2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2Vy
bmVsCg==
