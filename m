From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 21 Nov 2018 16:08:14 +0000
Subject: [PATCH v3] perf: xgene: Add CPU hotplug support
In-Reply-To: <1541619650-5953-1-git-send-email-hoan@os.amperecomputing.com>
References: <1541619650-5953-1-git-send-email-hoan@os.amperecomputing.com>
Message-ID: <20181121160814.u2vrkbtdxzsz5o4j@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hoan,

On Wed, Nov 07, 2018 at 07:40:58PM +0000, Hoan Tran wrote:
> From: Hoan Tran <Hoan@os.amperecomputing.com>
> 
> This patch adds CPU hotplug support where the PMU migrates the context to
> another online CPU when its CPU is offline.
> 
> It fixes the below issue where the user does offline the CPU which is assigned
> to this PMU.
> 
> Assuming, CPU0 is assigned for this PMU. When the user does offline CPU0
> 	[root@(none) ~]# echo 0 > /sys/devices/system/cpu/cpu0/online
> This PMU does not work anymore and shows the below error.
> 	[root@(none) ~]# perf stat -a -e l3c0/cycle-count/,l3c0/write/ sleep 1
> 	Error:
> 	The sys_perf_event_open() syscall returned with 19 (No such device) for event (l3c0/cycle-count/).
> 	/bin/dmesg may provide additional information.
> 	No CONFIG_PERF_EVENTS=y kernel support configured?
> 
> With this patch, when CPU0 is offline, PMU migrates to another online CPU and
> works on that CPU.
> 
> Signed-off-by: Hoan Tran <hoan.tran@amperecomputing.com>
> ---
> v3:
>  * Remove email footer
>  * Fix the space issue
> 
> v2:
>  * Remove the cpuhp instance when unregistering the PMU

Aside from one minor fixup below, this looks good to me, and with that
applied:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Will, are you happy to apply that fixup when picking the patch?

[...]

> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 8796ba3..afefca8a 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -164,6 +164,7 @@ enum cpuhp_state {
>  	CPUHP_AP_PERF_POWERPC_NEST_IMC_ONLINE,
>  	CPUHP_AP_PERF_POWERPC_CORE_IMC_ONLINE,
>  	CPUHP_AP_PERF_POWERPC_THREAD_IMC_ONLINE,
> +	CPUHP_AP_PERF_XGENE_ONLINE,


All the other ARM vendors have named their callbacks with a prefix:

	CPUHP_AP_PERF_ARM_*

... e.g.

	CPUHP_AP_PERF_ARM_HISI_DDRC_ONLINE,
	CPUHP_AP_PERF_ARM_QCOM_L2_ONLINE,

... for consistency I'd prefer if  we could rename this state to:

	CPUHP_AP_PERF_ARM_XGENE_ONLINE,

... or:

	CPUHP_AP_PERF_ARM_APM_XGENE_ONLINE,


... and place it adjacent to those other entries, fixing up the uses as
appropriate.

Thanks,
Mark.
