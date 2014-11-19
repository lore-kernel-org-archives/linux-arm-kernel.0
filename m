From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 19 Nov 2014 10:42:55 +0000
Subject: [PATCH 2/7] phy: miphy365x: Pass sysconfig register offsets via
 syscfg dt property.
In-Reply-To: <1416385632-5832-3-git-send-email-peter.griffin@linaro.org>
References: <1416385632-5832-1-git-send-email-peter.griffin@linaro.org>
 <1416385632-5832-3-git-send-email-peter.griffin@linaro.org>
Message-ID: <20141119104255.GI13959@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Nov 2014, Peter Griffin wrote:

> Based on Arnds review comments here https://lkml.org/lkml/2014/11/13/161, update
> the miphy365 phy driver to access sysconfig register offsets via syscfg dt property.
> 
> This is because the reg property should not be mixing address spaces like it does
> currently for miphy365. This change then also aligns us to how other platforms such
> as keystone and bcm7445 pass there syscon offsets via DT.
> 
> This patch breaks DT compatibility, but this platform is considered WIP, and is only
> used by a few developers who are upstreaming support for it. This change has been done
> as a single atomic commit to ensure it is bisectable.

You should wrap your lines sooner (70-75 chars).

> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  .../devicetree/bindings/phy/phy-miphy365x.txt      | 15 +++++------
>  arch/arm/boot/dts/stih416.dtsi                     | 10 ++++----
>  drivers/phy/phy-miphy365x.c                        | 29 ++++++++--------------
>  3 files changed, 23 insertions(+), 31 deletions(-)

[...]

> diff --git a/drivers/phy/phy-miphy365x.c b/drivers/phy/phy-miphy365x.c
> index 801afaf..7308afe 100644
> --- a/drivers/phy/phy-miphy365x.c
> +++ b/drivers/phy/phy-miphy365x.c

[...]

>  		phy_set_drvdata(phy, miphy_dev->phys[port]);
> +
>  		port++;
> +		/*sysconfig offsets are not indexed from zero */

You're missing a ' ' afrer '/*'.

Probably better do say what they _are_ indexed from, rather than what
they're not.

> +		ret = of_property_read_u32_index(np, "st,syscfg", port,
> +					&miphy_phy->ctrlreg);
> +		if (ret) {
> +			dev_err(&pdev->dev, "No sysconfig offset found\n");
> +			return ret;
> +		}
>  	}
>  
>  	provider = devm_of_phy_provider_register(&pdev->dev, miphy365x_xlate);

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
