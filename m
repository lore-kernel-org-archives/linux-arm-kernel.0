From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 30 Jun 2014 14:48:32 -0600
Subject: [PATCH 4/6] ARM: tegra: Add soctherm and thermal zones to Tegra124
 device tree
In-Reply-To: <1403856699-2140-5-git-send-email-mperttunen@nvidia.com>
References: <1403856699-2140-1-git-send-email-mperttunen@nvidia.com>
 <1403856699-2140-5-git-send-email-mperttunen@nvidia.com>
Message-ID: <53B1CD20.3010008@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2014 02:11 AM, Mikko Perttunen wrote:
> This adds the soctherm thermal sensing and management unit to the
> Tegra124 device tree along with the four thermal zones it exports.

> diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi

> +	thermal-zones {
> +		cpu {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;

I think we should still define a polling delay so that if there's SW
that doesn't support HW trip points/interrupts, it still knows how often
it should reasonably check the sensor.

Perhaps a delay of 0 is used to determine whether to use HW trip points
vs polling (I haven't read patch 1 yet)? If so, I'd prefer not to do
that. Rather, the driver should advertize its ability to provide HW trip
points, and it would be up to the core to then make use of them. The DT
should just describe the HW, not assume it can influence SW's choice of
whether to use HW trip points.

> +	soctherm: soctherm at 0,700e2000 {
...
> +		reset-names = "soctherm";
> +
> +		#thermal-sensor-cells = <1>;

I don't see any real need for that blank line. If there was, there would
probably be more blank lines in the big list of properties above.
