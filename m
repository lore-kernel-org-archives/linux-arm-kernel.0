From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 19 Nov 2012 01:37:57 -0500
Subject: [PATCH v2 2/2] ARM: Kirkwood: Convert XOR instantiation to DT.
In-Reply-To: <1353235498-22638-2-git-send-email-andrew@lunn.ch>
References: <1353235498-22638-1-git-send-email-andrew@lunn.ch>
 <1353235498-22638-2-git-send-email-andrew@lunn.ch>
Message-ID: <20121119063757.GJ22106@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 18, 2012 at 11:44:57AM +0100, Andrew Lunn wrote:
> Use DT to describe the two XOR DMA engines on Kirkwood. Remove the
> C code initialization.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
> 
> These patches depend on the refactoring/DT patches from Thomas and NOT
> the clock patches from me. With the clock patches, a slight different
> patch is needed, specifying a clocks property in DT and no auxdata.
> 
>  arch/arm/boot/dts/kirkwood.dtsi   |   38 +++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-kirkwood/board-dt.c |    6 ++----
>  2 files changed, 40 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
> index 4e5b815..e0ba79d 100644
> --- a/arch/arm/boot/dts/kirkwood.dtsi
> +++ b/arch/arm/boot/dts/kirkwood.dtsi
> @@ -77,6 +77,44 @@
>  			status = "okay";
>  		};
>  
> +		xor at 60800 {
> +			compatible = "marvell,orion-xor";
> +			reg = <0x60800 0x100
> +			       0x60A00 0x100>;
> +			status = "okay";
> +
> +			xor00 {
> +			      interrupts = <5>;
> +			      dmacap,memcpy;
> +			      dmacap,xor;
> +			};
> +			xor01 {
> +			      interrupts = <6>;
> +			      dmacap,memcpy;
> +			      dmacap,xor;
> +			      dmacap,memset;
> +			};
> +		};
> +
> +		xor at 60900 {
> +			compatible = "marvell,orion-xor";
> +			reg = <0x60900 0x100
> +			       0xd0B00 0x100>;
> +			status = "okay";
> +
> +			xor00 {
> +			      interrupts = <7>;
> +			      dmacap,memcpy;
> +			      dmacap,xor;
> +			};
> +			xor01 {
> +			      interrupts = <8>;
> +			      dmacap,memcpy;
> +			      dmacap,xor;
> +			      dmacap,memset;
> +			};
> +		};
> +
>  		sata at 80000 {
>  			compatible = "marvell,orion-sata";
>  			reg = <0x80000 0x5000>;
> diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
> index d94872f..e62f10de 100644
> --- a/arch/arm/mach-kirkwood/board-dt.c
> +++ b/arch/arm/mach-kirkwood/board-dt.c
> @@ -34,6 +34,8 @@ struct of_dev_auxdata kirkwood_auxdata_lookup[] __initdata = {
>  	OF_DEV_AUXDATA("marvell,orion-sata", 0xf1080000, "sata_mv.0", NULL),
>  	OF_DEV_AUXDATA("marvell,orion-nand", 0xf4000000, "orion_nand", NULL),
>  	OF_DEV_AUXDATA("marvell,orion-crypto", 0xf1030000, "mv_crypto", NULL),
> +	OF_DEV_AUXDATA("marvell,orion-xor", 0xf1060800, "mv_xor.0", NULL),
> +	OF_DEV_AUXDATA("marvell,orion-xor", 0xf1060900, "mv_xor.1", NULL),

This conflicts with the earlier clock work.  I'll be pushing mvebu/dt in
a bit, could you please rebase these two patches against that?

thx,

Jason.
