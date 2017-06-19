From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 19 Jun 2017 12:25:08 +0100
Subject: [PATCH] psci: add debugfs for runtime instrumentation
In-Reply-To: <CAKfTPtBj3RBd+d_LERYdUxoQ706L6wrs5+L+MOTL7aoZmAkZ8w@mail.gmail.com>
References: <1497601420-8783-1-git-send-email-vincent.guittot@linaro.org>
 <20170616114737.GM20092@leverpostej>
 <CAKfTPtBj3RBd+d_LERYdUxoQ706L6wrs5+L+MOTL7aoZmAkZ8w@mail.gmail.com>
Message-ID: <20170619112508.GA24482@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 16, 2017 at 04:26:20PM +0200, Vincent Guittot wrote:
> Hi Mark,
> 
> On 16 June 2017 at 13:47, Mark Rutland <mark.rutland@arm.com> wrote:
> > Hi Vincent,
> >
> > On Fri, Jun 16, 2017 at 10:23:40AM +0200, Vincent Guittot wrote:
> >> Add debugfs to display runtime instrumentation results that can be collected
> >> by PSCI firmware.
> >
> > Could you elaborate on this please? e.g.
> 
> yes sorry. I should have given more details about it
> 
> >
> > * What is instrumented?
> 
> The ARM Trusted Firwware that implements PSCI, also has a Performance
> Measurement Framework (PMF) that can be used to save some timetamps
> when running psci firmware. On top of PMF, serveral services have been
> implemented like the PSCI residency stats and the runtime
> instrumentation service. The latter saves timestamp when a PSCI
> service is entered and then leaved or when cache maintenance is
> executed durign psci call. With these timestamps, we can measure the
> duration of some part of code of the PSCI firmware.
> 
> > * What values can be derived from this?
> 
> The time needed to execute the firmware part of the PSCI and extract
> some min, average and max duration to run some PSCI services
> 
> 
> > * How is this exposed by the driver? (e.g. trace, summation, average?)
> 
> The firmware only exposed some timestamps and this patch compute the
> result to extract some latency information
> 
> 
> > * What is the format of the files? (shouldn't there be documentation?)
> > * Who is this useful for, and when?
> 
> The debugfs provides a snapshot of the timestamps with latency current entry
> 
> And some statistics per CPU with latency_summary entry . I have put
> below an example:
> #cat /sys/kernel/debug/psci/latency_summary
> CPU0   step      min     avg     max   count
>        enter   12502   12502  313396   18665
>        leave   20837   20837  298393   18665
>        cache    4167    4167  256718   18665
> CPU1   step      min     avg     max   count
>        enter   13336   13336  425085   18381
>        leave   21671   21671  308395   18381
>        cache    4167    4167  370074   18381
> CPU2   step      min     avg     max   count
>        enter   12502   12502  267553   18349
>        leave   21671   21671  265053   18349
>        cache    4167    4167  220877   18349
> 
> Such informations are useful when working on cpuidle and power
> management and when studying the cpu entry/wakeup latency
> 
> > * On which platforms is this available, and when?
> 
> The code that save the timestamp is generic and as result available
> for all platforms that implement PSCI. Nevertheless, each platfrom has
> to enable the SMC service. At now, juno and hikey has enable the
> service and hikey960 should some soon as well
> 
> >
> > Is this gathered on each call, periodically, or lazily, when requested
> > by the user?
> 
> At boot, everything is disabled. User has to enable the gathering of
> the timestamp and the computation of the statistics.
> When enable, the statistics are updated on every call to psci_cpu_suspend_enter
> 
> >
> >>
> >> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> >> ---
> >>  drivers/firmware/Kconfig |   8 ++
> >>  drivers/firmware/psci.c  | 366 +++++++++++++++++++++++++++++++++++++++++++++++
> >>  2 files changed, 374 insertions(+)
> >>
> >> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> >> index 6e4ed5a..4431504 100644
> >> --- a/drivers/firmware/Kconfig
> >> +++ b/drivers/firmware/Kconfig
> >> @@ -8,6 +8,14 @@ menu "Firmware Drivers"
> >>  config ARM_PSCI_FW
> >>       bool
> >>
> >> +config ARM_PSCI_INSTRUMENTATION
> >> +     bool "ARM PSCI Run Time Instrumentation"
> >> +     depends on ARM_PSCI_FW && CPU_IDLE && DEBUG_FS
> >> +     help
> >> +       Enable debugfs interface for PSCI FW in which you can retrieve
> >> +       runtime instrumentation values of the PSCI firmware like time to
> >> +       enter or leave a cpu suspend state or time to flush cache.
> >
> > Looking at the latest published spec (ARM DEN 0022D), PSCI doesn't
> > provide such information, as there's only PSCI_STAT_{COUNT,RESIDENCY}.
> 
> This use the same Performance Measurement Framework as
> PSCI_STAT_{COUNT,RESIDENCY}

Except that as Mark pointed out PSCI_STAT_{COUNT, RESIDENCY} are
standard calls and part of the PSCI specification and the rest of the
PMF is implementation defined firmware that is mostly useful for
debugging...firmware :) so why do we even have to bother adding a kernel
debugs layer to read those stats ?

Anyway, I am happy to implement PSCI v1.0 calls to retrieve
PSCI_STAT_{COUNT, RESIDENCY} statistics to add to CPU_IDLE kernel
stats, as for this patch it does not implement anything that is part of
the PSCI specification so there is not much else I can comment on I am
afraid.

Thanks,
Lorenzo

> > What mechanisms are you using here?
> 
> More details can be founded here
> https://github.com/ARM-software/arm-trusted-firmware/blob/master/docs/firmware-design.md#13--performance-measurement-framework
> 
> >
> > As far as I can tell, these are not part of the PSCI standard, and I'm
> > not aware of any documentation.
> >
> > I'm very much not keen on using IMPLEMENTATION DEFINED functionality in
> > the PSCI driver, as IMP DEF stuff always creates long-term maintenance
> > problems. You'll need to convince me that this is worth supporting.
> 
> I will try.
> 
> I have put it in psci.c as it is really about measurement latenccy of
> psci firmware but it can probably be put somewhere else if it is more
> relevant. The only link between current psci driver and this feature
> is the call to psci_update_all_rt_instr() in psci_cpu_suspend_enter()
> to make sure that we have coherent timestamp
> Thinking a bit more about this, we can probably use the cpu_pm_exit
> 
> >
> > [...]
> >
> >> +#ifdef CONFIG_ARM_PSCI_INSTRUMENTATION
> >> +#include <linux/clocksource.h>
> >> +#include <linux/debugfs.h>
> >> +#include <linux/seq_file.h>
> >> +
> >> +#define PMF_SMC_GET_TIMESTAMP_64     0xC2000010
> >
> > What is PMF?
> 
> Performance Monitoring Framework
> 
> >
> > Per the SMCCC, this ID is an atomic {SMC,HVC}64 SiP call.
> >
> > I'm really not keen on using IMP DEF SiP calls like this. These are not
> > part of PSCI.
> >
> >> +
> >> +#define PMF_ARM_TIF_IMPL_ID          0x41
> >> +
> >> +#define PMF_RT_INSTR_SVC_ID          1
> >> +
> >> +#define RT_INSTR_ENTER_PSCI          0
> >> +#define RT_INSTR_EXIT_PSCI           1
> >> +#define RT_INSTR_ENTER_HW_LOW_PWR    2
> >> +#define RT_INSTR_EXIT_HW_LOW_PWR     3
> >> +#define RT_INSTR_ENTER_CFLUSH                4
> >> +#define RT_INSTR_EXIT_CFLUSH         5
> >> +#define RT_INSTR_TOTAL_IDS           6
> >> +
> >> +#define PMF_TID_SHIFT                        0
> >> +#define PMF_TID_MASK                 (0xFF << PMF_TID_SHIFT)
> >> +#define PMF_SVC_ID_SHIFT             10
> >> +#define PMF_SVC_ID_MASK                      (0x3F << PMF_SVC_ID_SHIFT)
> >> +#define PMF_IMPL_ID_SHIFT            24
> >> +#define PMF_IMPL_ID_MASK             (0xFFU << PMF_IMPL_ID_SHIFT)
> >> +
> >> +struct rt_inst_stats {
> >> +     unsigned long min;
> >> +     unsigned long max;
> >> +     unsigned long avg;
> >> +     unsigned long count;
> >> +};
> >> +
> >> +static struct dentry *psci_debugfs_dir;
> >> +
> >> +/* meaningful instrumentation name */
> >> +char *rt_inst_name[RT_INSTR_TOTAL_IDS/2] = {
> >> +     "enter",
> >> +     "leave",
> >> +     "cache"
> >> +};
> >> +
> >> +/* timstamp index to use to compute the delta */
> >> +int rt_inst_delta_idx[RT_INSTR_TOTAL_IDS/2][2] = {
> >> +     /* Start -->                    End */
> >> +     {RT_INSTR_ENTER_PSCI,           RT_INSTR_ENTER_HW_LOW_PWR},
> >> +     {RT_INSTR_EXIT_HW_LOW_PWR,      RT_INSTR_EXIT_PSCI},
> >> +     {RT_INSTR_ENTER_CFLUSH,         RT_INSTR_EXIT_CFLUSH}
> >> +};
> >> +
> >> +DEFINE_PER_CPU(struct rt_inst_stats[RT_INSTR_TOTAL_IDS/2], rt_inst_summary);
> >> +int rt_track_enable;
> >> +
> >> +u32 rt_inst_shift;
> >> +u32 rt_inst_mult = 1;
> >> +
> >> +static bool psci_rt_instr_enable(void)
> >> +{
> >> +     int ret, tid;
> >> +     int cpu_mpidr = cpu_logical_map(0);
> >> +     tid |= PMF_RT_INSTR_SVC_ID << PMF_SVC_ID_SHIFT | RT_INSTR_ENTER_PSCI;
> >
> > What exactly is this tid parameter?
> 
> This tid selects which timestamp to get among the list
> 
> >
> >> +
> >> +     arm_smccc_smc(PMF_SMC_GET_TIMESTAMP_64, tid, cpu_mpidr,
> >> +                     0, 0, 0, 0, 0, &res);
> >> +
> >> +     ret = psci_to_linux_errno(res.a0);
> >
> > The above was not a PSCI call. Does it follow the same return
> > conventions?
> 
> No, psci smc call function only returns a0. In this case of runtime
> instrumentation, a0 is the error code and a1 is the timestamp
> 
> >
> > How big's the returnned timestamp?
> 
> it's a 64bit value
> 
> >
> > How's a big value disambiguated from a negative error code?
> 
> a0 is error code and a1 is the timestamp. the function
> psci_rt_instr_enable() just try to make get a timestamp to check that
> the service is supported by the firmwareso in this case we don't care
> of a1 but we do in psci_get_one_rt_instr_cpu
> 
> >
> >> +
> >> +     if (ret)
> >> +             return false;
> >> +
> >> +     return true;
> >> +}
> >> +
> >> +static long long psci_get_one_rt_instr_cpu(int id, int cpu, int cache)
> >> +{
> >> +     int ret, tid;
> >> +     int cpu_mpidr = cpu_logical_map(cpu);
> >> +     struct arm_smccc_res res;
> >> +
> >> +     tid = PMF_ARM_TIF_IMPL_ID << PMF_IMPL_ID_SHIFT;
> >> +     tid |= PMF_RT_INSTR_SVC_ID << PMF_SVC_ID_SHIFT | id;
> >> +
> >> +     arm_smccc_smc(PMF_SMC_GET_TIMESTAMP_64, tid, cpu_mpidr, cache,
> >> +                     0, 0, 0, 0, &res);
> >
> > What exaclty does this "cache" parameter do?
> 
> When set, this parameter forces a dcache invalidate in the PSCI
> firmware before reading the timestamp
> 
> >
> >> +
> >> +     ret = psci_to_linux_errno(res.a0);
> >> +
> >> +     if (ret)
> >> +             return (long long)(ret);
> >
> > Surely the implicit conversion to the return type is sufficient?
> 
> yes probably. I tend to explicitly cast in order to make the
> conversion easier to identify when reading the code
> 
> >
> >> +
> >> +     return res.a1;
> >> +}
> >> +
> >> +static int psci_get_all_rt_instr_cpu(int cpu, int cache, long long timestamp[])
> >> +{
> >> +     int i;
> >> +
> >> +     for (i = 0; i < RT_INSTR_TOTAL_IDS; i++) {
> >> +             timestamp[i] = psci_get_one_rt_instr_cpu(i, cpu, cache);
> >> +             if (timestamp[i] < 0)
> >> +                     return (int)(timestamp[i]);
> >> +     }
> >> +
> >> +     return 0;
> >> +}
> >> +
> >> +static void psci_update_all_rt_instr(int cpu, int cache)
> >> +{
> >> +     long long tmp_rt_inst[RT_INSTR_TOTAL_IDS];
> >> +     long tmp_delta[RT_INSTR_TOTAL_IDS/2];
> >> +     struct rt_inst_stats *my_stats = per_cpu(rt_inst_summary, cpu);
> >> +     long long start_ts;
> >> +     int i;
> >> +
> >> +     /* Get all RT statistics of the cpu*/
> >> +     if (psci_get_all_rt_instr_cpu(cpu, cache, tmp_rt_inst))
> >> +             /* An error happens while getting timestamp */
> >> +             return;
> >> +
> >> +     /* Get start time */
> >> +     start_ts = tmp_rt_inst[0];
> >> +
> >> +     /* Compute delta time */
> >> +     for (i = 0; i < RT_INSTR_TOTAL_IDS/2; i++) {
> >> +             long long start = tmp_rt_inst[rt_inst_delta_idx[i][0]];
> >> +             long long end = tmp_rt_inst[rt_inst_delta_idx[i][1]];
> >> +
> >> +             /*
> >> +              * If time is before start time, discard the value which come
> >> +              * from a previous call
> >> +              */
> >
> > I don't follow this comment.
> 
> start_ts = tmp_rt_inst[0] is the first timestamp of a PSCI call so if
> another timestamp is before, this probably mean that it comes from
> another call like cache maintenance timestamp not updated for this
> psci call
> 
> I will update the comment to make it clearer
> 
> >
> >> +             if ((start >= start_ts) && (end >= start))
> >> +                     tmp_delta[i] = end - start;
> >> +             else
> >> +                     tmp_delta[i] = -1;
> >> +     }
> >> +
> >> +     for (i = 0; i < RT_INSTR_TOTAL_IDS/2; i++) {
> >> +             if (tmp_delta[i] < 0)
> >> +                     continue;
> >> +
> >> +             if (tmp_delta[i] > my_stats[i].max) {
> >> +                     /* New max value */
> >> +                     my_stats[i].max = tmp_delta[i];
> >> +             }
> >> +             if (tmp_delta[i] < my_stats[i].min) {
> >> +                     /* New min value */
> >> +                     my_stats[i].min = tmp_delta[i];
> >> +             }
> >> +     }
> >> +
> >> +     /* Update avg */
> >> +     for (i = 0; i < RT_INSTR_TOTAL_IDS/2; i++) {
> >> +             unsigned long avg;
> >> +
> >> +             if (tmp_delta[i] < 0)
> >> +                     continue;
> >> +
> >> +             avg = my_stats[i].avg*my_stats[i].count + tmp_delta[i];
> >> +
> >> +             my_stats[i].avg = avg / (my_stats[i].count + 1);
> >> +
> >> +             my_stats[i].count++;
> >> +     }
> >> +}
> >> +
> >> +static void psci_update_all_rt_instr_this_cpu(int cache)
> >> +{
> >> +     if (!rt_track_enable)
> >> +             return;
> >> +
> >> +     psci_update_all_rt_instr(raw_smp_processor_id(), cache);
> >> +}
> >> +
> >> +/* Show latency summary all CPUs */
> >> +static int psci_summary_show(struct seq_file *s, void *data)
> >> +{
> >> +     int cpu, i, ret = 0;
> >> +
> >> +     for_each_online_cpu(cpu) {
> >> +             struct rt_inst_stats *my_stats = per_cpu(rt_inst_summary, cpu);
> >> +
> >> +             seq_printf(s, "CPU%-2d  step      min     avg     max   count\n", cpu);
> >> +
> >> +             for (i = 0; i < RT_INSTR_TOTAL_IDS/2; i++) {
> >> +                     seq_printf(s, "       %5s %7lu %7lu %7lu %7lu\n",
> >> +                             rt_inst_name[i],
> >> +                             (my_stats[i].min * rt_inst_mult) >> rt_inst_shift,
> >> +                             (my_stats[i].avg * rt_inst_mult) >> rt_inst_shift,
> >> +                             (my_stats[i].max * rt_inst_mult) >> rt_inst_shift,
> >> +                             my_stats[i].count);
> >
> > If we race with a CPU updating its stats, we could see junk here.
> 
> we should not see junk but may be some partial results like updated
> value of min, max, avg updated but the count is not updated yet.
> 
> >
> >> +             }
> >> +     }
> >> +
> >> +     return ret;
> >> +}
> >> +
> >> +static int psci_summary_open(struct inode *inode, struct file *file)
> >> +{
> >> +     return single_open(file, psci_summary_show, NULL);
> >> +}
> >> +
> >> +static const struct file_operations psci_summary_fops = {
> >> +     .open = psci_summary_open,
> >> +     .read = seq_read,
> >> +     .llseek = seq_lseek,
> >> +     .release = single_release,
> >> +};
> >> +
> >> +
> >> +/* Enable tracking runtime stats*/
> >> +static int psci_enable_show(struct seq_file *s, void *data)
> >> +{
> >> +     seq_printf(s, "%d\n", rt_track_enable);
> >> +
> >> +     return 0;
> >> +}
> >> +
> >> +static int psci_enable_open(struct inode *inode, struct file *file)
> >> +{
> >> +     return single_open(file, psci_enable_show, NULL);
> >> +}
> >> +
> >> +static ssize_t psci_enable_store(struct file *file,
> >> +     const char __user *user_buf, size_t count, loff_t *ppos)
> >> +{
> >> +     unsigned long val;
> >> +     int i, cpu, ret;
> >> +
> >> +     ret = kstrtoul_from_user(user_buf, count, 10, &val);
> >> +     if (ret)
> >> +             return ret;
> >> +
> >> +     rt_track_enable = !!val;
> >> +
> >> +     if (rt_track_enable)
> >> +             for_each_online_cpu(cpu) {
> >> +                     struct rt_inst_stats *my_stats = per_cpu(rt_inst_summary, cpu);
> >> +
> >> +                     for (i = 0; i < RT_INSTR_TOTAL_IDS/2; i++) {
> >> +                             my_stats[i].min = -1;
> >> +                             my_stats[i].max = 0;
> >> +                             my_stats[i].avg = 0;
> >> +                             my_stats[i].count = 0;
> >> +                     }
> >> +             }
> >> +
> >> +     return count;
> >> +}
> >> +
> >> +static const struct file_operations psci_enable_fops = {
> >> +     .open = psci_enable_open,
> >> +     .write = psci_enable_store,
> >> +     .read = seq_read,
> >> +     .llseek = seq_lseek,
> >> +     .release = single_release,
> >> +};
> >> +
> >> +/* Show current timestamp of all CPUs */
> >> +static int psci_current_show(struct seq_file *s, void *data)
> >> +{
> >> +     int cpu, i, ret = 0;
> >> +
> >> +     seq_puts(s, "CPU  INSTR ID  Timestamp\n");
> >> +
> >> +     for_each_online_cpu(cpu)
> >> +             for (i = 0; i < RT_INSTR_TOTAL_IDS; i++) {
> >> +                     unsigned long long ts;
> >> +
> >> +                     ts = (psci_get_one_rt_instr_cpu(i, cpu, 1) * rt_inst_mult)
> >> +                                     >> rt_inst_shift,
> >> +                     seq_printf(s, "CPU%-2d  INSTR%d timestamp %llu\n",
> >> +                                     cpu, i, ts);
> >> +             }
> >> +
> >> +     return ret;
> >> +}
> >> +
> >> +static int psci_current_open(struct inode *inode, struct file *file)
> >> +{
> >> +     return single_open(file, psci_current_show, NULL);
> >> +}
> >> +
> >> +static const struct file_operations psci_current_fops = {
> >> +     .open = psci_current_open,
> >> +     .read = seq_read,
> >> +     .llseek = seq_lseek,
> >> +     .release = single_release,
> >> +};
> >> +
> >> +static int __init psci_debug_init(void)
> >> +{
> >> +     u64 sec = GENMASK_ULL((56) - 1, 0);
> >
> > It's fine to write 55 directly.
> 
> yes
> 
> >
> > Please note the the timer is guaranteed to be *at least* 56 bits, not
> > *exactly* 56 bits, so you may need additional masking.
> >
> >> +     u32 freq;
> >> +
> >> +     /* Test if runtime instrumentation is enable */
> >> +     if (!psci_rt_instr_enable()) {
> >
> > This is an unconditional initcall, so this simply is not safe.
> 
> you're right, it should be called only if/when psci driver has been probed
> 
> >
> > The platform may not have FW, or no secure world.
> >
> > On systems without a full SMCCC implementation (e.g. many PSCI 0.1
> > implementations), this will also be bad.
> >
> >> +             pr_info("PSCI RunTime Instrumentation not supported\n");
> >> +             return 0;
> >> +     }
> >> +
> >> +     /*
> >> +      * PSCI instrumentation uses same timer ip as arm_arch_timer to count
> >> +      * clock cycle so we reuse some clocksource helpers to translate cycle
> >> +      * into ns
> >> +      */
> >> +
> >> +     /* Get counter frequency */
> >> +     freq = read_sysreg(cntfrq_el0);
> >
> > On some platforms, CNTFRQ is wrong.
> >
> > I really don't like tying this into the arch timer driver.
> 
> Not sure to catch your concern ? we don't touch the arch timer and in
> fact we don't even need it but only reuse some helpers function of
> clocksource to convert cycle into ns.
> On kernel side, we only get timestamps from the smc call and this
> timestamp are then converted in ns but we don't use anything directly
> from arm_arch_timer
> 
> Regards,
> Vincent
> 
> >
> > Thanks,
> > Mark.
> >
> >> +
> >> +     /* Compute max run time */
> >> +     do_div(sec, freq);
> >> +
> >> +     /*
> >> +      * Compute mul and shift values that will be used to convert cycle in
> >> +      * ns thanks to the formula ns = (cyc * mult) >> shift
> >> +      */
> >> +     clocks_calc_mult_shift(&rt_inst_mult, &rt_inst_shift, freq,
> >> +                                    NSEC_PER_SEC, sec);
> >> +
> >> +     /* Create debugfs entries */
> >> +     psci_debugfs_dir = debugfs_create_dir("psci", NULL);
> >> +
> >> +     if (!psci_debugfs_dir)
> >> +             return -ENOMEM;
> >> +
> >> +     if (!debugfs_create_file("latency_current", 0444,
> >> +                     psci_debugfs_dir, NULL, &psci_current_fops))
> >> +             goto error;
> >> +
> >> +     if (!debugfs_create_file("enable", 0644,
> >> +                     psci_debugfs_dir, NULL, &psci_enable_fops))
> >> +             goto error;
> >> +
> >> +     if (!debugfs_create_file("latency_summary", 0444,
> >> +                     psci_debugfs_dir, NULL, &psci_summary_fops))
> >> +             goto error;
> >> +
> >> +     return 0;
> >> +
> >> +error:
> >> +     debugfs_remove_recursive(psci_debugfs_dir);
> >> +     return -ENOMEM;
> >> +}
> >> +late_initcall(psci_debug_init);
> >> +
> >> +static void __exit psci_debug_exit(void)
> >> +{
> >> +     debugfs_remove_recursive(psci_debugfs_dir);
> >> +}
> >> +__exitcall(psci_debug_exit);
> >> +
> >> +#elif defined(CONFIG_CPU_IDLE)
> >> +static void psci_update_all_rt_instr_this_cpu(int cache) {}
> >> +#endif
> >> --
> >> 2.7.4
> >>
