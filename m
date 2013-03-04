From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 4 Mar 2013 10:03:09 +0000
Subject: [PATCH 1/3] clocksource: sh_cmt: Add Device Tree probing
In-Reply-To: <1362159932-18533-2-git-send-email-hechtb+renesas@gmail.com>
References: <1362159932-18533-1-git-send-email-hechtb+renesas@gmail.com>
 <1362159932-18533-2-git-send-email-hechtb+renesas@gmail.com>
Message-ID: <20130304100309.GA30747@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I have a couple of comments on the binding and the way it's parsed.

On Fri, Mar 01, 2013 at 05:45:30PM +0000, Bastian Hecht wrote:
> We add the capabilty to probe SH CMT timer devices using Device Tree
> setup.
> 
> We can deduce former platform data by the device IDs and channel
> IDs of our timer instances, so we choose this more intuitive info as our
> DT properties.
> 
> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> ---
>  .../bindings/timer/renesas,sh-cmt-timer.txt        |   21 +++++
>  drivers/clocksource/sh_cmt.c                       |   94 +++++++++++++++++---
>  2 files changed, 102 insertions(+), 13 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/timer/renesas,sh-cmt-timer.txt
> 
> diff --git a/Documentation/devicetree/bindings/timer/renesas,sh-cmt-timer.txt b/Documentation/devicetree/bindings/timer/renesas,sh-cmt-timer.txt
> new file mode 100644
> index 0000000..e5ad808
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/renesas,sh-cmt-timer.txt
> @@ -0,0 +1,21 @@
> +* Renesas SH Mobile Compare Match Timer
> +
> +Required properties:
> +- compatible : Should be "renesas,cmt"
> +- reg : Address and length of the register set for the device
> +- interrupts : Timer IRQ
> +- renesas,timer-device-id : The ID of the timer device
> +- renesas,timer-channel-id : The channel ID of the timer device

I'm not familiar with this hardware. Could you give me a basic idea of how it's
structured?

Does the device have a single timer that this describes, or does the device
have multiple timers, and this selects which one to use?

> +
> +Example for CMT10 of the R8A7740 SoC:
> +
> +	cmt at 0xe6138010 {
> +		compatible = "renesas,cmt";
> +		interrupt-parent = <&intca>;
> +		reg = <0xe6138010 0xc>;
> +		interrupts = <0x0b00>;
> +		renesas,timer-device-id = <1>;
> +		renesas,timer-channel-id = <0>;
> +		renesas,clocksource-rating = <150>;
> +		renesas,clockevent-rating = <150>;

I'm not sure these last two are describing the hardware as such, they look like
Linux implementation details. Do these really need to be in the binding?

[...]

> +static struct sh_timer_config *sh_cmt_parse_dt(struct device *dev)
> +{
> +	struct sh_timer_config *cfg;
> +	struct device_node *np = dev->of_node;
> +	const __be32 *prop;
> +	int timer_id, channel_id;
> +
> +	cfg = devm_kzalloc(dev, sizeof(struct sh_timer_config), GFP_KERNEL);
> +	if (!cfg) {
> +		dev_err(dev, "failed to allocate DT config data\n");
> +		return NULL;
> +	}
> +
> +	prop = of_get_property(np, "renesas,timer-device-id", NULL);
> +	if (!prop) {
> +		dev_err(dev, "device id missing\n");
> +		return NULL;
> +	}
> +	timer_id = be32_to_cpup(prop);

You can use of_property_read_u32 here, e.g.

if (!of_property_read_u32(np, "renesas,timer-device-id", &timer_id) {
	dev_err(dev, "device id missing\n");
	return NULL;
}

> +
> +	prop = of_get_property(np, "renesas,timer-channel-id", NULL);
> +	if (!prop) {
> +		dev_err(dev, "channel id missing\n");
> +		return NULL;
> +	}
> +	channel_id = be32_to_cpup(prop);

You can use of_property_read_u32 here too.

I assume there's a sensible range of channel_id values that could be checked
before it's used in a calculation below.

> +
> +	if (timer_id >= ARRAY_SIZE(sh_timer_offset_multiplier)) {
> +		dev_err(dev, "unsupported timer id\n");
> +		return NULL;
> +	}
> +
> +	cfg->channel_offset = sh_timer_offset_multiplier[timer_id] *
> +							(channel_id + 1);
> +	cfg->timer_bit = channel_id;
> +
> +	prop = of_get_property(np, "renesas,clocksource-rating", NULL);
> +	if (prop)
> +		cfg->clocksource_rating = be32_to_cpup(prop);

You can use of_property_read_u32 here too.

> +
> +	prop = of_get_property(np, "renesas,clockevent-rating", NULL);
> +	if (prop)
> +		cfg->clockevent_rating = be32_to_cpup(prop);

And here.

[...]

Thanks,
Mark.
