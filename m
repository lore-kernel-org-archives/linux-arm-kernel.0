From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 29 Aug 2013 10:15:36 -0700
Subject: [PATCH] ARM: OMAP4: cpuidle: fix: call cpu_cluster_pm_exit
 conditionally
In-Reply-To: <902E09E6452B0E43903E4F2D568737AB35C674@DNCE04.ent.ti.com>
 (Grygorii Strashko's message of "Thu, 29 Aug 2013 15:20:18 +0000")
References: <1377598250-2355-1-git-send-email-murzin.v@gmail.com>
 <87sixvw2n5.fsf@linaro.org>
 <902E09E6452B0E43903E4F2D568737AB35C674@DNCE04.ent.ti.com>
Message-ID: <8761uo2zbb.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Santosh

"Strashko, Grygorii" <grygorii.strashko@ti.com> writes:

> Hi Vladimir, Kevin
>
> On 08/27/2013 06:54 PM, Kevin Hilman wrote:
>> Vladimir Murzin <murzin.v@gmail.com> writes:
>>
>>> We call cpu_cluster_pm_enter for dev->cpu == 0 only, but
>>> cpu_cluster_pm_exit called without that check.
>>>
>>> Because of that unhandled page fault may happen:
>>>
>
> [...]
>
>>>
>>> It is supposed that sar_base is initialized in irq_save_context, which
>>> is called on CPU_CLUSTER_PM_ENTER notification. If this notification
>>> has been missed and CPU_CLUSTER_PM_EXIT is received sar_base is NULL.
>>>
>>> Fix it by calling CPU_CLUSTER_PM_{ENTER,EXIT} under the same condition.
>
> Could you check, if revert of the following patch will solve the issue, pls?
> commit e7457253494fff660a72bc0cedeee97491ccd173
> "ARM: OMAP4+: CPUidle: Deprecate use of omap4_mpuss_read_prev_context_state()"
>
>>>
>>> Signed-off-by: Vladimir Murzin <murzin.v@gmail.com>
>>
>> Good catch.
>
> Yes, but It seems, that CPUIdle logic is unclear for OAMP4 .
> The above issue may happen if CPU1 enter/exit LP while CPU0:
> - not enter at all (somewhere inside "coupled" core);
> - still entering LP (somewhere before call to omap4_enter_lowpower());
>
> The question is - Should first CPUx, who exited from LP(C3) state,
> restore Cluster context, or it should be done by CPU0 only?
> (on OMAP4 CPUs may return from C3 async).

Well, they're not *supposed* to return async on OMAP4.  IIUC, only CPU0
wakes up and then it's CPU0s job to wake up CPU1. However, the crash
reported here certainly suggests that CPU1 exiting before CPU0, so
one of the possibilities you suggest above is probably happening (I
suspect the latter.)

It looks like we might still need to check the actual hardware state
there to avoid those potential cases.

Alternatively, another solution might be to use
cpuidle_coupled_parallel_barrier() before the cluster_pm_exit()

Kevin
