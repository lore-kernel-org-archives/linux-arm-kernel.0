From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 9 Jan 2015 12:39:58 +0000
Subject: [PATCH v3 4/8] clk: Add clock driver for mb86s7x
In-Reply-To: <1420802977-4126-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
References: <1420802369-3840-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <1420802977-4126-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Message-ID: <20150109123958.GJ12302@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 09, 2015 at 07:29:37PM +0800, Vincent Yang wrote:
> +static int mb86s7x_clclk_of_init(void)
> +{
> +	int cpu;
> +	struct clk *clk;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct device *cpu_dev = get_cpu_device(cpu);
> +
> +		if (!cpu_dev) {
> +			pr_err("failed to get cpu%d device\n", cpu);
> +			continue;
> +		}
> +
> +		clk = mb86s7x_clclk_register(cpu_dev);
> +		if (IS_ERR(clk)) {
> +			pr_err("failed to register cpu%d clock\n", cpu);
> +			continue;
> +		}
> +		if (clk_register_clkdev(clk, NULL, dev_name(cpu_dev))) {
> +			pr_err("failed to register cpu%d clock lookup\n", cpu);
> +			continue;
> +		}
> +		pr_debug("registered clk for %s\n", dev_name(cpu_dev));
> +	}
> +
> +	platform_device_register_simple("arm-bL-cpufreq-dt", -1, NULL, 0);
> +
> +	return 0;
> +}
> +module_init(mb86s7x_clclk_of_init);

What is the effect of this initialising on platforms which are not
a "mb86s7x" ?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
