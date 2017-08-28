From: philipp.tomsich@theobroma-systems.com (Philipp Tomsich)
Date: Mon, 28 Aug 2017 17:12:02 +0200 (CEST)
Subject: [3/4] nvmem: rockchip: add support for RK3368
In-Reply-To: <20170828121604.15968-4-romain.perier@collabora.com>
References: <20170828121604.15968-4-romain.perier@collabora.com>
Message-ID: <alpine.OSX.2.21.1708281701280.2068@vpn-10-11-0-14.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Mon, 28 Aug 2017, Romain Perier wrote:

> This adds the necessary functions and data for handling support on RK3368
> SoCs.
>
> Signed-off-by: Romain Perier <romain.perier@collabora.com>
> ---
> .../devicetree/bindings/nvmem/rockchip-efuse.txt   |  1 +
> drivers/nvmem/rockchip-efuse.c                     | 80 ++++++++++++++++++++++
> 2 files changed, 81 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt b/Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt
> index 1ff02afdc55a..60bec4782806 100644
> --- a/Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt
> +++ b/Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt
> @@ -6,6 +6,7 @@ Required properties:
>   - "rockchip,rk3188-efuse" - for RK3188 SoCs.
>   - "rockchip,rk3228-efuse" - for RK3228 SoCs.
>   - "rockchip,rk3288-efuse" - for RK3288 SoCs.
> +  - "rockchip,rk3368-efuse" - for RK3368 SoCs.
>   - "rockchip,rk3399-efuse" - for RK3399 SoCs.
> - reg: Should contain the registers location and exact eFuse size
> - clocks: Should be the clock id of eFuse
> diff --git a/drivers/nvmem/rockchip-efuse.c b/drivers/nvmem/rockchip-efuse.c
> index 63e3eb55f3ac..4e11f251035f 100644
> --- a/drivers/nvmem/rockchip-efuse.c
> +++ b/drivers/nvmem/rockchip-efuse.c
> @@ -14,6 +14,7 @@
>  * more details.
>  */
>
> +#include <linux/arm-smccc.h>
> #include <linux/clk.h>
> #include <linux/delay.h>
> #include <linux/device.h>
> @@ -46,9 +47,17 @@
> #define REG_EFUSE_CTRL		0x0000
> #define REG_EFUSE_DOUT		0x0004
>
> +/* SMC function IDs for SiP Service queries */
> +#define ROCKCHIP_SIP_ACCESS_REG	0x82000002
> +
> +/* SIP access registers: read or write */
> +#define ROCKCHIP_SIP_SECURE_REG_RD	0x0
> +#define ROCKCHIP_SIP_SECURE_REG_WR	0x1
> +
> struct rockchip_efuse_chip {
> 	struct device *dev;
> 	void __iomem *base;
> +	phys_addr_t phys;
> 	struct clk *clk;
> };
>
> @@ -92,6 +101,72 @@ static int rockchip_rk3288_efuse_read(void *context, unsigned int offset,
> 	return 0;
> }
>
> +static u32 smc_reg_read(u32 addr_phy)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(ROCKCHIP_SIP_ACCESS_REG, 0, addr_phy,
> +		      ROCKCHIP_SIP_SECURE_REG_RD, 0, 0, 0, 0, &res);
> +	if (res.a0)
> +		pr_err("%s error: %d, addr phy: 0x%x\n", __func__, (int)res.a0,
> +		       addr_phy);
> +	return res.a1;
> +}
> +
> +static u32 smc_reg_write(u32 addr_phy, u32 val)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(ROCKCHIP_SIP_ACCESS_REG, val, addr_phy,
> +		      ROCKCHIP_SIP_SECURE_REG_WR, 0, 0, 0, 0, &res);
> +	if (res.a0)
> +		pr_err("%s error: %d, addr phy: 0x%x\n", __func__, (int)res.a0,
> +                       addr_phy);
> +	return res.a0;
> +}

I am not too happy with the SIP_SECURE_REG_RD/WR interfaces, as this opens 
an unauthenticated path from the non-secure world into the secure world.

> +
> +static int rockchip_rk3368_efuse_read(void *context, unsigned int offset,
> +				      void *val, size_t bytes)
> +{
> +	struct rockchip_efuse_chip *efuse = context;
> +	u8 *buf = val;
> +	int ret;
> +
> +	ret = clk_prepare_enable(efuse->clk);
> +	if (ret < 0) {
> +		dev_err(efuse->dev, "failed to prepare/enable efuse clk\n");
> +		return ret;
> +	}
> +
> +	smc_reg_write(efuse->phys + REG_EFUSE_CTRL, RK3288_LOAD | RK3288_PGENB);
> +	udelay(1);
> +	while (bytes--) {
> +		smc_reg_write(efuse->phys + REG_EFUSE_CTRL,
> +			      smc_reg_read(efuse->phys + REG_EFUSE_CTRL) &
> +			      (~(RK3288_A_MASK << RK3288_A_SHIFT)));
> +		smc_reg_write(efuse->phys + REG_EFUSE_CTRL,
> +			      smc_reg_read(efuse->phys + REG_EFUSE_CTRL) |
> +			      ((offset++ & RK3288_A_MASK) << RK3288_A_SHIFT));
> +
> +		udelay(1);
> +		smc_reg_write(efuse->phys + REG_EFUSE_CTRL,
> +			      smc_reg_read(efuse->phys + REG_EFUSE_CTRL) |
> +			      RK3288_STROBE);
> +		udelay(1);
> +		*buf++ = smc_reg_read(efuse->phys + REG_EFUSE_DOUT);
> +		smc_reg_write(efuse->phys + REG_EFUSE_CTRL,
> +			      smc_reg_read(efuse->phys + REG_EFUSE_CTRL) &
> +			      (~RK3288_STROBE));
> +		udelay(1);
> +	}
> +
> +	/* Switch to standby mode */
> +	smc_reg_write(efuse->phys + REG_EFUSE_CTRL, RK3288_PGENB | RK3288_CSB);
> +
> +	clk_disable_unprepare(efuse->clk);
> +	return 0;
> +}
> +
> static int rockchip_rk3399_efuse_read(void *context, unsigned int offset,
> 				      void *val, size_t bytes)
> {
> @@ -178,6 +253,10 @@ static const struct of_device_id rockchip_efuse_match[] = {
> 		.data = (void *)&rockchip_rk3288_efuse_read,
> 	},
> 	{
> +		.compatible = "rockchip,rk3368-efuse",
> +		.data = (void *)&rockchip_rk3368_efuse_read,
> +	},
> +	{
> 		.compatible = "rockchip,rk3399-efuse",
> 		.data = (void *)&rockchip_rk3399_efuse_read,
> 	},

Both the 3368 and 3399 have two eFuse blocks: one is the 'secure' eFuse
whereas the other is the 'non-secure' eFuse... for the 'secure' eFuse, 
there is no other way to access the fuses than in EL3. However, the 
non-secure eFuse access is configurable via SGRF.

In other words: SMC calls would be necessary for accesses to the secure
eFuse block only.

Note that the DTS released in Rockchip's github account has nvmem point
to 0xffb00000, which is efuse_256 (which is the 'non-secure' block).  I 
have successfully read this on the RK3368 from the U-Boot commandline 
using 'mw.l' and 'md.l' to the control registers, so the SMC call should 
not be necessary.

The same is also true for the RK3399, where we read the non-secure fuse 
block in U-Boot. So the SMC interface shouldn't be needed there.

> @@ -205,6 +284,7 @@ static int rockchip_efuse_probe(struct platform_device *pdev)
> 		return -ENOMEM;
>
> 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	efuse->phys = res->start;
> 	efuse->base = devm_ioremap_resource(&pdev->dev, res);
> 	if (IS_ERR(efuse->base))
> 		return PTR_ERR(efuse->base);
>
