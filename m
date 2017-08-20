From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sun, 20 Aug 2017 10:32:19 +0200
Subject: [RFC 2/3] rtc: Add Realtek RTD1295
In-Reply-To: <20170820013632.18375-3-afaerber@suse.de>
References: <20170820013632.18375-1-afaerber@suse.de>
 <20170820013632.18375-3-afaerber@suse.de>
Message-ID: <20170820083219.siez3rl2hbjgjgk5@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 20/08/2017 at 03:36:30 +0200, Andreas F?rber wrote:
> +static int rtd119x_rtc_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct rtd119x_rtc *data = dev_get_drvdata(dev);
> +	time64_t t;
> +	u32 day;
> +
> +	day = readl_relaxed(data->base + RTD_RTCDATE_LOW);
> +	day |= readl_relaxed(data->base + RTD_RTCDATE_HIGH) << 8;

Is RTD_RTCDATE_HIGH latched when RTD_RTCDATE_LOW is read? If this is not
the case, you probably want to handle a possible update between both
readl_relaxed.

> +	t = mktime64(data->base_year, 1, 1, 0, 0, 0);
> +	t += day * 24 * 60 * 60;
> +	rtc_time64_to_tm(t, tm);
> +	tm->tm_sec  = readl_relaxed(data->base + RTD_RTCSEC) >> 1;
> +	tm->tm_min  = readl_relaxed(data->base + RTD_RTCMIN);
> +	tm->tm_hour = readl_relaxed(data->base + RTD_RTCHR);
> +
> +	return rtc_valid_tm(tm);
> +}
> +
> +static int rtd119x_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct rtd119x_rtc *data = dev_get_drvdata(dev);
> +	time64_t time_base, new_time, time_delta;
> +	unsigned long day;
> +
> +	if (tm->tm_year < data->base_year)
> +		return -EINVAL;
> +
> +	time_base = mktime64(data->base_year, 1, 1, 0, 0, 0);
> +	new_time = rtc_tm_to_time64(tm);
> +	time_delta = new_time - time_base;
> +	day = time_delta / (24 * 60 * 60);
> +	if (day > 0x7fff)
> +		return -EINVAL;
> +
> +	rtd119x_rtc_set_enabled(dev, false);
> +
> +	writel_relaxed(tm->tm_sec,  data->base + RTD_RTCSEC);
> +	writel_relaxed(tm->tm_min,  data->base + RTD_RTCMIN);
> +	writel_relaxed(tm->tm_hour, data->base + RTD_RTCHR);
> +	writel_relaxed(day & 0xff, data->base + RTD_RTCDATE_LOW);
> +	writel_relaxed((day >> 8) & 0x7f, data->base + RTD_RTCDATE_HIGH);
> +
> +	rtd119x_rtc_set_enabled(dev, true);
> +
> +	return 0;
> +}
> +
> +static int rtd119x_rtc_open(struct device *dev)
> +{
> +	struct rtd119x_rtc *data = dev_get_drvdata(dev);
> +	u32 val;
> +	int ret;
> +
> +	ret = clk_prepare_enable(data->clk);
> +	if (ret)
> +		return ret;
> +
> +	val = readl_relaxed(data->base + RTD_RTCACR);
> +	dev_info(dev, "rtcacr = 0x%08x\n", val);
> +	if (!(val & BIT(7))) {
> +	}

I don't see the point of reading that register, and not doing anything
with it.

> +
> +	rtd119x_rtc_set_enabled(dev, true);
> +

This is certainly not what you want. The RTC device is usually not
opened so enabling the RTC when open and disabling it when closed will
not work on most systems. This is probably true for the clock too. i.e
what you do here should be done in probe.

> +	return 0;
> +}
> +
> +static void rtd119x_rtc_release(struct device *dev)
> +{
> +	struct rtd119x_rtc *data = dev_get_drvdata(dev);
> +
> +	rtd119x_rtc_set_enabled(dev, false);
> +
> +	clk_disable_unprepare(data->clk);
> +}
> +
> +static const struct rtc_class_ops rtd119x_rtc_ops = {
> +	.open		= rtd119x_rtc_open,
> +	.release	= rtd119x_rtc_release,
> +	.read_time	= rtd119x_rtc_read_time,
> +	.set_time	= rtd119x_rtc_set_time,
> +};
> +
> +static const struct of_device_id rtd119x_rtc_dt_ids[] = {
> +	 { .compatible = "realtek,rtd1295-rtc" },
> +	 { }
> +};
> +
> +static int rtd119x_rtc_probe(struct platform_device *pdev)
> +{
> +	struct rtd119x_rtc *data;
> +	struct resource *res;
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, data);
> +	data->base_year = 2014;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	data->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(data->base))
> +		return PTR_ERR(data->base);
> +
> +	data->clk = of_clk_get(pdev->dev.of_node, 0);
> +	if (IS_ERR(data->clk))
> +		return PTR_ERR(data->clk);
> +
> +	data->rtcdev = devm_rtc_device_register(&pdev->dev, "rtc",
> +				&rtd119x_rtc_ops, THIS_MODULE);
> +	if (IS_ERR(data->rtcdev)) {
> +		dev_err(&pdev->dev, "failed to register rtc device");
> +		clk_put(data->clk);
> +		return PTR_ERR(data->rtcdev);
> +	}
> +
> +	return 0;
> +}
> +
> +static struct platform_driver rtd119x_rtc_driver = {
> +	.probe = rtd119x_rtc_probe,
> +	.driver = {
> +		.name = "rtd1295-rtc",
> +		.of_match_table	= rtd119x_rtc_dt_ids,
> +	},
> +};
> +builtin_platform_driver(rtd119x_rtc_driver);
> -- 
> 2.12.3
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
