From: gbean@codeaurora.org (Gregory Bean)
Date: Thu, 18 Nov 2010 11:20:28 -0800 (PST)
Subject: [PATCH v3 2/2] msm: gpio: Add irq support to v2 gpiolib.
In-Reply-To: <20101118111527.GD11700@codeaurora.org>
References: <1289943516-11367-1-git-send-email-gbean@codeaurora.org>
	<1289943516-11367-2-git-send-email-gbean@codeaurora.org>
	<20101118111527.GD11700@codeaurora.org>
Message-ID: <alpine.DEB.2.00.1011181115220.9788@gbean-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> +	spin_lock_irqsave(&tlmm_lock, irq_flags);
>> +	for_each_set_bit(i, msm_gpio.enabled_irqs, NR_GPIO_IRQS) {
>> +		if (!test_bit(i, msm_gpio.wake_irqs))
>> +			writel(TARGET_PROC_NONE, GPIO_INTR_CFG_SU(i));
>> +	}
> If none of the enabled irqs is configured as a wakeup source, should not we
> disable the summary IRQ?

I do not believe there is a need.  If no irqs are wakeup sources, then
the summary irq is also not a wakeup source, see msm_gpio_irq_set_wake().
And if the GIC will mask the TLMM block appropriately during system PM
without further bit-twiddling from me, why complicate my PM hooks further?

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
