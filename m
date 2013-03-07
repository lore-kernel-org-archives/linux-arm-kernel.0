From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 8 Mar 2013 01:04:51 +0800
Subject: [PATCH] cpufreq: ARM big LITTLE: Add generic cpufreq driver and
 its DT glue
In-Reply-To: <20130307114950.GF17833@n2100.arm.linux.org.uk>
References: <f20e3c5e822c4bd28a3b71264d73143cc1f850b0.1362458878.git.viresh.kumar@linaro.org>
 <20130305105251.GL17833@n2100.arm.linux.org.uk>
 <CAKohpo=cBkHZnSa8ZsM=k7RRN+RZDXFUWDM82EXXBSQcM-8Vhw@mail.gmail.com>
 <20130307005119.GY17833@n2100.arm.linux.org.uk>
 <CAKohpok7aD-J-undUisxaOotbXWimPo46jqOH4ok04kg_hMWHA@mail.gmail.com>
 <20130307114950.GF17833@n2100.arm.linux.org.uk>
Message-ID: <CAKohpomp_DFi3GAJeTUiQowyEvfXcmTeuf9+O0qcXsXtbFkTDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 March 2013 19:49, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> So how is this different from any other clock which may also return zero
> from its clk_get_rate() ?
>
> If that's the condition you want to check for, call clk_get_rate() after
> a successful clk_get*() and check for the condition.  Don't go treating
> the cookie somehow specially.  You're *assuming* a behaviour that is
> inappropriate for the side of the interface you're working with.

Okay. I will replace the earlier fixup with following:

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
index 2486b9a..a41fd89 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -147,7 +147,7 @@ static void put_cluster_clk_and_freq_table(u32 cluster)

 static int get_cluster_clk_and_freq_table(u32 cluster)
 {
-       char name[9] = "cluster";
+       char name[9] = "cpu-cluster";
        int count;

        if (atomic_inc_return(&cluster_usage[cluster]) != 1)


For more clarity i will resend this patch now will all updates.
