From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 7 Aug 2017 11:04:30 +0200
Subject: [PATCH 3/3] irqchip: bcm2836: Move SMP startup code to arch/arm
In-Reply-To: <143fe51b-50d8-ef6d-2946-47a675f0337e@raspberrypi.org>
References: <1502058731-12462-1-git-send-email-stefan.wahren@i2se.com>
 <1502058731-12462-4-git-send-email-stefan.wahren@i2se.com>
 <143fe51b-50d8-ef6d-2946-47a675f0337e@raspberrypi.org>
Message-ID: <a4e7f1f9-3bf9-11ec-1e6e-da1830685122@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 07.08.2017 um 09:47 schrieb Phil Elwell:
> Hi Stefan,
>
> On 06/08/2017 23:32, Stefan Wahren wrote:
>> In order to easily provide SMP for BCM2837 on 32-bit and 64-bit
>> the SMP startup code was placed in irq-bcm2836. That's not the
>> right approach. So move this code where it belongs.
>>
>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>> Fixes: 41f4988cc287 ("irqchip/bcm2836: Add SMP support for the 2836")
>> ---
>>  arch/arm/mach-bcm/Makefile          |  3 ++
>>  arch/arm/mach-bcm/platsmp.c         | 35 ++++++++++++++++
>>  drivers/irqchip/irq-bcm2836.c       | 79 +------------------------------------
>>  include/linux/irqchip/irq-bcm2836.h | 70 ++++++++++++++++++++++++++++++++
>>  4 files changed, 110 insertions(+), 77 deletions(-)
>>  create mode 100644 include/linux/irqchip/irq-bcm2836.h
>>
>> diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
>> index 980f585..637cd9e 100644
>> --- a/arch/arm/mach-bcm/Makefile
>> +++ b/arch/arm/mach-bcm/Makefile
>> @@ -43,6 +43,9 @@ endif
>>  
>>  # BCM2835
>>  obj-$(CONFIG_ARCH_BCM2835)	+= board_bcm2835.o
>> +ifeq ($(CONFIG_ARCH_BCM2835),y)
>> +obj-$(CONFIG_SMP)		+= platsmp.o
>> +endif
>>  
>>  # BCM5301X
>>  obj-$(CONFIG_ARCH_BCM_5301X)	+= bcm_5301x.o
>> diff --git a/arch/arm/mach-bcm/platsmp.c b/arch/arm/mach-bcm/platsmp.c
>> index 9e3f275..3fa1a99 100644
>> --- a/arch/arm/mach-bcm/platsmp.c
>> +++ b/arch/arm/mach-bcm/platsmp.c
>> @@ -17,6 +17,7 @@
>>  #include <linux/errno.h>
>>  #include <linux/init.h>
>>  #include <linux/io.h>
>> +#include <linux/irqchip/irq-bcm2836.h>
>>  #include <linux/jiffies.h>
>>  #include <linux/of.h>
>>  #include <linux/of_address.h>
>> @@ -287,6 +288,35 @@ static int nsp_boot_secondary(unsigned int cpu, struct task_struct *idle)
>>  	return ret;
>>  }
>>  
>> +static int bcm2836_boot_secondary(unsigned int cpu, struct task_struct *idle)
>> +{
>> +	void __iomem *intc_base;
>> +	struct device_node *dn;
>> +	char *name;
>> +
>> +	name = "brcm,bcm2836-l1-intc";
>> +	dn = of_find_compatible_node(NULL, NULL, name);
>> +	if (!dn) {
>> +		pr_err("unable to find intc node\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	intc_base = of_iomap(dn, 0);
>> +	of_node_put(dn);
>> +
>> +	if (!intc_base) {
>> +		pr_err("unable to remap intc base register\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	writel(virt_to_phys(secondary_startup),
>> +	       intc_base + LOCAL_MAILBOX3_SET0 + 16 * cpu);
> I was going to upstream the patch to add dsb+sev today, but now the goalposts are
> (literally) moving. Should I produce two patchsets - one for before your patch is
> appied, and one for after - or will you add the required lines here?:
>  
> +       dsb(sy); /* Ensure write has completed before waking the other CPUs */
> +       sev();
> +

Since Marc make it clear that he won't accept any patches before this
cleanup, please base your patch on top of this repo:

https://github.com/anholt/linux/commits/bcm2835-soc-smp-cleanup

Btw Eric reported problems [1] about this change, is this fixed now?

[1] -
https://github.com/raspberrypi/linux/issues/1989#issuecomment-318180597
