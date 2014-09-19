From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 18 Sep 2014 20:41:43 -0700
Subject: [PATCH 1/3] watchdog: qcom: add support for KPSS WDT
In-Reply-To: <20140919032416.GE3749@joshc.qualcomm.com>
References: <cover.1411078425.git.joshc@codeaurora.org>
 <32d17907ad1dfdcafe4e76f33adc2ff22631cd28.1411078425.git.joshc@codeaurora.org>
 <541B97CD.60400@roeck-us.net> <20140919032416.GE3749@joshc.qualcomm.com>
Message-ID: <541BA5F7.1030704@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2014 08:24 PM, Josh Cartwright wrote:
> On Thu, Sep 18, 2014 at 07:41:17PM -0700, Guenter Roeck wrote:
>> On 09/18/2014 03:26 PM, Josh Cartwright wrote:
>>> Add a driver for the watchdog timer block found in the Krait Processor
>>> Subsystem (KPSS) on the MSM8960, APQ8064, and IPQ8064.
>>>
>>> Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
>>
>> Hi Josh,
>>
>> comments inline.
>
> Thanks for taking a look!
>
> [..]
>>> +static int qcom_watchdog_probe(struct platform_device *pdev)
>>> +{
>>> +	struct qcom_wdt *wdt;
>>> +	struct resource *res;
>>> +	u32 tmp;
>>> +	int ret;
>>> +
>>> +	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
>>> +	if (!wdt)
>>> +		return -ENOMEM;
>>> +
>>> +	platform_set_drvdata(pdev, wdt);
>>> +
>>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +	wdt->base = devm_ioremap_resource(&pdev->dev, res);
>>> +	if (IS_ERR(wdt->base))
>>> +		return PTR_ERR(wdt->base);
>>> +
>>> +	ret = of_property_read_u32(pdev->dev.of_node, "clock-frequency", &tmp);
>>> +	if (ret) {
>>> +		dev_err(&pdev->dev, "unable to get clock-frequency\n");
>>> +		return ret;
>>> +	}
>>> +
>>
>> You might want to use a clock property here, and the complete sequence of
>> 	devm_clk_get
>> 	clk_prepare_enable
>> 	clk_disable_unprepare
>> 	clk_get_rate
>
> Agreed.  I think this would be ideal.  I'll need to take a closer look
> at how this thing is clocked, and how/if the clocks are currently
> being modelled.
>

I think you should be able to specify some kind of "fixed" clock.
Other watchdog drivers use the mechanism; maybe you can find some examples.

>>> +	wdt->freq = tmp;
>>> +
>>> +	wdt->wdd.dev = &pdev->dev;
>>> +	wdt->wdd.info = &qcom_wdt_info;
>>> +	wdt->wdd.ops = &qcom_wdt_ops;
>>> +	wdt->wdd.min_timeout = 1;
>>> +	wdt->wdd.max_timeout = 0x10000000U / wdt->freq;
>>
>> As written, wdt->freq can be 0, which results in a nice division by zero here.
>
> Indeed.  I'll add a check.
>
>>> +	watchdog_init_timeout(&wdt->wdd, 0, &pdev->dev);
>>
>> That leaves you with no default timeout if timeout-sec is not set in devicetree,
>> which if I understand the code correctly might result in an immediate reset.
>> Is this really what you want to happen ?
>
> I think I'd like to handle timeout-sec being unspecified as an error at
> probe.  If someone explicitly sets timeout-sec = <0>, then they get what
> they ask for.  I'll take another look to see how to make this happen.
>

Hmm.. kind of unusual. Usual would be to initialize the timeout together
with min_timeout / max_timeout above and only force the user to specify
a value if the default timeout is not desirable. You don't really gain
anything by making timeout-sec mandatory.

>>> +
>>> +	ret = watchdog_register_device(&wdt->wdd);
>>> +	if (ret) {
>>> +		dev_err(&pdev->dev, "failed to register watchdog\n");
>>> +		return ret;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static const struct of_device_id qcom_wdt_of_table[] = {
>>> +	{ .compatible = "qcom,kpss-wdt-msm8960", },
>>> +	{ .compatible = "qcom,kpss-wdt-apq8064", },
>>> +	{ .compatible = "qcom,kpss-wdt-ipq8064", },
>>> +	{ },
>>> +};
>>> +MODULE_DEVICE_TABLE(of, qcom_wdt_of_table);
>>> +
>>> +static struct platform_driver qcom_watchdog_driver = {
>>> +	.probe	= qcom_watchdog_probe,
>>
>> No remove function ?
>>
>> Yes, you don't need it, because the driver can only be built into the kernel,
>> but there is a practical impact: It means the driver must always be built
>> into the kernel even if the image is supposed to be used on different systems,
>> some of which may not support this specific watchdog.
>>
>> Sure, you might say that you don't care about images supporting more than one
>> hardware, but the tendency seems to be multi-target images nowadays.
>
> This was motivated by the addition of the restart_handler bits in patch
> 3.  For some reason I was thinking there were race conditions between
> module unloading/the restart_handler mechanism, but looking at it again,
> I'm not so sure.  Is it safe to implement these handlers in modules?  If
> so, I'll revisit this.
>
Yes, it is safe. To ensure there are no race conditions was one of the reasons
for implementing the restart handler as notifier call chain.

Guenter
