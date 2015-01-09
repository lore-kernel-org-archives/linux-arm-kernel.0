From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Fri, 9 Jan 2015 18:53:23 +0530
Subject: [PATCH v3 3/8] ARM: MB86S7X: Add MCPM support
In-Reply-To: <20150109124134.GK12302@n2100.arm.linux.org.uk>
References: <1420802369-3840-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <1420802934-4084-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <20150109124134.GK12302@n2100.arm.linux.org.uk>
Message-ID: <CAJe_Zhcyxz5vPNGz4HPK3Y33fBuyUadS7fC82X_WOvnyTKnsFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 January 2015 at 18:11, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jan 09, 2015 at 07:28:54PM +0800, Vincent Yang wrote:
>> +static int __init mb86s7x_mcpm_init(void)
>> +{
>> +     unsigned int mpidr, cpu, cluster;
>> +     struct mb86s7x_scb_version cmd;
>> +     int ret;
>> +
>> +     if (!cci_probed())
>> +             return -ENODEV;
>> +
>> +     mpidr = read_cpuid_mpidr();
>> +     cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
>> +     cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
>> +
>> +     pr_info("Booting on cpu_%u cluster_%u\n", cpu, cluster);
>> +     mb86s7x_pm_use_count[cluster][cpu] = 1;
>> +
>> +     /* reset the wfi 'color' for primary cpu */
>> +     mb86s7x_set_wficolor(cluster, cpu, AT_WFI_DO_NOTHING);
>> +
>> +     /* Do SMC to set entry address for CPUs coming online */
>> +     mb86s7x_cpu_entry(virt_to_phys(mcpm_entry_point));
>> +
>> +     cmd.payload_size = sizeof(cmd);
>> +     cmd.version = 0;
>> +     cmd.config_version = 0;
>> +     ret = mb86s7x_send_packet(CMD_SCB_CAPABILITY_GET_REQ,
>> +                               &cmd, sizeof(cmd));
>> +     if (ret < 0) /* non fatal */
>> +             pr_err("%s:%d failed to get SCB version\n",
>> +                    __func__, __LINE__);
>> +     else
>> +             pr_err("MB86S7x SCB version 0x%x:0x%x\n",
>> +                    cmd.version, cmd.config_version);
>> +
>> +     ret = mcpm_platform_register(&mb86s7x_pm_power_ops);
>> +     if (!ret)
>> +             ret = mcpm_sync_init(mb86s7x_pm_power_up_setup);
>> +     if (!ret)
>> +             ret = mcpm_loopback(mb86s7x_cache_off); /* turn on the CCI */
>> +     if (!ret)
>> +             mcpm_smp_set_ops();
>> +
>> +     return ret;
>> +}
>> +early_initcall(mb86s7x_mcpm_init);
>
> What happens if this is built into a kernel running on another SoC where
> CCI has been probed?
>
Yeah, need to check for presence of "fujitsu,mb86s70-scb-1.0" node at
the start of this and other xxx_initcall()s.

thanks
jassi
