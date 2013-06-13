From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 13 Jun 2013 09:05:05 -0600
Subject: [PATCH V2 2/2] ARM: decouple CPU offlining from reboot/shutdown
In-Reply-To: <CAMj5BkiV29fWkk6k_Q=5ThSS-4hitvNZv0MFi86f5O=1Ma3Dhg@mail.gmail.com>
References: <1371067281-655-1-git-send-email-swarren@wwwdotorg.org>
 <1371067281-655-2-git-send-email-swarren@wwwdotorg.org>
 <CAMj5BkiV29fWkk6k_Q=5ThSS-4hitvNZv0MFi86f5O=1Ma3Dhg@mail.gmail.com>
Message-ID: <51B9DFA1.7030001@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/2013 07:58 PM, zhangfei gao wrote:
> On Thu, Jun 13, 2013 at 4:01 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
...
> Hi, Setphen
> 
> We also met the issue: fail to reboot system from panic.
> Solve it by the following change.
> 
> cpu_die is function kill cpu itself
> cpu_kill is functoin to check whethe the cpu is dead or not
> 
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c

> @@ -554,6 +554,9 @@ static void ipi_cpu_stop(unsigned int cpu)

> +#ifdef CONFIG_HOTPLUG_CPU
> +       cpu_die();
> +#endif
>         while (1)
>                 cpu_relax();
>  }
> 
> What do you think?

That probably works too, since it pairs cpu_die/cpu_kill, although the
patch I sent ends up running less code during the halt/power_off/restart
path, which seems like a good idea; less stuff to potentially break.
