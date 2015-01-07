From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Wed, 7 Jan 2015 12:50:23 +0530
Subject: [PATCH v2 3/8] ARM: MB86S7X: Add MCPM support
In-Reply-To: <alpine.LFD.2.11.1412151448520.1143@knanqh.ubzr>
References: <1418626369-3004-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <1418627216-3146-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <alpine.LFD.2.11.1412151448520.1143@knanqh.ubzr>
Message-ID: <CAJe_ZheoQZL4UQ8LJ7XbhPoftKwJkrmRwasYEvKMeeHM1D6S5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 December 2014 at 01:45, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Mon, 15 Dec 2014, Vincent Yang wrote:
>
....
>> +
>> +static int mb86s7x_pm_power_up(unsigned int cpu, unsigned int cluster)
>> +{
>> +     int ret = 0;
>> +
>> +     if (cluster >= S7X_MAX_CLUSTER || cpu >= S7X_MAX_CPU)
>> +             return -EINVAL;
>> +
>> +     pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
>> +
>> +     local_irq_disable();
>> +     arch_spin_lock(&mb86s7x_pm_lock);
>> +
>> +     mb86s7x_pm_use_count[cluster][cpu]++;
>> +
>> +     if (mb86s7x_pm_use_count[cluster][cpu] == 1) {
>> +             struct mb86s7x_cpu_gate cmd;
>> +
>> +             mb86s7x_set_wficolor(cluster, cpu, AT_WFI_DO_NOTHING);
>> +             arch_spin_unlock(&mb86s7x_pm_lock);
>> +             local_irq_enable();
>> +
>> +             cmd.payload_size = sizeof(cmd);
>> +             cmd.cluster_class = 0;
>> +             cmd.cluster_id = cluster;
>> +             cmd.cpu_id = cpu;
>> +             cmd.cpu_state = SCB_CPU_STATE_ON;
>> +
>> +             pr_debug("%s:%d CMD Cl_Class-%u CL_ID-%u CPU_ID-%u STATE-%u}\n",
>> +                      __func__, __LINE__, cmd.cluster_class,
>> +                      cmd.cluster_id, cmd.cpu_id, cmd.cpu_state);
>> +
>> +             ret = mb86s7x_send_packet(CMD_CPU_CLOCK_GATE_SET_REQ,
>> +                                       &cmd, sizeof(cmd));
>> +             if (ret < 0) {
>> +                     pr_err("%s:%d failed!\n", __func__, __LINE__);
>> +                     return ret;
>> +             }
>> +
>> +             pr_debug("%s:%d REP Cl_Class-%u CL_ID-%u CPU_ID-%u STATE-%u}\n",
>> +                      __func__, __LINE__, cmd.cluster_class,
>> +                      cmd.cluster_id, cmd.cpu_id, cmd.cpu_state);
>> +
>> +             if (cmd.cpu_state != SCB_CPU_STATE_ON)
>> +                     return -ENODEV;
>> +     } else if (mb86s7x_pm_use_count[cluster][cpu] != 2) {
>> +             /*
>> +              * The only possible values are:
>> +              * 0 = CPU down
>> +              * 1 = CPU (still) up
>> +              * 2 = CPU requested to be up before it had a chance
>> +              *     to actually make itself down.
>> +              * Any other value is a bug.
>> +              */
>> +             BUG();
>> +     }
>> +
>> +     return 0;
>
> It is well possible for mb86s7x_pm_use_count[cluster][cpu] to be 2 here.
> In which case you are returning with mb86s7x_pm_lock still locked and
> IRQs disabled.
>
Yeah, thanks for pointing out.

>> +
>> +     cmd.payload_size = sizeof(cmd);
>> +     cmd.version = 0;
>> +     cmd.config_version = 0;
>> +     ret = mb86s7x_send_packet(CMD_SCB_CAPABILITY_GET_REQ,
>> +                               &cmd, sizeof(cmd));
>> +     if (ret < 0)
>> +             pr_err("%s:%d failed to get SCB version\n",
>> +                    __func__, __LINE__);
>
> Wouldn't it be better to return an error here as well rather than
> continuing with potentially bad data?
>
The data is not used for anything other than dumping on the screen for
debug purposes. Though we should avoid printing the following pr_info
if this returned error.
>> +
>> +     pr_info("MB86S7x MCPM initialized: SCB version 0x%x:0x%x\n",
>> +             cmd.version, cmd.config_version);
>> +
....

>> +     ret = mcpm_platform_register(&mb86s7x_pm_power_ops);
>> +     if (!ret)
>> +             ret = mcpm_sync_init(mb86s7x_pm_power_up_setup);
>> +     if (!ret)
>> +             ret = mcpm_loopback(mb86s7x_cache_off); /* turn on the CCI */
>> +     mcpm_smp_set_ops();
>
> You should call mcpm_smp_set_ops() only if none of the precedent calls
> returned an error.
>
OK.

>> diff --git a/drivers/soc/mb86s7x/scb_mhu.c b/drivers/soc/mb86s7x/scb_mhu.c
>> index 72070f1..f4276d7 100644
>> --- a/drivers/soc/mb86s7x/scb_mhu.c
>> +++ b/drivers/soc/mb86s7x/scb_mhu.c
>> @@ -35,7 +35,7 @@ static struct mbox_client mhu_cl;
>>  static struct mbox_chan *mhu_chan;
>>  static mb86s7x_mhu_handler_t handler[MHU_NUM_CMDS];
>>
>> -void __iomem *mhu_base, *mb86s7x_shm_base;
>> +static void __iomem *mhu_base, *mb86s7x_shm_base;
>
> This should probably be done in the patch that introduced it instead.
>
>>  static void __iomem *cmd_to_scb, *rsp_to_scb;
>>  static void __iomem *cmd_from_scb, *rsp_from_scb;
>>
>> @@ -81,15 +81,27 @@ static int mhu_fsm[4][4] = {
>>       },
>>  };
>>
>> -struct mhu_xfer {
>> +static struct mhu_xfer {
>>       int code;
>>       int len;
>>       void *buf;
>>       struct completion *c;
>>       struct list_head node;
>> -};
>> +} *ax; /* stages of xfer */
>
> Ditto for the above.
>
Yeah, will do.

Thanks,
Jassi
