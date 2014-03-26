From: robherring2@gmail.com (Rob Herring)
Date: Wed, 26 Mar 2014 16:08:55 -0500
Subject: [PATCH 44/44] ARM: l2c: add L2C-310 power control DT properties
In-Reply-To: <E1WPLEy-0002er-51@rmk-PC.arm.linux.org.uk>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
 <E1WPLEy-0002er-51@rmk-PC.arm.linux.org.uk>
Message-ID: <CAL_JsqJ1Lx08iv4vj3c7s6vy5zF4BQDd=TuGH82O=54X4jAWGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 16, 2014 at 7:17 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> Add two new properties for setting thte L3 power control register.  Two
> new properties are added:
>
>         arm,dynamic-clk-gating
>         arm,standby-mode
>
> iMX6 sets both these, add the properties there.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  Documentation/devicetree/bindings/arm/l2cc.txt |  2 ++
>  arch/arm/boot/dts/imx6qdl.dtsi                 |  2 ++
>  arch/arm/boot/dts/imx6sl.dtsi                  |  2 ++
>  arch/arm/mm/cache-l2x0.c                       | 10 ++++++++++
>  4 files changed, 16 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
> index b513cb8196fe..e0dd400ecea6 100644
> --- a/Documentation/devicetree/bindings/arm/l2cc.txt
> +++ b/Documentation/devicetree/bindings/arm/l2cc.txt
> @@ -40,6 +40,8 @@ implementations of the L2 cache controller with compatible programming models.
>  - arm,filter-ranges : <start length> Starting address and length of window to
>    filter. Addresses in the filter window are directed to the M1 port. Other
>    addresses will go to the M0 port.
> +- arm,dynamic-clk-gating : Enables dynamic clock gating (PL310)
> +- arm,standby-mode : Enables standby mode (PL310)

I'd rather see properties to disable these features and the default to
be to enable them. I would expect disabling them to be the exception.
I can't imagine that they would be broken at an integration level
unless h/w is doing something based on CLKSTOPPED. Given you also need
s/w interaction (flush and disable the cache) to do anything like
reducing voltage or cutting power to the L2, it's unlikely that the
h/w will do anything in reaction to CLKSTOPPED . There is some risk of
breaking a platform with this approach, but there's also the risk we
never see power improvements because no one ever goes and adds these
to the dts file.

Also, standby probably doesn't really gain anything over dynamic clk
gating, so standby may not be worth adding.

Rob
