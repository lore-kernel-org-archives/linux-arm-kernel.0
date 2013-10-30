From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 31 Oct 2013 04:01:13 +0530
Subject: [PATCH v2 0/2] cpufreq support for the big.LITTLE switcher
In-Reply-To: <7822477.lBueQHUY4E@vostro.rjw.lan>
References: <1383162281-24204-1-git-send-email-nicolas.pitre@linaro.org>
 <7822477.lBueQHUY4E@vostro.rjw.lan>
Message-ID: <CAKohpom-Oo81U_J5sC8qG7uzjW=yRJLvAPDpNyV6Sst7uw=hag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 October 2013 03:22, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> Queued up for 3.13, thanks!

Hmm.. thanks for applying this but there was a minor bug here which
is fixed by below commit.. You don't really need to merge this with
the original commit and so can go as a separate commit..

Attached for applying.. Tested by Nico.

--------x------------------x-------------

Author: Viresh Kumar <viresh.kumar@linaro.org>
Date:   Thu Oct 31 03:45:42 2013 +0530

    cpufreq: arm_big_little: Call routine instead of passing its address

    In bL_cpufreq_init() we need to fill per-cpu cpu_last_req_freq
with the current
    frequency of cpu. Instead of calling the function we passed its
address to this
    routine by mistake earlier. Lets fix it by calling the routine instead.

    Tested-by: Nicolas Pitre <nico@linaro.org>
    Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/arm_big_little.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index 2b2a44a..ee66449 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -461,7 +461,8 @@ static int bL_cpufreq_init(struct cpufreq_policy *policy)
                policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;

        if (is_bL_switching_enabled())
-               per_cpu(cpu_last_req_freq, policy->cpu) = clk_get_cpu_rate;
+               per_cpu(cpu_last_req_freq, policy->cpu) =
+                       clk_get_cpu_rate(policy->cpu);

        dev_info(cpu_dev, "%s: CPU %d initialized\n", __func__, policy->cpu);
        return 0;
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-cpufreq-arm_big_little-Call-routine-instead-of-passi.patch
Type: text/x-patch
Size: 1377 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131031/ce1660dd/attachment.bin>
