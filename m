From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 3 Nov 2016 16:46:36 +0100
Subject: [RFC PATCH 2/3] rtc: Add Amlogic Virtual Wake RTC
In-Reply-To: <20161103153647.GD25852@remoulade>
References: <1478183365-23708-1-git-send-email-narmstrong@baylibre.com>
 <1478183365-23708-3-git-send-email-narmstrong@baylibre.com>
 <20161103153647.GD25852@remoulade>
Message-ID: <77aab6f0-e6a4-f0e2-2c08-7c545e8c07af@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/03/2016 04:36 PM, Mark Rutland wrote:
> On Thu, Nov 03, 2016 at 03:29:24PM +0100, Neil Armstrong wrote:
>> The Amlogic Meson GX SoCs uses a special register to store the
>> time in seconds to wakeup after a system suspend.
> 
> Where does this register live, exactly? What IP block is it part of?

It's part of the Always-ON APB registers, there is no clear IP block here,
but it seems to be like a scratch register shared with the BL3 FW.

> 
>> In order to be able to reuse the RTC wakealarm feature, this
>> driver implements a fake RTC device which uses the system time
>> to deduce a suspend delay.
> 
> This sounds like an always-on oneshot timer device, not an RTC.

The register seems to never change, and it seems to be an indication for the
FW when it enters the suspend mode.

> 
>> +static int meson_vrtc_read_time(struct device *dev, struct rtc_time *tm)
>> +{
>> +	unsigned long local_time;
>> +	struct timeval time;
>> +
>> +	do_gettimeofday(&time);
>> +	local_time = time.tv_sec - (sys_tz.tz_minuteswest * 60);
>> +	rtc_time_to_tm(local_time, tm);
>> +
>> +	return 0;
>> +}
> 
> ... if this were a timer, you wouldn't need this hack.

Actually the vendor tree uses a 64bit running counter to provide this
but with a fixed start date.

> 
>> +static int meson_vrtc_probe(struct platform_device *pdev)
>> +{
>> +	struct meson_vrtc_data *vrtc;
>> +	struct resource *res;
>> +
>> +	vrtc = devm_kzalloc(&pdev->dev, sizeof(*vrtc), GFP_KERNEL);
>> +	if (!vrtc)
>> +		return -ENOMEM;
>> +
>> +	vrtc->pdev = pdev;
>> +
>> +	/* Alarm registers */
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	vrtc->io_alarm = devm_ioremap_resource(&pdev->dev, res);
>> +	if (IS_ERR(vrtc->io_alarm))
>> +		return PTR_ERR(vrtc->io_alarm);
>> +
>> +	device_init_wakeup(&pdev->dev, 1);
>> +
>> +	platform_set_drvdata(pdev, vrtc);
>> +
>> +	vrtc->rtc = devm_rtc_device_register(&pdev->dev, "meson-vrtc",
>> +			&meson_vrtc_ops, THIS_MODULE);
>> +	if (IS_ERR(vrtc->rtc))
>> +		return PTR_ERR(vrtc->rtc);
>> +
>> +	return 0;
>> +}
> 
> I see that no interrupt is described. How exactly does this wake the system
> from suspend? Is there some interrupt managed by FW for this, for example?

It seems to be managed by the BL3 FW. We have no details on the underlying implementation.

> 
>> +static const struct of_device_id meson_vrtc_dt_match[] = {
>> +	{ .compatible = "amlogic,meson-vrtc"},
> 
> There was no binding documentation in this patch series.
> 
> Thanks,
> Mark.
> 
