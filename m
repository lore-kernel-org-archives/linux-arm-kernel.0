Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695F1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:11:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A93321479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pMswdgYq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SAIyMTaa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A93321479
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=v7+Iy1upeWOlspv32Wu05nSvVFGw8v8mexEcMAABQlo=; b=pMswdgYqQPhqeTGAPVvsIZ9/3
	BQibKHz0PlF7YrQjJErS/A0lMc55ykya5fivniFyjoiyodYoTndx6haNcJYeuDRuGSWt1wTKqDoXA
	w6c2jP3tK44FDNcuPbWKYfkJxdjg7Udx66yvfrr/UZ8VZGADUbmeFEeWGNGbnqFicm3R7ixrLrJ9Q
	37D3vCt+XpqOX3SC1/vAQNisCK5CCK2PGiAbn2iXNyvxjlrsWXTYAnQcmPIV49c7GNVv40MH3x4MF
	732WdR010On7OrxcBXY0LbwoKuF2KVrfQRBXxy051xCCVpMuO2hqRsL8ExgbF20b+YewmDB5m0Uow
	PtwAIOGmQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gve16-0001qx-LC; Mon, 18 Feb 2019 08:11:08 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gve13-0001qR-Ny
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 08:11:07 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1I8B1Ot103483;
 Mon, 18 Feb 2019 02:11:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550477461;
 bh=qUMjMe8FDM2VxhIXQ63aCt7E8FgrgcLZfyzgIAAiVmE=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=SAIyMTaaph8KO65NRxp5mS95o/8mem/doJzVxhN5htDbKZs4LyG+2R7rzxGvwXw/a
 QNCem3UPH0IzWrrkux6jv3VaZ1hy6Te1V4qe3g1KVCXSMQZxR8NFMsY3SRLgWqzYZh
 NKNJhnHqyrxN7xlbfQ3hL5nwft093RrnDEvwZNIY=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1I8B1lA019943
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 18 Feb 2019 02:11:01 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 18
 Feb 2019 02:10:59 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 18 Feb 2019 02:10:59 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1I8AsEM007674;
 Mon, 18 Feb 2019 02:10:55 -0600
Subject: Re: [PATCH 2/4] soc: ti: ti_sci_pm_domains: Add support for exclusive
 access
To: Lokesh Vutla <lokeshvutla@ti.com>, Nishanth Menon <nm@ti.com>, Santosh
 Shilimkar <ssantosh@kernel.org>, Rob Herring <robh+dt@kernel.org>
References: <20190218051517.9218-1-lokeshvutla@ti.com>
 <20190218051517.9218-3-lokeshvutla@ti.com>
From: Tero Kristo <t-kristo@ti.com>
Message-ID: <74ef7305-0575-f24a-0806-49d85b7b70ff@ti.com>
Date: Mon, 18 Feb 2019 10:10:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190218051517.9218-3-lokeshvutla@ti.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_001105_924873_42F0F9D7 
X-CRM114-Status: GOOD (  28.58  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 18/02/2019 07:15, Lokesh Vutla wrote:
> TISCI protocol supports for enabling the device with exclusive
> permissions. Certain remoteproc devices or some shared devices
> across VM doesn't wants to request devices with this flag set.
> So add support for getting this information from DT. With this
> power-domain-cells are increased to 2.
> 
> For keeping the DT backward compatibility intact, defaulting the
> device permissions to set the exclusive flag set. In this case the
> power-domain-cells is 1.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>   .../bindings/soc/ti/sci-pm-domain.txt         |  7 ++++--
>   drivers/soc/ti/ti_sci_pm_domains.c            | 22 +++++++++++++++++--

Please split the dt-binding change into a separate patch.

-Tero

>   2 files changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt b/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
> index f7b00a7c0f68..5fdda7475023 100644
> --- a/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
> +++ b/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
> @@ -19,8 +19,11 @@ child of the pmmc node.
>   Required Properties:
>   --------------------
>   - compatible: should be "ti,sci-pm-domain"
> -- #power-domain-cells: Must be 1 so that an id can be provided in each
> -		       device node.
> +- #power-domain-cells: Can be one of the following:
> +			1: Containing the device id of each node
> +			2: First entry should be device id
> +			   Second entry should be 1 or 0. Use 1 for enabling
> +			   the device with exclusive permissions set else 0.
>   
>   Example (K2G):
>   -------------
> diff --git a/drivers/soc/ti/ti_sci_pm_domains.c b/drivers/soc/ti/ti_sci_pm_domains.c
> index de31b9389e2e..4dae42651212 100644
> --- a/drivers/soc/ti/ti_sci_pm_domains.c
> +++ b/drivers/soc/ti/ti_sci_pm_domains.c
> @@ -24,6 +24,8 @@
>   #include <linux/slab.h>
>   #include <linux/soc/ti/ti_sci_protocol.h>
>   
> +#define PD_REQUEST_EXCLUSIVE BIT(0)
> +
>   /**
>    * struct ti_sci_genpd_dev_data: holds data needed for every device attached
>    *				 to this genpd
> @@ -32,6 +34,7 @@
>    */
>   struct ti_sci_genpd_dev_data {
>   	int idx;
> +	u8 exclusive;
>   };
>   
>   /**
> @@ -63,6 +66,14 @@ static int ti_sci_dev_id(struct device *dev)
>   	return sci_dev_data->idx;
>   }
>   
> +static u8 is_ti_sci_dev_exclusive(struct device *dev)
> +{
> +	struct generic_pm_domain_data *genpd_data = dev_gpd_data(dev);
> +	struct ti_sci_genpd_dev_data *sci_dev_data = genpd_data->data;
> +
> +	return sci_dev_data->exclusive & PD_REQUEST_EXCLUSIVE;
> +}
> +
>   /**
>    * ti_sci_dev_to_sci_handle(): get pointer to ti_sci_handle
>    * @dev: pointer to device associated with this genpd
> @@ -87,7 +98,10 @@ static int ti_sci_dev_start(struct device *dev)
>   	const struct ti_sci_handle *ti_sci = ti_sci_dev_to_sci_handle(dev);
>   	int idx = ti_sci_dev_id(dev);
>   
> -	return ti_sci->ops.dev_ops.get_device(ti_sci, idx);
> +	if (is_ti_sci_dev_exclusive(dev))
> +		return ti_sci->ops.dev_ops.get_device_exclusive(ti_sci, idx);
> +	else
> +		return ti_sci->ops.dev_ops.get_device(ti_sci, idx);
>   }
>   
>   /**
> @@ -118,7 +132,7 @@ static int ti_sci_pd_attach_dev(struct generic_pm_domain *domain,
>   	if (ret < 0)
>   		return ret;
>   
> -	if (pd_args.args_count != 1)
> +	if (pd_args.args_count != 1 && pd_args.args_count != 2)
>   		return -EINVAL;
>   
>   	idx = pd_args.args[0];
> @@ -136,6 +150,10 @@ static int ti_sci_pd_attach_dev(struct generic_pm_domain *domain,
>   		return -ENOMEM;
>   
>   	sci_dev_data->idx = idx;
> +	/* Enable the exclusive permissions by default */
> +	sci_dev_data->exclusive = PD_REQUEST_EXCLUSIVE;
> +	if (pd_args.args_count == 2)
> +		sci_dev_data->exclusive = pd_args.args[1];
>   
>   	genpd_data = dev_gpd_data(dev);
>   	genpd_data->data = sci_dev_data;
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
