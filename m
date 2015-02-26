From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 26 Feb 2015 11:52:52 +0100
Subject: [PATCH] irqchip: armada: Fix chained per-cpu interrupts
In-Reply-To: <20150226104710.GB29241@lukather>
References: <1424944527-16850-1-git-send-email-maxime.ripard@free-electrons.com>
 <54EEF4D4.7060102@free-electrons.com> <20150226104710.GB29241@lukather>
Message-ID: <54EEFB04.8020200@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

n 26/02/2015 11:47, Maxime Ripard wrote:
> Hi,
> 
> On Thu, Feb 26, 2015 at 11:26:28AM +0100, Gregory CLEMENT wrote:
>> Hi Maxime,
>>
>> On 26/02/2015 10:55, Maxime Ripard wrote:
>>> On the Cortex-A9-based Armada SoCs, the MPIC is not the primary interrupt
>>> controller. Yet, it still has to handle some per-cpu interrupt.
>>>
>>> To do so, it is chained with the GIC using a per-cpu interrupt. However, the
>>> current code only call irq_set_chained_handler, which is called and enable that
>>> interrupt only on the boot CPU, which means that the parent per-CPU interrupt
>>> is never unmasked on the secondary CPUs, preventing the per-CPU interrupt to
>>> actually work as expected.
>>>
>>> This was not seen until now since the only MPIC PPI users were the Marvell
>>> timers that were not working, but not used either since the system use the ARM
>>> TWD by default, and the ethernet controllers, that are faking there interrupts
>>> as SPI, and don't really expect to have interrupts on the secondary cores
>>> anyway.
>>>
>>> Add a CPU notifier that will enable the PPI on the secondary cores when they
>>> are brought up.
>>>
>>> Cc: <stable@kernel.org> # 3.15+
>>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>>> ---
>>>  drivers/irqchip/irq-armada-370-xp.c | 21 ++++++++++++++++++++-
>>>  1 file changed, 20 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
>>> index 463c235acbdc..137ee37a33ed 100644
>>> --- a/drivers/irqchip/irq-armada-370-xp.c
>>> +++ b/drivers/irqchip/irq-armada-370-xp.c
>>> @@ -69,6 +69,7 @@ static void __iomem *per_cpu_int_base;
>>>  static void __iomem *main_int_base;
>>>  static struct irq_domain *armada_370_xp_mpic_domain;
>>>  static u32 doorbell_mask_reg;
>>> +static int parent_irq;
>>>  #ifdef CONFIG_PCI_MSI
>>>  static struct irq_domain *armada_370_xp_msi_domain;
>>>  static DECLARE_BITMAP(msi_used, PCI_MSI_DOORBELL_NR);
>>> @@ -356,6 +357,7 @@ static int armada_xp_mpic_secondary_init(struct notifier_block *nfb,
>>>  {
>>>  	if (action == CPU_STARTING || action == CPU_STARTING_FROZEN)
>>>  		armada_xp_mpic_smp_cpu_init();
>>> +
>>>  	return NOTIFY_OK;
>>>  }
>>>  
>>> @@ -364,6 +366,20 @@ static struct notifier_block armada_370_xp_mpic_cpu_notifier = {
>>>  	.priority = 100,
>>>  };
>>>  
>> The following function is called as soon as the MPIC is used as a secondary
>> interrupt controller. So it will be the case for the Armada 375 and Armada 39x too. It
>> also seems to not be related to be used in an SoC or an other, so I think that the
>> function name is misleading. What about just using mpic_secondary_init and
>> mpic_cpu_notifier ?
>>
>> I know we prefixed the mpic function with armada_370_xp or armada_xp, but looking
>> back, it was a mistake.
> 
> I don't know, that code needs to be run only in the cases where the
> MPIC is a secondary interrupt controller, which rules out the armada
> 370/XP.
> 
> I was trying to make such a distinction, but indeed the wording is
> quite poor.
> 
> Do you have some suggestions?

Yes using  mpic_secondary_init and  mpic_cpu_notifier, because what is important
is the fact that the MPIC is used as a secondary interrupt controller.


Thanks,

Gregory


> 
> Maxime
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
