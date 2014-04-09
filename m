From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 9 Apr 2014 17:08:46 +0200
Subject: [PATCH 07/15] ARM: sunxi: dt: define A31's APB0 clk gates node
In-Reply-To: <1397051478-4113-8-git-send-email-boris.brezillon@free-electrons.com>
References: <1397051478-4113-1-git-send-email-boris.brezillon@free-electrons.com>
 <1397051478-4113-8-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140409150846.GG28585@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 09, 2014 at 03:51:10PM +0200, Boris BREZILLON wrote:
> Define the APB0 clk gates controlled by the PRCM (Power/Reset/Clock
> Management) block.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> ---
>  arch/arm/boot/dts/sun6i-a31.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
> index 3858424..61e8b34 100644
> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
> @@ -141,6 +141,16 @@
>  					"ahb1_drc0", "ahb1_drc1";
>  		};
>  
> +		apb0_gates: apb0_gates at 01f01428 {

The node name should reflect the class of the device, so it should be
clk@<address>.

> +			#clock-cells = <1>;
> +			compatible = "allwinner,sun6i-a31-apb0-gates-clk";
> +			reg = <0x01f01428 0x4>;
> +			clock-output-names = "apb0_pio", "apb0_ir",
> +					"apb0_timer01", "apb0_p2wi",
> +					"apb0_uart", "apb0_1wire",
> +					"apb0_i2c";
> +		};
> +

Hmmm, I'm not really fond of this.

There's already a PRCM node in the DT, which is used for the SMP
bringup.

I really don't want any duplicate memory regions in the DT, so you'll
have to fix the SMP code.

That being said, I can understand that you did this to be consistent
with the scheme we have for the clock controller where we chose to
make every clock a single driver.

That worked well for the CCU precisely because we only had clocks. It
doesn't for the PRCM because it's not been very well documented, and
it does clocks, resets, that fits pretty well in the existing
frameworks we have, but the SMP related functions are actually not
fitting that well.

It's mostly a power clamp and a power gating bits, that could maybe
fit in the regulator framework.

I don't really have a solution for this. Maybe someone else will.

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140409/9455aa24/attachment.sig>
