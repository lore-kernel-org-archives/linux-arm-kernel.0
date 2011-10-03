From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 03 Oct 2011 15:12:46 -0400 (EDT)
Subject: [PATCH v4 02/10] ARM: SoC: Add per SoC SMP and CPU hotplug
	operations
In-Reply-To: <1317663356-5114-3-git-send-email-marc.zyngier@arm.com>
References: <1317663356-5114-1-git-send-email-marc.zyngier@arm.com>
	<1317663356-5114-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <alpine.LFD.2.02.1110031508270.9106@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 3 Oct 2011, Marc Zyngier wrote:

> Populate the SoC descriptor structure with the SMP and CPU hotplug
> operations. To allow the kernel to continue building, the platform
> hooks are defined as weak symbols which are overrided by the
> platform code. Once all platforms are converted, the "weak" attribute
> will be removed and the function made static.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
[...]
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -141,8 +141,12 @@ static const char *cpu_name;
>  static const char *machine_name;
>  static char __initdata cmd_line[COMMAND_LINE_SIZE];
>  struct machine_desc *machine_desc __initdata;
> -const struct arm_soc_desc *soc_desc;
> -static struct arm_soc_desc __soc_desc __read_mostly;
> +const struct arm_soc_desc *soc_desc __initdata;

Does the above belong in this patch?

> +#ifdef CONFIG_SMP
> +const struct arm_soc_smp_init_ops *soc_smp_init_ops  __initdata;
> +const struct arm_soc_smp_ops *soc_smp_ops  __cpuinitdata;
> +static struct arm_soc_smp_ops __soc_smp_ops __cpuinitdata;
> +#endif

Maybe those could be moved in smp.c instead.


Nicolas
