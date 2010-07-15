From: rabin@rab.in (Rabin Vincent)
Date: Thu, 15 Jul 2010 21:39:22 +0530
Subject: [PATCH v4] GPIO PL061: Adding Clk framework support
In-Reply-To: <20100715095637.GF26212@n2100.arm.linux.org.uk>
References: <AANLkTikm-wupuQA1_zsmqf3jrpavkMaw8Bt-GWb04TSo@mail.gmail.com>
	<20100710071913.GM22845@n2100.arm.linux.org.uk>
	<AANLkTimskXW4Nnxhc5bxwKiNrfJkMb-9NeWKhVOGaA1k@mail.gmail.com>
	<20100713074449.GA20118@n2100.arm.linux.org.uk>
	<AANLkTilZJTHh_iFS37UL7XoUs_DhAB50A3tHfcfEr5JM@mail.gmail.com>
	<20100713182644.GC30142@n2100.arm.linux.org.uk>
	<4C3EA46B.1000709@st.com>
	<20100715083032.GA26212@n2100.arm.linux.org.uk>
	<4C3ED678.7010308@st.com>
	<20100715095637.GF26212@n2100.arm.linux.org.uk>
Message-ID: <20100715160922.GA4119@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 15, 2010 at 10:56:37AM +0100, Russell King - ARM Linux wrote:
> +static int amba_get_enable_pclk(struct amba_device *pcdev)
> +{
> +	struct clk *pclk = clk_get(&pcdev->dev, "apb_pclk");
> +	int ret;
> +
> +	pcdev->pclk = pclk;
> +
> +	if (IS_ERR(pclk))
> +		return PTR_ERR(pclk);
> +
> +	ret = clk_enable(pclk);
> +	if (ret)
> +		clk_put(pclk);
> +
> +	return ret;
> +}
> +
...
> @@ -130,17 +155,33 @@ static int amba_probe(struct device *dev)
>  {
>  	struct amba_device *pcdev = to_amba_device(dev);
>  	struct amba_driver *pcdrv = to_amba_driver(dev->driver);
> -	struct amba_id *id;
> +	struct amba_id *id = amba_lookup(pcdrv->id_table, pcdev);
> +	int ret;
>  
> -	id = amba_lookup(pcdrv->id_table, pcdev);
> +	do {
> +		ret = amba_get_enable_pclk(pcdev);
> +		if (ret)
> +			break;
> +
> +		ret = pcdrv->probe(pcdev, id);
> +		if (ret == 0)
> +			break;
>  
> -	return pcdrv->probe(pcdev, id);
> +		amba_put_disable_pclk(pcdev);
> +	} while (0);
> +
> +	return ret;
>  }

In your earlier patch, you proceeded with the probe if the error from
clk_get() was -ENOENT, but not in this version.  Isn't the -ENOENT
special handling preferable, since it avoids the need to change all
existing platforms?
