From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Apr 2017 15:57:30 +0100
Subject: [PATCH] arm64: Print DT machine model in setup_machine_fdt()
In-Reply-To: <1493296385-14140-1-git-send-email-geert+renesas@glider.be>
References: <1493296385-14140-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170428145730.GS13675@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 27, 2017 at 02:33:05PM +0200, Geert Uytterhoeven wrote:
> On arm32, the machine model specified in the device tree is printed
> during boot-up, courtesy of of_flat_dt_match_machine().
> 
> On arm64, of_flat_dt_match_machine() is not called, and the machine
> model information is not available from the kernel log.
> 
> Print the machine model to make it easier to derive the machine model
> from an arbitrary kernel boot log.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> I have scripts to save kernel boot logs, and compare logs[*] for
> subsequent boots on the same machine.  Having a way to extract the
> machine model from an arbitrary kernel boot log makes this easier.
> 
> Yes, I'm also a big fan of CONFIG_LOCALVERSION_AUTO and
> CONFIG_LOCALVERSION.
> 
> [*] and clock and PM domain lists...
> ---
>  arch/arm64/kernel/setup.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 28855ec1be95e113..2c822ef94f341417 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -180,6 +180,7 @@ static void __init smp_build_mpidr_hash(void)
>  static void __init setup_machine_fdt(phys_addr_t dt_phys)
>  {
>  	void *dt_virt = fixmap_remap_fdt(dt_phys);
> +	const char *name;
>  
>  	if (!dt_virt || !early_init_dt_scan(dt_virt)) {
>  		pr_crit("\n"
> @@ -192,7 +193,9 @@ static void __init setup_machine_fdt(phys_addr_t dt_phys)
>  			cpu_relax();
>  	}
>  
> -	dump_stack_set_arch_desc("%s (DT)", of_flat_dt_get_machine_name());
> +	name = of_flat_dt_get_machine_name();
> +	pr_info("Machine model: %s\n", name);
> +	dump_stack_set_arch_desc("%s (DT)", name);
>  }

I think your use-case is slightly questionable (e.g. for ACPI, we print
something different, and this isn't generally considered to be ABI), but
the patch is harmless and if you find it useful then:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
