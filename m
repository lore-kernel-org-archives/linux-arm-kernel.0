From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 12 Sep 2012 12:53:52 -0600
Subject: [PATCH] media: add V4L2 DT binding documentation
In-Reply-To: <Pine.LNX.4.64.1209111746420.22084@axis700.grange>
References: <Pine.LNX.4.64.1209111746420.22084@axis700.grange>
Message-ID: <5050DA40.8050105@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/2012 09:51 AM, Guennadi Liakhovetski wrote:
> This patch adds a document, describing common V4L2 device tree bindings.
> 
> Co-authored-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Overall, I think this looks pretty reasonable, so:

Acked-by: Stephen Warren <swarren@wwwdotorg.org>

Just a couple comments:

> +++ b/Documentation/devicetree/bindings/media/v4l2.txt

> +	ceu0: ceu at 0xfe910000 {

> +		mclk: master_clock {
> +			compatible = "renesas,ceu-clock";
> +			#clock-cells = <1>;

Why 1? If there's only 1 clock output from this provider, I don't see a
need for any cells, unless there are some configuration flags?

> +			clock-frequency = <50000000>;	/* max clock frequency */
> +			clock-output-names = "mclk";
> +		};
> +
> +		port {
...
> +			ceu0_0: link at 0 {
> +				reg = <0>;
> +				remote = <&csi2_2>;
> +				immutable;

Did we decide "immutable" was actually needed? Presumably the driver for
the HW in question knows the HW isn't configurable, and would simply not
attempt to apply any configuration even if the .dts author erroneously
provided some?

> +			};
> +		};
> +	};
> +
> +	i2c0: i2c at 0xfff20000 {
...
> +		ov772x_1: camera at 0x21 {
...
> +			clocks = <&mclk 0>;

So presumably that could just be "clocks = <&mclk>;"?
