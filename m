From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 9 Aug 2013 09:34:47 +0530
Subject: [PATCH 35/35] cpufreq: tegra: use
 cpufreq_table_validate_and_show()
In-Reply-To: <CAKohpomr8kwDitAFD7FKvHo3zNWz8qT5bkd3yOVEnC_k16o=Dw@mail.gmail.com>
References: <cover.1375964117.git.viresh.kumar@linaro.org>
 <568f3dbd414b050bb2319d960fb5044a5aed8ee3.1375964117.git.viresh.kumar@linaro.org>
 <5203BCDD.40809@wwwdotorg.org>
 <CAKohpomr8kwDitAFD7FKvHo3zNWz8qT5bkd3yOVEnC_k16o=Dw@mail.gmail.com>
Message-ID: <CAKohpo=Gy7D2LYmdFU1p+eL-nMoPE18YXWvE2M8t-fb-a5HBgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 August 2013 21:37, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Its useless and the correct routine isn't called at all :) .. I will add that
> additional patch and send it to you and will get this change out of this
> commit.

The two commits look like this now attached too in case you want
to test:

commit 9abdc9127b9f7f1e00c75694d15345843a60ff99
Author: Viresh Kumar <viresh.kumar@linaro.org>
Date:   Thu Aug 8 16:40:32 2013 +0530

    cpufreq: tegra: use cpufreq_table_validate_and_show()

    Lets use cpufreq_table_validate_and_show() instead of calling
    cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().

    Cc: Stephen Warren <swarren@nvidia.com>
    Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/tegra-cpufreq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/tegra-cpufreq.c b/drivers/cpufreq/tegra-cpufreq.c
index cd66b85..51752b3 100644
--- a/drivers/cpufreq/tegra-cpufreq.c
+++ b/drivers/cpufreq/tegra-cpufreq.c
@@ -215,8 +215,7 @@ static int tegra_cpu_init(struct cpufreq_policy *policy)
        clk_prepare_enable(emc_clk);
        clk_prepare_enable(cpu_clk);

-       cpufreq_frequency_table_cpuinfo(policy, freq_table);
-       cpufreq_frequency_table_get_attr(freq_table, policy->cpu);
+       cpufreq_table_validate_and_show(policy, freq_table);
        policy->cur = tegra_getspeed(policy->cpu);
        target_cpu_speed[policy->cpu] = policy->cur;


commit f1bb1cab6130501251eee616280b88c0b49d96d7
Author: Viresh Kumar <viresh.kumar@linaro.org>
Date:   Fri Aug 9 09:29:19 2013 +0530

    cpufreq: tegra: fix implementation of ->exit()

    ->exit() of drivers should call cpufreq_frequency_table_put_attr()
if they have
    called cpufreq_frequency_table_get_attr() earlier in init() and they aren't
    required to validate their cpufreq table in exit by calling
    cpufreq_frequency_table_cpuinfo(). Tegra's driver wasn't calling
    cpufreq_frequency_table_put_attr() and was calling
    cpufreq_frequency_table_cpuinfo() in exit.

    Fix both these issues in it.

    Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/tegra-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/tegra-cpufreq.c b/drivers/cpufreq/tegra-cpufreq.c
index 51752b3..faf1ce5 100644
--- a/drivers/cpufreq/tegra-cpufreq.c
+++ b/drivers/cpufreq/tegra-cpufreq.c
@@ -232,7 +232,7 @@ static int tegra_cpu_init(struct cpufreq_policy *policy)

 static int tegra_cpu_exit(struct cpufreq_policy *policy)
 {
-       cpufreq_frequency_table_cpuinfo(policy, freq_table);
+       cpufreq_frequency_table_put_attr(policy->cpu);
        clk_disable_unprepare(emc_clk);
        return 0;
 }
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-cpufreq-Add-new-helper-cpufreq_table_validate_and_sh.patch
Type: application/octet-stream
Size: 2428 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130809/b0a4ba28/attachment.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0035-cpufreq-tegra-use-cpufreq_table_validate_and_show.patch
Type: application/octet-stream
Size: 1458 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130809/b0a4ba28/attachment-0001.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0036-cpufreq-tegra-fix-implementation-of-exit.patch
Type: application/octet-stream
Size: 1565 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130809/b0a4ba28/attachment-0002.obj>
