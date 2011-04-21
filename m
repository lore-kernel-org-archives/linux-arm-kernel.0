From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 21 Apr 2011 19:28:09 +0200 (CEST)
Subject: arm: msm: Convert irq-vic to generic irq chip
In-Reply-To: <4DB0611D.6040902@codeaurora.org>
References: <20110416211221.853079766@linutronix.de>
	<20110416211308.455390167@linutronix.de>
	<4DB0611D.6040902@codeaurora.org>
Message-ID: <alpine.LFD.2.02.1104211926550.3323@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Apr 2011, Abhijeet Dharmapurikar wrote:
> On 04/16/2011 02:14 PM, Thomas Gleixner wrote:
> However, let me explain that SMSM arrays are. MSM has a different interrupt
> controller that monitors few of the lines that the VIC does.
> This parallel interrupt controller is activated when the MSM goes to low
> power modes.
> 
> For idle case, if an interrupt not monitored by the parallel interrupt
> controller is enabled, we avoid going to low power modes. It is unreasonable
> to check all the shadow registers to find if such is the case, so we maintain
> the unmask status of such interrupts in
> static uint32_t msm_irq_idle_disable[VIC_NUM_REGS]. If any bit is set we dont
> go to low power mode. This code is not upstreamed yet, I can submit it on top
> of this patch.
> 
> The reason for explaining this is to ask if we should extend the generic chip
> to have a function that returns if any interrupts besides the wakeup ones are
> unmasked. It would return
> 
> mask_cache & ~wakeup_active  if mask_cache bit set means interrupt is unmasked
> ~mask_cache & ~wakeup_active if mask_cache bit set means interrupts is masked
> 
> or you would prefer the driver do that check?

That wants to be a function in the core as I assume that there are
similar usecases in tree.

Another question is whether you could move to the arm/common/vic.c
implementation completely.

Thanks,

	tglx
