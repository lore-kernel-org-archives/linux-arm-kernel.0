From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 8 Dec 2015 12:34:33 +0000
Subject: [PATCH v4] acpi, apei, arm64: APEI initial support for aarch64.
In-Reply-To: <1449558183-12259-1-git-send-email-fu.wei@linaro.org>
References: <1449558183-12259-1-git-send-email-fu.wei@linaro.org>
Message-ID: <20151208123433.GB404@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 08, 2015 at 03:03:03PM +0800, fu.wei at linaro.org wrote:
> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>

[...]

> +#if defined(__i386__) || defined(__x86_64__)
>  /*
>   * Check if firmware advertises firmware first mode. We need FF bit to be set
>   * along with a set of MC banks which work in FF mode.
>   */
>  static int __init hest_parse_cmc(struct acpi_hest_header *hest_hdr, void *data)
>  {
> -	return arch_apei_enable_cmcff(hest_hdr, data);
> +	if (!acpi_disable_cmcff)

Why do not you define the flag above in this file (move it out of x86 -
that's what I was aiming at in my previous reply) and remove this ifdeffery
altogether (First firmware handling could apply to arm64 too according to
specs and ACPI on arm64 guidelines) ?

arch_apei_enable_cmcff() is a weak function that does nothing on arm64
and if we need to add an implementation we can do it later.

Thanks,
Lorenzo

> +		return !arch_apei_enable_cmcff(hest_hdr, data);
> +
> +	return 0;
>  }
>  
> +static inline int __init hest_ia_init(void)
> +{
> +	return apei_hest_parse(hest_parse_cmc, NULL);
> +}
> +#else
> +static inline int __init hest_ia_init(void) { return 0; }
> +#endif
> +
>  struct ghes_arr {
>  	struct platform_device **ghes_devs;
>  	unsigned int count;
> @@ -232,8 +244,9 @@ void __init acpi_hest_init(void)
>  		goto err;
>  	}
>  
> -	if (!acpi_disable_cmcff)
> -		apei_hest_parse(hest_parse_cmc, NULL);
> +	rc = hest_ia_init();
> +	if (rc)
> +		goto err;
>  
>  	if (!ghes_disable) {
>  		rc = apei_hest_parse(hest_parse_ghes_count, &ghes_count);
> -- 
> 2.5.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
