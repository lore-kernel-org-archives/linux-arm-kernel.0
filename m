From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 31 Oct 2012 11:13:03 -0600
Subject: [PATCH v2 3/5] irqchip: Move ARM GIC to drivers/irqchip
In-Reply-To: <509146B8.2000305@gmail.com>
References: <1351695517-5636-1-git-send-email-robherring2@gmail.com>
 <1351695517-5636-4-git-send-email-robherring2@gmail.com>
 <20121031150954.GN21164@n2100.arm.linux.org.uk> <509146B8.2000305@gmail.com>
Message-ID: <50915C1F.3050502@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/31/2012 09:41 AM, Rob Herring wrote:
> On 10/31/2012 10:09 AM, Russell King - ARM Linux wrote:
>> On Wed, Oct 31, 2012 at 09:58:35AM -0500, Rob Herring wrote:
>>> From: Rob Herring <rob.herring@calxeda.com>
>>>
>>> Now that we have drivers/irqchip, move GIC irqchip to drivers/irqchip. This
>>> is necessary to share the GIC with arm and arm64.
>>>
>>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>>> Cc: Russell King <linux@arm.linux.org.uk>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> ---
>>>  arch/arm/common/Kconfig                            |    8 --------
>>>  arch/arm/common/Makefile                           |    1 -
>>>  drivers/irqchip/Kconfig                            |    8 ++++++++
>>>  drivers/irqchip/Makefile                           |    1 +
>>>  arch/arm/common/gic.c => drivers/irqchip/irq-gic.c |    0
>>>  drivers/irqchip/irqchip.c                          |   10 ++++++++++
>>>  drivers/irqchip/irqchip.h                          |    1 +
>>>  7 files changed, 20 insertions(+), 9 deletions(-)
>>>  rename arch/arm/common/gic.c => drivers/irqchip/irq-gic.c (100%)
>>
>> What about its dependent arch/arm/include/asm/hardware/gic.h header,
>> which I believe after patch 1 becomes just a bunch of function calls,
>> and so no longer has any right to be in asm/hardware.
>>
>> Nothing should be moved out of arch/arm without its associated header
>> file also moving with it.
> 
> What is left is only used within arch/arm and I expect we will get rid
> of the remaining users. So I didn't want to encourage any additional
> users by moving to include/linux.
> 
> gic_secondary_init and gic_cascade_irq could be function ptrs.
> gic_of_init can be removed once users are converted to call irqchip_init
> instead. That leaves gic_init which are all the non-DT converted GIC
> users and will take some time to convert. I am puzzled by tegra and zynq
> which should be DT only already.

I imagine you're talking about:

        /*
         * Check if there is a devicetree present, since the GIC will be
         * initialized elsewhere under DT.
         */
        if (!of_have_populated_dt())
                gic_init(0, 29, distbase,
                        IO_ADDRESS(TEGRA_ARM_PERIF_BASE + 0x100));

This is probably legacy code from when we weren't DT only, and I imagine
can simply be removed. There are probably other pieces of code we can go
through and remove now.
