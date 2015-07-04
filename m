From: jszhang@marvell.com (Jisheng Zhang)
Date: Sat, 4 Jul 2015 16:50:07 +0800
Subject: [PATCH v2 2/2] irqchip: dw-apb-ictl: add irq_set_affinity support
In-Reply-To: <20150704082623.GA7557@n2100.arm.linux.org.uk>
References: <1435987170-3962-1-git-send-email-jszhang@marvell.com>
 <1435987170-3962-3-git-send-email-jszhang@marvell.com>
 <20150704082623.GA7557@n2100.arm.linux.org.uk>
Message-ID: <20150704165007.45aa9f45@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Russell,

On Sat, 4 Jul 2015 09:26:23 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Sat, Jul 04, 2015 at 01:19:30PM +0800, Jisheng Zhang wrote:
> > On Marvell Berlin SoCs, the cpu's local timer is shutdown when the cpu
> > goes to a deep idle state, then the timer framework will be notified to
> > use a broadcast timer instead. The broadcast timer uses dw-apb-ictl as
> > interrupt chip, this patch adds irq_set_affinity support so that the
> > going to deep idle state cpu can set the interrupt affinity of the
> > broadcast interrupt to avoid unnecessary wakeups and IPIs.
> 
> NAK to this patch.
> 
> The real question is - if CPU0 is the CPU going offline, why is it
> still receiving _any_ interrupts - all interrupts should be migrated
> off it, including the chained interrupts.

I think it's due to broadcast timer interrupt. Let me describe the situation:

1. cpu1 is going offline
2. cpuidle notify timer framework to use a broadcast timer instead due to localtimer
is CLOCK_EVT_FEAT_C3STOP
3. when timer is expired, CPU0 will be waken up by the timer interrupt if it has
gone offline
4. CPU0 sends broadcast timer IPI to CPU1

As can be seen, both cpu0 waken up and the broadcast timer IPI are unnecessary.

This patch tries to improve such situation. Here I copied my simple test result

A simple test:
~ # rm /tmp/test.sh
~ # cat > /tmp/test.sh
cat /proc/interrupts
for i in `seq 10` ; do sleep $i; done
cat /proc/interrupts
~ # chmod +x /tmp/test.sh
~ # taskset 0x2 /tmp/test.sh

without the patch:

           CPU0       CPU1
 27:        115         36       GIC  27  arch_timer
 45:         62          0       GIC  45  mmc0
160:         88          0  interrupt-controller   8  timer
227:          0          0  interrupt-controller   4  f7e81400.i2c
228:          0          0  interrupt-controller   5  f7e81800.i2c
229:          0          0  interrupt-controller   7  dw_spi65535
230:          0          0  interrupt-controller  21  f7e84000.i2c
231:          0          0  interrupt-controller  20  f7e84800.i2c
265:        445          0  interrupt-controller   8  serial
IPI0:          0          0  CPU wakeup interrupts
IPI1:          0         11  Timer broadcast interrupts
IPI2:         56        104  Rescheduling interrupts
IPI3:          0          0  Function call interrupts
IPI4:          0          4  Single function call interrupts
IPI5:          0          0  CPU stop interrupts
IPI6:         25         27  IRQ work interrupts
IPI7:          0          0  completion interrupts
IPI8:          0          0  CPU backtrace
Err:          0
           CPU0       CPU1
 27:        115         38       GIC  27  arch_timer
 45:         62          0       GIC  45  mmc0
160:        160          0  interrupt-controller   8  timer
227:          0          0  interrupt-controller   4  f7e81400.i2c
228:          0          0  interrupt-controller   5  f7e81800.i2c
229:          0          0  interrupt-controller   7  dw_spi65535
230:          0          0  interrupt-controller  21  f7e84000.i2c
231:          0          0  interrupt-controller  20  f7e84800.i2c
265:        514          0  interrupt-controller   8  serial
IPI0:          0          0  CPU wakeup interrupts
IPI1:          0         83  Timer broadcast interrupts
IPI2:         56        104  Rescheduling interrupts
IPI3:          0          0  Function call interrupts
IPI4:          0          4  Single function call interrupts
IPI5:          0          0  CPU stop interrupts
IPI6:         25         46  IRQ work interrupts
IPI7:          0          0  completion interrupts
IPI8:          0          0  CPU backtrace
Err:          0

cpu0 get 160-88=72 timer interrupts, CPU1 got 83-11=72 broadcast timer
IPIs. So, overall system got 72+72=144 wake ups and 72 broadcast timer IPIs

With the patch:
           CPU0       CPU1
 27:        107         37       GIC  27  arch_timer
 45:         62          0       GIC  45  mmc0
160:         66          7  interrupt-controller   8  timer
227:          0          0  interrupt-controller   4  f7e81400.i2c
228:          0          0  interrupt-controller   5  f7e81800.i2c
229:          0          0  interrupt-controller   7  dw_spi65535
230:          0          0  interrupt-controller  21  f7e84000.i2c
231:          0          0  interrupt-controller  20  f7e84800.i2c
265:        311          0  interrupt-controller   8  serial
IPI0:          0          0  CPU wakeup interrupts
IPI1:          2          4  Timer broadcast interrupts
IPI2:         58        100  Rescheduling interrupts
IPI3:          0          0  Function call interrupts
IPI4:          0          4  Single function call interrupts
IPI5:          0          0  CPU stop interrupts
IPI6:         21         24  IRQ work interrupts
IPI7:          0          0  completion interrupts
IPI8:          0          0  CPU backtrace
Err:          0
           CPU0       CPU1
 27:        107         39       GIC  27  arch_timer
 45:         62          0       GIC  45  mmc0
160:         69         75  interrupt-controller   8  timer
227:          0          0  interrupt-controller   4  f7e81400.i2c
228:          0          0  interrupt-controller   5  f7e81800.i2c
229:          0          0  interrupt-controller   7  dw_spi65535
230:          0          0  interrupt-controller  21  f7e84000.i2c
231:          0          0  interrupt-controller  20  f7e84800.i2c
265:        380          0  interrupt-controller   8  serial
IPI0:          0          0  CPU wakeup interrupts
IPI1:          3          6  Timer broadcast interrupts
IPI2:         60        100  Rescheduling interrupts
IPI3:          0          0  Function call interrupts
IPI4:          0          4  Single function call interrupts
IPI5:          0          0  CPU stop interrupts
IPI6:         21         45  IRQ work interrupts
IPI7:          0          0  completion interrupts
IPI8:          0          0  CPU backtrace
Err:          0

cpu0 got 69-66=3, cpu1 got 75-7=68 timer interrupts. cpu0 got 3-2=1
broadcast timer IPIs, cpu1 got 6-4=2 broadcast timer IPIs. So, overall
system got 3+68+1+2=74 wakeups and 1+2=3 broadcast timer IPIs.

This patch removes 50% wakeups and almost 100% broadcast timer IPIs!

What do you think?

Thanks,
Jisheng

> 
> Sounds like there's a bug in the migration code which needs further
> investigation, rather than hacking around the problem by introducing
> lots of driver code.
> 
