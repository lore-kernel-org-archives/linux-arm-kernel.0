From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Thu, 19 Aug 2010 10:53:06 +0900
Subject: [PATCH v7 6/6] ARM: S5PV210: Initial CPUFREQ Support
In-Reply-To: <000001cb3f2d$7a5acb80$6f106280$%kim@samsung.com>
References: <1281419049-11562-1-git-send-email-myungjoo.ham@samsung.com>
	<1281419049-11562-2-git-send-email-myungjoo.ham@samsung.com>
	<1281419049-11562-3-git-send-email-myungjoo.ham@samsung.com>
	<1281419049-11562-4-git-send-email-myungjoo.ham@samsung.com>
	<1281419049-11562-5-git-send-email-myungjoo.ham@samsung.com>
	<1281419049-11562-6-git-send-email-myungjoo.ham@samsung.com>
	<1281419049-11562-7-git-send-email-myungjoo.ham@samsung.com>
	<000001cb3f2d$7a5acb80$6f106280$%kim@samsung.com>
Message-ID: <AANLkTik7u49pn2_UatW+pxOf9Rq9biiMGeR1z5Jcvfqs@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 19, 2010 at 8:30 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> MyungJoo Ham wrote:
>>
>> S5PV210 CPUFREQ Support.
>>

(snip)

> Hi,
>
> Did you test on the board?
>
> The following error occurs.
>

Hello,

The CPUFREQ patch is not tested in conjuntion with PM support as PM is
not yet included in the mainline although we've tried to be compatible
with PM support.

However, as we've found that this CPUFREQ patch is not fully
compatible with PM, I'd like to suggest the following patch over the
patch v7. It removes the "SLEEP_FREQ" feature, which fixes the
frequency in suspend procedures. This feature should be later included
in PM support and executed before calling "suspend" ops of devices and
after calling "resume" ops of the devices. In previous versions of
kernel, we've done this at ".begin" and ".end" of struct
platform_suspend_ops.


 arch/arm/mach-s5pv210/cpufreq.c               |   15 +--------------
 arch/arm/mach-s5pv210/include/mach/cpu-freq.h |    2 --
 2 files changed, 1 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-s5pv210/cpufreq.c b/arch/arm/mach-s5pv210/cpufreq.c
index 2ae83c3..2ee6585 100644
--- a/arch/arm/mach-s5pv210/cpufreq.c
+++ b/arch/arm/mach-s5pv210/cpufreq.c
@@ -635,18 +635,10 @@ out:
 }

 #ifdef CONFIG_PM
-static int previous_frequency;
-
 static int s5pv210_cpufreq_suspend(struct cpufreq_policy *policy,
 		pm_message_t pmsg)
 {
-	int ret = 0;
-	pr_info("cpufreq: Entering suspend.\n");
-
-	previous_frequency = cpufreq_get(0);
-	ret = __cpufreq_driver_target(cpufreq_cpu_get(0), SLEEP_FREQ,
-			DISABLE_FURTHER_CPUFREQ);
-	return ret;
+	return 0;
 }

 static int s5pv210_cpufreq_resume(struct cpufreq_policy *policy)
@@ -656,11 +648,6 @@ static int s5pv210_cpufreq_resume(struct
cpufreq_policy *policy)
 	int level = CPUFREQ_TABLE_END;
 	int i = 0;

-	pr_info("cpufreq: Waking up from a suspend.\n");
-
-	__cpufreq_driver_target(cpufreq_cpu_get(0), previous_frequency,
-			ENABLE_FURTHER_CPUFREQ);
-
 	/* Clock information update with wakeup value */
 	rate = clk_get_rate(mpu_clk);

diff --git a/arch/arm/mach-s5pv210/include/mach/cpu-freq.h
b/arch/arm/mach-s5pv210/include/mach/cpu-freq.h
index 76806ab..a4ea36e 100644
--- a/arch/arm/mach-s5pv210/include/mach/cpu-freq.h
+++ b/arch/arm/mach-s5pv210/include/mach/cpu-freq.h
@@ -25,8 +25,6 @@ enum perf_level {
 };

 #ifdef CONFIG_PM
-#define SLEEP_FREQ      (800 * 1000) /* Use 800MHz when entering sleep */
-
 /* additional symantics for "relation" in cpufreq with pm */
 #define DISABLE_FURTHER_CPUFREQ         0x10
 #define ENABLE_FURTHER_CPUFREQ          0x20


---
> --
> ...
> cpufreq: Entering suspend.
> BUG: sleeping function called from invalid context at kernel/rwsem.c:21
> in_atomic(): 0, irqs_disabled(): 128, pid: 13, name: suspend
> [<c002c91c>] (unwind_backtrace+0x0/0xec) from [<c0295dd0>]
> (down_read+0x18/0x28)
> [<c0295dd0>] (down_read+0x18/0x28) from [<c01e8524>]
> (lock_policy_rwsem_read+0x2c/0x50)
> [<c01e8524>] (lock_policy_rwsem_read+0x2c/0x50) from [<c01e85d4>]
> (cpufreq_get+0x20/0x50)
> [<c01e85d4>] (cpufreq_get+0x20/0x50) from [<c0031e5c>]
> (s5pv210_cpufreq_suspend+0x14/0x40)
> [<c0031e5c>] (s5pv210_cpufreq_suspend+0x14/0x40) from [<c01e78c8>]
> (cpufreq_suspend+0x50/0x84)
> [<c01e78c8>] (cpufreq_suspend+0x50/0x84) from [<c0175464>]
> (sysdev_suspend+0x84/0x28c)
> [<c0175464>] (sysdev_suspend+0x84/0x28c) from [<c0071324>]
> (suspend_devices_and_enter+0xe0/0x1a0)
> [<c0071324>] (suspend_devices_and_enter+0xe0/0x1a0) from [<c007148c>]
> (enter_state+0xa8/0xd4)
> [<c007148c>] (enter_state+0xa8/0xd4) from [<c0072914>] (suspend+0x60/0x124)
> [<c0072914>] (suspend+0x60/0x124) from [<c0058260>]
> (worker_thread+0x15c/0x1ec)
> [<c0058260>] (worker_thread+0x15c/0x1ec) from [<c005b58c>]
> (kthread+0x78/0x80)
> [<c005b58c>] (kthread+0x78/0x80) from [<c0027f64>]
> (kernel_thread_exit+0x0/0x8)
> ...
> --
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
>



-- 
MyungJoo Ham (???), Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
