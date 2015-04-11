From: mturquette@linaro.org (Michael Turquette)
Date: Fri, 10 Apr 2015 17:12:31 -0700
Subject: [PATCH v6 1/6] clk: iproc: define Broadcom iProc clock binding
In-Reply-To: <1426657522-2473-2-git-send-email-rjui@broadcom.com>
References: <1426657522-2473-1-git-send-email-rjui@broadcom.com>
 <1426657522-2473-2-git-send-email-rjui@broadcom.com>
Message-ID: <20150411001231.18916.93186@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Ray Jui (2015-03-17 22:45:17)
> Document the device tree binding for Broadcom iProc architecture based
> clock controller
> 
> Signed-off-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> ---
>  .../bindings/clock/brcm,iproc-clocks.txt           |  171 ++++++++++++++++++++
>  1 file changed, 171 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/brcm,iproc-clocks.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/brcm,iproc-clocks.txt b/Documentation/devicetree/bindings/clock/brcm,iproc-clocks.txt
> new file mode 100644
> index 0000000..bf2316b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/brcm,iproc-clocks.txt
> @@ -0,0 +1,171 @@
> +Broadcom iProc Family Clocks
> +
> +This binding uses the common clock binding:
> +    Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +The iProc clock controller manages clocks that are common to the iProc family.
> +An SoC from the iProc family may have several PPLs, e.g., ARMPLL, GENPLL,
> +LCPLL0, MIPIPLL, and etc., all derived from an onboard crystal. Each PLL
> +comprises of several leaf clocks
> +
> +Required properties for PLLs:
> +- compatible:
> +    Should have a value of the form "brcm,<soc>-<pll>". For example, GENPLL on
> +Cygnus has a compatible string of "brcm,cygnus-genpll"
> +
> +- #clock-cells:
> +    Must be <0>
> +
> +- reg:
> +    Define the base and range of the I/O address space that contain the iProc
> +clock control registers required for the PLL
> +
> +- clocks:
> +    The input parent clock phandle for the PLL. For all iProc PLLs, this is an
> +onboard crystal with a fixed rate
> +
> +Example:
> +
> +       osc: oscillator {
> +               #clock-cells = <0>;
> +               compatible = "fixed-clock";
> +               clock-frequency = <25000000>;
> +       };
> +
> +       genpll: genpll {
> +               #clock-cells = <0>;
> +               compatible = "brcm,cygnus-genpll";
> +               reg = <0x0301d000 0x2c>,
> +                       <0x0301c020 0x4>;
> +               clocks = <&osc>;
> +       };
> +
> +Required properties for leaf clocks of a PLL:
> +
> +- compatible:
> +    Should have a value of the form "brcm,<soc>-<pll>-clk". For example, leaf
> +clocks derived from the GENPLL on Cygnus SoC have a compatible string of
> +"brcm,cygnus-genpll-clk"
> +
> +- #clock-cells:
> +    Have a value of <1> since there are more than 1 leaf clock of a
> +given PLL
> +
> +- reg:
> +    Define the base and range of the I/O address space that contain the iProc
> +clock control registers required for the PLL leaf clocks
> +
> +- clocks:
> +    The input parent PLL phandle for the leaf clock
> +
> +- clock-output-names:
> +    An ordered list of strings defining the names of the leaf clocks
> +
> +Example:
> +
> +       genpll: genpll {
> +               #clock-cells = <0>;
> +               compatible = "brcm,cygnus-genpll";
> +               reg = <0x0301d000 0x2c>,
> +                       <0x0301c020 0x4>;
> +               clocks = <&osc>;
> +       };
> +
> +       genpll_clks: genpll_clks {
> +               #clock-cells = <1>;
> +               compatible = "brcm,cygnus-genpll-clk";
> +               reg = <0x0301d000 0x2c>;
> +               clocks = <&genpll>;
> +               clock-output-names = "axi21", "250mhz", "ihost_sys",
> +                       "enet_sw", "audio_125", "can";
> +       };

Hi Ray,

Thanks for submitting the patch. It was nice meeting you at ELC as well.

This binding doesn't conform to the norms for clock bindings. It looks
like for each type of controllable clock node (e.g. pll, leaf clock,
etc) you have a dts node. Looking at the above example it seems that
those two nodes (genpll and genpll_clks) share the same register.

/me checks patch #5

Yup, you re-use the same register address for the *pll and *pll_clks
nodes. I'm not a DT expert but I think this is considered Wrong.

More generally your clock dt binding should be modeling the hardware in
terms of IP blocks. If you have a clock generator IP block it may
control many clock bits and output many clock signals. E.g. for your
hardware (based only on the addresses in patch #5 and not having seen
any data manual) I will hazard a guess that the genpll, lcpll and asiu
clocks are all part of the same IP block.

If my guess is correct then these clocks should all be represented by a
single node int DT. Lets say that the clock controller IP block that
manages the genpll, lcpll and asiu clocks (including their child/leaf
clocks) is called "foobar" in your data manual. You should have a dts
node with a compatible string such as "brcm,cygnus-foobar" or
"brcm,cygnus-foobar-clk".

Your clock driver should be responsible for registering all of the
clocks controlled by this IP block, regardless of the "type" of clock
node.

I think part of the reason for your approach is that the previous
(deprecated) binding/dts had a bunch of fixed-rate clocks in it. This is
a hack that we do every now and then to get a new platform up and
running with a mainline kernel, but we don't do per-clock nodes in dts
any more, we do them by clock controller ip block instead.

There are plenty of good examples of this for Exynos and QCOM SoCs if
you want an example.

Regards,
Mike
