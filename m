From: lina.iyer@linaro.org (Lina Iyer)
Date: Tue, 30 Sep 2014 09:46:32 -0600
Subject: [PATCH v7 5/7] qcom: cpuidle: Add cpuidle driver for QCOM cpus
In-Reply-To: <20140930085849.GA11393@e102568-lin.cambridge.arm.com>
References: <1411779495-39724-1-git-send-email-lina.iyer@linaro.org>
 <1411779495-39724-6-git-send-email-lina.iyer@linaro.org>
 <5429E8D6.6080101@codeaurora.org>
 <20140930085849.GA11393@e102568-lin.cambridge.arm.com>
Message-ID: <20140930154632.GB528@ilina-mac.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30 2014 at 02:58 -0600, Lorenzo Pieralisi wrote:
>On Tue, Sep 30, 2014 at 12:18:46AM +0100, Stephen Boyd wrote:
>> On 09/26/14 17:58, Lina Iyer wrote:
>> > diff --git a/drivers/cpuidle/cpuidle-qcom.c b/drivers/cpuidle/cpuidle-qcom.c
[...]
> > +static int qcom_lpm_enter_wfi(struct cpuidle_device *dev,
>> > +				struct cpuidle_driver *drv, int index)
>> > +{
>> > +	qcom_idle_enter(PM_SLEEP_MODE_WFI);
>>
>> Why can't we just pass index here? It would be nice to not need to
>> include soc/qcom/pm.h in this file.
>
>I think this is definitely worth exploring.
>
Sorry, I explained in the other thread. I feel that we are dispersing
the translation information all over the place in doing so. The reason
being, the compatible flag is not passed over to pm.c and I believe this
is where it should be.

>> > +	return index;
>> > +}
>> > +
>> > +static int qcom_lpm_enter_spc(struct cpuidle_device *dev,
>> > +				struct cpuidle_driver *drv, int index)
>> > +{
>> > +	cpu_pm_enter();
>> > +	qcom_idle_enter(PM_SLEEP_MODE_SPC);
>> > +	cpu_pm_exit();
>> > +
>> > +	return index;
>> > +}
>> > +
>> > +static struct cpuidle_driver qcom_cpuidle_driver = {
>> > +	.name	= "qcom_cpuidle",
>> > +	.owner	= THIS_MODULE,
>> > +};
>> > +
>> > +static const struct of_device_id qcom_idle_state_match[] __initconst = {
>> > +	{ .compatible = "qcom,idle-state-wfi", .data = qcom_lpm_enter_wfi },
>> > +	{ .compatible = "qcom,idle-state-spc", .data = qcom_lpm_enter_spc },
>> > +	{ },
>> > +};
This is the onward translation from QCOM's idle states to cpuidle's
states and passing cpuidle index value to SoC layer, opens up
possibility for errors.

>> > +
>> > +static int qcom_cpuidle_probe(struct platform_device *pdev)
>> > +{
>> > +	struct cpuidle_driver *drv = &qcom_cpuidle_driver;
>> > +	int ret;
>> > +
>> > +	qcom_idle_enter = (void *)(pdev->dev.platform_data);
>> > +	if (!qcom_idle_enter)
>> > +		return -EFAULT;
>>
>> Error code looks a little wrong. -ENODEV?
>>
>> > +
>> > +	 /* Probe for other states including platform WFI */
>> > +	ret = dt_init_idle_driver(drv, qcom_idle_state_match, 0);
>> > +	if (ret <= 0) {
>> > +		pr_err("%s: No cpuidle state found.\n", __func__);
>>
>> This would be true if ret == 0, but if it's < 0 that isn't true. Drop
>> the print?
>
>I think we can safely drop the print, DT parsing code already barfs on
>error. Maybe you want to keep the (ret == 0) case to signal that driver
>was probed but no idle states were found.
>
OK
>> > +		return ret;
>> > +	}
>> > +
>> > +	ret = cpuidle_register(drv, NULL);
>> > +	if (ret) {
>> > +		pr_err("%s: failed to register cpuidle driver\n", __func__);
>>
>> This seems redundant given that cpuidle_register() already prints an
>> error when it fails.
>
>Yes, I will drop it from arm64 driver too as part of a minor clean-up
>when the merge window closes (also other drivers do that, and as you say
>it is redundant).
>
OK
>
