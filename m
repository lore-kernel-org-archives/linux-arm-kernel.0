From: dianders@chromium.org (Doug Anderson)
Date: Tue, 9 Jun 2015 11:16:56 -0700
Subject: [PATCH v6 1/3] ARM: rockchip: fix the CPU soft reset
In-Reply-To: <1433843400-24831-2-git-send-email-wxt@rock-chips.com>
References: <1433843400-24831-1-git-send-email-wxt@rock-chips.com>
 <1433843400-24831-2-git-send-email-wxt@rock-chips.com>
Message-ID: <CAD=FV=VQaD-VSmiNXTNdFnhKZZPXQwDW5BVBB+XJCJfKswbycA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Caesar,

On Tue, Jun 9, 2015 at 2:49 AM, Caesar Wang <wxt@rock-chips.com> wrote:
> We need different orderings when turning a core on and turning a core
> off.  In one case we need to assert reset before turning power off.
> In ther other case we need to turn power on and the deassert reset.
>
> In general, the correct flow is:
>
> CPU off:
>     reset_control_assert
>     regmap_update_bits(pmu, PMU_PWRDN_CON, BIT(pd), BIT(pd))
>     wait_for_power_domain_to_turn_off
> CPU on:
>     regmap_update_bits(pmu, PMU_PWRDN_CON, BIT(pd), 0)
>     wait_for_power_domain_to_turn_on
>     reset_control_deassert
>
> This is needed for stressing CPU up/down, as per:
>     cd /sys/devices/system/cpu/
>     for i in $(seq 10000); do
>         echo "================= $i ============"
>         for j in $(seq 100); do
>             while [[ "$(cat cpu1/online)$(cat cpu2/online)$(cat cpu3/online)" != "000"" ]]
>                 echo 0 > cpu1/online
>                 echo 0 > cpu2/online
>                 echo 0 > cpu3/online
>             done
>             while [[ "$(cat cpu1/online)$(cat cpu2/online)$(cat cpu3/online)" != "111" ]]; do
>                 echo 1 > cpu1/online
>                 echo 1 > cpu2/online
>                 echo 1 > cpu3/online
>             done
>         done
>     done
>
> The following is reproducable log:
>     [34466.186812] PM: noirq suspend of devices complete after 0.669 msecs
>     [34466.186824] Disabling non-boot CPUs ...
>     [34466.187509] CPU1: shutdown
>     [34466.188672] CPU2: shutdown
>     [34473.736627] Kernel panic - not syncing:Watchdog detected hard LOCKUP on cpu 0
>     .......
> or others similar log:
>     .......
>     [ 4072.454453] CPU1: shutdown
>     [ 4072.504436] CPU2: shutdown
>     [ 4072.554426] CPU3: shutdown
>     [ 4072.577827] CPU1: Booted secondary processor
>     [ 4072.582611] CPU2: Booted secondary processor
>     <hang>
>
>     Tested by cpu up/down scripts, the results told us need delay more time
> before write the sram. The wait time is affected by many aspects
> (e.g: cpu frequency, bootrom frequency, sram frequency, bus speed, ...).
>
>     Although the cpus other than cpu0 will write the sram, the speedy is
> no the same as cpu0, if the cpu0 early wake up, perhaps the other cpus
> can't startup. As we know, the cpu0 can wake up when the cpu1/2/3 write
> the 'sram+4/8' and send the sev.
>     Anyway.....
>     At the moment, 1ms delay will be happy work for cpu up/down scripts test.
>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Reviewed-by: Doug Anderson <dianders@chromium.org>

Usually it's good to remove someone's "Reviewed-by" when you've made
as many changes as you have.  ...but in this case I am still happy
with this patch, so I'll re-assert:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
