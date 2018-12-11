Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31479C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:43:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01EBE20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Uh3OlpHu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hxcIwHvW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01EBE20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:Date:Message-ID:
	In-Reply-To:To:From:Subject:Mime-Version:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ci5KEepJsnJ/ZvA6zQal/3gQr5c2enhZtpH9ZpTqDxQ=; b=Uh3OlpHumNPxt0
	4rIJIZmqEIC83CxSKP3tMg/WLE76hh+YgYP42NpSINwLVWyOGhtBVV+lWqkalMAEE1epaeyBkh3cZ
	/QpvdT0KXMmbWt4HOv9yUai4jXay3RJ9YBSP+ICqyTuswbgMIf9SP6Q23vVsS9d7Df87UiVe6t7on
	veWUH/EmRC3s0SMT+vdtjNSBD6iELlkYmNbwbW1cMfHaa0T5Xi/ZO7ZKCDncrg7mPFBrH+drxL83t
	2m1YG51oDFYvd3Izlq0rDq1bjK4NJsw+NHqWRMcHeN0RB9nzpashWBqqz5ObF425hDTbI6m9R/r6H
	Gt2eOOKHzVXXSQY8Q8Rg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWX5J-0006yP-ME; Tue, 11 Dec 2018 01:43:41 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWX5E-0006y1-AD
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 01:43:39 +0000
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20181211014319epoutp01fc60d198cf0728db3999acb2f88195c9~vI9X4WEUl1802718027epoutp01P
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 01:43:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20181211014319epoutp01fc60d198cf0728db3999acb2f88195c9~vI9X4WEUl1802718027epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1544492599;
 bh=N6gtlJaIZdoRTs9uBS6/4m50BwuZJ04ayUsPQyAtdHE=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=hxcIwHvWVVaH0Gsehy0RFaaw/RO9Yu8Rz2x5flyjIEiPPZmz7CG4BboBwCX6rtQ7r
 kvyP6UoodRyvm4IiU0n9ASs7/YW/bqUH3DZFRdHb/U4qgsorRBM/vaKe/yBHWJ6w5H
 hcrVeDUVrkdDpnrtXXPfKvZtz17DvTjvmDvs07yQ=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.153]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20181211014315epcas1p235be1126f6a1b2156c68333bb87d1741~vI9U64bM40864408644epcas1p2r;
 Tue, 11 Dec 2018 01:43:15 +0000 (GMT)
X-AuditID: b6c32a35-e1fff70000000fda-e2-5c0f163391a4
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
 epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 F4.6A.04058.3361F0C5; Tue, 11 Dec 2018 10:43:15 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [PATCH v3 2/5] devfreq: add support for suspend/resume of a
 devfreq device
From: MyungJoo Ham <myungjoo.ham@samsung.com>
To: Chanwoo Choi <cw00.choi@samsung.com>, Lukasz Luba
 <l.luba@partner.samsung.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org"
 <linux-samsung-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <5C0878C0.4060500@samsung.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20181211014315epcms1p153a54217e587fd76a8198db77762699a@epcms1p1>
Date: Tue, 11 Dec 2018 10:43:15 +0900
X-CMS-MailID: 20181211014315epcms1p153a54217e587fd76a8198db77762699a
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfUwTZxz2vev1DmK7o6K+6Zg2l02DWuCsZS9GliUSc9l0IxH8Y+DgAjcg
 9Cu9YtRtsRGdEz8oxmhTFMaEVT4WtEDt5MNRq1EZVpyD+QHqqDGKuEWYE4yyfhH978lzv+ee
 5/m970vhip2kkioxWASzgdcx0liJ+3yiWq1Z8E5uyhF7KurtSESn7a0EOnP6OYGGJh8SqNZ3
 lUDlJ1ql6Ld9elQ5OoYjv/8Uifp3PiHRLWsCchzuxpBrdJBAv589JkUTB3wA2f09GPrZN0yi
 hqEBDA1fuRCU910n0O5uH4m+a/6HQE+ujUg+Xsi5O90E11LTArhq64CEs1U+A9yJrkcY52ra
 K+XOHW8hubb6HdzriyTX+7QL49r/2CPhDrY3Ae5k838kN+FalCn/onRNscAXCmaVYCgwFpYY
 itKZTzfmrc3TpqawajYNfcioDLxeSGcy1meq15XogvUZ1RZeVxakMnlRZJI/WmM2llkEVbFR
 tKQzgqlQZ0ozJYm8XiwzFCUVGPWr2ZSUldrgYH5p8d07l0hTr3zr/ZnLUivYK68AMRSkV0Hb
 6HOsAsRSCtoDYIO1ElQAipLRcfCVZ15oZh69GfbbrXgIK2gGWm/24BE+GX5/zw1CWEqrYcep
 YUnoP/G0E4fPnCFBLIXT4wS8cvsXLOImg/Y9DyQR/C484+wIq2Po5fDQTKM0ws+HN5vHyVn8
 98VaEMHxcPdIPx7BcfDeVGeUV8LAeF10fgccmvgx3AbSNgBf/jkT/ZAM/7pRHTaQ0Rtgb+P5
 cCAJ/QG8O3QnGi4D+lu6wuHwYKCf6sbw0CZwOhG2nk2O0HL49N/9xGwXT00gKl0CvZ31UasE
 2He0LiyFNAevXVBFljsJYE95OW4Dix1v9ut4y8zxxuwHgDeBBYJJ1BcJImti3z5SFwjf/2Va
 Dzh8db0X0BRg5spUu+S5CoLfIm7TewGkcCZepv5KlquQFfLbtgtmY565TCeIXqANdq7ClfML
 jMHXZLDksdqVGo0GrWJTtSzLLJQFlMdzFHQRbxFKBcEkmGd1GBWjtAIDcft6axs/NVE/7W88
 0rb4VU72ocCKR3Pfs70/Wb+5NmZascKXlPV4JOGTarhp068vBl3ykSx7XHdX/qJ9HXOyB5pS
 Cw6e+zKL/Nak4NY+aK9aqnmY3/34hncyY7vTXbX1m77lvtWfjzoGsTnHxj5rqNE2OL+WTg16
 ZnIqN9in07IDjEQs5tlluFnk/wePnE3hFQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181205110620eucas1p14de70dc092580b684a0304b5ce771605
References: <5C0878C0.4060500@samsung.com>
 <1544007956-28889-1-git-send-email-l.luba@partner.samsung.com>
 <1544007956-28889-3-git-send-email-l.luba@partner.samsung.com>
 <CGME20181205110620eucas1p14de70dc092580b684a0304b5ce771605@epcms1p1>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_174336_690470_091691E9 
X-CRM114-Status: GOOD (  21.74  )
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
Reply-To: myungjoo.ham@samsung.com
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "len.brown@intel.com" <len.brown@intel.com>,
 "tony.luck@intel.com" <tony.luck@intel.com>,
 "keescook@chromium.org" <keescook@chromium.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "anton@enomsg.org" <anton@enomsg.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "krzk@kernel.org" <krzk@kernel.org>,
 "tjakobi@math.uni-bielefeld.de" <tjakobi@math.uni-bielefeld.de>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "kgene@kernel.org" <kgene@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>,
 "ccross@android.com" <ccross@android.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

PiBIaSBMdWthc3osCj4gCj4gT24gMjAxOOuFhCAxMuyblCAwNeydvCAyMDowNSwgTHVrYXN6IEx1
YmEgd3JvdGU6DQo+ID4gVGhlIHBhdGNoIHByZXBhcmVzIGRldmZyZXEgZGV2aWNlIGZvciBoYW5k
bGluZyBzdXNwZW5kL3Jlc3VtZQ0KPiA+IGZ1bmN0aW9uYWxpdHkuIFRoZSBuZXcgZmllbGRzIHdp
bGwgc3RvcmUgbmVlZGVkIGluZm9ybWF0aW9uIGR1cmluZyB0aGlzDQo+ID4gcHJvY2Vzcy4gRGV2
ZnJlcSBmcmFtZXdvcmsgaGFuZGxlcyBvcHAtc3VzcGVuZCBEVCBlbnRyeSBhbmQgdGhlcmUgaXMg
bm8NCj4gPiBuZWVkIG9mIG1vZHlmaWNhdGlvbnMgaW4gdGhlIGRyaXZlcnMgY29kZS4gSXQgdXNl
cyBhdG9taWMgdmFyaWFibGVzIHRvDQo+ID4gbWFrZSBzdXJlIG5vIHJhY2UgY29uZGl0aW9uIGFm
ZmVjdHMgdGhlIHByb2Nlc3MuDQo+ID4gDQo+ID4gU3VnZ2VzdGVkLWJ5OiBUb2JpYXMgSmFrb2Jp
IDx0amFrb2JpQG1hdGgudW5pLWJpZWxlZmVsZC5kZT4NCj4gPiBTdWdnZXN0ZWQtYnk6IENoYW53
b28gQ2hvaSA8Y3cwMC5jaG9pQHNhbXN1bmcuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEx1a2Fz
eiBMdWJhIDxsLmx1YmFAcGFydG5lci5zYW1zdW5nLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVy
cy9kZXZmcmVxL2RldmZyZXEuYyB8IDQ3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrLS0tLS0tDQo+ID4gIGluY2x1ZGUvbGludXgvZGV2ZnJlcS5oICAgfCAgNyArKysr
KysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNDggaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMo
LSkNCj4gDQo+IFJldmlld2VkLWJ5OiBDaGFud29vIENob2kgPGN3MDAuY2hvaUBzYW1zdW5nLmNv
bT4NCj4gDQoNCkxvb2tzIGdvb3QgZG8gbWUgYXMgd2VsbC4NCg0KQWNrZWQtYnk6IE15dW5nSm9v
IEhhbSA8bXl1bmdqb28uaGFtQHNhbXN1bmcuY29tPg0KDQoNCkFueXdheSwgZm9yIHRoZSBzYWtl
IG9mIGN1cmlvc2l0eS4uLg0KDQpIYXZpbmcgc3VzcGVuZC1mcmVxdWVuY3kgaXMgdXN1YWxseSBy
ZXF1aXJlZCB3aGVuDQp0aGUgZnJlcXVlbmN5IGNvbmZpZ3VyYXRpb24gaXMgcmVzZXQgd2l0aCBz
dXNwZW5kLXJlc3VtZQ0KYXMgb2xkZXIgRXh5bm9zJ3MgQ1BVIGRpZCAoSSBkb24ndCBrbm93IHdo
ZXRoZXIgaXQgc3RpbGwgZG9lcykuDQoNCkRvZXMgR1BVIGRvIHRoaXMgYXMgd2VsbD8NCihtZW1v
cnktYnVzIHdvbid0IGRvIHRoaXMgYmVjYXVzZSB0aGV5IGFyZSBrZXB0IHR1cm5lZCBvbiBkdXJp
bmcgc3VzcGVuZCkNCg0KDQpDaGVlcnMsDQpNeXVuZ0pvbw0KCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
