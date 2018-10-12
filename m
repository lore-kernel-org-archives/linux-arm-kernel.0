From: bp@alien8.de (Borislav Petkov)
Date: Fri, 12 Oct 2018 18:55:53 +0200
Subject: [PATCH v6 11/18] ACPI / APEI: Remove silent flag from
 ghes_read_estatus()
In-Reply-To: <20180921221705.6478-12-james.morse@arm.com>
References: <20180921221705.6478-1-james.morse@arm.com>
 <20180921221705.6478-12-james.morse@arm.com>
Message-ID: <20181012165553.GE580@zn.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2018 at 11:16:58PM +0100, James Morse wrote:
> Subsequent patches will split up ghes_read_estatus(), at which
> point passing around the 'silent' flag gets annoying. This is to
> suppress prink() messages, which prior to 42a0bb3f7138 ("printk/nmi:
> generic solution for safe printk in NMI"), were unsafe in NMI context.

Put that commit onto a separate line:

"... which prior to

  42a0bb3f7138 ("printk/nmi: generic solution for safe printk in NMI")

were unsafe ..."

This way it is immediately visible.

In any case, this patch looks like a cleanup so move it to the beginning
of the queue, I'd say.

> We don't need to do this anymore, remove the flag. printk() messages
> are batched in a per-cpu buffer and printed via irq-work, or a call
> back from panic().
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  drivers/acpi/apei/ghes.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 586689cbc0fd..ba5344d26a39 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -300,7 +300,7 @@ static void ghes_copy_tofrom_phys(void *buffer, u64 paddr, u32 len,
>  
>  static int ghes_read_estatus(struct ghes *ghes,
>  			     struct acpi_hest_generic_status *estatus,
> -			     int silent, int fixmap_idx)
> +			     int fixmap_idx)
>  {
>  	struct acpi_hest_generic *g = ghes->generic;
>  	u64 buf_paddr;
> @@ -309,7 +309,7 @@ static int ghes_read_estatus(struct ghes *ghes,
>  
>  	rc = apei_read(&buf_paddr, &g->error_status_address);
>  	if (rc) {
> -		if (!silent && printk_ratelimit())
> +		if (printk_ratelimit())

Btw, checkpatch complains here:

WARNING: Prefer printk_ratelimited or pr_<level>_ratelimited to printk_ratelimit
#57: FILE: drivers/acpi/apei/ghes.c:312:
+               if (printk_ratelimit())

WARNING: Prefer printk_ratelimited or pr_<level>_ratelimited to printk_ratelimit
#66: FILE: drivers/acpi/apei/ghes.c:345:
+       if (rc && printk_ratelimit())


-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
