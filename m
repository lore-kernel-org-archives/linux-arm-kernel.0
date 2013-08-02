From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 2 Aug 2013 18:18:00 +0100
Subject: [PATCH] xen/arm: missing put_cpu in xen_percpu_init
In-Reply-To: <1375113966-2859-1-git-send-email-julien.grall@linaro.org>
References: <1375113966-2859-1-git-send-email-julien.grall@linaro.org>
Message-ID: <alpine.DEB.2.02.1308021817030.4893@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 29 Jul 2013, Julien Grall wrote:
> When CONFIG_PREEMPT is enabled, Linux will not be able to boot and warn:
> [    4.127825] ------------[ cut here ]------------
> [    4.133376] WARNING: at init/main.c:699 do_one_initcall+0x150/0x158()
> [    4.140738] initcall xen_init_events+0x0/0x10c returned with preemption imbalance
> 
> This is because xen_percpu_init uses get_cpu but doesn't have the corresponding
> put_cpu.
> 
> Signed-off-by: Julien Grall <julien.grall@linaro.org>

Ops. Thanks for catching the bug.
I'll add this to my queue.


>  arch/arm/xen/enlighten.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> index f71c37e..dc9f284 100644
> --- a/arch/arm/xen/enlighten.c
> +++ b/arch/arm/xen/enlighten.c
> @@ -170,6 +170,7 @@ static void __init xen_percpu_init(void *unused)
>  	per_cpu(xen_vcpu, cpu) = vcpup;
>  
>  	enable_percpu_irq(xen_events_irq, 0);
> +	put_cpu();
>  }
>  
>  static void xen_restart(char str, const char *cmd)
> -- 
> 1.7.10.4
> 
