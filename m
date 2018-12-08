Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0E2C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 05:25:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BC93208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 05:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sRkZ4GkH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="p/FXwQRT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC93208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GdXf2+mNUfcDYhHv1t8k9GByMtE1exTn2d3m1w2Spp8=; b=sRkZ4GkH+ZnQeh
	gKRM6VhsuTl4SMOkjQeL4l6x3AZtjUZayNVXlWR99eEz1LNYduiNx/n6NJhea7W+G1f/pc+gogElp
	bMrZbCn602BRnH6gqGot0oiLH34HbkRI0o1egjVIZcH8g5MMnqzFxfuEv9HAPYsKQ07egIxNj/18F
	zB2Hes2t75yeIRzHtsTjnVpYru7UXmeJey+p/sfcjQ4X0nz33WTUqRFInKTat2GU8ebS35lY74HVF
	+GHvHEFUyGRFUXYsazujMqfHjw0q1xMI/qjx3oivXZV47SCV44CKPUsk0+aXuEarLCB6r2pzbaQ6s
	8YEAnG1b+ahsDXC/wVYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVV7f-0006h7-7g; Sat, 08 Dec 2018 05:25:51 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVV7b-0006gd-8M
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 05:25:48 +0000
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB85PNNo100657;
 Fri, 7 Dec 2018 23:25:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1544246723;
 bh=2Y86cF7svuzm9nRFpjhgu0SCYEF98sfaU/8WiRNFIbY=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=p/FXwQRT3TFu04M8WRK7QbFy0NcYyfvv9yRUfZRi9gjBX9uzuqEfEQQvCIpvMEqGR
 vW+qnTIflTJw2ZPnbORhDxKQZb7/0OkilaR6Axehw+AAfPg+G0OXYsHe6pcO3IhWgX
 H7UQSCA5eg5Mmq0vuobGBagqlPN0ncq5E8uRaHQ8=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB85PN1O001015
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 7 Dec 2018 23:25:23 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 7
 Dec 2018 23:25:22 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 7 Dec 2018 23:25:22 -0600
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB85PJe1003543;
 Fri, 7 Dec 2018 23:25:19 -0600
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am654: Add Support for MMC/SD
To: Faiz Abbas <faiz_abbas@ti.com>, <linux-arm-kernel@lists.infradead.org>,
 <nm@ti.com>, <t-kristo@ti.com>
References: <20181207084233.13700-1-faiz_abbas@ti.com>
 <20181207084233.13700-2-faiz_abbas@ti.com>
From: Vignesh R <vigneshr@ti.com>
Message-ID: <a6aacd53-e1c4-fce0-7712-f276c80bbffc@ti.com>
Date: Sat, 8 Dec 2018 10:56:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181207084233.13700-2-faiz_abbas@ti.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_212547_399989_02AA3690 
X-CRM114-Status: GOOD (  18.88  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, ulf.hansson@linaro.org,
 linux-kernel@vger.kernel.org, kishon@ti.com, robh+dt@kernel.org,
 adrian.hunter@intel.com, michal.simek@xilinx.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 07/12/18 2:12 PM, Faiz Abbas wrote:
> There are two MMC host controller instances present on the TI's
> Am654 SOCs. Add device tree nodes for the same.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 28 ++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index 916434839603..d07212f16a81 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -129,4 +129,32 @@
>  		clocks = <&k3_clks 113 1>;
>  		power-domains = <&k3_pds 113>;
>  	};
> +
> +	sdhci0: sdhci@4f80000 {
> +		compatible = "ti,am654-sdhci-5.1";
> +		reg = <0x0 0x4f80000 0x0 0x260>, <0x0 0x4f90000 0x0 0x134>;
> +		power-domains = <&k3_pds 47>;
> +		clocks = <&k3_clks 47 0>, <&k3_clks 47 1>;
> +		clock-names = "clk_ahb", "clk_xin";
> +		interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
> +		sdhci-caps-mask = <0x80000007 0x0>;
> +		mmc-ddr-1_8v;
> +		ti,otap-del-sel = <0x2>;
> +		ti,trm-icp = <0x8>;
> +		status = "disabled";
> +	};

Please drop "status=disabled" from dtsi. Can be disabled as required in
the board dts.

> +
> +	sdhci1: sdhci@4fa0000 {
> +		compatible = "ti,am654-sdhci-5.1";
> +		reg = <0x0 0x4fa0000 0x0 0x260>, <0x0 0x4fb0000 0x0 0x134>;
> +		power-domains = <&k3_pds 48>;
> +		clocks = <&k3_clks 48 0>, <&k3_clks 48 1>;
> +		clock-names = "clk_ahb", "clk_xin";
> +		interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
> +		sdhci-caps-mask = <0x80000007 0x0>;
> +		mmc-ddr-1_8v;
> +		ti,otap-del-sel = <0x2>;
> +		ti,trm-icp = <0x8>;
> +		status = "disabled";
> +	};
>  };
> 

-- 
Regards
Vignesh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
