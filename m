From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 7 Mar 2013 08:32:37 +0800
Subject: [PATCH] cpufreq: ARM big LITTLE: Add generic cpufreq driver and
 its DT glue
In-Reply-To: <20130305105251.GL17833@n2100.arm.linux.org.uk>
References: <f20e3c5e822c4bd28a3b71264d73143cc1f850b0.1362458878.git.viresh.kumar@linaro.org>
 <20130305105251.GL17833@n2100.arm.linux.org.uk>
Message-ID: <CAKohpo=cBkHZnSa8ZsM=k7RRN+RZDXFUWDM82EXXBSQcM-8Vhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 March 2013 18:52, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Tue, Mar 05, 2013 at 12:52:41PM +0800, Viresh Kumar wrote:
>> +     clk[cluster] = clk_get(NULL, name);
>> +     if (!IS_ERR_OR_NULL(clk[cluster])) {
>
> NAK.  Two reasons.
>
> 1. IS_ERR_OR_NULL.  You know about this, it's been on the list several
>    times.

Hey, i had a second thought about this one and i have some other opinion
here. This is a cpufreq driver and we need clock support for sure here, we
can't work without it. And so here is the latest fixup:

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index fdf54a9..87b7e48 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -9,8 +9,7 @@ config ARM_BIG_LITTLE_CPUFREQ
 config ARM_DT_BL_CPUFREQ
        tristate "Generic ARM big LITTLE CPUfreq driver probed via DT"
        select ARM_BIG_LITTLE_CPUFREQ
-       depends on OF
-       default n
+       depends on OF && HAVE_CLK
        help
          This enables the Generic CPUfreq driver for ARM big.LITTLE platform.
          This gets frequency tables from DT.
diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index 2486b9a..d1fdc65 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -147,7 +147,7 @@ static void put_cluster_clk_and_freq_table(u32 cluster)

 static int get_cluster_clk_and_freq_table(u32 cluster)
 {
-       char name[9] = "cluster";
+       char name[9] = "cpu-cluster";
        int count;

        if (atomic_inc_return(&cluster_usage[cluster]) != 1)
@@ -159,7 +159,7 @@ static int get_cluster_clk_and_freq_table(u32 cluster)

        name[7] = cluster + '0';
        clk[cluster] = clk_get_sys(name, NULL);
-       if (!IS_ERR(clk[cluster])) {
+       if (!IS_ERR_OR_NULL(clk[cluster])) {
                pr_debug("%s: clk: %p & freq table: %p, cluster: %d\n",
                                __func__, clk[cluster], freq_table[cluster],
                                cluster);
