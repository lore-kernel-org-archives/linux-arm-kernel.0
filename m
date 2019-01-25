Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB56FC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:51:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88D82217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i1WqqWxy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XVECqFOU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88D82217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bP5wOX8p495UFnWyLy6Z0IGVjgJAAErvDqFeui1yc9s=; b=i1WqqWxys5DfuL
	VbQbzEmeWrsUYg0YUNzc1gzxuQPBkdJ/83wer1n2h7KXN8aTS/LijXEua0HSYE3rTof/hHYpumL58
	ueY8xqljliYKfYzTYL+5MWKgj6vnvcf0FaNQMtvTXJ+FSf/m9I7zImfHtIpIV385BdgM8EgwjoC+0
	t5x8YQFMZG5tudVqePe+6E9ZjX0Ib8Lyvj+AeF1yq/t9a4Kur0pFEHBVEqAOVkA9ITMkGhVCi4y6f
	yIOQi8Ug9PzLprFxwu9azZ1Fy03QoL+7SX9YJJMWrt/Acg0yRjicBq5fOzwx7fqcjb4puei+jNh4A
	MKH98HwhfT5dA2BsdZbA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmwH0-0006C7-Eq; Fri, 25 Jan 2019 07:51:34 +0000
Received: from mail-eopbgr30059.outbound.protection.outlook.com ([40.107.3.59]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmwGv-0006BG-Ou
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 07:51:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wUGkLvQF0cnkmBYg2JGT+JABvtZ2h9/CUkQXQu43Pw=;
 b=XVECqFOU8T/oxqF005sB+D7GKaZbM90/hjwGcQA2nd4ZHk+iVafCHi68eA6UeSUxeaa3BlyOeghOowCXDuRZ4R77CN9ODWcRWzH/JdcmlYlgQCy/ZL/l4T2nhrkc4PfTN5n0ndugAzsnnX1VrBEzHPMY90YF9d4QETujUFr2FBI=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.159) by
 VI1PR04MB4336.eurprd04.prod.outlook.com (52.134.122.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.29; Fri, 25 Jan 2019 07:51:25 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::558f:3cb4:9a6a:8f84]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::558f:3cb4:9a6a:8f84%4]) with mapi id 15.20.1558.021; Fri, 25 Jan 2019
 07:51:25 +0000
From: Peng Ma <peng.ma@nxp.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>, "axboe@kernel.dk"
 <axboe@kernel.dk>
Subject: RE: [v4] dt-bindings: ahci-fsl-qoriq: add lx2160a chip name to the
 list
Thread-Topic: [v4] dt-bindings: ahci-fsl-qoriq: add lx2160a chip name to the
 list
Thread-Index: AQHUtF9efFS7Qrpb80CTNCtsf0630qW/myqAgAAAzMA=
Date: Fri, 25 Jan 2019 07:51:25 +0000
Message-ID: <VI1PR04MB443120B2EDFF71E7F6BB1969ED9B0@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <20190125033221.30333-1-peng.ma@nxp.com>
 <20190125033221.30333-2-peng.ma@nxp.com>
 <7c0ed8e1-7d41-8594-fd9d-9e220cbb2ab1@cogentembedded.com>
In-Reply-To: <7c0ed8e1-7d41-8594-fd9d-9e220cbb2ab1@cogentembedded.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB4336;
 6:mCNYjiQoKGdHu3DQglESCNpa/ZGSkKuaGHR1dm+GV2uOM59Yb3PrmvdOkpe+ydHeYfd4oG3YRkIPt+dnP/LkMsYeseK73ivuiP2xQhKSKfwKTPHJvJwH5FSlDsm0a7wGNYLFUZz1pIVksb78FOHUToEAYVHheQsT/S6WYD2kk1NKze4QbLIDxpzSgWXgY72TxsGBtnwY+LBFJdlcjpceq6I/RbYiAh4cW3zChPzlCkQZXNr4zH54Vogrw8ut8M+K4AYOdNSEE5CcKwkocE59CJIQk+0xdv8LGsYEey33tepbzwyG2mtXBhTV1juHEL+DHWZNxg+G6fij28TPAl0rnPn9eJhSJantPYZAd3+9LYzlPePVytbk1EdnjvTNAqOFcVF+bg3k3v8fMoBLGbhbiVYK0VfUUOOwrO4AxVZRizpGVvKyF2a31qEAADcQWRC9azK90Gxh7T9+DPVlG4klag==;
 5:eBX+UQu4RDPRmyh8O+ZsfW8qsATKbN/BTwRb+CKHP3PFX4dVBocoOgUiTi93w1rvCf9sHJcE+bmtwm9/mE7hWdXpTlyLaMgRHq59HDQGcgf0o/sj6QLkXN/wxgIu3E/7Sowyk6O++Gj0jYusyQBd8kM0PAcv484mwKUzdqx1EHyjMvpjGOrGSkFaE5/dt6YRqlFYBNvycURZgWnd5FCmPg==;
 7:4vbNi11yiKJnCWpwLpgz2lZL3te5/oDni2SbAURqothx39vo8tFX5a92ON/ueHdQCAOd9smVo/blHS62wUpXTCy0CKoamwvcBRW7NC32MsbO+Tg5IUMuw7Zod2X/42FLvQJZUvqaGcxUTFA6uzXR9g==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 660bfebb-734b-4838-4046-08d68299e839
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB4336; 
x-ms-traffictypediagnostic: VI1PR04MB4336:
x-microsoft-antispam-prvs: <VI1PR04MB433665DF3731AB03401DDE45ED9B0@VI1PR04MB4336.eurprd04.prod.outlook.com>
x-forefront-prvs: 0928072091
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(366004)(346002)(376002)(136003)(13464003)(189003)(199004)(44832011)(55016002)(256004)(81156014)(81166006)(8936002)(6116002)(3846002)(99286004)(7736002)(6436002)(8676002)(66066001)(2201001)(2501003)(86362001)(305945005)(53936002)(106356001)(102836004)(11346002)(97736004)(486006)(26005)(9686003)(71190400001)(54906003)(7696005)(2906002)(316002)(478600001)(76176011)(229853002)(71200400001)(110136005)(74316002)(105586002)(68736007)(6506007)(14454004)(25786009)(33656002)(446003)(4326008)(186003)(6246003)(476003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4336;
 H:VI1PR04MB4431.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rcqlbfTsd417duwEtjJe0Z9fo6NxJ3XLiHG21OJ8bAVufEieUONiUnIxwuW0qUhnH/MHLUAvUWicdgNup0i6eNRSiEdFSVew9J1FF7YWPcWNfZq07ar8qBAJiecKJCF4He67ytOFJ0Rxb4mYwSw+g3tiDNeuZdq4ppAB1FJ1yKx2ReCg5ApneZlGlAz6kZBGFI7XX1qV+ACTKPaqwr5PA46HKcxV0peZ7CqFP9i+oFokXb9b81qup8cSoR08GJ8x9U+SEP9FNYiAWlsckJZ5NsZqxHNYMd9K4Uu5gvoJHjD694/ld+8+nx0OfVLrUx6iv5M6+6ziBqMf8zBrBdxpPlOQKsW3BWOhyJOgkbEoMoimBAF5NWFyseGon2PZVCaKVLaMRITDScqjJbg84lntP+V1//2PnLpjym+19+cljBA=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 660bfebb-734b-4838-4046-08d68299e839
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2019 07:51:25.6239 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4336
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_235129_811028_278754C3 
X-CRM114-Status: GOOD (  13.04  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Andy Tang <andy.tang@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>,
 "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFNlcmdlaSBTaHR5bHlvdiA8
c2VyZ2VpLnNodHlseW92QGNvZ2VudGVtYmVkZGVkLmNvbT4NCj5TZW50OiAyMDE55bm0MeaciDI1
5pelIDE1OjQ2DQo+VG86IFBlbmcgTWEgPHBlbmcubWFAbnhwLmNvbT47IHNoYXduZ3VvQGtlcm5l
bC5vcmc7IGF4Ym9lQGtlcm5lbC5kaw0KPkNjOiByb2JoK2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0
bGFuZEBhcm0uY29tOyBMZW8gTGkNCj48bGVveWFuZy5saUBueHAuY29tPjsgbGludXgtaWRlQHZn
ZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+bGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBB
bmR5IFRhbmcNCj48YW5keS50YW5nQG54cC5jb20+DQo+U3ViamVjdDogUmU6IFt2NF0gZHQtYmlu
ZGluZ3M6IGFoY2ktZnNsLXFvcmlxOiBhZGQgbHgyMTYwYSBjaGlwIG5hbWUgdG8gdGhlIGxpc3QN
Cj4NCj5IZWxsbyENCj4NCj5PbiAyNS4wMS4yMDE5IDY6MzIsIFBlbmcgTWEgd3JvdGU6DQo+DQo+
PiBBZGQgbHh4MjE2MGEgY29tcGF0aWJsZSB0byBiaW5kaW5ncyBkb2N1bWVudGF0aW9uLg0KPg0K
PiAgICBseDIxNjBhPw0KPg0KW1BlbmcgTWFdIA0KWWVzLCBpdCBpcyBzaG91bGQgYmUgbHgyMTYw
YSwgdGhhbmtzIHZlcnkgbXVjaC4NCkkgd2lsbCBjaGFuZ2UgaXQgYXMgc29vbiBhcyBwb3NzaWJs
ZS4NCkJlc3QgUmVnYXJkcywNClBlbmcNCj4+IFNpZ25lZC1vZmYtYnk6IFBlbmcgTWEgPHBlbmcu
bWFAbnhwLmNvbT4NCj4+IC0tLQ0KPj4gY2hhbmdlZCBmb3IgVjQ6DQo+PiAJLSBhZGQgbHgyMTYw
YSBjb21wYXRpYmxlIHRvIGJpbmRpbmdzIGRvYw0KPj4NCj4+ICAgLi4uL2RldmljZXRyZWUvYmlu
ZGluZ3MvYXRhL2FoY2ktZnNsLXFvcmlxLnR4dCAgICAgfCAgICAyICstDQo+PiAgIDEgZmlsZXMg
Y2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1n
aXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXRhL2FoY2ktZnNsLXFvcmlx
LnR4dA0KPmIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2F0YS9haGNpLWZzbC1x
b3JpcS50eHQNCj4+IGluZGV4IDdjM2NhMGUuLjllY2MwMTkgMTAwNjQ0DQo+PiAtLS0gYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXRhL2FoY2ktZnNsLXFvcmlxLnR4dA0KPj4g
KysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2F0YS9haGNpLWZzbC1xb3Jp
cS50eHQNCj4+IEBAIC0zLDcgKzMsNyBAQCBCaW5kaW5nIGZvciBGcmVlc2NhbGUgUW9ySVEgQUhD
SSBTQVRBIENvbnRyb2xsZXINCj4+ICAgUmVxdWlyZWQgcHJvcGVydGllczoNCj4+ICAgICAtIHJl
ZzogUGh5c2ljYWwgYmFzZSBhZGRyZXNzIGFuZCBzaXplIG9mIHRoZSBjb250cm9sbGVyJ3MgcmVn
aXN0ZXIgYXJlYS4NCj4+ICAgICAtIGNvbXBhdGlibGU6IENvbXBhdGliaWxpdHkgc3RyaW5nLiBN
dXN0IGJlICdmc2wsPGNoaXA+LWFoY2knLCB3aGVyZQ0KPj4gLSAgICBjaGlwIGNvdWxkIGJlIGxz
MTAyMWEsIGxzMTA0M2EsIGxzMTA0NmEsIGxzMTA4OGEsIGxzMjA4MGEgZXRjLg0KPj4gKyAgICBj
aGlwIGNvdWxkIGJlIGxzMTAyMWEsIGxzMTA0M2EsIGxzMTA0NmEsIGxzMTA4OGEsIGxzMjA4MGEs
IGx4MjE2MGEsIGV0Yy4NCj4+ICAgICAtIGNsb2NrczogSW5wdXQgY2xvY2sgc3BlY2lmaWVyLiBS
ZWZlciB0byBjb21tb24gY2xvY2sgYmluZGluZ3MuDQo+PiAgICAgLSBpbnRlcnJ1cHRzOiBJbnRl
cnJ1cHQgc3BlY2lmaWVyLiBSZWZlciB0byBpbnRlcnJ1cHQgYmluZGluZy4NCj4+DQo+DQo+TUJS
LCBTZXJnZWkNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LWFybS1rZXJuZWwK
