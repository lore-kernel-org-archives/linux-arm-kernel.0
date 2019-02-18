Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038C9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:47:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF32321900
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F9VgzEAr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SiWQ78+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF32321900
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zPySXMTsf1ZYeP+h8DT/Jl3g/hUt8KYmMmEXXGgwNq8=; b=F9VgzEArm8SChO
	q4OmJeW2qlH3kaNtbl03rCdCzAzMIByBCB2B1YFotZSMwcBwR4NDkP2KRPcWTScAUZiEIfulSg7Co
	llAwrzswXd86Kb5fbx15jx1NkqDaaYID1F3PYt8HTBFL0mu5LxgqNdJit9DsZCNnwuD/TiFEn/59f
	6y0WNkGDphgH+/h72qSaz+ofXEaOr1hphoQVk7xkVoYkL4fIaIY57e8ArIUSiPc4aHSwTxKYhO/cM
	/T1oD8JZ9HUMJTgiq1wolh7iBH0/OofFp/mS3UkIRYmJZG77G00vfmJITT+CuohNzuADRjIxKj0LP
	xtrWyQmxhk4MFMSk+brQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvjG7-00059L-RH; Mon, 18 Feb 2019 13:46:59 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvjG4-00058g-3T
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 13:46:57 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1IDkrjr008835;
 Mon, 18 Feb 2019 07:46:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550497613;
 bh=ui2+XjoYpGM5P2fIowhD27cL2FbBJPK9jpp7UsYfAEc=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=SiWQ78+TYx1M1EGVZeBchMTAxlmG30feh/hpaPfK6jSX+Kg42bjy15ODMXeRrlq3n
 32TAAs7Wwyv17RxaZnBI7uqV0l4gMui1X3dkPb53W+t2JCVmR6OgvnmKttS1gbgTpu
 rpZEAH9nxOiRkdgZQt9j1ttdurzNB2Sf3J1sj0K8=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1IDkr99014308
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 18 Feb 2019 07:46:53 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 18
 Feb 2019 07:46:53 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 18 Feb 2019 07:46:53 -0600
Received: from [172.24.190.117] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1IDkoGC031171;
 Mon, 18 Feb 2019 07:46:51 -0600
Subject: Re: [PATCH 2/4] soc: ti: ti_sci_pm_domains: Add support for exclusive
 access
To: Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Santosh
 Shilimkar <ssantosh@kernel.org>, Rob Herring <robh+dt@kernel.org>
References: <20190218051517.9218-1-lokeshvutla@ti.com>
 <20190218051517.9218-3-lokeshvutla@ti.com>
 <74ef7305-0575-f24a-0806-49d85b7b70ff@ti.com>
From: Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <dea9f6ba-5a0f-59f1-7fa2-2a17df821c9c@ti.com>
Date: Mon, 18 Feb 2019 19:16:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <74ef7305-0575-f24a-0806-49d85b7b70ff@ti.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_054656_227383_C8EACABE 
X-CRM114-Status: GOOD (  25.68  )
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
Cc: Device Tree Mailing List <devicetree@vger.kernel.org>,
 Sekhar Nori <nsekhar@ti.com>,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CgpPbiAxOC8wMi8xOSAxOjQwIFBNLCBUZXJvIEtyaXN0byB3cm90ZToKPiBPbiAxOC8wMi8yMDE5
IDA3OjE1LCBMb2tlc2ggVnV0bGEgd3JvdGU6Cj4+IFRJU0NJIHByb3RvY29sIHN1cHBvcnRzIGZv
ciBlbmFibGluZyB0aGUgZGV2aWNlIHdpdGggZXhjbHVzaXZlCj4+IHBlcm1pc3Npb25zLiBDZXJ0
YWluIHJlbW90ZXByb2MgZGV2aWNlcyBvciBzb21lIHNoYXJlZCBkZXZpY2VzCj4+IGFjcm9zcyBW
TSBkb2Vzbid0IHdhbnRzIHRvIHJlcXVlc3QgZGV2aWNlcyB3aXRoIHRoaXMgZmxhZyBzZXQuCj4+
IFNvIGFkZCBzdXBwb3J0IGZvciBnZXR0aW5nIHRoaXMgaW5mb3JtYXRpb24gZnJvbSBEVC4gV2l0
aCB0aGlzCj4+IHBvd2VyLWRvbWFpbi1jZWxscyBhcmUgaW5jcmVhc2VkIHRvIDIuCj4+Cj4+IEZv
ciBrZWVwaW5nIHRoZSBEVCBiYWNrd2FyZCBjb21wYXRpYmlsaXR5IGludGFjdCwgZGVmYXVsdGlu
ZyB0aGUKPj4gZGV2aWNlIHBlcm1pc3Npb25zIHRvIHNldCB0aGUgZXhjbHVzaXZlIGZsYWcgc2V0
LiBJbiB0aGlzIGNhc2UgdGhlCj4+IHBvd2VyLWRvbWFpbi1jZWxscyBpcyAxLgo+Pgo+PiBTaWdu
ZWQtb2ZmLWJ5OiBMb2tlc2ggVnV0bGEgPGxva2VzaHZ1dGxhQHRpLmNvbT4KPj4gLS0tCj4+IMKg
IC4uLi9iaW5kaW5ncy9zb2MvdGkvc2NpLXBtLWRvbWFpbi50eHTCoMKgwqDCoMKgwqDCoMKgIHzC
oCA3ICsrKystLQo+PiDCoCBkcml2ZXJzL3NvYy90aS90aV9zY2lfcG1fZG9tYWlucy5jwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8IDIyICsrKysrKysrKysrKysrKysrLS0KPiAKPiBQbGVhc2Ugc3Bs
aXQgdGhlIGR0LWJpbmRpbmcgY2hhbmdlIGludG8gYSBzZXBhcmF0ZSBwYXRjaC4KClN1cmUsIHdp
bGwgZml4IGluIHYyLiBXaWxsIHdhaXQgZm9yIHNvbWUgbW9yZSB0aW1lIGJlZm9yZSBwb3N0aW5n
IHYyLgoKVGhhbmtzIGFuZCByZWdhcmRzLApMb2tlc2gKCj4gCj4gLVRlcm8KPiAKPj4gwqAgMiBm
aWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy90aS9zY2ktcG0t
ZG9tYWluLnR4dAo+PiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvdGkv
c2NpLXBtLWRvbWFpbi50eHQKPj4gaW5kZXggZjdiMDBhN2MwZjY4Li41ZmRkYTc0NzUwMjMgMTAw
NjQ0Cj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvdGkvc2Np
LXBtLWRvbWFpbi50eHQKPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3NvYy90aS9zY2ktcG0tZG9tYWluLnR4dAo+PiBAQCAtMTksOCArMTksMTEgQEAgY2hpbGQgb2Yg
dGhlIHBtbWMgbm9kZS4KPj4gwqAgUmVxdWlyZWQgUHJvcGVydGllczoKPj4gwqAgLS0tLS0tLS0t
LS0tLS0tLS0tLS0KPj4gwqAgLSBjb21wYXRpYmxlOiBzaG91bGQgYmUgInRpLHNjaS1wbS1kb21h
aW4iCj4+IC0tICNwb3dlci1kb21haW4tY2VsbHM6IE11c3QgYmUgMSBzbyB0aGF0IGFuIGlkIGNh
biBiZSBwcm92aWRlZCBpbiBlYWNoCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRl
dmljZSBub2RlLgo+PiArLSAjcG93ZXItZG9tYWluLWNlbGxzOiBDYW4gYmUgb25lIG9mIHRoZSBm
b2xsb3dpbmc6Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDE6IENvbnRhaW5pbmcgdGhlIGRl
dmljZSBpZCBvZiBlYWNoIG5vZGUKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMjogRmlyc3Qg
ZW50cnkgc2hvdWxkIGJlIGRldmljZSBpZAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBTZWNvbmQgZW50cnkgc2hvdWxkIGJlIDEgb3IgMC4gVXNlIDEgZm9yIGVuYWJsaW5nCj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRoZSBkZXZpY2Ugd2l0aCBleGNsdXNpdmUgcGVy
bWlzc2lvbnMgc2V0IGVsc2UgMC4KPj4gwqAgwqAgRXhhbXBsZSAoSzJHKToKPj4gwqAgLS0tLS0t
LS0tLS0tLQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvdGkvdGlfc2NpX3BtX2RvbWFpbnMu
Ywo+PiBiL2RyaXZlcnMvc29jL3RpL3RpX3NjaV9wbV9kb21haW5zLmMKPj4gaW5kZXggZGUzMWI5
Mzg5ZTJlLi40ZGFlNDI2NTEyMTIgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvc29jL3RpL3RpX3Nj
aV9wbV9kb21haW5zLmMKPj4gKysrIGIvZHJpdmVycy9zb2MvdGkvdGlfc2NpX3BtX2RvbWFpbnMu
Ywo+PiBAQCAtMjQsNiArMjQsOCBAQAo+PiDCoCAjaW5jbHVkZSA8bGludXgvc2xhYi5oPgo+PiDC
oCAjaW5jbHVkZSA8bGludXgvc29jL3RpL3RpX3NjaV9wcm90b2NvbC5oPgo+PiDCoCArI2RlZmlu
ZSBQRF9SRVFVRVNUX0VYQ0xVU0lWRSBCSVQoMCkKPj4gKwo+PiDCoCAvKioKPj4gwqDCoCAqIHN0
cnVjdCB0aV9zY2lfZ2VucGRfZGV2X2RhdGE6IGhvbGRzIGRhdGEgbmVlZGVkIGZvciBldmVyeSBk
ZXZpY2UgYXR0YWNoZWQKPj4gwqDCoCAqwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
dG8gdGhpcyBnZW5wZAo+PiBAQCAtMzIsNiArMzQsNyBAQAo+PiDCoMKgICovCj4+IMKgIHN0cnVj
dCB0aV9zY2lfZ2VucGRfZGV2X2RhdGEgewo+PiDCoMKgwqDCoMKgIGludCBpZHg7Cj4+ICvCoMKg
wqAgdTggZXhjbHVzaXZlOwo+PiDCoCB9Owo+PiDCoCDCoCAvKioKPj4gQEAgLTYzLDYgKzY2LDE0
IEBAIHN0YXRpYyBpbnQgdGlfc2NpX2Rldl9pZChzdHJ1Y3QgZGV2aWNlICpkZXYpCj4+IMKgwqDC
oMKgwqAgcmV0dXJuIHNjaV9kZXZfZGF0YS0+aWR4Owo+PiDCoCB9Cj4+IMKgICtzdGF0aWMgdTgg
aXNfdGlfc2NpX2Rldl9leGNsdXNpdmUoc3RydWN0IGRldmljZSAqZGV2KQo+PiArewo+PiArwqDC
oMKgIHN0cnVjdCBnZW5lcmljX3BtX2RvbWFpbl9kYXRhICpnZW5wZF9kYXRhID0gZGV2X2dwZF9k
YXRhKGRldik7Cj4+ICvCoMKgwqAgc3RydWN0IHRpX3NjaV9nZW5wZF9kZXZfZGF0YSAqc2NpX2Rl
dl9kYXRhID0gZ2VucGRfZGF0YS0+ZGF0YTsKPj4gKwo+PiArwqDCoMKgIHJldHVybiBzY2lfZGV2
X2RhdGEtPmV4Y2x1c2l2ZSAmIFBEX1JFUVVFU1RfRVhDTFVTSVZFOwo+PiArfQo+PiArCj4+IMKg
IC8qKgo+PiDCoMKgICogdGlfc2NpX2Rldl90b19zY2lfaGFuZGxlKCk6IGdldCBwb2ludGVyIHRv
IHRpX3NjaV9oYW5kbGUKPj4gwqDCoCAqIEBkZXY6IHBvaW50ZXIgdG8gZGV2aWNlIGFzc29jaWF0
ZWQgd2l0aCB0aGlzIGdlbnBkCj4+IEBAIC04Nyw3ICs5OCwxMCBAQCBzdGF0aWMgaW50IHRpX3Nj
aV9kZXZfc3RhcnQoc3RydWN0IGRldmljZSAqZGV2KQo+PiDCoMKgwqDCoMKgIGNvbnN0IHN0cnVj
dCB0aV9zY2lfaGFuZGxlICp0aV9zY2kgPSB0aV9zY2lfZGV2X3RvX3NjaV9oYW5kbGUoZGV2KTsK
Pj4gwqDCoMKgwqDCoCBpbnQgaWR4ID0gdGlfc2NpX2Rldl9pZChkZXYpOwo+PiDCoCAtwqDCoMKg
IHJldHVybiB0aV9zY2ktPm9wcy5kZXZfb3BzLmdldF9kZXZpY2UodGlfc2NpLCBpZHgpOwo+PiAr
wqDCoMKgIGlmIChpc190aV9zY2lfZGV2X2V4Y2x1c2l2ZShkZXYpKQo+PiArwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIHRpX3NjaS0+b3BzLmRldl9vcHMuZ2V0X2RldmljZV9leGNsdXNpdmUodGlfc2Np
LCBpZHgpOwo+PiArwqDCoMKgIGVsc2UKPj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiB0aV9zY2kt
Pm9wcy5kZXZfb3BzLmdldF9kZXZpY2UodGlfc2NpLCBpZHgpOwo+PiDCoCB9Cj4+IMKgIMKgIC8q
Kgo+PiBAQCAtMTE4LDcgKzEzMiw3IEBAIHN0YXRpYyBpbnQgdGlfc2NpX3BkX2F0dGFjaF9kZXYo
c3RydWN0IGdlbmVyaWNfcG1fZG9tYWluCj4+ICpkb21haW4sCj4+IMKgwqDCoMKgwqAgaWYgKHJl
dCA8IDApCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Owo+PiDCoCAtwqDCoMKgIGlm
IChwZF9hcmdzLmFyZ3NfY291bnQgIT0gMSkKPj4gK8KgwqDCoCBpZiAocGRfYXJncy5hcmdzX2Nv
dW50ICE9IDEgJiYgcGRfYXJncy5hcmdzX2NvdW50ICE9IDIpCj4+IMKgwqDCoMKgwqDCoMKgwqDC
oCByZXR1cm4gLUVJTlZBTDsKPj4gwqAgwqDCoMKgwqDCoCBpZHggPSBwZF9hcmdzLmFyZ3NbMF07
Cj4+IEBAIC0xMzYsNiArMTUwLDEwIEBAIHN0YXRpYyBpbnQgdGlfc2NpX3BkX2F0dGFjaF9kZXYo
c3RydWN0IGdlbmVyaWNfcG1fZG9tYWluCj4+ICpkb21haW4sCj4+IMKgwqDCoMKgwqDCoMKgwqDC
oCByZXR1cm4gLUVOT01FTTsKPj4gwqAgwqDCoMKgwqDCoCBzY2lfZGV2X2RhdGEtPmlkeCA9IGlk
eDsKPj4gK8KgwqDCoCAvKiBFbmFibGUgdGhlIGV4Y2x1c2l2ZSBwZXJtaXNzaW9ucyBieSBkZWZh
dWx0ICovCj4+ICvCoMKgwqAgc2NpX2Rldl9kYXRhLT5leGNsdXNpdmUgPSBQRF9SRVFVRVNUX0VY
Q0xVU0lWRTsKPj4gK8KgwqDCoCBpZiAocGRfYXJncy5hcmdzX2NvdW50ID09IDIpCj4+ICvCoMKg
wqDCoMKgwqDCoCBzY2lfZGV2X2RhdGEtPmV4Y2x1c2l2ZSA9IHBkX2FyZ3MuYXJnc1sxXTsKPj4g
wqAgwqDCoMKgwqDCoCBnZW5wZF9kYXRhID0gZGV2X2dwZF9kYXRhKGRldik7Cj4+IMKgwqDCoMKg
wqAgZ2VucGRfZGF0YS0+ZGF0YSA9IHNjaV9kZXZfZGF0YTsKPj4KPiAKPiAtLSAKPiBUZXhhcyBJ
bnN0cnVtZW50cyBGaW5sYW5kIE95LCBQb3Jra2FsYW5rYXR1IDIyLCAwMDE4MCBIZWxzaW5raS4K
PiBZLXR1bm51cy9CdXNpbmVzcyBJRDogMDYxNTUyMS00LiBLb3RpcGFpa2thL0RvbWljaWxlOiBI
ZWxzaW5raQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtYXJtLWtlcm5lbAo=
