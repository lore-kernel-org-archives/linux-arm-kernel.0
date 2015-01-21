From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Wed, 21 Jan 2015 10:47:37 +0000
Subject: [PATCH 3.19-rc2 v14 0/7] arm: Implement
 arch_trigger_all_cpu_backtrace
In-Reply-To: <54BEC04D.1050402@codeaurora.org>
References: <1415968543-29469-1-git-send-email-daniel.thompson@linaro.org>
 <1421144818-14036-1-git-send-email-daniel.thompson@linaro.org>
 <54BE2D15.9080606@linaro.org> <54BEC04D.1050402@codeaurora.org>
Message-ID: <54BF83C9.5060300@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/01/15 20:53, Stephen Boyd wrote:
> On 01/20/2015 02:25 AM, Daniel Thompson wrote:
>> On 13/01/15 10:26, Daniel Thompson wrote:
>>> Hi Thomas, Hi Jason:
>>>     Patches 1 to 3 are for you (and should be separable from the rest
>>>     of the series). The patches haven't changes since the last time
>>>     I posted them. The changes in v14 tidy up the later part of the
>>>     patch set in order to share more code between x86 and arm.
>> No review comments! Have I finally got this right?
>>
>> If so it possible and/or sensible to get patches 1-3 in a tree that
>> feeds linux-next. I'd really like the gic changes to meet the various
>> ARM build and boot bots.
> 
> With this patchset, is it possible to call sched_clock() from within NMI
> context? I ask because the generic sched_clock() code is not NMI safe
> today. We were planning on making it NMI safe by doing something similar
> to what was done for ktime_get_mono_fast_ns() but we haven't gotten
> around to it. Mostly because no architecture that uses generic
> sched_clock() has support for NMIs right now.

I've not done any work to make sched_clock() safe to call from NMI.
However since my patchset does not introduce any calls to sched_clock()
from NMI I think this is OK!

I ported Steven Rostedt's work to make arch_trigger_all_cpu_backtrace()
safe from NMI from x86 to ARM. One result of Steven's approach are that
printk() timestamping is deferred until we return to normal context.
Thus even with CONFIG_PRINTK_TIME we do not call local_clock() during
NMI processing.

To confirm the above I have added the code below to my kernel and ran it
with a fairly paranoid set of debugging options. The check does not fire.


Daniel.

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 630dd2372238..fea0deeb524b 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -111,8 +111,10 @@ extern void warn_slowpath_null(const char *file,
const int line);
        int __ret_warn_once = !!(condition);                    \
                                                                \
        if (unlikely(__ret_warn_once))                          \
-               if (WARN_ON(!__warned))                         \
+               if (unlikely(!__warned)) {                      \
                        __warned = true;                        \
+                       __WARN();                               \
+               }                                               \
        unlikely(__ret_warn_once);                              \
 })

diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index 01d2d15aa662..81ea469b7e68 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -63,6 +63,8 @@ unsigned long long notrace sched_clock(void)
        u64 cyc;
        unsigned long seq;

+       WARN_ON_ONCE(in_nmi());
+
        if (cd.suspended)
                return cd.epoch_ns;
