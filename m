From: lina.iyer@linaro.org (Lina Iyer)
Date: Fri, 15 Aug 2014 15:45:13 -0600
Subject: [PATCH v7 8/8] drivers: cpuidle: initialize Exynos driver
 through DT
In-Reply-To: <20140815214034.GA10552@e102568-lin.cambridge.arm.com>
References: <1407945127-27554-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1407945127-27554-9-git-send-email-lorenzo.pieralisi@arm.com>
 <20140815211233.GA46224@ilina-mac.local>
 <20140815214034.GA10552@e102568-lin.cambridge.arm.com>
Message-ID: <20140815214513.GB46224@ilina-mac.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 15, 2014 at 10:40:34PM +0100, Lorenzo Pieralisi wrote:
>On Fri, Aug 15, 2014 at 10:12:33PM +0100, Lina Iyer wrote:
>
>[...]
>
>> > static int exynos_cpuidle_probe(struct platform_device *pdev)
>> > {
>> >-	int ret;
>> >+	int ret, i;
>> >+	struct cpuidle_driver *drv = &exynos_idle_driver;
>> >
>> > 	exynos_enter_aftr = (void *)(pdev->dev.platform_data);
>> >
>> >-	ret = cpuidle_register(&exynos_idle_driver, NULL);
>> >+	drv->cpumask = kzalloc(cpumask_size(), GFP_KERNEL);
>> >+	if (!drv->cpumask)
>> >+		return -ENOMEM;
>> drv->cpumask would not have any cpu set. I dont see it being modified
>> elsewhere.
>
>Gah, I should have missed that while refactoring, I can just compile test this
>patch so it went unnoticed. Fixed (by copying the possible mask to
>drv->cpumask).
>
>Thank you !
>Lorenzo
Noticed that in the big.little exynos driver  as well.

>
>> >+
>> >+	/* Start at index 1, index 0 standard WFI */
>> >+	ret = dt_init_idle_driver(drv, 1);
>> >+	if (ret < 0) {
>> >+		dev_err(&pdev->dev, "failed to initialize idle states\n");
>> >+		goto free_mem;
>> >+	}
>> >+
>> >+	for (i = 1; i < drv->state_count; i++)
>> >+		drv->states[i].enter = exynos_enter_lowpower;
>> >+
>> >+	ret = cpuidle_register(drv, NULL);
>> > 	if (ret) {
>> > 		dev_err(&pdev->dev, "failed to register cpuidle driver\n");
>> >-		return ret;
>> >+		goto free_mem;
>> > 	}
>> >
>> > 	return 0;
>> >+free_mem:
>> >+	kfree(drv->cpumask);
>> >+	return ret;
>> > }
>> >
>> > static struct platform_driver exynos_cpuidle_driver = {
>> >--
>> >1.9.1
>> >
>> >
>>
>
