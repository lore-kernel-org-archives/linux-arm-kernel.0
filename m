From: will.deacon@arm.com (Will Deacon)
Date: Wed, 20 Nov 2013 18:00:12 +0000
Subject: [PATCH V4 2/2] arm64: perf: add support for percpu pmu interrupt
In-Reply-To: <CAPrCYkcu7wVjoV5Q=pd55Zn8+PR30n3WJ8F6t=qV4BMLhZFcxA@mail.gmail.com>
References: <1384946021-22100-1-git-send-email-vkale@apm.com>
 <1384946021-22100-3-git-send-email-vkale@apm.com>
 <528CB5AC.5080007@arm.com>
 <CAPrCYkcu7wVjoV5Q=pd55Zn8+PR30n3WJ8F6t=qV4BMLhZFcxA@mail.gmail.com>
Message-ID: <20131120180012.GJ19352@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 20, 2013 at 05:28:50PM +0000, Vinayak Kale wrote:
> In Will's existing code, I think he was taking care of 'no IRQ' case
> by comparing pmu_device->num_resources. Do you think this is not
> enough and we must enforce the check after each platform_get_irq()?
> Existing driver code snippet as below for quick reference.
> 
> [snip]
> static int
> armpmu_reserve_hardware(struct arm_pmu *armpmu)
> {
>         int i, err, irq, irqs;
>         struct platform_device *pmu_device = armpmu->plat_device;
> 
>         if (!pmu_device) {
>                 pr_err("no PMU device registered\n");
>                 return -ENODEV;
>         }
> 
>         irqs = min(pmu_device->num_resources, num_possible_cpus());
>         if (irqs < 1) {
>                 pr_err("no irqs for PMUs defined\n");
>                 return -ENODEV;
>         }

This bit is fine.

>         for (i = 0; i < irqs; ++i) {
>                 err = 0;
>                 irq = platform_get_irq(pmu_device, i);
>                 if (irq < 0)
>                          continue;

This is a bug, which you can fix in your patch. IRQ0 isn't valid.

Will
