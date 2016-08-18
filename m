From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Aug 2016 10:10:58 +0100
Subject: [PATCH] arm: l2x0: add PMU support
In-Reply-To: <1471451191-18090-1-git-send-email-mark.rutland@arm.com>
References: <1471451191-18090-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20160818091058.GS1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 17, 2016 at 05:26:31PM +0100, Mark Rutland wrote:
> +static void l2x0_pmu_counter_config_write(int idx, u32 val)
> +{
> +	writel(val, l2x0_base + L2X0_EVENT_CNT0_CFG - 4 * idx);
> +}
> +
> +static u32 l2x0_pmu_counter_read(int idx)
> +{
> +	return readl(l2x0_base + L2X0_EVENT_CNT0_VAL - 4 * idx);
> +}
> +
> +static void l2x0_pmu_counter_write(int idx, u32 val)
> +{
> +	writel(val, l2x0_base + L2X0_EVENT_CNT0_VAL - 4 * idx);
> +}
> +
> +static void __l2x0_pmu_enable(void)
> +{
> +	u32 val = readl(l2x0_base + L2X0_EVENT_CNT_CTRL);
> +	val |= L2X0_EVENT_CNT_CTRL_ENABLE;
> +	writel(val, l2x0_base + L2X0_EVENT_CNT_CTRL);
> +}
> +
> +static void __l2x0_pmu_disable(void)
> +{
> +	u32 val = readl(l2x0_base + L2X0_EVENT_CNT_CTRL);
> +	val &= ~L2X0_EVENT_CNT_CTRL_ENABLE;
> +	writel(val, l2x0_base + L2X0_EVENT_CNT_CTRL);
> +}

Are you sure you want to be using the barriered IOs here, which will
come back in and run a sync on the L2C?  Isn't that going to affect
the performance measurements?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
