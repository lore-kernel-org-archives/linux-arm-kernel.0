Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF72BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 04:30:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B50B220675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 04:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AjI/bxyy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wH2+MHN7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B50B220675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=inOrLwVW1AnkRJNDzDvRUNR6APex/Aafm709qwyOkB8=; b=AjI/bxyy0r0tyz
	btB+sbw0nKTc36IuLPH2+aJDdm3fjHQeMXcpqYbEktfeHjXQuVPm6U7u89iq/h2z4a+qN5SnH+gh+
	dBl+D28D+YCkYv1YX5SlZc+sIhlAtu1B5tpxvOfRgI+w577h+lSBcaVvjspj+6kx6H0Rt3ves13Ju
	agLlR+1rd4ELP3abIQMV8avKko/dTup8vBT5yXkgjha2VxZeePirXucwphpl3gXHDgdcGaCsoEoe/
	thquegLpMf3eepOwlGcdlcU17WRAfwWlPdAFUiNUWjIZjKbr/L8Cogd1jl7ch6el9ELOmy3ay736m
	brnqPu52HqERpSSAUhQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjcqg-0003go-6D; Wed, 16 Jan 2019 04:30:42 +0000
Received: from mail-eopbgr20087.outbound.protection.outlook.com ([40.107.2.87]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjcqa-0003gE-Jm
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 04:30:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyKlXFs4SQiLbjRualxGC5JuzAMnMgIrbWempZyePEk=;
 b=wH2+MHN7SiHNqqfgRln2goskHIXfutHrj9N6eVwM0Ck/wCAAR6FV4Q+fhKautEAvCsGiyYYGNVTq/t9giyX5PyfVmfKC+aZWFxlb3FBQTXP2aJBIldIJcb+xFG0h82ypXdzwXVfnuNgfqg7+bE+jk1QlPpDCwCJaDZEGgkpWAk0=
Received: from VI1PR04MB4558.eurprd04.prod.outlook.com (20.177.55.216) by
 VI1PR04MB4557.eurprd04.prod.outlook.com (20.177.55.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Wed, 16 Jan 2019 04:30:29 +0000
Received: from VI1PR04MB4558.eurprd04.prod.outlook.com
 ([fe80::b031:35a0:6edf:62c7]) by VI1PR04MB4558.eurprd04.prod.outlook.com
 ([fe80::b031:35a0:6edf:62c7%3]) with mapi id 15.20.1516.019; Wed, 16 Jan 2019
 04:30:29 +0000
From: Jun Li <jun.li@nxp.com>
To: Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Subject: RE: [PATCH 1/2] arm64: dts: fsl: imx8mq: add USB nodes
Thread-Topic: [PATCH 1/2] arm64: dts: fsl: imx8mq: add USB nodes
Thread-Index: AQHUrMHyMvPNwhXL0kWRqhQWmSCSE6WxAgAg
Date: Wed, 16 Jan 2019 04:30:29 +0000
Message-ID: <VI1PR04MB455880021886BD03D29126DA89820@VI1PR04MB4558.eurprd04.prod.outlook.com>
References: <20190115110325.13236-1-l.stach@pengutronix.de>
In-Reply-To: <20190115110325.13236-1-l.stach@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=jun.li@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB4557;
 6:VAE0eynw/XxeTOTAZ2WjUaAxm4PK8WyTTMPmS7/jUpjdXtx3LN8ws6fcmvBcFUNeane3U5Bhab8/fzge9C7YnnuOGBAKOBbJRkzJC/8S3MzR0PAQ+ZY8DQ2WdGkE5T2HWMqhGdljf3jLtO78uwo0sa8WsJPawT63COtqnzaEVRJASYu/+yPg4K9o93q5d6CzElBDAZA230KkOYiG1K2FP0UnBcDdUnxcYh0m+V15EQr87/xgeOddSBuxvfCAITMIg4PZbhzoTlMEXSHu0r4wqgbZ5WGA0q5h58HumRY36IN0lypbn5zdD3iX139SjlOW2foD1JsUMaf1k1bP3o7k/5udP57lucG12TIlMfz1hWU8clVC+iZZIhb8AVDRBB30xae4mOXxmhReQkO3loOw1hqoDPgALcykR4w8OIzWUv6oWD1L9p5TNzeJrRTLmKt9HU8q8ZBFLZq/7gA1C23uVg==;
 5:WGpKYBP0TQ52E5eaewhB0cXO7vKBZow9QgONNV93EZhxBoYlqvVKfYDdd2K7tKYfaO47AxvUpOhFS3IDJa8mibGjgO3tM9adXhFbPvfZh296ncaEvFPqrYMBaEMo9WK5S6umlQvoa/Qx+VplTdu+4NSgTqrd5NcGh08idZhYz1LoJ8YvidlEyJ53+HKZcggpaRyc/N37oh/bFBnm7T2Gzw==;
 7:UUWSVH97emwqVhjMmhiiwMIO6741bQyXffcml5irAutL77Mn+tBkdcvOtLfX3SFIsZKcHBCfRFWLH4EO63U+1dXOt2xV1iAmFEzXjgctFqksoY5ATafCB59oiYUI/BIq8zqt0QZmUrPUaoGak194Xw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: eb4fa521-c961-484f-938e-08d67b6b588c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB4557; 
x-ms-traffictypediagnostic: VI1PR04MB4557:
x-microsoft-antispam-prvs: <VI1PR04MB4557A64FD8855421D103924C89820@VI1PR04MB4557.eurprd04.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(39860400002)(366004)(396003)(346002)(136003)(13464003)(43544003)(189003)(199004)(99286004)(256004)(14444005)(478600001)(54906003)(316002)(33656002)(110136005)(5660300001)(68736007)(105586002)(106356001)(14454004)(229853002)(66066001)(4326008)(3846002)(186003)(6116002)(7736002)(53936002)(6436002)(6246003)(86362001)(71190400001)(305945005)(76176011)(8936002)(26005)(55016002)(71200400001)(446003)(102836004)(486006)(2906002)(11346002)(81166006)(7696005)(25786009)(44832011)(74316002)(6506007)(476003)(97736004)(81156014)(9686003)(53546011)(8676002)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4557;
 H:VI1PR04MB4558.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2cgk8rm7dl24Twfws0GSNiCQsXQsqGrtSCU7SA3ibk9tp0D4g3shXiwdsdS9n2P6Hu/R6VkjCY6n6OYYAxejkULpgX5JrTyF1iQQCq7eILLXpbPSw74BZz18CpTknqLZWCgMSO/+dqE3ZyEYMr1MZWH7V7otNtN5yJxBLOtrWU/060nQcGpTMBda3HYmIfMegMYEEJNCnHl8unzEcVM/b2kmXLnZ6uiGOV8YQ+LZeVngcpuuZ/rbX/gW0dNY2DEWvfaUECX5FnYysjqt6czqupIGHmVfAqE+qTSgFqgJXrRmwlBNX41ulNbICpotZHi1Tu6oF4SR3ZuzNXlekd3Hpcs0tHiQKbIngRn14WzcP4tFMnb+rQjQ/ojaOuaunMA3/Ja8uh9eyP2BkVlEAoAoZEmHQJiKRy1Z2w1rQABDkJM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4fa521-c961-484f-938e-08d67b6b588c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 04:30:29.5097 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4557
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_203036_653941_38F20324 
X-CRM114-Status: GOOD (  15.26  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>,
 "patchwork-lst@pengutronix.de" <patchwork-lst@pengutronix.de>,
 dl-linux-imx <linux-imx@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgTHVjYXMsDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEx1Y2FzIFN0
YWNoIDxsLnN0YWNoQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiAyMDE5xOox1MIxNcjVIDE5OjAz
DQo+IFRvOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+DQo+IENjOiBGYWJpbyBFc3Rl
dmFtIDxmYWJpby5lc3RldmFtQG54cC5jb20+OyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAu
Y29tPjsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBrZXJuZWxAcGVu
Z3V0cm9uaXguZGU7DQo+IHBhdGNod29yay1sc3RAcGVuZ3V0cm9uaXguZGUNCj4gU3ViamVjdDog
W1BBVENIIDEvMl0gYXJtNjQ6IGR0czogZnNsOiBpbXg4bXE6IGFkZCBVU0Igbm9kZXMNCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEx1Y2FzIFN0YWNoIDxsLnN0YWNoQHBlbmd1dHJvbml4LmRlPg0KPiAt
LS0NCj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS5kdHNpIHwgNjYgKysr
KysrKysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA2NiBpbnNlcnRpb25zKCsp
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1x
LmR0c2kNCj4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEuZHRzaQ0KPiBp
bmRleCA1YmQxZjEwNmVkODQuLmQyNWFiNTBkNmI4OCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kNCj4gKysrIGIvYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kNCj4gQEAgLTQ3MCw2ICs0NzAsNzIgQEANCj4gIAkJ
CX07DQo+ICAJCX07DQo+IA0KPiArCQl1c2JfZHdjM18wOiB1c2JAMzgxMDAwMDAgew0KPiArCQkJ
Y29tcGF0aWJsZSA9ICJmc2wsaW14OG1xLWR3YzMiLCAic25wcyxkd2MzIjsNCj4gKwkJCXJlZyA9
IDwweDM4MTAwMDAwIDB4MTAwMDA+Ow0KPiArCQkJY2xvY2tzID0gPCZjbGsgSU1YOE1RX0NMS19V
U0JfQlVTPiwNCj4gKwkJCSAgICAgICAgIDwmY2xrIElNWDhNUV9DTEtfVVNCX0NPUkVfUkVGPiwN
Cj4gKwkJCSAgICAgICAgIDwmY2xrIElNWDhNUV9DTEtfVVNCMV9DVFJMX1JPT1Q+Ow0KPiArCQkJ
Y2xvY2stbmFtZXMgPSAiYnVzX2Vhcmx5IiwgInJlZiIsICJzdXNwZW5kIjsNCj4gKwkJCWFzc2ln
bmVkLWNsb2NrcyA9IDwmY2xrIElNWDhNUV9DTEtfVVNCX0JVUz4sDQo+ICsJCQkgICAgICAgICAg
ICAgICAgICA8JmNsayBJTVg4TVFfQ0xLX1VTQl9DT1JFX1JFRj47DQo+ICsJCQlhc3NpZ25lZC1j
bG9jay1wYXJlbnRzID0gPCZjbGsgSU1YOE1RX1NZUzJfUExMXzUwME0+LA0KPiArCQkJICAgICAg
ICAgICAgICAgICAgICAgICAgIDwmY2xrIElNWDhNUV9TWVMxX1BMTF8xMDBNPjsNCj4gKwkJCWFz
c2lnbmVkLWNsb2NrLXJhdGVzID0gPDUwMDAwMDAwMD4sIDwxMDAwMDAwMDA+Ow0KPiArCQkJaW50
ZXJydXB0cyA9IDxHSUNfU1BJIDQwIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiArCQkJcGh5cyA9
IDwmdXNiM19waHkwPiwgPCZ1c2IzX3BoeTA+Ow0KPiArCQkJcGh5LW5hbWVzID0gInVzYjItcGh5
IiwgInVzYjMtcGh5IjsNCj4gKwkJCXBvd2VyLWRvbWFpbnMgPSA8JnBnY19vdGcxPjsNCj4gKwkJ
CXNucHMscG93ZXItZG93bi1zY2FsZSA9IDwyPjsNCg0KVGhpcyBwcm9wZXJ0eSBkb2VzIG5vdCBl
eGlzdCBvbiB1cHN0cmVhbSwgbmVlZCBmaXJzdGx5IGludHJvZHVjZSBpdCBmb3IgZHdjMyBkcml2
ZXINCmJlZm9yZSBhZGQgaXQgaW4gZHRzLCBJIGNhbiBkbyB0aGF0IGlmIHlvdSBhcmUgbm90IGdv
aW5nIHRvIHRha2UgY2FyZSBvZiBpdC4NCg0KSnVuDQoNCj4gKwkJCXVzYjMtcmVzdW1lLW1pc3Np
bmctY2FzOw0KPiArCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gKwkJfTsNCj4gKw0KPiArCQl1
c2IzX3BoeTA6IHBoeUAzODFmMDA0MCB7DQo+ICsJCQljb21wYXRpYmxlID0gImZzbCxpbXg4bXEt
dXNiLXBoeSI7DQo+ICsJCQlyZWcgPSA8MHgzODFmMDA0MCAweDQwPjsNCj4gKwkJCWNsb2NrcyA9
IDwmY2xrIElNWDhNUV9DTEtfVVNCMV9QSFlfUk9PVD47DQo+ICsJCQljbG9jay1uYW1lcyA9ICJw
aHkiOw0KPiArCQkJYXNzaWduZWQtY2xvY2tzID0gPCZjbGsgSU1YOE1RX0NMS19VU0JfUEhZX1JF
Rj47DQo+ICsJCQlhc3NpZ25lZC1jbG9jay1wYXJlbnRzID0gPCZjbGsgSU1YOE1RX1NZUzFfUExM
XzEwME0+Ow0KPiArCQkJYXNzaWduZWQtY2xvY2stcmF0ZXMgPSA8MTAwMDAwMDAwPjsNCj4gKwkJ
CSNwaHktY2VsbHMgPSA8MD47DQo+ICsJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiArCQl9Ow0K
PiArDQo+ICsJCXVzYl9kd2MzXzE6IHVzYkAzODIwMDAwMCB7DQo+ICsJCQljb21wYXRpYmxlID0g
ImZzbCxpbXg4bXEtZHdjMyIsICJzbnBzLGR3YzMiOw0KPiArCQkJcmVnID0gPDB4MzgyMDAwMDAg
MHgxMDAwMD47DQo+ICsJCQljbG9ja3MgPSA8JmNsayBJTVg4TVFfQ0xLX1VTQl9CVVM+LA0KPiAr
CQkJICAgICAgICAgPCZjbGsgSU1YOE1RX0NMS19VU0JfQ09SRV9SRUY+LA0KPiArCQkJICAgICAg
ICAgPCZjbGsgSU1YOE1RX0NMS19VU0IyX0NUUkxfUk9PVD47DQo+ICsJCQljbG9jay1uYW1lcyA9
ICJidXNfZWFybHkiLCAicmVmIiwgInN1c3BlbmQiOw0KPiArCQkJYXNzaWduZWQtY2xvY2tzID0g
PCZjbGsgSU1YOE1RX0NMS19VU0JfQlVTPiwNCj4gKwkJCSAgICAgICAgICAgICAgICAgIDwmY2xr
IElNWDhNUV9DTEtfVVNCX0NPUkVfUkVGPjsNCj4gKwkJCWFzc2lnbmVkLWNsb2NrLXBhcmVudHMg
PSA8JmNsayBJTVg4TVFfU1lTMl9QTExfNTAwTT4sDQo+ICsJCQkgICAgICAgICAgICAgICAgICAg
ICAgICAgPCZjbGsgSU1YOE1RX1NZUzFfUExMXzEwME0+Ow0KPiArCQkJYXNzaWduZWQtY2xvY2st
cmF0ZXMgPSA8NTAwMDAwMDAwPiwgPDEwMDAwMDAwMD47DQo+ICsJCQlpbnRlcnJ1cHRzID0gPEdJ
Q19TUEkgNDEgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ICsJCQlwaHlzID0gPCZ1c2IzX3BoeTE+
LCA8JnVzYjNfcGh5MT47DQo+ICsJCQlwaHktbmFtZXMgPSAidXNiMi1waHkiLCAidXNiMy1waHki
Ow0KPiArCQkJcG93ZXItZG9tYWlucyA9IDwmcGdjX290ZzI+Ow0KPiArCQkJc25wcyxwb3dlci1k
b3duLXNjYWxlID0gPDI+Ow0KDQpEaXR0bw0KDQo+ICsJCQl1c2IzLXJlc3VtZS1taXNzaW5nLWNh
czsNCj4gKwkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICsJCX07DQo+ICsNCj4gKwkJdXNiM19w
aHkxOiBwaHlAMzgyZjAwNDAgew0KPiArCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OG1xLXVzYi1w
aHkiOw0KPiArCQkJcmVnID0gPDB4MzgyZjAwNDAgMHg0MD47DQo+ICsJCQljbG9ja3MgPSA8JmNs
ayBJTVg4TVFfQ0xLX1VTQjJfUEhZX1JPT1Q+Ow0KPiArCQkJY2xvY2stbmFtZXMgPSAicGh5IjsN
Cj4gKwkJCWFzc2lnbmVkLWNsb2NrcyA9IDwmY2xrIElNWDhNUV9DTEtfVVNCX1BIWV9SRUY+Ow0K
PiArCQkJYXNzaWduZWQtY2xvY2stcGFyZW50cyA9IDwmY2xrIElNWDhNUV9TWVMxX1BMTF8xMDBN
PjsNCj4gKwkJCWFzc2lnbmVkLWNsb2NrLXJhdGVzID0gPDEwMDAwMDAwMD47DQo+ICsJCQkjcGh5
LWNlbGxzID0gPDA+Ow0KPiArCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gKwkJfTsNCj4gKw0K
PiAgCQlnaWM6IGludGVycnVwdC1jb250cm9sbGVyQDM4ODAwMDAwIHsNCj4gIAkJCWNvbXBhdGli
bGUgPSAiYXJtLGdpYy12MyI7DQo+ICAJCQlyZWcgPSA8MHgzODgwMDAwMCAweDEwMDAwPiwJLyog
R0lDIERpc3QgKi8NCj4gLS0NCj4gMi4yMC4xDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
