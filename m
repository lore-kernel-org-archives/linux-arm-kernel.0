From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 15 Dec 2014 10:45:48 +0000
Subject: [PATCH] ARM: display machine model in cpuinfo
In-Reply-To: <1418566387-16468-1-git-send-email-zajec5@gmail.com>
References: <1418566387-16468-1-git-send-email-zajec5@gmail.com>
Message-ID: <20141215104548.GB462@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 14, 2014 at 02:13:07PM +0000, Rafa? Mi?ecki wrote:
> This may be useful to display hardware model in the /proc/cpuinfo. It
> definitely helps to identify the device and there are some archs already
> doing that (arm64, m32r, mips).

Not true for arm64, if you look in linux-next.

I'm rather wary of exposing this kind via cpuinfo because it's
completely arbitrary in nature and not guaranteed to be in any way
useful (I have seen dtbs where the model string is misleading due to
copy+paste and no modificiation).

Mark.

> Use the model from DT and add it to the cpuinfo.
> 
> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
> ---
>  arch/arm/kernel/setup.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index c031063..957d9ac 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -145,6 +145,7 @@ EXPORT_SYMBOL(elf_platform);
>  
>  static const char *cpu_name;
>  static const char *machine_name;
> +static const char *hardware;
>  static char __initdata cmd_line[COMMAND_LINE_SIZE];
>  const struct machine_desc *machine_desc __initdata;
>  
> @@ -899,7 +900,8 @@ void __init setup_arch(char **cmdline_p)
>  	if (!mdesc)
>  		mdesc = setup_machine_tags(__atags_pointer, __machine_arch_type);
>  	machine_desc = mdesc;
> -	machine_name = mdesc->name;
> +	machine_name = of_flat_dt_get_machine_name();
> +	hardware = mdesc->name;
>  
>  	if (mdesc->reboot_mode != REBOOT_HARD)
>  		reboot_mode = mdesc->reboot_mode;
> @@ -1077,7 +1079,8 @@ static int c_show(struct seq_file *m, void *v)
>  		seq_printf(m, "CPU revision\t: %d\n\n", cpuid & 15);
>  	}
>  
> -	seq_printf(m, "Hardware\t: %s\n", machine_name);
> +	seq_printf(m, "Machine\t\t: %s\n", machine_name);
> +	seq_printf(m, "Hardware\t: %s\n", hardware);
>  	seq_printf(m, "Revision\t: %04x\n", system_rev);
>  	seq_printf(m, "Serial\t\t: %08x%08x\n",
>  		   system_serial_high, system_serial_low);
> -- 
> 1.8.4.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
