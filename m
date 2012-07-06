From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 06 Jul 2012 09:52:49 -0600
Subject: [PATCH 1/2] pinctrl: pinctrl-imx: add support for set bits for
 general purpose registers
In-Reply-To: <1341565763-10074-1-git-send-email-b29396@freescale.com>
References: <1341565763-10074-1-git-send-email-b29396@freescale.com>
Message-ID: <4FF709D1.40903@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/2012 03:09 AM, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> The General Purpose Registers (GPR) is used to select operating modes for
> general features in the SoC, usually not related to the IOMUX itself,
> but it does belong to IOMUX controller.
> We simply provide an convient API for driver to call to set the general purpose
> register bits if needed.

> +static struct imx_pinctrl *imx_pinctrl;
> +/*
> + * Set bits for general purpose registers
> + */
> +void imx_pinctrl_set_gpr_register(u8 gpr, u8 start_bit, u8 num_bits, u32 value)
> +{
> +	u32 reg;
> +
> +	/* general purpose register is 32 bits size */
> +	WARN_ON(!imx_pinctrl || start_bit > 31 || num_bits > 32);

Hmmm. It's going to be very hard to control the probe() order to ensure
that this WARN doesn't fire all the time.

I think it would be better to pass in a struct imx_pinctrl* or DT node
to this function. The DT node for the device that's using this function
should contain a phandle to the pinctrl device node, which it uses to
get that handle. Or in a non-DT case, the client driver needs to be
given the provider driver handle using some other mechanism.

For example, look at how the Tegra30 SMMU uses services from the Tegra30
AHB; see arch/arm/boot/dts/tegra30.dtsi node "smmu" (client) and node
"ahb" (provider), drivers/iommu/tegra-smmu.c functions probe() (saves
smmu->ahb) and smmu_setup_regs() (calls tegra_ahb_enable_smmu() with
this handle) and drivers/amba/tegra-ahb.c function
tegra_ahb_enable_smmu() (implements the deferred probe checking to
correctly order the client/provider driver probing)
