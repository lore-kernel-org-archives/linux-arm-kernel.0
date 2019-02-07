Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196CFC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:01:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB8BD2175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NKxTEXu1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="dK/NonD5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8BD2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MshNrf2mCgd6qLnFiJnradq8y3dPmdbPIqMlkgOx0Es=; b=NKxTEXu1dycRxV
	tp7hexcA47b9o+ZMneODY/43gXpT56nlEZWy1UUvanAAHd2pB18AToSjVJYLXYG1UquQC8efSEH4Z
	GEivk5WMY5TYYLmDr2caoVH604N+LcFLT+YpK2g75EyychtAEQe2An2iq8YreR+oumR3zd2dkxx0S
	XAqyVz8OdvpFR0Qc9BmdHhUZLTzyyOUxUygHbs12qARADC11aUGpnDjaDBWLI6mpVzZcHbpFKYWpH
	zOI8r5XvUGFIycAfhqpingjMPF9oEBji9dTvnV7Nr/jR0vnZW+zFOHyIovHaCTnM3bq9ee0FuVxMs
	xJ3UYrLrXUX83ARUDGtw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grqmz-0003LT-4m; Thu, 07 Feb 2019 21:00:53 +0000
Received: from mail-eopbgr750133.outbound.protection.outlook.com
 ([40.107.75.133] helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grqmu-0003Kq-Vo
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 21:00:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Cc6v6OfaoNRFvTvdvV9r6J5i9WAeF7BmwRI71peiFQ=;
 b=dK/NonD5BdZqVtVKkHXgmb13TRWd0MA2pSjMSOAk+iTVSU9SIvskhXIu2dOgeXyUaNp3dH6UD3xlGrXtX95Bl+RwzwkfycVRso8ZJf7ueubky5/ZGOu2k01bNHOAVUOCUC/R+X0zkmnyOwC0D/XJu1La4Gbhh6hXNv2i2r2v1g8=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3737.namprd06.prod.outlook.com (10.167.236.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Thu, 7 Feb 2019 21:00:44 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85%5]) with mapi id 15.20.1601.016; Thu, 7 Feb 2019
 21:00:44 +0000
From: Trent Piepho <tpiepho@impinj.com>
To: "stefan@agner.ch" <stefan@agner.ch>, "s.hauer@pengutronix.de"
 <s.hauer@pengutronix.de>, "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: Re: [PATCH 2/2] ARM: dts: imx7: add DMA properties for ECSPI
Thread-Topic: [PATCH 2/2] ARM: dts: imx7: add DMA properties for ECSPI
Thread-Index: AQHUvyD/DkP33gVxsUSHwHJ5QzA1bqXU0h6A
Date: Thu, 7 Feb 2019 21:00:44 +0000
Message-ID: <1549573243.3075.72.camel@impinj.com>
References: <20190107132226.16216-1-stefan@agner.ch>
 <20190107132226.16216-2-stefan@agner.ch>
In-Reply-To: <20190107132226.16216-2-stefan@agner.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR0601MB3737;
 6:Gd4ldN54T+trkzj5C+gl3ZQ6zayrbOT1Mfuq/symv3bniUoUaeDJuEC+SxQJUmr80dyEFEETmax+KcIye1+cmmOeb5rh7bIDplUJb0wGtwZNEYXWUibk6vFcJXSza5dkhRxKhKvpR/tTOZNmrPrLvhXygG4V0sdMpKxPEyPGC5bsNffniYiD0ygOQ+mbKRsm+ClNITJGVgZxCl+5Xjz4FaidxtE9BF7xyUIMzf/nG08rm2TsAhlu1zyaZUAKwLGpeG/Wpzp7s0VPxkztyD55O6yLLwcnnw+UzOrz4gpnDcu6WKDavjehNXl8jbCFZBboOsHz1D+09VZu+JralwuXArv/JhJQx2U69ifcKyuZgd3sn7JvW5H+WuqQPSE4llvIt21LDx6/SID6vi5cVwPgB87/lpcIq5wOB3XPBjYM2qLjmY6UYMlCwz2wJ6ZvOeq0CaCANO1/XXjTzfquJG6ilw==;
 5:LCZ7B+HGS25rPtKEOS2tvbPG7W5Iy7oZnrX6pA9ZeAs7rYj7lZHMhJ3Iua6Q+WHp6VHDWtacy342OiLPtzpwOwghNRuPmTsZqktHu0dO3E1siqeNoDQWbS0GaW0W6mnEu0kBhe+8jtdQzjkovJsFLoVtKScF8HaVImCNBk35kJ2I+HcYuMMyo5Ak+lTjPaCUN+UqvugsG6kU7NoQm3CDgQ==;
 7:hguK6rzUz0lvkIb5s/HQaxlXiQtY7APadLmHXItSzaKs9Ur2KOzFfhMphjr7RSDbCSBaoFgbQ5Hqhd6TTbcGLxSRwWMIQNx5p2JE/L2JBOGic6tcnvc2DyXyc06ozfBItNZaa7tldfbhUsptxO0UZQ==
x-ms-office365-filtering-correlation-id: 77f4af54-31af-4992-2107-08d68d3f537a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR0601MB3737; 
x-ms-traffictypediagnostic: MWHPR0601MB3737:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <MWHPR0601MB37374904AD31565B8462F36ED3680@MWHPR0601MB3737.namprd06.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(136003)(39850400004)(396003)(366004)(376002)(189003)(199004)(110136005)(229853002)(6506007)(25786009)(54906003)(486006)(2906002)(68736007)(4326008)(6512007)(11346002)(316002)(6306002)(476003)(103116003)(2616005)(446003)(76176011)(186003)(6486002)(99286004)(102836004)(26005)(86362001)(53936002)(2201001)(2501003)(6436002)(6246003)(71190400001)(6116002)(106356001)(3846002)(478600001)(36756003)(7416002)(71200400001)(14454004)(305945005)(97736004)(105586002)(7736002)(45080400002)(8936002)(81166006)(81156014)(66066001)(8676002)(966005)(256004)(14444005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR0601MB3737;
 H:MWHPR0601MB3708.namprd06.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qY/FJCbId4vNMdtQzBhutLlM7bdXSnryvT5kCVZfeCyJQLFaMhQJU+bteJa4OHrjYdpZbtttxwEbjL/6+NizM1MXP+jERZ5Gje7x0oHFpyuJbSX/sX6ndV2rC1mxuMzr+yWcEY5WXbJ8V48jjv/L2RnW8KV9dqUiqh5Iw3GxxuSbZZB973mIcjQ766AhF2eyJcXHf8feuJEZ0v2ArJQwUbXPXFEovKIHWbgmvFOA0k4Q6VlNh1jpQ9NRK7r+QXDaTT5xp4i92kOVLfs+UHDTsBqG+QlPnCGQbX7bxVQVhZbX89QuWWXnBaiZCbwO9bS7tI1q0OICRx44yRYadf57rmD2ZLodChpfu7SlBkR/lTeXzg4muTU1Set9KHeVDoG+na/UuO2zUMAbyfrG/icO4VA0f8mgs6GE/FHDJXjW7q4=
Content-ID: <78B3DAFA5E28EF4EAFD719015854BE6B@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f4af54-31af-4992-2107-08d68d3f537a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 21:00:44.0651 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3737
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_130049_077044_2B15B8CE 
X-CRM114-Status: GOOD (  20.89  )
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linux-imx@nxp.com" <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 2019-01-07 at 14:22 +0100, Stefan Agner wrote:
> Allow to use DMA for SPI by adding the appropriate DMA properites
> to the ecspi nodes.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm/boot/dts/imx7s.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
> index a052198f6e96..b9330176c3af 100644
> --- a/arch/arm/boot/dts/imx7s.dtsi
> +++ b/arch/arm/boot/dts/imx7s.dtsi
> @@ -653,6 +653,8 @@
>  				clocks = <&clks IMX7D_ECSPI4_ROOT_CLK>,
>  					<&clks IMX7D_ECSPI4_ROOT_CLK>;
>  				clock-names = "ipg", "per";
> +				dmas = <&sdma 6 7 1>, <&sdma 7 7 2>;
> +				dma-names = "rx", "tx";
>  				status = "disabled";
>  			};

After updating my kernel to linux-next on my IMX7d based device, I
found that an FPGA, which is programmed via the ECSPI interface, was no
longer accepting its image.

I tracked the problem to this change.  If I turn off DMA, it works.

There's an interesting thing that happens when DMA is used.  The SPI
clock changes.  Instead of cycling continuously for the entire
transfer, it instead clocks out 8 bits, then pauses for 4 bit times,
then the next byte, etc.  So it's a net of about 50% slower.  The pause
between bytes scales with spi frequency to always be about 4 bits.

Here's a trace with DMA: https://imagebin.ca/v/4WEkEnvsVSkq

Here's what it looks like without DMA:
https://imagebin.ca/v/4WEkVfEqpQ12

It seems like there are other problems with DMA too.  Here's an error
I'll random get every so often.

[  142.082325] spi_master spi1: I/O Error in DMA RX
[  142.085678] spidev spi1.0: SPI transfer failed: -110
[  142.089389] spi_master spi1: failed to transfer one message from queue

Not sure if the timeout is overly aggressive or if there is some other failure.

Then sometimes there errors are worse:

Internal error: Oops - undefined instruction: 0 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 0 PID: 1006 Comm: fpga-loader Not tainted 5.0.0-rc4-next-20190201 #1
Hardware name: Freescale i.MX7 Dual (Device Tree)
PC is at sg_last+0x4c/0x68
LR is at   (null)
pc : [<80494800>]    lr : [<00000000>]    psr: 60010013
sp : bf0add5c  ip : bea94598  fp : bf371218
r10: bf0949f0  r9 : 00000000  r8 : bf094800
r7 : bdc39300  r6 : bf371000  r5 : bdc39300  r4 : bf094b68
r3 : 00000000  r2 : 00000001  r1 : 00000001  r0 : bea94580
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 30c5387d  Table: bea94000  DAC: fffffffd
Process fpga-loader (pid: 1006, stack limit = 0x61bc8b73)
Stack: (0xbf0add5c to 0xbf0ae000)
dd40:                                                                8056cdb0
dd60: 8056c9ac 00001000 00000000 bdc39300 bf094800 bf094b68 bf371000 00000000
dd80: bf0949f0 8056bc00 bf094800 bdc39300 bf0adeac bf094800 bf094ad0 80569edc
...
dfc0: 00217301 00150000 00001000 00000036 00df2010 00000003 00001000 00df1008
dfe0: 00022f70 7e9ebb14 000113b8 76f2a7f8 20010030 00000003 00000000 00000000
[<80494800>] (sg_last) from [<8056cdb0>] (spi_imx_transfer+0xd8/0x448)
[<8056cdb0>] (spi_imx_transfer) from [<8056bc00>] (spi_bitbang_transfer_one+0x50/0xa0)
[<8056bc00>] (spi_bitbang_transfer_one) from [<80569edc>] (spi_transfer_one_message+0x18c/0x3e0)
[<80569edc>] (spi_transfer_one_message) from [<8056a498>] (__spi_pump_messages+0x368/0x518)
[<8056a498>] (__spi_pump_messages) from [<8056a7ec>] (__spi_sync+0x198/0x1a0)
[<8056a7ec>] (__spi_sync) from [<8056a818>] (spi_sync+0x24/0x3c)
[<8056a818>] (spi_sync) from [<8056ae14>] (spidev_sync+0x38/0x4c)
[<8056ae14>] (spidev_sync) from [<8056b6f4>] (spidev_ioctl+0x660/0x704)
[<8056b6f4>] (spidev_ioctl) from [<80335f9c>] (do_vfs_ioctl+0xac/0x79c)
[<80335f9c>] (do_vfs_ioctl) from [<803366c0>] (ksys_ioctl+0x34/0x58)
[<803366c0>] (ksys_ioctl) from [<80201120>] (ret_fast_syscall+0x0/0x4c)
Exception stack(0xbf0adfa8 to 0xbf0adff0)
dfa0:                   00217301 00150000 00000003 40206b00 7e9ebb80 03938700
dfc0: 00217301 00150000 00001000 00000036 00df2010 00000003 00001000 00df1008
dfe0: 00022f70 7e9ebb14 000113b8 76f2a7f8
Code: e1510002 1afffff3 e3530000 149df004 (e7f001f2)
---[ end trace 1588229fc7541669 ]---

I think DMA on imx not be ready for prime time yet.
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
