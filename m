From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 16 Aug 2016 17:48:36 +0100
Subject: [PATCH 1/1] irqchip: irq-gic: forward SGI to itself for cortex-a7
 single core
In-Reply-To: <CAOMZO5AB1u3+pL1kgxwF1zNH5MSxEd-BrT=3dzwUTxBd0R4Vsw@mail.gmail.com>
References: <20160808105026.GA12649@leverpostej>
 <HE1PR04MB1450C6BE844A31C95CEE3BE18B1B0@HE1PR04MB1450.eurprd04.prod.outlook.com>
 <20160808130754.GB12649@leverpostej> <20160808132847.GB17680@shlinux2>
 <20160808134842.GE12649@leverpostej> <20160808145916.0924e868@arm.com>
 <20160809034613.GB31105@shlinux2> <20160809063401.3117dc94@arm.com>
 <20160809055701.GC31105@shlinux2> <20160809075930.529f98ca@arm.com>
 <20160809071821.GD31105@shlinux2> <57A99A4A.6010301@arm.com>
 <CAOMZO5AB1u3+pL1kgxwF1zNH5MSxEd-BrT=3dzwUTxBd0R4Vsw@mail.gmail.com>
Message-ID: <57B343E4.6090604@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/08/16 17:29, Fabio Estevam wrote:
> Hi Marc,
> 
> On Tue, Aug 9, 2016 at 5:54 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> 
>> From 23ba8b645d219e333a10224d74fb5d8d75d67de2 Mon Sep 17 00:00:00 2001
>> From: Marc Zyngier <marc.zyngier@arm.com>
>> Date: Tue, 9 Aug 2016 07:50:44 +0100
>> Subject: [PATCH] irqchip/gic: Allow self-SGIs for SMP on UP configurations
>>
>> On systems where a single CPU is present, the GIC may not support
>> having SGIs delivered to a target list. In that case, we use the
>> self-SGI mechanism to allow the interrupt to be delivered locally.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  drivers/irqchip/irq-gic.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
>> index c2cab57..390fac5 100644
>> --- a/drivers/irqchip/irq-gic.c
>> +++ b/drivers/irqchip/irq-gic.c
>> @@ -769,6 +769,13 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>>         int cpu;
>>         unsigned long flags, map = 0;
>>
>> +       if (unlikely(nr_cpu_ids == 1)) {
>> +               /* Only one CPU? let's do a self-IPI... */
>> +               writel_relaxed(2 << 24 | irq,
>> +                              gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
>> +               return;
>> +       }
>> +
>>         raw_spin_lock_irqsave(&irq_controller_lock, flags);
> 
> With this patch applied 'reboot' command works fine, but now after
> going into suspend mode, it reboots automatically.
> 
> # echo mem > /sys/power/state
> [  285.299792] PM: Syncing filesystems ... done.
> [  285.397549] Freezing user space processes ... (elapsed 0.007 seconds) done.
> [  285.412868] Double checking all user space processes after OOM
> killer disable... (elapsed 0.000 seconds)
> [  285.423597] Freezing remaining freezable tasks ... (elapsed 0.008
> seconds) done.
> [  285.523882] PM: suspend of devices complete after 78.037 msecs
> [  285.529926] PM: suspend devices took 0.090 seconds
> [  285.542638] PM: late suspend of devices complete after 7.799 msecs
> [  285.557131] PM: noirq suspend of devices complete after 8.105 msecs
> [  285.563589] Disabling non-boot CPUs ...
> 
> 
> U-Boot 2016.07 (Aug 02 2016 - 17:50:40 -0300)
> 
> CPU:   Freescale i.MX6UL rev1.0 at 396 MHz
> Reset cause: POR
> Board: PICO-IMX6UL-EMMC
> DRAM:  256 MiB
> MMC:   FSL_SDHC: 0
> In:    serial
> Out:   serial
> Err:   serial
> Net:   CPU Net Initialization Failed
> No ethernet found.
> Hit any key to stop autoboot:  0
> 

Maybe because you now have a pending interrupt that you don't handle,
making your WFI exit immediately? Sorry, but without more information,
it is pretty hard to guess what's happening.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
