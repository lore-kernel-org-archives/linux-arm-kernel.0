From: robherring2@gmail.com (Rob Herring)
Date: Tue, 13 Sep 2011 10:33:26 -0500
Subject: [PATCH] ARM: CSR: call l2x0_of_init to init L2 cache of
	SiRFprimaII
In-Reply-To: <CAGsJ_4xtHsKpLqS81maGS5g=RHW+Paa09wKNVx3qEvxjCc8-Pw@mail.gmail.com>
References: <1315905006-21390-1-git-send-email-Baohua.Song@csr.com>
	<4E6F61BF.8000907@gmail.com>
	<CAGsJ_4xtHsKpLqS81maGS5g=RHW+Paa09wKNVx3qEvxjCc8-Pw@mail.gmail.com>
Message-ID: <4E6F77C6.8040409@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2011 09:43 AM, Barry Song wrote:
> 2011/9/13 Rob Herring <robherring2@gmail.com>:
>> On 09/13/2011 04:10 AM, Barry Song wrote:
>>> Cc: Rob Herring <robherring2@gmail.com>
>>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>>> ---
>>>
>>> This patch depends on:
>>> [1]Rob Herring
>>> ARM: 7009/1: l2x0: Add OF based initialization
>>> http://www.spinics.net/lists/arm-kernel/msg131123.html
>>> it has been in rmk/for-next
>>>
>>> [2]Barry Song
>>> ARM: CACHE-L2X0: filter start address can be 0 and is often 0
>>> http://www.spinics.net/lists/arm-kernel/msg140126.html
>>> this patch fixes the filter start address error of Rob Herring'patch
>>>
>>>  arch/arm/mach-prima2/l2x0.c |   48 ++----------------------------------------
>>>  1 files changed, 3 insertions(+), 45 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-prima2/l2x0.c b/arch/arm/mach-prima2/l2x0.c
>>> index 9cda205..5587958 100644
>>> --- a/arch/arm/mach-prima2/l2x0.c
>>> +++ b/arch/arm/mach-prima2/l2x0.c
>>> @@ -8,52 +8,10 @@
>>>
>>>  #include <linux/init.h>
>>>  #include <linux/kernel.h>
>>> -#include <linux/io.h>
>>> -#include <linux/errno.h>
>>> -#include <linux/of.h>
>>> -#include <linux/of_address.h>
>>>  #include <asm/hardware/cache-l2x0.h>
>>> -#include <mach/memory.h>
>>>
>>> -#define L2X0_ADDR_FILTERING_START       0xC00
>>> -#define L2X0_ADDR_FILTERING_END         0xC04
>>> -
>>> -static struct of_device_id l2x_ids[]  = {
>>> -     { .compatible = "arm,pl310-cache" },
>>> -};
>>> -
>>> -static int __init sirfsoc_of_l2x_init(void)
>>> +static int __init sirfsoc_l2x0_init(void)
>>>  {
>>> -     struct device_node *np;
>>> -     void __iomem *sirfsoc_l2x_base;
>>> -
>>> -     np = of_find_matching_node(NULL, l2x_ids);
>>> -     if (!np)
>>> -             panic("unable to find compatible l2x node in dtb\n");
>>> -
>>> -     sirfsoc_l2x_base = of_iomap(np, 0);
>>> -     if (!sirfsoc_l2x_base)
>>> -             panic("unable to map l2x cpu registers\n");
>>> -
>>> -     of_node_put(np);
>>> -
>>> -     if (!(readl_relaxed(sirfsoc_l2x_base + L2X0_CTRL) & 1)) {
>>> -             /*
>>> -              * set the physical memory windows L2 cache will cover
>>> -              */
>>> -             writel_relaxed(PLAT_PHYS_OFFSET + 1024 * 1024 * 1024,
>>> -                     sirfsoc_l2x_base + L2X0_ADDR_FILTERING_END);
>>> -             writel_relaxed(PLAT_PHYS_OFFSET | 0x1,
>>> -                     sirfsoc_l2x_base + L2X0_ADDR_FILTERING_START);
>>> -
>>> -             writel_relaxed(0,
>>> -                     sirfsoc_l2x_base + L2X0_TAG_LATENCY_CTRL);
>>> -             writel_relaxed(0,
>>> -                     sirfsoc_l2x_base + L2X0_DATA_LATENCY_CTRL);
>>> -     }
>>> -     l2x0_init((void __iomem *)sirfsoc_l2x_base, 0x00040000,
>>> -             0x00000000);
>>> -
>>> -     return 0;
>>> +     return l2x0_of_init(0x40000, 0);
>>>  }
>>> -early_initcall(sirfsoc_of_l2x_init);
>>> +early_initcall(sirfsoc_l2x0_init);
>>
>> This needs to be called from a prima2 function that is only run for this
>> platform rather than an initcall. This will run all platforms in a
>> single kernel build. However, the that's not really a new problem with
>> this patch, so you could fix in a follow-on patch.
> 
> then it is difficult to find a place to call it. this function needs
> to be called after mm_init since l2x0_of_init needs of_iomap, irq init
> is the thing closely following mm_init, but it is strange to call it
> in .init_irq.  .init_machine looks ok, but it is much later than
> early_initcall but we want to enable l2 as early as possible.
> 
> before sending this patch, i thought much. an early_initcall seems to
> be better since it is early and not embedded into function like
> .init_irq.
> 
> which function did you intend to call l2x0_of_init while you sent your
> original patch?

I have it in init_irq as I need the outer flush to work for SMP init.
init_machine may be okay as well, but as early as possible is probably
best. It depends if you are turning on the L2 or it is already on when
you boot.

You could also just check your machine compatible string in this
function, but calling it from a machine specific function is a cleaner
solution.

Rob
