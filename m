Return-Path: <SRS0=5OaU=PA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D88DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:15:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 491A221903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aoISYnsy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kcuENunP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 491A221903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9r2ZARb4Zv3O2jlY7qGYzjyXMmrAFDJlOa9t9JBH4+E=; b=aoISYnsyf8KH1h
	UUEP1efTrbe4peub0JqBHo5qLVAb+nzlmVN7pChOzrXTVXipteEsIfipCUf0Xe5+R02CWbfcTRF7E
	VzvgA6rW2NxE5Or+ROGCQN0AnAaSsBV959CyFELQSABwGUJAODEPZIyxdYkqRyJgqXt4D3uGM2eaT
	fauNuOQBdr+uWKy84rsKbCljm/q+qstY9ORs9DadsxDQCpfQ5PT992P+xhX19W0p7xV6+z7n8an7b
	sOxmUlfzRrUfhoU2LYfZ3hL5KTdMEujNPKSTTvP/H8OfhRO0QS0HE9So3tlQIBghfBVDjI5qtKPx7
	GmoP0kKc+xhNzdX3pZ3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gazqb-0005VZ-Cp; Sun, 23 Dec 2018 09:14:57 +0000
Received: from mail-eopbgr10056.outbound.protection.outlook.com ([40.107.1.56]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gazqX-0005TZ-K4
 for linux-arm-kernel@lists.infradead.org; Sun, 23 Dec 2018 09:14:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uo9o1+4coZxW9vGX64Qb49ldl8SjPQ0kY30GT0Wl1QQ=;
 b=kcuENunPAmkgxay16sdtUmiBgtOYKpwcjl41xEjnnS3Jd+Gw66cGTXwoUPhgt6Q3nQGP2954/JS/j0pc09/wRr4n94/TGxR/P+jbfAPVBMuah3TsX2xqQIwRwy8XRt+Q2NqOh0EMdc9G/RNIiJnIXfTkrnyg4T+UXDUKuxdPbpQ=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5059.eurprd04.prod.outlook.com (20.177.40.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.26; Sun, 23 Dec 2018 09:14:36 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6%7]) with mapi id 15.20.1446.026; Sun, 23 Dec 2018
 09:14:36 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>
Subject: RE: [PATCH] soc: imx: Break dependency on SOC_IMX8MQ for GPCv2
Thread-Topic: [PATCH] soc: imx: Break dependency on SOC_IMX8MQ for GPCv2
Thread-Index: AQHUmo0ZxZkW3cAPxEypasRMKtmrGKWMCRmQ
Date: Sun, 23 Dec 2018 09:14:36 +0000
Message-ID: <AM0PR04MB4211F4CAC02A1ECA6939960380BA0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1545548380-17399-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1545548380-17399-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5059;
 6:NYusrPLJESuwLhZ3JxD7V8/xvSDNw+jVlTRZLxIQqMp0ihoING9ub2XWKIKKplgyQ1gL2YrEgT9+YPKAHJaHyKbCh/bh2EkoWFlc9R/ZxRINA7jeo6TfyGAilyahHqcDV4YSLv1DYUvfQXSoRWi/Jl1KR/6LcJ+NaSSXL6vyP8/PF3mvhBcjHuPTpDv84/9oBKnTJ1CZhkUXmagvU5mtYNMeM2J+rPN2V/YIRf7uBORo9zGC2FmYu7QHCpiXABUFHz3i7O8t0I+Nb/ktDxyH84TrvH6x7dEojxrUL5hYWQB8kaAHLytP0xNqyrSnHTWhvS3cW5nPfkpdeGZHLZFvwukINQ8CG/HfKuEvKHbzAfcpqPg9XASQF1qQDTxEHvJawrRVQdqW4dP6myYMnUSBC7Yalu9IxdNDfaV9hTRGKOxuppqwXtoe6qQRKTh0d3aey4X+xnQmcApmkymq8GZyoA==;
 5:GrUm5vHoC72ih+TXzo5+gLeqEg5eSpACYeTHLwJO0X+MhbJPQpD9KxhZPVAC/gVzoCgkvsJjp1aPWrKxAotSsaKVTVBvLOcaAbjdcmiix68KOpq1SjvcRCA5No1tvLVheMBz19SBbyS0SrCfecy8JK8e94M2Q303zz7PmfdSM98=;
 7:ss5qPFcMQYj7apQcRV6jDBPKLJegHHXxRqEiiOgJkvCqRm895ID3wigxgfQ8Cb9qgiAOmSbus1QVaJqYoH6vU8BN/JMcgo6hzsoc8uS/d4yT1E82dgntEuADEoWwlaS35OuOY4Ay7GTfcUqRufu5hQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e666d3f3-a0fd-40ce-f713-08d668b70f5e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5059; 
x-ms-traffictypediagnostic: AM0PR04MB5059:
x-microsoft-antispam-prvs: <AM0PR04MB5059B1D6F0460D379C7F3A1180BA0@AM0PR04MB5059.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB5059; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB5059; 
x-forefront-prvs: 0895DF8FFD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(396003)(376002)(39860400002)(346002)(136003)(189003)(199004)(13464003)(81166006)(102836004)(81156014)(86362001)(14454004)(476003)(486006)(11346002)(478600001)(5660300001)(25786009)(8676002)(186003)(446003)(76176011)(2906002)(33656002)(6436002)(105586002)(106356001)(44832011)(316002)(4326008)(8936002)(53936002)(74316002)(66066001)(55016002)(229853002)(26005)(9686003)(71190400001)(71200400001)(97736004)(14444005)(256004)(68736007)(54906003)(7696005)(99286004)(6246003)(6116002)(305945005)(7736002)(110136005)(53546011)(6636002)(3846002)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5059;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OxJ5bk98zNl+qTy4HJk2dxEfQSc0YKUKm2OzfcMA+TSgDIr2s2z7WF4Z1zax81udnXwa693hL/20LNa3gbv6Rwnl2WBhIlogaff18ptdwkae2MP/kMvNvbQqERPRH0ZJSKYt40sCnnbsitrWj3HZ7+YPHBkozrvaoaaB7xY8fxCja/to28sP/agrOLyXkta5ic3jQPVdLa5FVCK+o47LlPQf9cL6QyJo5T4qUuoc2Z9FrhI1JWRrN5zLXLsqOMfrXlIUzsgyVpYDqzSG9myH60fTw1Dny4gBJuKSqED753FL3yuzvGi4MhvI4VwOs/Bc
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e666d3f3-a0fd-40ce-f713-08d668b70f5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2018 09:14:36.5079 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5059
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181223_011453_662649_67E933BD 
X-CRM114-Status: GOOD (  17.16  )
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
Cc: dl-linux-imx <linux-imx@nxp.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> -----Original Message-----
> From: Abel Vesa
> Sent: Sunday, December 23, 2018 3:00 PM
> To: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>
> Cc: dl-linux-imx <linux-imx@nxp.com>; linux-arm-kernel@lists.infradead.org;
> Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Abel Vesa
> <abel.vesa@nxp.com>
> Subject: [PATCH] soc: imx: Break dependency on SOC_IMX8MQ for GPCv2
> 
> Since this is going to be used on more SoCs than just i.MX8MQ, make the
> dependency here more generic.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  drivers/soc/imx/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig index
> 2112d18..7ffbb6b 100644
> --- a/drivers/soc/imx/Kconfig
> +++ b/drivers/soc/imx/Kconfig
> @@ -2,7 +2,7 @@ menu "i.MX SoC drivers"
> 
>  config IMX_GPCV2_PM_DOMAINS
>  	bool "i.MX GPCv2 PM domains"
> -	depends on SOC_IMX7D || SOC_IMX8MQ || (COMPILE_TEST && OF)
> +	depends on SOC_IMX7D || ARCH_MXC || (COMPILE_TEST && OF)

Nitpick:
ARCH_MXC already contains SOC_IMX7D, so simply depends on
ARCH_MXC || (COMPILE_TEST && OF) should be enough.

Otherwise:
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

>  	depends on PM
>  	select PM_GENERIC_DOMAINS
>  	default y if SOC_IMX7D
> --
> 2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
