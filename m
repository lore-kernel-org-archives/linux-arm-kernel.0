From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 25 Mar 2014 12:19:42 +0100
Subject: [RFC PATCH v2 2/2] clk: Add handling of clk parent and rate
 assigned from DT
In-Reply-To: <1393870975-21020-1-git-send-email-s.nawrocki@samsung.com>
References: <1393870533-20845-1-git-send-email-s.nawrocki@samsung.com>
 <1393870975-21020-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <5331664E.2050008@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/14 19:22, Sylwester Nawrocki wrote:
> This function adds a notifier callback run before a driver is bound
> to a device. It will configure any parent clocks and clock frequencies
> according to values of 'clock-parents' and 'clock-rates' DT properties
> respectively.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> Changes since v1:
>  - the helper function to parse and set assigned clock parents and
>    rates made public so it is available to clock providers to call
>    directly;
>  - dropped the platform bus notification and call of_clk_device_setup()
>    is is now called from the driver core, rather than from the
>    notification callback;
>  - s/of_clk_get_list_entry/of_clk_get_by_property.
> ---
>  .../devicetree/bindings/clock/clock-bindings.txt   |   23 ++++++
>  drivers/base/dd.c                                  |    5 ++
>  drivers/clk/clk.c                                  |   77 ++++++++++++++++++++
>  include/linux/clk-provider.h                       |    6 ++
>  4 files changed, 111 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/clock-bindings.txt b/Documentation/devicetree/bindings/clock/clock-bindings.txt
> index 7c52c29..eb8d547 100644
> --- a/Documentation/devicetree/bindings/clock/clock-bindings.txt
> +++ b/Documentation/devicetree/bindings/clock/clock-bindings.txt
> @@ -115,3 +115,26 @@ clock signal, and a UART.
>    ("pll" and "pll-switched").
>  * The UART has its baud clock connected the external oscillator and its
>    register clock connected to the PLL clock (the "pll-switched" signal)
> +
> +==Assigned clock parents and rates==
> +
> +Some platforms require static configuration of (parts of) the clock controller
> +often determined by the board design. Such a configuration can be specified in
> +a clock consumer node through clock-parents and clock-rates DT properties.
> +The former should contain list of parent clocks in form of phandle and clock
> +specifier pairs, the latter the list of assigned clock frequency values
> +(one cell each).
> +
> +    uart at a000 {
> +        compatible = "fsl,imx-uart";
> +        reg = <0xa000 0x1000>;
> +        ...
> +        clocks = <&clkcon 0>, <&clkcon 3>;
> +        clock-names = "baud", "mux";
> +
> +        clock-parents = <0>, <&pll 1>;

I have some doubts here, i.e. the order in which clocks are being 
configured may be important in some cases. Should the binding then be
specifying that the clocks will be configured in a sequence exactly 
as listed in the clock-parents property ?

E.g. consider part of a clock controller where one of frequencies fed to
a consumer device cannot exceed given value:

                mux1
 200 MHz   0 .--------.
----->-------|--.     |
             |   \____|__                    f1 
 400 MHz   1 |        |  `-+------------------->--
----->-------|-       |    |
             '--------'	   |	  mux2
                           | 0 .---------.
                           `---|--.      |   f2
                               |   \_____|_,---->--
                 100 MHz     1 |         |   (max. 200 MHz)
                 ----->--------|         | 
                               '---------'		

In this case we want to set frequency f1 to 400 MHz and f2 to 100 MHz.
To ensure f2 doesn't exceed 200 MHz at any time, mux2 has to be switched 
to position '1' first and then mux 1 to position '1'.

> +        clock-rates = <460800>;

For clock-rates it's a bit more complicated, since it might require
setting up frequency of some clocks twice - first to a low and then 
to a higher value. Such details could likely be handled by bindings 
of individual devices. Also we could assume the clock tree 
(re)configuration is being done when any consumer clocks are masked 
at the consumer clock gates.

I'm no sure if we should sort the clocks to ensure any parents are set
before the child clocks, or should we rely on the sequence specified 
in devicetree ? I'd assume sorting it wouldn't hurt, there should not 
be relatively many clocks in a single dt node.

> +    };
> +
> +In this example the pll is set as parent of "mux" clock and frequency of "baud"
> +clock is specified as 460800 Hz.

--
Thanks,
Sylwester
