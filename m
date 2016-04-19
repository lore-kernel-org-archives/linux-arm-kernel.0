From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 19 Apr 2016 14:48:40 -0700
Subject: [PATCH] drivers/perf: arm-pmu: fix RCU usage on resume from idle
 states
In-Reply-To: <20160419172320.GD4509@arm.com> (Will Deacon's message of "Tue,
 19 Apr 2016 18:23:20 +0100")
References: <1461085689-2893-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20160419172320.GD4509@arm.com>
Message-ID: <7hr3e1b77r.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon <will.deacon@arm.com> writes:

> Hi Lorenzo,
>
> On Tue, Apr 19, 2016 at 06:08:09PM +0100, Lorenzo Pieralisi wrote:
>> Commit da4e4f18afe0 ("drivers/perf: arm_pmu: implement CPU_PM notifier")
>> added code in the arm perf infrastructure that allows the kernel to
>> save/restore perf counters whenever the CPU enters a low-power idle
>> state. The kernel saves/restores the counters for each active event
>> through the armpmu_{stop/start} ARM pmu API, so that the idle state
>> enter/exit power cycle is emulated through pmu start/stop operations
>> for each event in use.
>> 
>> However, calling armpmu_start() for each active event on power up
>> executes code that requires RCU locking (perf_event_update_userpage())
>> to be functional, so, given that the core may call the CPU_PM notifiers
>> while running the idle thread in an quiescent RCU state this is not
>> allowed as detected through the following splat when kernel is run with
>> CONFIG_PROVE_LOCKING enabled:
>> 
>> [   49.293286]
>> [   49.294761] ===============================
>> [   49.298895] [ INFO: suspicious RCU usage. ]
>> [   49.303031] 4.6.0-rc3+ #421 Not tainted
>> [   49.306821] -------------------------------
>> [   49.310956] include/linux/rcupdate.h:872 rcu_read_lock() used
>> illegally while idle!
>> [   49.318530]
>> [   49.318530] other info that might help us debug this:
>> [   49.318530]
>> [   49.326451]
>> [   49.326451] RCU used illegally from idle CPU!
>> [   49.326451] rcu_scheduler_active = 1, debug_locks = 0
>> [   49.337209] RCU used illegally from extended quiescent state!
>> [   49.342892] 2 locks held by swapper/2/0:
>> [   49.346768]  #0:  (cpu_pm_notifier_lock){......}, at:
>> [<ffffff8008163c28>] cpu_pm_exit+0x18/0x80
>> [   49.355492]  #1:  (rcu_read_lock){......}, at: [<ffffff800816dc38>]
>> perf_event_update_userpage+0x0/0x260
>> 
>> This patch refactors the perf CPU_PM notifiers to add a boolean
>> flag to the function updating the counters event period, so that the
>> userpage update can be skipped when resuming from low-power whilst
>> keeping correct save/restore functionality for the running events.
>> 
>> As a side effect the kernel, while resuming from low-power with
>> perf events enabled, runs with a userspace view of active counters that
>> is not up-to-date with the kernel one, but since the core power down is
>> not really a PMU event start/stop this can be considered acceptable and
>> the userspace event snapshot will update the user view of counters
>> on subsequent perf event updates requested by either the perf API
>> or event counters overflow-triggered interrupts.
>> 
>> Fixes: da4e4f18afe0 ("drivers/perf: arm_pmu: implement CPU_PM notifier")
>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Reported-by: James Morse <james.morse@arm.com>
>> Cc: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Kevin Hilman <khilman@baylibre.com>
>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> ---
>>  drivers/perf/arm_pmu.c | 26 +++++++++++++++++++++-----
>>  1 file changed, 21 insertions(+), 5 deletions(-)
>
> This is horrible, but I think it's the best we can do without completely
> redesigning the way in which we save/restore the PMU state. We should do
> that, but not for 4.6!
>
> Acked-by: Will Deacon <will.deacon@arm.com>

Maybe RCU_NONIDLE() will help here?

Kevin
