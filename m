From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 24 Mar 2013 20:23:27 +0530
Subject: [PATCH 1/2] cpufreq: Notify all policy->cpus in
 cpufreq_notify_transition()
In-Reply-To: <514F0FB0.8030109@gmail.com>
References: <981c23bd4b2a14c346820685e1203ab7054378f8.1364132845.git.viresh.kumar@linaro.org>
 <514F0FB0.8030109@gmail.com>
Message-ID: <CAKohpomznLtxYZYx31xg+V5FesNiMwOqNDN0QNqOqUw_7g4Uhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 March 2013 20:07, Francesco Lavra <francescolavra.fl@gmail.com> wrote:
> On 03/24/2013 02:48 PM, Viresh Kumar wrote:
>> policy->cpus contains all online cpus that have single shared clock line. And
>> their frequencies are always updated together.
>>
>> Many SMP system's cpufreq drivers take care of this in individual drivers but
>> the best place for this code is in cpufreq core.
>>
>> This patch modifies cpufreq_notify_transition() to notify frequency change for
>> all cpus in policy->cpus and hence updates all users of this API.

One thing about this work. I compiled it for ARM and Intel. Also this
stuff is tested
by "Fengguang Wu" <fengguang.wu@intel.com> automated build system.

I am not sure if that builds all architectures or not.
I tried to review my patch closely but their can be some minor mistakes.

I thought of adding this in the patch details but forgot at last.

Is their a simple way to compile stuff for all platforms? Sorry i am
not aware of
it :(

>> diff --git a/arch/blackfin/mach-common/cpufreq.c b/arch/blackfin/mach-common/cpufreq.c
>> +     ret = cpu_set_cclk(policy->cpu, freqs.new * 1000);
>> +     if (ret != 0) {
>> +             WARN_ONCE(ret, "cpufreq set freq failed %d\n", ret);
>> +             break;
>
> This doesn't even compile, as the break statement isn't in the
> for_each_online_cpu() loop anymore.

I tried to review it very carefully but this situation was a bit tricky :)
Thanks for trying it out.

Following should fix it for you:

commit 942ca8a6bc87e3c42beabc9102755136493e5355
Author: Viresh Kumar <viresh.kumar@linaro.org>
Date:   Sun Mar 24 20:21:43 2013 +0530

    fixup! cpufreq: Notify all policy->cpus in cpufreq_notify_transition()
---
 arch/blackfin/mach-common/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/blackfin/mach-common/cpufreq.c
b/arch/blackfin/mach-common/cpufreq.c
index 4e67368..995511e80 100644
--- a/arch/blackfin/mach-common/cpufreq.c
+++ b/arch/blackfin/mach-common/cpufreq.c
@@ -164,7 +164,7 @@ static int bfin_target(struct cpufreq_policy *policy,
        ret = cpu_set_cclk(policy->cpu, freqs.new * 1000);
        if (ret != 0) {
                WARN_ONCE(ret, "cpufreq set freq failed %d\n", ret);
-               break;
+               return ret;
        }
 #endif
        on_each_cpu(bfin_adjust_core_timer, &index, 1);


@Rafael: Let me add fixups for now, i will send final patch later after others
also review their part.
