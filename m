From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sun, 29 Sep 2013 17:33:15 -0300
Subject: [PATCH v2 1/3] ARM: kirkwood: Remove kirkwood_setup_wins and
 rely on the DT binding (Was Re: ..)
In-Reply-To: <20130917184146.GD21230@obsidianresearch.com>
References: <20130917184146.GD21230@obsidianresearch.com>
Message-ID: <20130929203314.GA2457@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

Sorry for the delayed review. I finally found some time off
to take a deeper look at this series.

So, despite the wrong subject this is v2 for:

"ARM: kirkwood: Remove kirkwood_setup_wins and rely on the DT binding"

Right? I took the liberty of fixing the subject.

I think a small cover-letter would have been nice, just to have
some context about the three patches. I assume the series is:

ARM: kirkwood: Remove kirkwood_setup_wins and rely on the DT binding
ARM: kirkwood: Move the crypto node under the mbus node
ARM: kirkwood: Move the nand node under the mbus node

Right?

I have just a minor comment to make. See below.

On Tue, Sep 17, 2013 at 12:41:46PM -0600, Jason Gunthorpe wrote:
> kirkwood_setup_wins is the last manual caller of mbus in kirkwood, don't
> call it for DT boards and rely on the DT having a mbus node with
> a proper ranges property to setup these windows.
> 
> Move all the mbus ranges properties for all boards into kirkwood.dtsi,
> since they are currently all the same.
> 
> This makes the DT self consistent, since the physical address of the
> NAND and CRYPTO are both referenced internally. The arbitary Linux
> constants KIRKWOOD_NAND_MEM_PHYS_BASE and KIRKWOOD_SRAM_PHYS_BASE
> no longer have to match the DT values.
> 
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> ---
>  arch/arm/boot/dts/kirkwood-db-88f6281.dts              | 1 -
>  arch/arm/boot/dts/kirkwood-db-88f6282.dts              | 1 -
>  arch/arm/boot/dts/kirkwood-iconnect.dts                | 1 -
>  arch/arm/boot/dts/kirkwood-mplcec4.dts                 | 1 -
>  arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts | 1 -
>  arch/arm/boot/dts/kirkwood-nsa310.dts                  | 1 -
>  arch/arm/boot/dts/kirkwood-ts219-6282.dts              | 1 -
>  arch/arm/boot/dts/kirkwood.dtsi                        | 5 +++++
>  arch/arm/mach-kirkwood/board-dt.c                      | 1 -
>  9 files changed, 5 insertions(+), 8 deletions(-)
> 
> v2 changes:
>  - Move the ranges into kirkwood.dtsi so all boards get it [Ezequiel]
>  - Add a comment that boards have to replace not append the ranges [Ezequiel]
> 
> diff --git a/arch/arm/boot/dts/kirkwood-db-88f6281.dts b/arch/arm/boot/dts/kirkwood-db-88f6281.dts
> index 72c4b0a..c39dd76 100644
> --- a/arch/arm/boot/dts/kirkwood-db-88f6281.dts
> +++ b/arch/arm/boot/dts/kirkwood-db-88f6281.dts
> @@ -19,7 +19,6 @@
>  	compatible = "marvell,db-88f6281-bp", "marvell,kirkwood-88f6281", "marvell,kirkwood";
>  
>  	mbus {
> -		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000>;
>  		pcie-controller {
>  			status = "okay";
>  
> diff --git a/arch/arm/boot/dts/kirkwood-db-88f6282.dts b/arch/arm/boot/dts/kirkwood-db-88f6282.dts
> index 36c411d..701c6b6 100644
> --- a/arch/arm/boot/dts/kirkwood-db-88f6282.dts
> +++ b/arch/arm/boot/dts/kirkwood-db-88f6282.dts
> @@ -19,7 +19,6 @@
>  	compatible = "marvell,db-88f6282-bp", "marvell,kirkwood-88f6282", "marvell,kirkwood";
>  
>  	mbus {
> -		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000>;
>  		pcie-controller {
>  			status = "okay";
>  
> diff --git a/arch/arm/boot/dts/kirkwood-iconnect.dts b/arch/arm/boot/dts/kirkwood-iconnect.dts
> index 0323f01..b8150a7 100644
> --- a/arch/arm/boot/dts/kirkwood-iconnect.dts
> +++ b/arch/arm/boot/dts/kirkwood-iconnect.dts
> @@ -19,7 +19,6 @@
>  	};
>  
>  	mbus {
> -		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000>;
>  		pcie-controller {
>  			status = "okay";
>  
> diff --git a/arch/arm/boot/dts/kirkwood-mplcec4.dts b/arch/arm/boot/dts/kirkwood-mplcec4.dts
> index ce2b94b..26ae240 100644
> --- a/arch/arm/boot/dts/kirkwood-mplcec4.dts
> +++ b/arch/arm/boot/dts/kirkwood-mplcec4.dts
> @@ -17,7 +17,6 @@
>          };
>  
>  	mbus {
> -		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000>;
>  		pcie-controller {
>  			status = "okay";
>  
> diff --git a/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts b/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
> index 874857e..d3a5a0f 100644
> --- a/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
> +++ b/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
> @@ -17,7 +17,6 @@
>  	};
>  
>  	mbus {
> -		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000>;
>  		pcie-controller {
>  			status = "okay";
>  
> diff --git a/arch/arm/boot/dts/kirkwood-nsa310.dts b/arch/arm/boot/dts/kirkwood-nsa310.dts
> index 7aeae0c..b5418bc 100644
> --- a/arch/arm/boot/dts/kirkwood-nsa310.dts
> +++ b/arch/arm/boot/dts/kirkwood-nsa310.dts
> @@ -15,7 +15,6 @@
>  	};
>  
>  	mbus {
> -		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000>;
>  		pcie-controller {
>  			status = "okay";
>  
> diff --git a/arch/arm/boot/dts/kirkwood-ts219-6282.dts b/arch/arm/boot/dts/kirkwood-ts219-6282.dts
> index 9efcd2d..345562f 100644
> --- a/arch/arm/boot/dts/kirkwood-ts219-6282.dts
> +++ b/arch/arm/boot/dts/kirkwood-ts219-6282.dts
> @@ -6,7 +6,6 @@
>  
>  / {
>  	mbus {
> -		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000>;
>  		pcie-controller {
>  			status = "okay";
>  
> diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
> index cf7aeaf..d1bbe95 100644
> --- a/arch/arm/boot/dts/kirkwood.dtsi
> +++ b/arch/arm/boot/dts/kirkwood.dtsi
> @@ -27,6 +27,11 @@
>  		compatible = "marvell,kirkwood-mbus", "simple-bus";
>  		#address-cells = <2>;
>  		#size-cells = <1>;
> +		/* If a board file needs to change this ranges it must replace it completely */

I'd rather have a longer comment in here, explaining why such
replacement is needed and how the 'ranges' entries are not inherited
in any way.

This is just a minor observation, so feel free to ignore it :)

> +		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000	/* internal-regs */
> +			  MBUS_ID(0x01, 0x2f) 0 0xf4000000 0x10000	/* nand flash */
> +			  MBUS_ID(0x03, 0x01) 0 0xf5000000 0x10000	/* crypto sram */
> +			  >;
>  		controller = <&mbusc>;
>  		pcie-mem-aperture = <0xe0000000 0x10000000>; /* 256 MiB memory space */
>  		pcie-io-aperture  = <0xf2000000 0x100000>;   /*   1 MiB    I/O space */
> diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
> index 82d3ad8..f087b5f 100644
> --- a/arch/arm/mach-kirkwood/board-dt.c
> +++ b/arch/arm/mach-kirkwood/board-dt.c
> @@ -92,7 +92,6 @@ static void __init kirkwood_dt_init(void)
>  	writel(readl(CPU_CONFIG) & ~CPU_CONFIG_ERROR_PROP, CPU_CONFIG);
>  
>  	BUG_ON(mvebu_mbus_dt_init());
> -	kirkwood_setup_wins();
>  
>  	kirkwood_l2_init();
>  

Other than that, the patch looks good:

Acked-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

And, in Openblocks-A6:

Tested-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Regards,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
