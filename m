From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 15 Jan 2015 11:39:47 +0000
Subject: [PATCH v3 1/5] rtc: armada38x: Add the device tree binding
 documentation
In-Reply-To: <1421318826-27268-2-git-send-email-gregory.clement@free-electrons.com>
References: <1421318826-27268-1-git-send-email-gregory.clement@free-electrons.com>
 <1421318826-27268-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20150115113947.GC16217@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 15, 2015 at 10:47:02AM +0000, Gregory CLEMENT wrote:
> The Armada 38x SoCs come with a new RTC which differs from the one
> used in the other mvebu SoCs until now. This patch describes the
> binding of this RTC.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  .../devicetree/bindings/rtc/armada-380-rtc.txt     | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/armada-380-rtc.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/armada-380-rtc.txt b/Documentation/devicetree/bindings/rtc/armada-380-rtc.txt
> new file mode 100644
> index 000000000000..e6fe29bda608
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/armada-380-rtc.txt
> @@ -0,0 +1,22 @@
> +* Real Time Clock of the Armada 38x SoCs
> +
> +RTC controller for the Armada 38x SoCs
> +
> +Required properties:
> +- compatible : Should be "marvell,armada-380-rtc"
> +- reg: physical base address of the controller and length of memory
> +  mapped region, associated to the reg-name "rtc". The other entry is
> +  related to the interrupt control from the SoC, associated to the
> +  reg-name "soc-int".
> +- reg-names: names of the mapped memory regions listed in reg property
> +    in the same order: "rtc" and "soc-int".

It would be nicer if reg were defined in terms of reg-names to avoid
redundancy, e.g.

- reg: a list of base address and size pairs, one for each entry in
  reg-names
- reg names: should contain:
  * "rtc" for the RTC registers
  * "soc-int" for the interrutp control registers.

That said, what are the "soc-int" registers, and why does the RTC driver
need to poke them? It looks like they're for a separate component (i.e.
the interrupt controller).

Thanks,
Mark.

> +- interrupts: IRQ line for the RTC.
> +
> +Example:
> +
> +rtc at a3800 {
> +	compatible = "marvell,armada-380-rtc";
> +	reg = <0xa3800 0x20>, <0x184a0 0x0c>;
> +	reg-names = "rtc", "soc-int";
> +	interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> +};
> -- 
> 1.9.1
> 
> 
