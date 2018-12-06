Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4A9C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:14:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 947E520700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VJFAU97C";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="J8MC84tl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 947E520700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zwK1yPRLaGm9pzkXXXFXK5eMhRbOR5QTsF9nJhvjmuo=; b=VJFAU97CKF8Dif
	ygyeehrTUUJMbU0N+pU+gPCwat6qwDqxgzNqgvaQqXGgDBzB3Dsbu7Bq/+MH6M/YK+n8c4QJMeREu
	J/Rz43V9fmWdi8WO1aazIWAFVbh6smLD3xD6RrVwPfLBMSb0LisGpsfuy8ly1m+Tl2zp9T5T3qnvj
	KT7VZMxVb4JCK1T+UdCR16EdJZiNfKWQIwrg7VUxvdJoXg1xgip2CYTq51ES3RsP/I46Pn/he0UvO
	u5yXmvuVUpcdXn8OxE7dtQHwujqpwYgcPipYMCRujc1h4Y2k2REaoPztsm3VOGngosj/00+e3gGSS
	6453s/o9rKcdt7Z/j89A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUqfk-0004kv-Gg; Thu, 06 Dec 2018 10:14:20 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUqff-0004k9-Kj
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 10:14:17 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20181206101403euoutp015479e98068f8aeaf675eb5c1f40b01e0~tts4gm2r32139721397euoutp01r
 for <linux-arm-kernel@lists.infradead.org>;
 Thu,  6 Dec 2018 10:14:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20181206101403euoutp015479e98068f8aeaf675eb5c1f40b01e0~tts4gm2r32139721397euoutp01r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1544091243;
 bh=gDn7TD04dfrUWr7r68wrUglhw8bAV6f70NFJLMZJOtk=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=J8MC84tlhm3FT4sVg1Q0rU88QpdHMGfepBIj3hVydTZ55kLD39IRmOAS8q9KgXKS6
 ZqTTkYgoVHLQA6nIgT0Bhs10dR68kwE1DPB9+HbThoCX5XAsPq/pF+c9w7fvi1mZNW
 agmCEQAGvqmNxMAyTW1aFUFFk7Z5OBf74YT83oxk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20181206101402eucas1p24de68039176e82a2e034307edd303194~tts3KkZde0900609006eucas1p2i;
 Thu,  6 Dec 2018 10:14:02 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 15.3B.04806.966F80C5; Thu,  6
 Dec 2018 10:14:01 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20181206101401eucas1p23036ae977a70e7e67da3d46e6be936f6~tts2WMxkq0901009010eucas1p2Z;
 Thu,  6 Dec 2018 10:14:01 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20181206101401eusmtrp20f7591a94c0298126d535f62bf016d84~tts2FwtYL1261312613eusmtrp2G;
 Thu,  6 Dec 2018 10:14:01 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-7d-5c08f669627a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id D2.24.04284.866F80C5; Thu,  6
 Dec 2018 10:14:01 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20181206101400eusmtip16ea28fca08ee0c09048f5fc2f21c40c1~tts1HyiDN1346513465eusmtip1i;
 Thu,  6 Dec 2018 10:14:00 +0000 (GMT)
Subject: Re: [PATCH v3 2/5] devfreq: add support for suspend/resume of a
 devfreq device
To: Chanwoo Choi <cw00.choi@samsung.com>,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org
From: Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <d64d50db-375d-5fd5-5938-dcd0341ef2d7@partner.samsung.com>
Date: Thu, 6 Dec 2018 11:13:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5C0878C0.4060500@samsung.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0yTZxj17XeFWPJamH1gm8bORNGsuAzNqxijkejn5ceWLIiORbr5BZkU
 WT9AURPrEAt4I8QoFIYaXcBSh3YFK+OiFQREKTgmzCsGjPeAAkWitvPjY5F/5znPOXnOefPy
 lKaEDeMTk1NFU7IhSccG0lVXRz1fJnr5uHmXeheRy5Xh5HxBBUMunPcypGvoMUOON7QxJPNU
 BUuu7zeSw73PKeLxnOPIjV9fcMR6pFZFHL23GPJ3dTFLBg82IFLgqVORsw33OPJ7V4eK3NlT
 xpJ71xo/+FtvMiSrtoEj+8oHGPKi/T69VCtU/VXFCPYSOxKKzB20kHf4NRJO1TxVCQ5bDivU
 /2bnhD9P7xZ8VznB+Y+FFg45bUgoKx/hhEHHtG/UGwIXbxKTEtNFU8SS+MDNnS0jKGV45va2
 4n7KjBo/z0U8DzgSCka/zUWBvAaXIdh79hqjDEMIutv7KWUYRFDtqEG5KGDMceFgj0pZlCIY
 eGOnleElAl9JASergvF68LWZkbwIwa0I6uvdrDxQOIsC34CTla+zWA8u2y+yQY1XwMnLbxgZ
 03gmeIfaxvAnOBayH5SzimYKtBT20TIOwHMh339mjKewFm73HVcpeDpkVhaN5QbczYP5USan
 5I4G/x9FtIKD4VmTc5z/DPwXFTNgCW5k21gF7wJLi2tcEwVXmjoYOTOFw6GiOkKhl0HjI7m9
 /JBB0P1yihIhCPKrjlEKrYbsfRpFPRucB9rHD02FUvtRLg/prBOKWSeUsU4oY/149wSibUgr
 pknGBFH6OlncppcMRiktOUH/01ajA334ta2+pmEXqnv3oxthHukmq5/0cHEaxpAuZRjdCHhK
 F6KepOfjNOpNhowdomnrRlNakii50ac8rdOqd07q+V6DEwyp4hZRTBFN/29VfECYGc0vO93n
 nINjpmtTou/Gh8zIWbFnx8Int1c11/I/vLUsWH0xvdKV4wnKiBn9WV8bEXNljcv7MOFmRYl/
 eejRZ1H+VyP5Wb6hzLW3tlv8xc3elZbS1ZFd5uX3w4ZjN3oLdf1fuK/nRXGX5oYunPfvd1ND
 m8/N6lz3Pj62ODU63GJapt8SrKOlzYav5lAmyfAf2tUVALEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe8/dcHCali+CXYYVFh2d11czyS91iIIuFGZ2GXpSyznb2USN
 aCUWGuUFC5va3dBpmdOmZCqKF9TatIvSRTGMSmZkXmaKWJsj8NsP/s/v4Xngz+DSWtKTSUzW
 COpkRZKMWkn0LnYNbUu0MTF+34Yw1PrcB9UUVZOovsZGosHp7yS6224mUebDagq9uqZEuaNW
 HFksz2j0+vI4jfSFTRgyjg6Q6O2LEgpNXW8HqMjSjKEn7UM0Khvsx9CnS+UUGurpsPu9b0iU
 1dROoyuVEyQa7xsmdnrwpkYTyVfdqQJ8sa6f4PNyJwH/8OUYxhsN2RTfUlpF87WPLvKLnTRf
 9/4qwd+oMwC+vHKW5qeMa/dLorlwtUqrEdYnqETNDtkxOfLn5KGI8w8M5eQBIcfD/INkvhHh
 cUJSYqqg9o04xSW8654FKTPeaeaSX7gOdHjlABcGsoGw/voIlgNWMlK2DEBr/gfKGayBBc31
 tJPd4MJADuUcsgLYXGcDjsCNPQoXzTrgCNzZXgALLT1Lq3A2C4djPx8Ap6LD4LhVZ/cZhmI5
 2GA457Al7C54v/UP6WCC9Ya2afMSr2aj4Ouxp8A5swp23/5KONiF3QoL/lYsnYezwfBO7Rfc
 yR7w49e7mJPXwcznxXgekOqX6fplin6Zol+m3AOEAbgLWlEZrxTlnKhQitrkeC5WpTQCe2FM
 nXO1DeBNzaE2wDJA5ir5MULHSElFqpiubAOQwWXukhUcEyOVxCnSMwS16qRamySIbSDI/lw+
 7rk6VmWvX7LmpDxIHoJC5SEBIQHBSOYhsfilR0vZeIVGOCsIKYL6v4cxLp464Fbvne31rXn4
 oGTTdIY+JmhDt3FbsGpuXVd+VFjeJHeiqfSKJtMncWb3nqyNe+fnFyYrRsNsCvcqbeXwSORs
 3xkz+BB5euLlmbSWnsabhvOdeKYkC7/Auzb6fe4L3odNeA/Kug5gmxnqyA04+jj2HTFdfKs6
 5WA/qZkw/X56eLuMEBMU8i24WlT8A56HZA5GAwAA
X-CMS-MailID: 20181206101401eucas1p23036ae977a70e7e67da3d46e6be936f6
X-Msg-Generator: CA
X-RootMTR: 20181205110620eucas1p14de70dc092580b684a0304b5ce771605
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181205110620eucas1p14de70dc092580b684a0304b5ce771605
References: <1544007956-28889-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20181205110620eucas1p14de70dc092580b684a0304b5ce771605@eucas1p1.samsung.com>
 <1544007956-28889-3-git-send-email-l.luba@partner.samsung.com>
 <5C0878C0.4060500@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_021415_980090_EC845ADC 
X-CRM114-Status: GOOD (  19.17  )
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
Cc: mark.rutland@arm.com, len.brown@intel.com, tony.luck@intel.com,
 keescook@chromium.org, b.zolnierkie@samsung.com, gregkh@linuxfoundation.org,
 anton@enomsg.org, rjw@rjwysocki.net, robh+dt@kernel.org,
 tjakobi@math.uni-bielefeld.de, kyungmin.park@samsung.com,
 myungjoo.ham@samsung.com, kgene@kernel.org, pavel@ucw.cz, ccross@android.com,
 krzk@kernel.org, m.szyprowski@samsung.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQ2hhbndvbywKCk9uIDEyLzYvMTggMjoxNyBBTSwgQ2hhbndvbyBDaG9pIHdyb3RlOgo+IEhp
IEx1a2FzeiwKPiAKPiBPbiAyMDE464WEIDEy7JuUIDA17J28IDIwOjA1LCBMdWthc3ogTHViYSB3
cm90ZToKPj4gVGhlIHBhdGNoIHByZXBhcmVzIGRldmZyZXEgZGV2aWNlIGZvciBoYW5kbGluZyBz
dXNwZW5kL3Jlc3VtZQo+PiBmdW5jdGlvbmFsaXR5LiBUaGUgbmV3IGZpZWxkcyB3aWxsIHN0b3Jl
IG5lZWRlZCBpbmZvcm1hdGlvbiBkdXJpbmcgdGhpcwo+PiBwcm9jZXNzLiBEZXZmcmVxIGZyYW1l
d29yayBoYW5kbGVzIG9wcC1zdXNwZW5kIERUIGVudHJ5IGFuZCB0aGVyZSBpcyBubwo+PiBuZWVk
IG9mIG1vZHlmaWNhdGlvbnMgaW4gdGhlIGRyaXZlcnMgY29kZS4gSXQgdXNlcyBhdG9taWMgdmFy
aWFibGVzIHRvCj4+IG1ha2Ugc3VyZSBubyByYWNlIGNvbmRpdGlvbiBhZmZlY3RzIHRoZSBwcm9j
ZXNzLgo+Pgo+PiBTdWdnZXN0ZWQtYnk6IFRvYmlhcyBKYWtvYmkgPHRqYWtvYmlAbWF0aC51bmkt
YmllbGVmZWxkLmRlPgo+PiBTdWdnZXN0ZWQtYnk6IENoYW53b28gQ2hvaSA8Y3cwMC5jaG9pQHNh
bXN1bmcuY29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBMdWthc3ogTHViYSA8bC5sdWJhQHBhcnRuZXIu
c2Ftc3VuZy5jb20+Cj4+IC0tLQo+PiAgIGRyaXZlcnMvZGV2ZnJlcS9kZXZmcmVxLmMgfCA0NyAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQo+PiAgIGluY2x1
ZGUvbGludXgvZGV2ZnJlcS5oICAgfCAgNyArKysrKysrCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCA0
OCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQo+IAo+IFJldmlld2VkLWJ5OiBDaGFud29v
IENob2kgPGN3MDAuY2hvaUBzYW1zdW5nLmNvbT4KVGhhbmsgeW91IGZvciB0aGUgcmV2aWV3IGFu
ZCBjb21tZW50cyBmb3IgdGhlIHdob2xlIHBhdGNoIHNlcmllcy4KClJlZ2FyZHMsCkx1a2FzegoK
PiAKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZGV2ZnJlcS9kZXZmcmVxLmMgYi9kcml2ZXJz
L2RldmZyZXEvZGV2ZnJlcS5jCj4+IGluZGV4IGE5ZmQ2MWIuLjQ2NTE3YjYgMTAwNjQ0Cj4+IC0t
LSBhL2RyaXZlcnMvZGV2ZnJlcS9kZXZmcmVxLmMKPj4gKysrIGIvZHJpdmVycy9kZXZmcmVxL2Rl
dmZyZXEuYwo+PiBAQCAtMzE2LDYgKzMxNiwxMCBAQCBzdGF0aWMgaW50IGRldmZyZXFfc2V0X3Rh
cmdldChzdHJ1Y3QgZGV2ZnJlcSAqZGV2ZnJlcSwgdW5zaWduZWQgbG9uZyBuZXdfZnJlcSwKPj4g
ICAJCQkiQ291bGRuJ3QgdXBkYXRlIGZyZXF1ZW5jeSB0cmFuc2l0aW9uIGluZm9ybWF0aW9uLlxu
Iik7Cj4+ICAgCj4+ICAgCWRldmZyZXEtPnByZXZpb3VzX2ZyZXEgPSBuZXdfZnJlcTsKPj4gKwo+
PiArCWlmIChkZXZmcmVxLT5zdXNwZW5kX2ZyZXEpCj4+ICsJCWRldmZyZXEtPnJlc3VtZV9mcmVx
ID0gY3VyX2ZyZXE7Cj4+ICsKPj4gICAJcmV0dXJuIGVycjsKPj4gICB9Cj4+ICAgCj4+IEBAIC02
NjcsNiArNjcxLDkgQEAgc3RydWN0IGRldmZyZXEgKmRldmZyZXFfYWRkX2RldmljZShzdHJ1Y3Qg
ZGV2aWNlICpkZXYsCj4+ICAgCX0KPj4gICAJZGV2ZnJlcS0+bWF4X2ZyZXEgPSBkZXZmcmVxLT5z
Y2FsaW5nX21heF9mcmVxOwo+PiAgIAo+PiArCWRldmZyZXEtPnN1c3BlbmRfZnJlcSA9IGRldl9w
bV9vcHBfZ2V0X3N1c3BlbmRfb3BwX2ZyZXEoZGV2KTsKPj4gKwlhdG9taWNfc2V0KCZkZXZmcmVx
LT5zdXNwZW5kX2NvdW50LCAwKTsKPj4gKwo+PiAgIAlkZXZfc2V0X25hbWUoJmRldmZyZXEtPmRl
diwgImRldmZyZXElZCIsCj4+ICAgCQkJCWF0b21pY19pbmNfcmV0dXJuKCZkZXZmcmVxX25vKSk7
Cj4+ICAgCWVyciA9IGRldmljZV9yZWdpc3RlcigmZGV2ZnJlcS0+ZGV2KTsKPj4gQEAgLTg2Nywx
NCArODc0LDI4IEBAIEVYUE9SVF9TWU1CT0woZGV2bV9kZXZmcmVxX3JlbW92ZV9kZXZpY2UpOwo+
PiAgICAqLwo+PiAgIGludCBkZXZmcmVxX3N1c3BlbmRfZGV2aWNlKHN0cnVjdCBkZXZmcmVxICpk
ZXZmcmVxKQo+PiAgIHsKPj4gKwlpbnQgcmV0Owo+PiArCj4+ICAgCWlmICghZGV2ZnJlcSkKPj4g
ICAJCXJldHVybiAtRUlOVkFMOwo+PiAgIAo+PiAtCWlmICghZGV2ZnJlcS0+Z292ZXJub3IpCj4+
ICsJaWYgKGF0b21pY19pbmNfcmV0dXJuKCZkZXZmcmVxLT5zdXNwZW5kX2NvdW50KSA+IDEpCj4+
ICAgCQlyZXR1cm4gMDsKPj4gICAKPj4gLQlyZXR1cm4gZGV2ZnJlcS0+Z292ZXJub3ItPmV2ZW50
X2hhbmRsZXIoZGV2ZnJlcSwKPj4gLQkJCQlERVZGUkVRX0dPVl9TVVNQRU5ELCBOVUxMKTsKPj4g
KwlpZiAoZGV2ZnJlcS0+Z292ZXJub3IpIHsKPj4gKwkJcmV0ID0gZGV2ZnJlcS0+Z292ZXJub3It
PmV2ZW50X2hhbmRsZXIoZGV2ZnJlcSwKPj4gKwkJCQkJREVWRlJFUV9HT1ZfU1VTUEVORCwgTlVM
TCk7Cj4+ICsJCWlmIChyZXQpCj4+ICsJCQlyZXR1cm4gcmV0Owo+PiArCX0KPj4gKwo+PiArCWlm
IChkZXZmcmVxLT5zdXNwZW5kX2ZyZXEpIHsKPj4gKwkJcmV0ID0gZGV2ZnJlcV9zZXRfdGFyZ2V0
KGRldmZyZXEsIGRldmZyZXEtPnN1c3BlbmRfZnJlcSwgMCk7Cj4+ICsJCWlmIChyZXQpCj4+ICsJ
CQlyZXR1cm4gcmV0Owo+PiArCX0KPj4gKwo+PiArCXJldHVybiAwOwo+PiAgIH0KPj4gICBFWFBP
UlRfU1lNQk9MKGRldmZyZXFfc3VzcGVuZF9kZXZpY2UpOwo+PiAgIAo+PiBAQCAtODg4LDE0ICs5
MDksMjggQEAgRVhQT1JUX1NZTUJPTChkZXZmcmVxX3N1c3BlbmRfZGV2aWNlKTsKPj4gICAgKi8K
Pj4gICBpbnQgZGV2ZnJlcV9yZXN1bWVfZGV2aWNlKHN0cnVjdCBkZXZmcmVxICpkZXZmcmVxKQo+
PiAgIHsKPj4gKwlpbnQgcmV0Owo+PiArCj4+ICAgCWlmICghZGV2ZnJlcSkKPj4gICAJCXJldHVy
biAtRUlOVkFMOwo+PiAgIAo+PiAtCWlmICghZGV2ZnJlcS0+Z292ZXJub3IpCj4+ICsJaWYgKGF0
b21pY19kZWNfcmV0dXJuKCZkZXZmcmVxLT5zdXNwZW5kX2NvdW50KSA+PSAxKQo+PiAgIAkJcmV0
dXJuIDA7Cj4+ICAgCj4+IC0JcmV0dXJuIGRldmZyZXEtPmdvdmVybm9yLT5ldmVudF9oYW5kbGVy
KGRldmZyZXEsCj4+IC0JCQkJREVWRlJFUV9HT1ZfUkVTVU1FLCBOVUxMKTsKPj4gKwlpZiAoZGV2
ZnJlcS0+cmVzdW1lX2ZyZXEpIHsKPj4gKwkJcmV0ID0gZGV2ZnJlcV9zZXRfdGFyZ2V0KGRldmZy
ZXEsIGRldmZyZXEtPnJlc3VtZV9mcmVxLCAwKTsKPj4gKwkJaWYgKHJldCkKPj4gKwkJCXJldHVy
biByZXQ7Cj4+ICsJfQo+PiArCj4+ICsJaWYgKGRldmZyZXEtPmdvdmVybm9yKSB7Cj4+ICsJCXJl
dCA9IGRldmZyZXEtPmdvdmVybm9yLT5ldmVudF9oYW5kbGVyKGRldmZyZXEsCj4+ICsJCQkJCURF
VkZSRVFfR09WX1JFU1VNRSwgTlVMTCk7Cj4+ICsJCWlmIChyZXQpCj4+ICsJCQlyZXR1cm4gcmV0
Owo+PiArCX0KPj4gKwo+PiArCXJldHVybiAwOwo+PiAgIH0KPj4gICBFWFBPUlRfU1lNQk9MKGRl
dmZyZXFfcmVzdW1lX2RldmljZSk7Cj4+ICAgCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L2RldmZyZXEuaCBiL2luY2x1ZGUvbGludXgvZGV2ZnJlcS5oCj4+IGluZGV4IGU0OTYzYjAuLmQ5
ODUxOTkgMTAwNjQ0Cj4+IC0tLSBhL2luY2x1ZGUvbGludXgvZGV2ZnJlcS5oCj4+ICsrKyBiL2lu
Y2x1ZGUvbGludXgvZGV2ZnJlcS5oCj4+IEBAIC0xMzEsNiArMTMxLDkgQEAgc3RydWN0IGRldmZy
ZXFfZGV2X3Byb2ZpbGUgewo+PiAgICAqIEBzY2FsaW5nX21pbl9mcmVxOglMaW1pdCBtaW5pbXVt
IGZyZXF1ZW5jeSByZXF1ZXN0ZWQgYnkgT1BQIGludGVyZmFjZQo+PiAgICAqIEBzY2FsaW5nX21h
eF9mcmVxOglMaW1pdCBtYXhpbXVtIGZyZXF1ZW5jeSByZXF1ZXN0ZWQgYnkgT1BQIGludGVyZmFj
ZQo+PiAgICAqIEBzdG9wX3BvbGxpbmc6CSBkZXZmcmVxIHBvbGxpbmcgc3RhdHVzIG9mIGEgZGV2
aWNlLgo+PiArICogQHN1c3BlbmRfZnJlcToJIGZyZXF1ZW5jeSBvZiBhIGRldmljZSBzZXQgZHVy
aW5nIHN1c3BlbmQgcGhhc2UuCj4+ICsgKiBAcmVzdW1lX2ZyZXE6CSBmcmVxdWVuY3kgb2YgYSBk
ZXZpY2Ugc2V0IGluIHJlc3VtZSBwaGFzZS4KPj4gKyAqIEBzdXNwZW5kX2NvdW50Ogkgc3VzcGVu
ZCByZXF1ZXN0cyBjb3VudGVyIGZvciBhIGRldmljZS4KPj4gICAgKiBAdG90YWxfdHJhbnM6CU51
bWJlciBvZiBkZXZmcmVxIHRyYW5zaXRpb25zCj4+ICAgICogQHRyYW5zX3RhYmxlOglTdGF0aXN0
aWNzIG9mIGRldmZyZXEgdHJhbnNpdGlvbnMKPj4gICAgKiBAdGltZV9pbl9zdGF0ZToJU3RhdGlz
dGljcyBvZiBkZXZmcmVxIHN0YXRlcwo+PiBAQCAtMTY3LDYgKzE3MCwxMCBAQCBzdHJ1Y3QgZGV2
ZnJlcSB7Cj4+ICAgCXVuc2lnbmVkIGxvbmcgc2NhbGluZ19tYXhfZnJlcTsKPj4gICAJYm9vbCBz
dG9wX3BvbGxpbmc7Cj4+ICAgCj4+ICsJdW5zaWduZWQgbG9uZyBzdXNwZW5kX2ZyZXE7Cj4+ICsJ
dW5zaWduZWQgbG9uZyByZXN1bWVfZnJlcTsKPj4gKwlhdG9taWNfdCBzdXNwZW5kX2NvdW50Owo+
PiArCj4+ICAgCS8qIGluZm9ybWF0aW9uIGZvciBkZXZpY2UgZnJlcXVlbmN5IHRyYW5zaXRpb24g
Ki8KPj4gICAJdW5zaWduZWQgaW50IHRvdGFsX3RyYW5zOwo+PiAgIAl1bnNpZ25lZCBpbnQgKnRy
YW5zX3RhYmxlOwo+Pgo+IAo+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
