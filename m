From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 14 Aug 2015 22:28:26 -0600
Subject: [PATCH v5 2/3] clk: Add a Raspberry Pi-specific clock driver.
In-Reply-To: <1439507142-2965-3-git-send-email-eric@anholt.net>
References: <1439507142-2965-1-git-send-email-eric@anholt.net>
 <1439507142-2965-3-git-send-email-eric@anholt.net>
Message-ID: <55CEBFEA.7080505@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/13/2015 05:05 PM, Eric Anholt wrote:
> Unfortunately, the clock manager's registers are not accessible by the
> ARM, so we have to request that the firmware modify our clocks for us.
> 
> This driver only registers the clocks at the point they are requested
> by a client driver.  This is partially to support returning
> -EPROBE_DEFER when the firmware driver isn't supported yet, but it
> also avoids issues with disabling "unused" clocks due to them not yet
> being connected to their consumers in the DT.

> diff --git a/drivers/clk/clk-raspberrypi.c b/drivers/clk/clk-raspberrypi.c

> +static const struct {
> +	const char *name;
> +	int flags;
> +} rpi_clocks[] = {
> +	[RPI_CLOCK_EMMC] = { "emmc", CLK_IS_ROOT },
> +	[RPI_CLOCK_UART0] = { "uart0", CLK_IS_ROOT },
> +	[RPI_CLOCK_ARM] = { "arm", CLK_IS_ROOT | CLK_IGNORE_UNUSED },
> +	[RPI_CLOCK_CORE] = { "core", CLK_IS_ROOT | CLK_IGNORE_UNUSED },
> +	[RPI_CLOCK_V3D] = { "v3d", CLK_IS_ROOT },
> +	[RPI_CLOCK_H264] = { "h264", CLK_IS_ROOT },
> +	[RPI_CLOCK_ISP] = { "isp", CLK_IS_ROOT },
> +	[RPI_CLOCK_SDRAM] = { "sdram", CLK_IS_ROOT | CLK_IGNORE_UNUSED },
> +	[RPI_CLOCK_PIXEL] = { "pixel", CLK_IS_ROOT | CLK_IGNORE_UNUSED },
> +	[RPI_CLOCK_PWM] = { "pwm", CLK_IS_ROOT },
> +};
> +
> +struct rpi_firmware_clock {
> +	/* Clock definitions in our static struct. */
> +	const char *name;
> +	int flags;

Are these duplicates of the values in rpi_clocks[]? Why not just store a
pointer to or index of the entry in that array?

> +static int rpi_clk_set_state(struct clk_hw *hw, bool on)
> +{
> +	struct rpi_firmware_clock *rpi_clk =
> +		container_of(hw, struct rpi_firmware_clock, hw);
> +	u32 packet[2];
> +	int ret;
> +
> +	if (on == (rpi_clk->last_rate != 0))
> +		return 0;

The overloading of last_rate to represent both rate information and
on/off status is slightly confusing. I would have expected this function
to clear last_rate to 0 when switching the clock off, and some specific
rate when turning a clock on. Is there some guarantee that the clock
core will always call recalc_rate() at certain times, thus ensuring that
last_rate is always accurate?

Wouldn't it be simpler to let last_rate always represent that actual
rate, and have a separate last_on or is_on field to represent the
enable/disable state?

> +static unsigned long rpi_clk_get_rate(struct clk_hw *hw,
> +				      unsigned long parent_rate)
...
> +	rpi_clk->last_rate = packet[1];

Since this is a query API, I wouldn't have expected it to have
side-effects like this. Don't we know what rate the clock runs at based
on the firmware's response in set_rate()?

> +static int rpi_clk_probe(struct platform_device *pdev)

> +	onecell = devm_kmalloc(dev, sizeof(*onecell), GFP_KERNEL);
> +	if (!onecell)
> +		return -ENOMEM;
> +	onecell->clk_num = ARRAY_SIZE(rpi_clocks);
> +	onecell->clks = devm_kzalloc(dev, sizeof(*onecell->clks), GFP_KERNEL);

Don't you need to multiply the size by ARRAY_SIZE(rpi_clocks)? I assume
onecell->clks is an array with one entry per each of onecell->clk_num?
Yes, the for loop right after that allocation confirms this.
