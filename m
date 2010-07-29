From: kevin.wells@nxp.com (Kevin Wells)
Date: Fri, 30 Jul 2010 01:22:58 +0200
Subject: [PATCH v4] GPIO PL061: Adding Clk framework support
In-Reply-To: <20100715095637.GF26212@n2100.arm.linux.org.uk>
References: <20100709124050.GF22845@n2100.arm.linux.org.uk>
	<AANLkTikm-wupuQA1_zsmqf3jrpavkMaw8Bt-GWb04TSo@mail.gmail.com>
	<20100710071913.GM22845@n2100.arm.linux.org.uk>
	<AANLkTimskXW4Nnxhc5bxwKiNrfJkMb-9NeWKhVOGaA1k@mail.gmail.com>
	<20100713074449.GA20118@n2100.arm.linux.org.uk>
	<AANLkTilZJTHh_iFS37UL7XoUs_DhAB50A3tHfcfEr5JM@mail.gmail.com>
	<20100713182644.GC30142@n2100.arm.linux.org.uk>	<4C3EA46B.1000709@st.com>
	<20100715083032.GA26212@n2100.arm.linux.org.uk>	<4C3ED678.7010308@st.com>
	<20100715095637.GF26212@n2100.arm.linux.org.uk>
Message-ID: <083DF309106F364B939360100EC290F80AC392ACFC@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>  /*
>   * These are the device model conversion veneers; they convert the
>   * device model structures to our more specific structures.
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

Should the AMBA clock be disabled if the probe() fails?

> +	} while (0);
> +
> +	return ret;
>  }
> 
