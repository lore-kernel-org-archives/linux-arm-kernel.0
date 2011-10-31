From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 31 Oct 2011 13:18:13 -0700
Subject: [PATCH 2/3] staging: nvec: add device tree support
In-Reply-To: <04ffd9770698b7efb119b92fa379eb2e2698e223.1320088857.git.marvin24@gmx.de>
References: <cover.1320088857.git.marvin24@gmx.de>
	<04ffd9770698b7efb119b92fa379eb2e2698e223.1320088857.git.marvin24@gmx.de>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173EDAB877@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Dietrich wrote at Monday, October 31, 2011 1:59 PM:
> This adds device tree support to the nvec driver. By using this method
> it is no longer necessary to specify platform data through a board
> file.
...
> diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
...
> +	if (pdata) {
> +		nvec->gpio = pdata->gpio;
> +		nvec->i2c_addr = pdata->i2c_addr;
> +	} else if (nvec->dev->of_node) {
> +		nvec->gpio = of_get_named_gpio(nvec->dev->of_node, "request-gpios", 0);
> +		if (nvec->gpio < 0) {
> +			dev_err(&pdev->dev, "no gpio specified");
> +			goto failed;
> +		}

> +		prop = of_get_property(nvec->dev->of_node, "slave-addr", NULL);
> +		if (!prop) {
> +			dev_err(&pdev->dev, "no i2c address specified");
> +			goto failed;
> +		}
> +		nvec->i2c_addr = be32_to_cpup(prop);

----------==========----------==========----------==========----------==========
Don't you want to use of_property_read_u32() here to simplify the code
slightly? You can also get rid of at least one #include that way.

> +	} else {
> +		dev_err(&pdev->dev, "no platform data\n");
> +		goto failed;
> +	}

-- 
nvpublic
