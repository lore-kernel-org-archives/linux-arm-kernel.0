From: bp@alien8.de (Borislav Petkov)
Date: Fri, 28 Apr 2017 15:07:10 +0200
Subject: [PATCH V15 07/11] acpi: apei: panic OS with fatal error status
 block
In-Reply-To: <1492556723-9189-8-git-send-email-tbaicar@codeaurora.org>
References: <1492556723-9189-1-git-send-email-tbaicar@codeaurora.org>
 <1492556723-9189-8-git-send-email-tbaicar@codeaurora.org>
Message-ID: <20170428130710.s7m7nk46xmobxgq5@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 05:05:19PM -0600, Tyler Baicar wrote:
> From: "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>
> 
> Even if an error status block's severity is fatal, the kernel does not
> honor the severity level and panic.
> 
> With the firmware first model, the platform could inform the OS about a
> fatal hardware error through the non-NMI GHES notification type. The OS
> should panic when a hardware error record is received with this
> severity.
> 
> Call panic() after CPER data in error status block is printed if
> severity is fatal, before each error section is handled.
> 
> Signed-off-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
> Reviewed-by: James Morse <james.morse@arm.com>
> ---
>  drivers/acpi/apei/ghes.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 2d387f8..b91123f 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -134,6 +134,8 @@
>  static struct ghes_estatus_cache *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
>  static atomic_t ghes_estatus_cache_alloced;
>  
> +static int ghes_panic_timeout __read_mostly = 30;
> +
>  static int ghes_ioremap_init(void)
>  {
>  	ghes_ioremap_area = __get_vm_area(PAGE_SIZE * GHES_IOREMAP_PAGES,
> @@ -692,6 +694,13 @@ static int ghes_ack_error(struct acpi_hest_generic_v2 *generic_v2)
>  	return apei_write(val, &generic_v2->read_ack_register);
>  }
>  
> +static void __ghes_call_panic(void)

__ghes_panic()

> +{
> +	if (panic_timeout == 0)

	if (!panic_timeout)

> +		panic_timeout = ghes_panic_timeout;
> +	panic("Fatal hardware error!");
> +}
> +
>  static int ghes_proc(struct ghes *ghes)
>  {
>  	int rc;
> @@ -699,6 +708,10 @@ static int ghes_proc(struct ghes *ghes)
>  	rc = ghes_read_estatus(ghes, 0);
>  	if (rc)
>  		goto out;

<---- newline here.

> +	if (ghes_severity(ghes->estatus->error_severity) >= GHES_SEV_PANIC) {
> +		__ghes_print_estatus(KERN_EMERG, ghes->generic, ghes->estatus);
> +		__ghes_call_panic();
> +	}

ditto.

>  	if (!ghes_estatus_cached(ghes->estatus)) {
>  		if (ghes_print_estatus(NULL, ghes->generic, ghes->estatus))
>  			ghes_estatus_cache_add(ghes->generic, ghes->estatus);

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
