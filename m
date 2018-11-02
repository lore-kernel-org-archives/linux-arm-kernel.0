From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 2 Nov 2018 09:55:14 +0000
Subject: [PATCH v2] ARM:kexec:offline panic_smp_self_stop CPU
In-Reply-To: <5BDBB6FF.6080907@huawei.com>
References: <1541071249-15660-1-git-send-email-wangyufen@huawei.com>
 <20181101113430.GO30658@n2100.armlinux.org.uk>
 <5BDBB6FF.6080907@huawei.com>
Message-ID: <20181102095513.GQ30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 02, 2018 at 10:31:27AM +0800, wangyufen wrote:
> In case panic() and panic() called at the same time on different CPUS.
> For example:
> CPU 0:
>   panic()
>      __crash_kexec
>        machine_crash_shutdown
>          crash_smp_send_stop
>        machine_kexec
>          BUG_ON(num_online_cpus() > 1);
> 
> CPU 1:
>   panic()
>     local_irq_disable
>     panic_smp_self_stop
> 
> If CPU 1 calls panic_smp_self_stop() before crash_smp_send_stop(), kdump
> fails. CPU1 can't receive the ipi irq, CPU1 will be always online.
> To fix this problem, this patch split out the panic_smp_self_stop()
> and add set_cpu_online(smp_processor_id(), false).

Looks fine now, please send it to the patch system (details in my
signature.)  Thanks.

> 
> Signed-off-by: Yufen Wang <wangyufen@huawei.com>
> ---
>  arch/arm/kernel/smp.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 9000d8b..d7b86e4 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -682,6 +682,21 @@ void smp_send_stop(void)
>  		pr_warn("SMP: failed to stop secondary CPUs\n");
>  }
>  
> +/* In case panic() and panic() called at the same time on CPU1 and CPU2,
> + * and CPU 1 calls panic_smp_self_stop() before crash_smp_send_stop()
> + * CPU1 can't receive the ipi irqs from CPU2, CPU1 will be always online,
> + * kdump fails. So split out the panic_smp_self_stop() and add
> + * set_cpu_online(smp_processor_id(), false).
> + */
> +void panic_smp_self_stop(void)
> +{
> +	pr_debug("CPU %u will stop doing anything useful since another CPU has paniced\n",
> +	         smp_processor_id());
> +	set_cpu_online(smp_processor_id(), false);
> +	while (1)
> +		cpu_relax();
> +}
> +
>  /*
>   * not supported here
>   */
> -- 
> 2.7.4
> 
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
