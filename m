From: anjiandi@codeaurora.org (Jiandi An)
Date: Wed, 16 Aug 2017 13:10:12 -0500
Subject: [PATCH 2/3] [v3] pinctrl: qcom: disable GPIO groups with no pins
In-Reply-To: <d0b16753-b202-5756-1cba-1cd083af52ed@codeaurora.org>
References: <1501179565-26466-1-git-send-email-timur@codeaurora.org>
 <1501179565-26466-3-git-send-email-timur@codeaurora.org>
 <CACRpkdZj+tnMcEpic6PrQS-qMJDodmc_uFJVudxc=USCTXpyKg@mail.gmail.com>
 <d0b16753-b202-5756-1cba-1cd083af52ed@codeaurora.org>
Message-ID: <7c278367-bf3b-6a26-e31f-ee696cb5534e@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During a kexec shutdown, machine_kexec_mask_interrupts() will attempt
to disable all IRQs that are registered.  If gpio is not available,
don't register IRQs and it won't be in the irq_desc list it walks through.

If gpio is unavailable, perhaps a more correct fix that covers more is 
to not calling gpiochip_irqchip_add() to register msm_gpio_irq_chip in 
msm_gpio_init().

When registering interrupt for msm_qpio_irq_chip the following are 
registered, not just irq_mask and irq_unmask.

static struct irq_chip msm_gpio_irq_chip = {
	.name           = "msmgpio",
	.irq_mask       = msm_gpio_irq_mask,
	.irq_unmask     = msm_gpio_irq_unmask,
	.irq_ack        = msm_gpio_irq_ack,
	.irq_set_type   = msm_gpio_irq_set_type,
	.irq_set_wake   = msm_gpio_irq_set_wake,
};

Technically the same check added in msm_gpio_irq_mask() and 
msm_gpio_irq_unmask() should be added in msm_gpio_irq_ack(), 
msm_gpio_irq_set_type(), and msm_gpio_irq_set_wake() if it's registered 
with irq domain.

To cover more bases, the more correct way is to not register interrupt 
with irq domain at all if gpio is unavailable.


On 08/09/2017 02:02 PM, Timur Tabi wrote:
> On 07/31/2017 08:36 AM, Linus Walleij wrote:
>>> To support sparse GPIO maps, pinctrl-msm client drivers can specify
>>> that a given GPIO has a pin count of zero.  These GPIOs will be
>>> considered "hidden".  Any attempt to claim the GPIO will fail, and they
>>> will not be listed in debugfs.
>>>
>>> During a kexec shutdown, machine_kexec_mask_interrupts() will attempt
>>> to disable all IRQs, even those that aren't enabled.  This includes
>>> GPIOs that are unavailable (npins == 0), so add a check to the irq mask
>>> and unmask functions.
>>>
>>> Signed-off-by: Timur Tabi<timur@codeaurora.org>
>
>> I'm waiting for Bj?rn's review of the two remaining patches.
>
> Bj?rn, do you have time to review these patches?  I'm hoping to get them
> into 4.14.
>

-- 
Jiandi An
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
Linux Foundation Collaborative Project.
