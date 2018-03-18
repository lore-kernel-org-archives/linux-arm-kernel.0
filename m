From: robh@kernel.org (Rob Herring)
Date: Sun, 18 Mar 2018 07:52:22 -0500
Subject: [PATCH 1/4] dt-bindings: clock: meson: update documentation with
 hhi syscon
In-Reply-To: <20180315115545.1884-2-jbrunet@baylibre.com>
References: <20180315115545.1884-1-jbrunet@baylibre.com>
 <20180315115545.1884-2-jbrunet@baylibre.com>
Message-ID: <20180318125222.kqtybu4hiwvsx3om@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2018 at 12:55:42PM +0100, Jerome Brunet wrote:
> The HHI register region hosts more than just clocks and needs to
> accessed drivers other than the clock controller, such as the display
> driver.
> 
> This register region should be managed by syscon. It is already the case
> on gxbb/gxl and it soon will be on axg. The clock controllers must use
> this system controller instead of directly mapping the registers.

Sounds like a kernel problem, not a DT one.

> 
> This changes the bindings of gxbb and axg's clock controllers. This is
> due to an initial 'incomplete' knowledge of these SoCs, which is why the
> meson bindings are unstable ATM.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  .../devicetree/bindings/clock/amlogic,gxbb-clkc.txt      | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
> index e2b377ed6f91..e950599566a9 100644
> --- a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
> +++ b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
> @@ -10,9 +10,6 @@ Required Properties:
>  		"amlogic,gxl-clkc" for GXL and GXM SoC,
>  		"amlogic,axg-clkc" for AXG SoC.
>  
> -- reg: physical base address of the clock controller and length of memory
> -       mapped region.
> -
>  - #clock-cells: should be 1.
>  
>  Each clock is assigned an identifier and client nodes can use this identifier
> @@ -20,13 +17,22 @@ to specify the clock which they consume. All available clocks are defined as
>  preprocessor macros in the dt-bindings/clock/gxbb-clkc.h header and can be
>  used in device tree sources.
>  
> +Parent node should have the following properties :
> +- compatible: "syscon", "simple-mfd, and "amlogic,meson-gx-hhi-sysctrl" or
> +              "amlogic,meson-axg-hhi-sysctrl"
> +- reg: base address and size of the HHI system control register space.
> +
>  Example: Clock controller node:
>  
> -	clkc: clock-controller at c883c000 {
> +sysctrl: system-controller at 0 {
> +	compatible = "amlogic,meson-gx-hhi-sysctrl", "syscon", "simple-mfd";
> +	reg = <0 0 0 0x400>;
> +
> +	clkc: clock-controller {

With a single child, there is really no point to this change. A single 
node can provide multiple functions. Look at nodes that are both reset 
and clock providers.

What other functions are there?

Rob
