From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 28 May 2015 16:02:45 -0600
Subject: [PATCH 2/7] ARM: bcm2835: Add a Raspberry Pi-specific clock
 driver.
In-Reply-To: <1431978219-14226-3-git-send-email-eric@anholt.net>
References: <1431978219-14226-1-git-send-email-eric@anholt.net>
 <1431978219-14226-3-git-send-email-eric@anholt.net>
Message-ID: <55679085.6040402@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18/2015 01:43 PM, Eric Anholt wrote:
> Unfortunately, the clock manager's registers are not accessible by the
> ARM, so we have to request that the firmware modify our clocks for us.
> 
> This driver only registers the clocks at the point they are requested
> by a client driver.  This is partially to support returning
> -EPROBE_DEFER when the firmware driver isn't supported yet, but it
> also avoids issues with disabling "unused" clocks due to them not yet
> being connected to their consumers in the DT.

It looks like you forgot to CC the clock subsystem maintainers:

M:      Mike Turquette <mturquette@linaro.org>
M:      Stephen Boyd <sboyd@codeaurora.org>

The description above sounds like a neat solution, but has the
disadvantage that the clocks without a client won't show up in debugfs.
I wonder if the clock maintainers know of a better way?

> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile

>  obj-$(CONFIG_ARCH_BCM2835)		+= clk-bcm2835.o
> +obj-$(CONFIG_ARCH_BCM2835)		+= clk-raspberrypi.o

Shouldn't this replace the old legacy code in clk-bcm2835.c?

I wonder if a separate Kconfig symbol is warranted for the clock driver.
Looking at the context in the patch, it's common not to do that though.

> diff --git a/drivers/clk/clk-raspberrypi.c b/drivers/clk/clk-raspberrypi.c

> +struct rpi_firmware_clock {
> +	/* Clock definitions in our static struct. */
> +	int clock_id;

Why not just use the raw HW IDs (from the mailbox protocol) as the ID in
DT and the driver? The only thing that would need to change is to add a
error check for "clkspec->args[0] == 0" in
rpi_firmware_delayed_get_clk(). The advantage would be that
include/dt-bindings/clk/raspberrypi.h would exactly match the firmware
protocol, and hence be easily correlated with the documentation.

> +static int rpi_clk_set_rate(struct clk_hw *hw,
> +			    unsigned long rate, unsigned long parent_rate)
> +{
> +	struct rpi_firmware_clock *rpi_clk =
> +		container_of(hw, struct rpi_firmware_clock, hw);
> +	u32 packet[2];
> +	int ret;
> +
> +	packet[0] = rpi_clk->clock_id;
> +	packet[1] = rate;
> +	ret = rpi_firmware_property(rpi_clk->firmware_node,

The docs indicate there's a third word here "skip setting turbo". Is
that optional?

https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface

> +static long rpi_clk_round_rate(struct clk_hw *hw, unsigned long rate,
> +			       unsigned long *parent_rate)
> +{
> +	/*
> +	 * The firmware will end up rounding our rate to something,
> +	 * but we don't have an interface for it.  Just return the
> +	 * requested value, and it'll get updated after the clock gets
> +	 * set.
> +	 */
> +	return rate;
> +}

Hmm. I wonder if that will confuse things; I thought the purpose of
round_rate() was so code could know exactly what would happen ahead of time?

> +static struct clk *rpi_firmware_delayed_get_clk(struct of_phandle_args *clkspec,
> +						void *_data)

> +	rpi_clk = &rpi_clocks[clkspec->args[0]];
> +
> +	firmware_node = of_parse_phandle(of_node, "firmware", 0);
> +	if (!firmware_node) {
> +		dev_err(dev, "%s: Missing firmware node\n", rpi_clk->name);
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	/* Try a no-op transaction to see if the driver is loaded yet. */
> +	ret = rpi_firmware_property_list(firmware_node, NULL, 0);
> +	if (ret)
> +		return ERR_PTR(ret);

I would move all that into this driver's probe().

> +	init.flags = CLK_IS_ROOT;

Is it possible to add clock parent information to the driver, so the
clocks are all hooked together into the correct tree, rather than all
looking like root clocks?

One of the many reasons I didn't do anything FW-wise for the kernel was
the hope that such information would be forthcoming, and hence we could
have complete kernel drivers.

> +void __init rpi_firmware_init_clock_provider(struct device_node *node)
> +{
> +	/* We delay construction of our struct clks until get time,
> +	 * because we need to be able to return -EPROBE_DEFER if the
> +	 * firmware driver isn't up yet.  clk core doesn't support
> +	 * re-probing on -EPROBE_DEFER, but callers of clk_get can.

Oh, that's nasty. What would it take to fix the clock core to support
deferred probe? It really should.

> +CLK_OF_DECLARE(rpi_firmware_clocks, "raspberrypi,firmware-clocks",
> +	       rpi_firmware_init_clock_provider);

Oh, I guess the same comment as for the firmware node applies re: the
over-genericity of the DT compatible value applies here too. Perhaps
raspberrypi,bcm2835-firmware-clocks to match Lee's proposal for the
firmware node?
