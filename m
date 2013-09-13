From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 13 Sep 2013 21:33:26 +0530
Subject: [PATCH 181/228] cpufreq: move freq change notifications to
 cpufreq core
In-Reply-To: <20130913155313.GA12758@n2100.arm.linux.org.uk>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
 <fd43341751c7a00d2f4eedf48d6338f866b26a52.1379063063.git.viresh.kumar@linaro.org>
 <20130913155313.GA12758@n2100.arm.linux.org.uk>
Message-ID: <CAKohpo=az_vF8T5jdSLEeA+a1vk8AH7wS_2gTueUobgJ39jQnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 September 2013 21:23, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Sep 13, 2013 at 06:32:07PM +0530, Viresh Kumar wrote:
>> +             read_lock_irqsave(&cpufreq_driver_lock, flags);
>> +             notify = !(cpufreq_driver->flags & CPUFREQ_ASYNC_NOTIFICATION);
>> +             read_unlock_irqrestore(&cpufreq_driver_lock, flags);
>
> I don't think this needs to be read under a lock - if this bit changes
> dynamically, then there's something very wrong.

No it doesn't change dynamically.. Was a mistake..
Following change folded into the original commit (attached)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 2c1ae708..bb7402d 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1802,7 +1802,6 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
        else if (cpufreq_driver->target_index) {
                struct cpufreq_frequency_table *freq_table;
                struct cpufreq_freqs freqs;
-               unsigned long flags;
                bool notify;
                int index;

@@ -1824,9 +1823,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
                        goto out;
                }

-               read_lock_irqsave(&cpufreq_driver_lock, flags);
                notify = !(cpufreq_driver->flags & CPUFREQ_ASYNC_NOTIFICATION);
-               read_unlock_irqrestore(&cpufreq_driver_lock, flags);

                if (notify) {
                        freqs.old = policy->cur;
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0181-cpufreq-move-freq-change-notifications-to-cpufreq-co.patch
Type: application/octet-stream
Size: 2729 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130913/a913d972/attachment.obj>
