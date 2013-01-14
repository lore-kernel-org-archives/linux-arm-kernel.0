From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Jan 2013 13:32:08 +0000
Subject: [PATCH] ARM: imx: disable cpu in .cpu_kill hook
In-Reply-To: <1358168977-9631-1-git-send-email-shawn.guo@linaro.org>
References: <1358168977-9631-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130114133208.GC23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 09:09:37PM +0800, Shawn Guo wrote:
>  void imx_cpu_die(unsigned int cpu)
>  {
> +	static int spurious;
> +
>  	cpu_enter_lowpower();
> -	imx_enable_cpu(cpu, false);
> +	cpu_do_idle();
> +	cpu_leave_lowpower();
>  
> -	/* spin here until hardware takes it down */
> -	while (1)
> -		;
> +	pr_warn("CPU%u: %u spurious wakeup calls\n", cpu, ++spurious);

Returning from the platform cpu die implementation should only be done
in extreme situations, particularly where there's no possibility for the
CPU to actually be taken offline (in other words, the ARM development
platforms where there is _no_ possibility of powering down or resetting
the secondary CPUs individually.)

I'm actually thinking about supplementing cpu_die() in arch/arm/kernel/smp.c
with a warning:

@@ -259,6 +259,9 @@ void __ref cpu_die(void)
         */
        platform_cpu_die(cpu);

+       pr_warn("CPU%u: platform cpu_die() returned, trying to resuscitate\n",
+               cpu);
+

so that people get warned of this buggy behaviour.
