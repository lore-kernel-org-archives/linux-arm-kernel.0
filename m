From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 6 Aug 2013 13:36:23 -0400
Subject: [PATCH 1/2] ARM: mvebu: add support for the AXP WiFi AP board
In-Reply-To: <20130806170941.GC2705@localhost>
References: <1375199091-31215-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1375199091-31215-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130806155343.GU19280@titan.lakedaemon.net>
 <20130806170941.GC2705@localhost>
Message-ID: <20130806173623.GX19280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 06, 2013 at 02:09:42PM -0300, Ezequiel Garcia wrote:
> On Tue, Aug 06, 2013 at 11:53:43AM -0400, Jason Cooper wrote:
> > Ezequiel,
> > 
> > On Tue, Jul 30, 2013 at 05:44:50PM +0200, Thomas Petazzoni wrote:
> > > The AXP WiFi AP board is a Marvell platform based on the Armada XP
> > > MV78230 SoC. It has two mini-PCIe connectors, one USB 3.0 port powered
> > > by a USB 3.0 controller on PCIe, two Ethernet ports, 1 GB of RAM, 1 GB
> > > of NAND, 16 MB of SPI flash, one SATA port and one button, two UARTs
> > > 
> > > Successfully tested: USB 3.0 port, the mini-PCIe connectors, SPI
> > > flash, Ethernet ports, SATA port, button, UART.
> > > 
> > > Untested: NAND flash, due to lack of mainline support for the Armada
> > > 370/XP NAND controller for now.
> > > 
> > > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > > ---
> > >  arch/arm/boot/dts/Makefile                |   1 +
> > >  arch/arm/boot/dts/armada-xp-axpwifiap.dts | 164 ++++++++++++++++++++++++++++++
> > >  2 files changed, 165 insertions(+)
> > >  create mode 100644 arch/arm/boot/dts/armada-xp-axpwifiap.dts
> > 
> > When I merge this code with your MBus series I get the following
> > warning:
> > 
> >   DTC     arch/arm/boot/dts/armada-xp-axpwifiap.dtb
> > Warning (ranges_format): "ranges" property in /soc has invalid length (32 bytes)
> >  (parent #address-cells == 2, child #address-cells == 2, #size-cells == 1)
> > 
> > Could you please take a look and provide a separate patch to fix it up?
> > 
> 
> Jason,
> 
> When I cherry-pick commit 704cc70179481c814d581597a7d2cdbbeb152bee
> (ARM: mvebu: add support for the AXP WiFi AP board) from mvebu/dt
> into mvebu/mbus_dt, I found it's needed to apply the changes below.
> 
> If they look fine feel free to pick them, or request any other
> base for them.
> 
> I don't have the board to test this, so maybe Seif can help
> testing them?

Thanks Ezequiel!  Seif, would you mind giving this a spin and let me
know if it's ok?

thx,

Jason.

> commit ad1821bf7fa0790f2d513f5551abcd13cf297303
> Author: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Date:   Tue Aug 6 14:02:45 2013 -0300
> 
>     ARM: mvebu: Fix AXP-WiFi-AP DT for MBUS DT binding
>     
>     The ranges property needs to be changed to use the new MBus DT binding.
>     Also, the pcie-controller node needs to be relocated as according the MBus
>     DT binding, it's now a child of the mbus-compatible node.
> 
>     Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> 
> diff --git a/arch/arm/boot/dts/armada-xp-axpwifiap.dts b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
> index 2a542bd..c5fe572 100644
> --- a/arch/arm/boot/dts/armada-xp-axpwifiap.dts
> +++ b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
> @@ -16,7 +16,7 @@
>   */
>  
>  /dts-v1/;
> -/include/ "armada-xp-mv78230.dtsi"
> +#include "armada-xp-mv78230.dtsi"
>  
>  / {
>  	model = "Marvell RD-AXPWiFiAP";
> @@ -32,8 +32,30 @@
>  	};
>  
>  	soc {
> -		ranges = <0          0 0xf1000000 0x100000  /* Internal registers 1MiB */
> -			  0xe0000000 0 0xe0000000 0x8100000 /* PCIe */>;
> +		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
> +			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000>;
> +
> +		pcie-controller {
> +			status = "okay";
> +
> +			/* First mini-PCIe port */
> +			pcie at 1,0 {
> +				/* Port 0, Lane 0 */
> +				status = "okay";
> +			};
> +
> +			/* Second mini-PCIe port */
> +			pcie at 2,0 {
> +				/* Port 0, Lane 1 */
> +				status = "okay";
> +			};
> +
> +			/* Renesas uPD720202 USB 3.0 controller */
> +			pcie at 3,0 {
> +				/* Port 0, Lane 3 */
> +				status = "okay";
> +			};
> +		};
>  
>  		internal-regs {
>  			pinctrl {
> @@ -123,28 +145,6 @@
>  					spi-max-frequency = <108000000>;
>  				};
>  			};
> -
> -			pcie-controller {
> -				status = "okay";
> -
> -				/* First mini-PCIe port */
> -				pcie at 1,0 {
> -					/* Port 0, Lane 0 */
> -					status = "okay";
> -				};
> -
> -				/* Second mini-PCIe port */
> -				pcie at 2,0 {
> -					/* Port 0, Lane 1 */
> -					status = "okay";
> -				};
> -
> -				/* Renesas uPD720202 USB 3.0 controller */
> -				pcie at 3,0 {
> -					/* Port 0, Lane 3 */
> -					status = "okay";
> -				};
> -			};
>  		};
>  	};
>  
> 
> commit ae6c4bd3c2d337797ed1b8949b693d33c36ecbac
> Author: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Date:   Tue Aug 6 14:02:11 2013 -0300
> 
>     ARM: mvebu: Fix missing DT preprocessor include
>     
>     Fix the armada-xp-mv78230.dtsi file which lacked a proper #include
>     to use the DT preprocessor.
> 
>     Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> 
> diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
> index f093e39..e45e363 100644
> --- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
> +++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
> @@ -13,7 +13,7 @@
>   * common to all Armada XP SoCs.
>   */
>  
> -/include/ "armada-xp.dtsi"
> +#include "armada-xp.dtsi"
>  
>  / {
>  	model = "Marvell Armada XP MV78230 SoC";
> 
> -- 
> Ezequiel Garc?a, Free Electrons
> Embedded Linux, Kernel and Android Engineering
> http://free-electrons.com
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
