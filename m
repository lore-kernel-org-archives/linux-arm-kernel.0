From: jszhang@marvell.com (Jisheng Zhang)
Date: Sat, 4 Jul 2015 11:40:11 +0800
Subject: [PATCH] clocksource: dw_apb_timer: add dynamic irq flag to the
 timer
In-Reply-To: <5596A324.4040800@linaro.org>
References: <1435933847-2069-1-git-send-email-jszhang@marvell.com>
 <5596A324.4040800@linaro.org>
Message-ID: <20150704114011.21e45112@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Daniel,

On Fri, 3 Jul 2015 16:58:44 +0200
Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

> On 07/03/2015 04:30 PM, Jisheng Zhang wrote:
> > Commit d2348fb6fdc6 ("tick: Dynamically set broadcast irq affinity")
> > adds one excelent feature CLOCK_EVT_FEAT_DYNIRQ to let the core set the
> > interrupt affinity of the broadcast interrupt to the cpu which has the
> > earliest expiry time. This patch adds CLOCK_EVT_FEAT_DYNIRQ flag to
> > avoid unnecessary wakeups and IPIs when the dw_apb_timer is used as
> > broadcast timer.
> >
> > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > ---
> 
> I am glad this flag helps. Were you able to do some measurements ?

Sure. Here is the rough measurement step:

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

cpu0 get 160-88=72 timer interrupts, CPU1 got 83-11=72 broadcast timer IPIs
So, overall system got 72+72=144 wake ups and 72 broadcast timer IPIs


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

cpu0 got 69-66 = 3, cpu1 got 75-7=68 timer interrupts. cpu0 got 3-2 = 1
broadcast timer IPIs, cpu1 got 6-4=2 broadcast timer IPIs.
So, overall system got 3+68+1+2=74 wakeups and 1+2=3 broadcast timer IPIs

We removed 50% wakeups and almost 100% broadcast timer IPIs

I will add these rough measurement's result into the commit msg.

Thanks for your suggestion,
Jisheng
