From: al.stone@linaro.org (Al Stone)
Date: Mon, 30 Mar 2015 15:53:12 -0600
Subject: [Linaro-acpi] [PATCH 1/2] ARM64 / ACPI: Ignore the return error
 value of acpi_map_gic_cpu_interface()
In-Reply-To: <1427458476-20140-1-git-send-email-hanjun.guo@linaro.org>
References: <1427458476-20140-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <5519C5C8.2020903@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/27/2015 06:14 AM, Hanjun Guo wrote:
> MADT table scannig will stopped once it gets the errors
> returned by the handler, which is acpi_map_gic_cpu_interface()
> in for ARM64, so Ignore the return error value to search for
> all enabled CPUs for SMP init.

I think the comment should say something like:

MADT scanning will stop when it gets an error from the handler,
acpi_map_gic_cpu_interface(), on arm64.  However, we need to
find all of the enabled CPUs so that SMP initialization can work
properly.  So, if an error occurs in this case, ignore it for
now so that we can find all of the enabled CPUs.

Is that what you meant, Hanjun?

> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  arch/arm64/kernel/acpi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index 07649e4..c263cba 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -181,7 +181,8 @@ acpi_parse_gic_cpu_interface(struct acpi_subtable_header *header,
>  		return -EINVAL;
>  
>  	acpi_table_print_madt_entry(header);
> -	return acpi_map_gic_cpu_interface(processor);
> +	acpi_map_gic_cpu_interface(processor);
> +	return 0;
>  }
>  
>  /* Parse GIC cpu interface entries in MADT for SMP init */
> 


-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone at linaro.org
-----------------------------------
