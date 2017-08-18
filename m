From: jeffy.chen@rock-chips.com (jeffy)
Date: Sat, 19 Aug 2017 04:05:01 +0800
Subject: [RFC PATCH v2 1/3] PCI: rockchip: Add support for pcie wake irq
In-Reply-To: <20170818181416.GF6008@atomide.com>
References: <20170817120431.12398-1-jeffy.chen@rock-chips.com>
 <20170817120431.12398-2-jeffy.chen@rock-chips.com>
 <20170818170107.GA119461@google.com> <20170818181416.GF6008@atomide.com>
Message-ID: <5997486D.4040803@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

On 08/19/2017 02:14 AM, Tony Lindgren wrote:
>> static irqreturn_t handle_threaded_wake_irq(int irq, void *_wirq)
>> >{
>> >         struct wake_irq *wirq = _wirq;
>> >         int res;
>> >
>> >         /* Maybe abort suspend? */
>> >         if (irqd_is_wakeup_set(irq_get_irq_data(irq))) {
>> >                 pm_wakeup_event(wirq->dev, 0);
>> >
>> >                 return IRQ_HANDLED; <--- We can return here, with the trigger still asserted
>> >         }
>> >...
>> >
>> >This could cause some kind of an IRQ storm, including a lockup or
>> >significant slowdown, I think.
> Hmm yeah that should be checked. The test cases I have are all
> edge interrupts where there is no status whatsoever after the
> wake-up event except which irq fired.
>
> To me it seems that the wakeirq consumer driver should be able
> to clear the level wakeirq in it's runtime_resume, or even better,
> maybe all it takes is just let the consumer driver's irq handler
> clear the level wakeirq when it runs after runtime_resume.
>

i did some tests about it:
[   70.335883] device_wakeup_arm_wake_irqs <-- enable wake irq
[   70.335932] handle_threaded_wake_irq
...<--- a lot of wake irq handler log
[   70.335965] suspend_device_irq
[   70.335987] irq_pm_check_wakeup <--- wake and disable wake irq
...<--- no wake irq handler log
[   70.336173] resume_irqs <-- enable wake irq
[   70.336480] handle_threaded_wake_irq
...<--- a lot of wake irq handler log
[   70.336600] device_wakeup_disarm_wake_irqs < disable wake irq
...<--- no wake irq handler log


so it would indeed possible to get irq storm in 
device_wakeup_arm_wake_irqs to suspend_device_irq
and resume_irqs to device_wakeup_disarm_wake_irqs.


a simple workaround would be:
enable_irq_wake
suspend_device_irq
enable_irq
...irq fired, irq_pm_check_wakeup disabled irq
disable_irq
resume_irqs
disable_irq_wake




and i have a hacky patch for that, which works well:

+++ b/drivers/pci/host/pcie-rockchip.c
@@ -1308,6 +1308,8 @@ static int __maybe_unused 
rockchip_pcie_suspend_noirq(struct
device *dev)
         if (!IS_ERR(rockchip->vpcie0v9))
                 regulator_disable(rockchip->vpcie0v9);

+       dev_pm_enable_wake_irq(dev);
+
         return ret;
  }

@@ -1316,6 +1318,8 @@ static int __maybe_unused 
rockchip_pcie_resume_noirq(struct d
evice *dev)
         struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
         int err;

+       dev_pm_disable_wake_irq(dev);
+


@ -323,7 +324,7 @@ void dev_pm_arm_wake_irq(struct wake_irq *wirq)
                 return;

         if (device_may_wakeup(wirq->dev)) {
-               if (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED)
+               if (0 && wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED)
                         enable_irq(wirq->irq);

                 enable_irq_wake(wirq->irq);
@@ -345,7 +346,7 @@ void dev_pm_disarm_wake_irq(struct wake_irq *wirq)
         if (device_may_wakeup(wirq->dev)) {
                 disable_irq_wake(wirq->irq);

-               if (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED)
+               if (0 && wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED)
                         disable_irq_nosync(wirq->irq);
         }



which is basically move enable_irq and disable_irq to driver noirq 
stages, to avoid:
1/ not disabled by irq_pm_check_wakeup when it first fired
2/ re-enabled by resume_irq when it disabled by irq_pm_check_wakeup


with that hack, i no longer saw the irq storm, and the irq handler would 
never be called:

[    9.693385] device_wakeup_arm_wake_irqs
[    9.697130] suspend_device_irq
<--- suspend noirq, enable wake irq
[    9.716569] irq_pm_check_wakeup disable the wake irq
<--- resume noirq, disable wake irq
[    9.968115] resume_irqs <-- enable wake irq(not actually enable, 
since disabled twice)
[   10.193072] device_wakeup_disarm_wake_irqs
