From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 15 Feb 2017 15:52:47 +0100
Subject: [PATCH v2 4/6] ARM: mvebu: Add mv98dx3236-soc-id
In-Reply-To: <20170207202815.20226-5-chris.packham@alliedtelesis.co.nz> (Chris
 Packham's message of "Wed, 8 Feb 2017 09:28:13 +1300")
References: <20170207202815.20226-1-chris.packham@alliedtelesis.co.nz>
 <20170207202815.20226-5-chris.packham@alliedtelesis.co.nz>
Message-ID: <87vasbcxq8.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,
 
 On mar., f?vr. 07 2017, Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:

> The DFX server on the 98dx3236 and compatible SoCs has an ID register
> that provides revision information that the PCI based ID register
> doesn't have. Use this if it's available.
>

Could you split this patch in two part: one for device tree and one for
the C code?

Thanks,

Gregory

> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>
> Notes:
>     Changes in v2:
>     - none
>
>  .../bindings/arm/marvell/mv98dx3236-soc-id.txt     | 14 +++++++
>  arch/arm/boot/dts/armada-xp-98dx3236.dtsi          |  5 +++
>  arch/arm/mach-mvebu/mvebu-soc-id.c                 | 43 ++++++++++++++++++++--
>  3 files changed, 59 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/marvell/mv98dx3236-soc-id.txt
>
> diff --git a/Documentation/devicetree/bindings/arm/marvell/mv98dx3236-soc-id.txt b/Documentation/devicetree/bindings/arm/marvell/mv98dx3236-soc-id.txt
> new file mode 100644
> index 000000000000..ed08cb126a83
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/marvell/mv98dx3236-soc-id.txt
> @@ -0,0 +1,14 @@
> +Marvell 98dx3236 SoC ID
> +---------------------------------------------------------------
> +
> +Required properties:
> +
> +- compatible: Should be "marvell,mv98dx3236-soc-id".
> +
> +- reg: should be the register base and length as documented in the
> +  datasheet for the Device ID Status
> +
> +soc-id at f8244 {
> +	compatible = "marvell,mv98dx3236-soc-id";
> +	reg = <0xf8244 0x4>;
> +};
> diff --git a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
> index cbf5cd0c6429..e4baa97836e7 100644
> --- a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
> +++ b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
> @@ -264,6 +264,11 @@
>  			ranges = <0 MBUS_ID(0x08, 0x00) 0 0x100000>;
>  			reg = <MBUS_ID(0x08, 0x00) 0 0x100000>;
>  
> +			soc-id at f8244 {
> +				compatible = "marvell,mv98dx3236-soc-id";
> +				reg = <0xf8244 0x4>;
> +			};
> +
>  			dfx_coredivclk: corediv-clock at f8268 {
>  				compatible = "marvell,mv98dx3236-corediv-clock";
>  				reg = <0xf8268 0xc>;
> diff --git a/arch/arm/mach-mvebu/mvebu-soc-id.c b/arch/arm/mach-mvebu/mvebu-soc-id.c
> index a99434bcee84..b4c94a57f358 100644
> --- a/arch/arm/mach-mvebu/mvebu-soc-id.c
> +++ b/arch/arm/mach-mvebu/mvebu-soc-id.c
> @@ -34,6 +34,9 @@
>  #define SOC_ID_MASK	    0xFFFF0000
>  #define SOC_REV_MASK	    0xFF
>  
> +#define MV98DX3236_DEV_ID_MASK	0xFF00
> +#define MV98DX3236_REV_MASK	0xF
> +
>  static u32 soc_dev_id;
>  static u32 soc_rev;
>  static bool is_id_valid;
> @@ -45,6 +48,11 @@ static const struct of_device_id mvebu_pcie_of_match_table[] = {
>  	{},
>  };
>  
> +static const struct of_device_id mvebu_mv98dx3236_of_match_table[] = {
> +	{ .compatible = "marvell,mv98dx3236-soc-id", },
> +	{},
> +};
> +
>  int mvebu_get_soc_id(u32 *dev, u32 *rev)
>  {
>  	if (is_id_valid) {
> @@ -131,15 +139,44 @@ static int __init get_soc_id_by_pci(void)
>  	return ret;
>  }
>  
> +static int __init mvebu_dfx_get_soc_id(u32 *dev, u32 *rev)
> +{
> +	struct device_node *np;
> +	void __iomem *base;
> +
> +	np = of_find_matching_node(NULL, mvebu_mv98dx3236_of_match_table);
> +	if (!np)
> +		return -ENODEV;
> +
> +	base = of_iomap(np, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	/* SoC ID */
> +	*dev = (readl(base) >> 12) & MV98DX3236_DEV_ID_MASK;
> +	/* SoC revision */
> +	*rev = (readl(base) >> 28) & MV98DX3236_REV_MASK;
> +
> +	iounmap(base);
> +	of_node_put(np);
> +
> +	return 0;
> +}
> +
>  static int __init mvebu_soc_id_init(void)
>  {
>  
>  	/*
> -	 * First try to get the ID and the revision by the system
> -	 * register and use PCI registers only if it is not possible
> +	 * First try to get the ID and the revision by from system controller
> +	 * register, then try the DFX register (if applicable), finally read it
> +	 * from PCI registers.
>  	 */
> -	if (!mvebu_system_controller_get_soc_id(&soc_dev_id, &soc_rev)) {
> +	if (!mvebu_system_controller_get_soc_id(&soc_dev_id, &soc_rev))
> +		is_id_valid = true;
> +	else if (!mvebu_dfx_get_soc_id(&soc_dev_id, &soc_rev))
>  		is_id_valid = true;
> +
> +	if (is_id_valid) {
>  		pr_info("MVEBU SoC ID=0x%X, Rev=0x%X\n", soc_dev_id, soc_rev);
>  		return 0;
>  	}
> -- 
> 2.11.0.24.ge6920cf
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
