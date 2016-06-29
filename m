From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Wed, 29 Jun 2016 21:52:08 +0800
Subject: [PATCH RFC 0/7] support clk setting during kernel early boot
Message-ID: <1467208335-29876-1-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recently several people met the kernel complaining
"bad: scheduling from the idle thread!" issue which caused by
sleeping during kernel early booting phase by calling clk
APIs like clk_prepare_enable.

See:
https://lkml.org/lkml/fancy/2016/1/29/695
https://lkml.org/lkml/2016/6/10/779
http://www.spinics.net/lists/linux-clk/msg08635.html

The calling sequence simply could be like:
start_kernel
  ->time_init
    ->of_clk_init
      ->clk_core_prepare
        ->clk_pllv3_prepare
          ->usleep_range
            ->dequeue_task_idle

This issue is mainly caused during time_init, the irq is still
not enabled and scheduler is still not ready, thus there's no way
to allow sleep at that time.

However, there're many exist platforms calling clk_prepare_enable/
clk_get_rate/clk_set_parent at that time in CLK_OF_DECLARE init
function.
e.g
drivers/clk/imx/clk-{soc}.c
drivers/clk/rockchip/clk-rk3188.c
drivers/clk/ti/clk-44xx.c
...

And irqchip and clock source is also initialized before it which
may requires to do clk settings.

Furthermore, current clk framework also supports critical clocks
flagged by CLK_IS_CRITICAL which will be prepared and
enabled during clk_register by clk core, that is also happened
quite early in of_clk_init usually.

And clk framework also supports assign default clk rate and parent for
each registered clk provider which also happens early in of_clk_init.
(see of_clk_set_defaults())

Above are all possible cases which may cause sleeping during kernel
early booting.

So it seems we'd like to have the requirement to make kernel support
calling clk APIs during kernel early boot without sleep.

Thomas suggested a solution to fix at core layer instead of hacks
at each platform driver at here during our early discussion.
https://lkml.org/lkml/fancy/2016/1/29/695

The basic idea behind is spliting the sleepable API into two part and
let the clk core to handle if sleep or polling according to system state.
e.g.
clk_ops.prepare()       Legacy callback
clk_ops.prepare_hw()    Callback which writes to the hardware
clk_ops.prepare_done()  Callback which checks whether the prepare is completed

So now the core can do:

clk_prepare()
{
        /* Legacy code should go away */
        if (ops->prepare) {
              ops->prepare();
              return;
        }

        if (ops->prepare_hw)
              ops->prepare_hw();

        if (!ops->prepare_done())
                return;

        if (early_boot_or_suspend_resume()) {
                /*
                 * Busy loop when we can't schedule in early boot,
                 * suspend and resume.
                 */
                while (!ops->prepare_done())
                      ;
        } else {
                while (!ops->prepare_done())
                      usleep(clk->prepare_delay);
        }
}

As a side effect that allows us to remove the gazillion of

            while (!hw_ready)
                  usleep();

copies all over the place and we have a single point of control where we allow
the clocks to busy loop.

This RFC gives a draft implementation and aim to start a dicussion for
the known issues during the implementation.
1) Thomas's original proposal seems like to to remove legacy code
(ops->prepare) in the future.
However, we might not be able to do it due to there may be some special
clocks which can't avoid sleep and can't be divided into xxx_hw and xxx_done.
e.g. I2C clocks, virtual clocks (drivers/clk/imx/clk-cpu.c)
and clocks operate via sync conmunication with firmware(i.MX8).

For those clocks, we may not be able to convert them and still have to
keep the exist callbacks for them which will make us to increase a lot
new callbacks.

2) Do we need define each sleep range for each sleep cases?
Current only one sleep range(delay_min and delay_max) interface
defined in clk_init_data for all sleeping user cases including
set_rate/set_parent/..?
The benefit is avoid defining more x_delay_min and x_delay_max.
The drawback is the small range may causing more interrupts
for big range.
e.g.
set_rate	delay min 50ns	max 500ns
set_parent	delay min 10ns	max 20ns
Then range becomes usleep_range(10, 500)

3) core level sleep timeout is 10ms, probably may be small.

4) This RFC only implements prepare_hw/set_rate_hw/set_parent_hw.
In theory, all callbacks protected by prepare_lock(mutex) may need
the same implementation.

The complete list may be:
prepare_hw
prepare_done
unprepare_hw
unprepare_done
set_rate_hw
set_rate_done
set_parent_hw
set_parent_done
recalc_rate_hw
recalc_rate_done
round_rate_hw
round_rate_done
determine_rate_hw
determine_rate_done
set_rate_and_parent_hw
set_rate_and_parent_done
recalc_accuracy_hw
recalc_accuracy_done
get_phase_hw
get_phase_hw_done
set_phase_hw
set_phase_hw_done
(get_rate & get_parent do not need)

Since many of them is actually mostly implemented unsleepable already,
e.g. recalc_rate, recalc_accuracy, get/set_phase
but due to the definition allows them sleep, we may still have to add
xxx_hw and xxx_done for them.
Not sure if any better idea to avoid adding so many new callbacks.

5) The most important issue may be callbacks (round_rate and determine_rate)
which may recursively call its parent.
For this case, we may not be able to convert it to xx_hw type.
e.g. drivers/clk/clk-divider.c
.round_rate
-> clk_divider_round_rate
   -> clk_hw_round_rate(clk_hw_get_parent(hw), rate) if CLK_SET_RATE_PARENT

clk_hw_round_rate is sleepable in theory.
Thus we may not convert .round_rate to .round_rate_hw since we can't
predict whether it's parent round_rate is sleepable or not.

This issue may cause us unable to convert the common clk-divider and clk-mux
which could be a potential issue since clk_set_rate will indirectly call
.round_rate and .determinte_rate which may results in possible sleep.

Any good ideas for this issue?

6) Not sure your guys's option on calling clk_prepare which acqures a mutex
when irq is disalbed.
Ideally we probably may should not call mutex_lock with irq disabled.
But seems we may can't avoid and during booting, it seems still safe to
call it.

Dong Aisheng (6):
  clk: add prepare_hw and prepare_done support
  clk: add set_rate_hw and set_rate_done
  clk: add set_parent_hw and set_parent_done
  clk: use polling way for SYSTEM_SUSPEND state too
  clk: imx: pllv3: convert to prepare_hw and set_rate_hw
  clk: imx: clk-busy: convert to set_rate_hw and set_parent_hw

Thomas Gleixner (1):
  PM: add SYSTEM_SUSPEND system_state

 drivers/clk/clk.c            | 119 +++++++++++++++++++++++++++++++++++++++++--
 drivers/clk/imx/clk-busy.c   |  52 +++++++++----------
 drivers/clk/imx/clk-pllv3.c  |  64 +++++++++++------------
 include/linux/clk-provider.h |  61 ++++++++++++++++++++++
 include/linux/kernel.h       |   1 +
 kernel/power/hibernate.c     |   7 +++
 kernel/power/suspend.c       |   4 ++
 7 files changed, 245 insertions(+), 63 deletions(-)

-- 
1.9.1
