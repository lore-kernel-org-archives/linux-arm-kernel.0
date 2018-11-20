From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Tue, 20 Nov 2018 10:48:59 +0000
Subject: [PATCH 3/3] PCI: imx: Add support for i.MX8MQ
In-Reply-To: <20181117181225.10737-4-andrew.smirnov@gmail.com>
References: <20181117181225.10737-1-andrew.smirnov@gmail.com>
 <20181117181225.10737-4-andrew.smirnov@gmail.com>
Message-ID: <ce2ac1a880ce2a7a39f0e42b5059676daa748e52.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2018-11-17 at 10:12 -0800, Andrey Smirnov wrote:
> @@ -921,7 +1004,28 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> -	case IMX7D:
> +	case IMX8MQ:
> +		if (of_property_read_u32(node, "fsl,iomux-gpr1x",
> +					 &imx6_pcie->gpr1x)) {
> +			dev_err(dev, "Failed to get GPR1x address\n");
> +			return -EINVAL;
> +		}

This is for distinguishing multiple controllers on the SOC but other
registers and bits might differ. Isn't it preferable to have a property
for controller id instead of adding many registers to DT?

> +
> +		if (of_property_read_u32_array(
> +			    node, "fsl,gpr12-device-type",
> +			    imx6_pcie->device_type,
> +			    ARRAY_SIZE(imx6_pcie->device_type))) {
> +			dev_err(dev, "Failed to get device type
> mask/value\n");
> +			return -EINVAL;
> +		}

The device type can be set on multiple SOCs, why are you adding a
mandatory property only for 8m?

There should probably be a separate patch with documented DT bindings.

--
Regards,
Leonard
