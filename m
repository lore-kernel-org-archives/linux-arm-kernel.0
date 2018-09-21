From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 21 Sep 2018 17:47:50 +0800
Subject: [PATCH] arm64: dts: allwinner: a64: Re-add "syscon" compatible
In-Reply-To: <20180917152857.162662-1-andre.przywara@arm.com>
References: <20180917152857.162662-1-andre.przywara@arm.com>
Message-ID: <CAGb2v643=V_3DbLeEyXEavSQJsW2KdknpZZLfw4QwCjhfdmVsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2018 at 11:29 PM Andre Przywara <andre.przywara@arm.com> wrote:
>
> Commit 1f1f5183981d ("arm64: dts: allwinner: a64: add SRAM controller
> device tree node") changed the (so far unused) compatible name of the
> sytem controller node, to match a specific SRAM controller driver
> instead of relying on the generic syscon driver. The Ethernet driver
> needs a register in there, so it got amended to use the new driver instead
> of the generic syscon approach. Consequently the "syscon" compatible has
> been dropped, as it's not needed anymore and would compete with the
> new SRAM driver.
>
> However this breaks existing DT consumers like older kernels, which
> expect the node pointed to by the syscon property to contain the string
> "syscon" somewhere in the compatible list. When such a DT is given to an
> older kernel (<4.19, for instance one on a distro installer image),
> the Ethernet will not probe successfully:
> ----------
> dwmac-sun8i 1c30000.ethernet: PTP uses main clock
> dwmac-sun8i 1c30000.ethernet: Linked as a consumer to regulator.6
> dwmac-sun8i 1c30000.ethernet: Unable to map syscon: -22
> dwmac-sun8i 1c30000.ethernet: Dropping the link to regulator.6
> dwmac-sun8i: probe of 1c30000.ethernet failed with error -22
> ----------
>
> To avoid this problem, (re-)add the "syscon" string to the compatible
> list of the sytem controller. This should make both older and newer
> kernels happy:
> - A newer kernel will try to find an existing *device* offering the regmap
>   first. The "syscon" string itself will not trigger a driver probe on
>   its own, the node must be explicitly referenced by another driver, wanting
>   to use the regmap. Newer kernels won't do it this way and will use the
>   regmap offered by the SRAM driver.
> - An older kernel will try the syscon way, and the system controller /
>   SRAM driver DT node is still fully syscon compatible.
>
> So by adding "syscon" we make everyone happy: Newer kernels will ignore
> it (knowing a better way), and older kernels will still work.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
> Hi,
>
> I think we need to amend the Ethernet driver now to not too easily use
> syscon as a fallback, in case dwmac-sun8i probed earlier than the SRAM driver.
> Will try this later tonight, but just wanted to start the discussion.

There is a good reason for removing the syscon compatible. It signals
that the block is a "generic" collection of random registers, which in
this case is not. This is the main reason. A supplimental one follows.

Implementations follow this "generic" concept and offer unrestricted,
concurrent access to the syscon region. Linux and one of the BSDs AFAIK
are the same in that syscon is just an API and not a full-blown device.
Thus the other sram controller driver that we bind to it has no way of
knowing about other accesses happening under its nose. U-boot, IIRC,
makes syscon an actual device driver, so you can't even have both drivers
bind to the same node.

Yes these are implementation issues, but other drivers might depend on it.
The syscon driver is simple and nice to use, until it isn't.

Regards
ChenYu

> Thanks,
> Andre.
>
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index d3daf90a8715..8f2dad7e5d06 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -197,7 +197,8 @@
>                 };
>
>                 syscon: syscon at 1c00000 {
> -                       compatible = "allwinner,sun50i-a64-system-control";
> +                       compatible = "allwinner,sun50i-a64-system-control",
> +                                    "syscon";
>                         reg = <0x01c00000 0x1000>;
>                         #address-cells = <1>;
>                         #size-cells = <1>;
> --
> 2.17.1
>
