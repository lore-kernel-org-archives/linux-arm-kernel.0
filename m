From: afaerber@suse.de (=?windows-1252?Q?Andreas_F=E4rber?=)
Date: Mon, 26 Jan 2015 23:34:34 +0100
Subject: [PATCH] ARM: /proc/cpuinfo: DT: Add support for Revision
In-Reply-To: <201501262009.45854@pali>
References: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
 <201412041857.49341@pali>
 <CAL_JsqJ9i0jwaL1cyeomQG=bhhcnEgdGWYOqkcwidyk5xOUukg@mail.gmail.com>
 <201501262009.45854@pali>
Message-ID: <54C6C0FA.10401@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 26.01.2015 um 20:09 schrieb Pali Roh?r:
> diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
> index 11c54de..9946c1b 100644
> --- a/arch/arm/kernel/devtree.c
> +++ b/arch/arm/kernel/devtree.c
[...]
> @@ -204,6 +206,8 @@ static const void * __init arch_get_next_mach(const char *const **match)
>  const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
>  {
>  	const struct machine_desc *mdesc, *mdesc_best = NULL;
> +	unsigned long dt_root;
> +	const u32 *prop;
>  
>  #ifdef CONFIG_ARCH_MULTIPLATFORM
>  	DT_MACHINE_START(GENERIC_DT, "Generic DT based system")
> @@ -215,17 +219,16 @@ const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
>  	if (!dt_phys || !early_init_dt_verify(phys_to_virt(dt_phys)))
>  		return NULL;
>  
> +	dt_root = of_get_flat_dt_root();
>  	mdesc = of_flat_dt_match_machine(mdesc_best, arch_get_next_mach);
>  
>  	if (!mdesc) {
>  		const char *prop;

Probably the use of two differently typed variables of name "prop" in
this function is not intentional?

Regards,
Andreas

>  		int size;
> -		unsigned long dt_root;
>  
>  		early_print("\nError: unrecognized/unsupported "
>  			    "device tree compatible list:\n[ ");
>  
> -		dt_root = of_get_flat_dt_root();
>  		prop = of_get_flat_dt_prop(dt_root, "compatible", &size);
>  		while (size > 0) {
>  			early_print("'%s' ", prop);
> @@ -246,5 +249,10 @@ const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
>  	/* Change machine number to match the mdesc we're using */
>  	__machine_arch_type = mdesc->nr;
>  
> +	/* Set system revision from DT */
> +	prop = of_get_flat_dt_prop(dt_root, "revision", NULL);
> +	if (prop)
> +		system_rev = fdt32_to_cpu(*prop);
> +
>  	return mdesc;
>  }
[snip]

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Jennifer Guild, Dilip Upmanyu,
Graham Norton; HRB 21284 (AG N?rnberg)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150126/a6b5053f/attachment.sig>
