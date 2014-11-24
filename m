From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Mon, 24 Nov 2014 02:45:03 +0100
Subject: [PATCH v5 03/18] ACPI / table: Count matched and successfully
 parsed entries without specifying max entries
In-Reply-To: <1413553034-20956-4-git-send-email-hanjun.guo@linaro.org>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <1413553034-20956-4-git-send-email-hanjun.guo@linaro.org>
Message-ID: <6619034.gHDuQJ1A7y@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, October 17, 2014 09:36:59 PM Hanjun Guo wrote:
> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> 
> It is very useful to traverse all available table entries without max
> number of expected entries type. Current acpi_parse_entries()
> implementation gives that feature but it does not count those entries,
> it returns 0 instead, so fix it to count matched and successfully
> entries and return it.

Hmm.  I guess that the goal is for count to only be incremented when the
condition is satisfied entirely, while without the patch it may be incremented
even if that isn't the case.

I'm not sure how that is related to the above paragraph, however.

> NOTE: This change has no impact to x86 and ia64 archs since existing code
> checks for error occurrence only (acpi_parse_entries(...,0) < 0).
> 
> Acked-by: Grant Likely <grant.likely@linaro.org>
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  drivers/acpi/tables.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 21ae521..b18e45e 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -225,10 +225,13 @@ acpi_parse_entries(unsigned long table_size,
>  	while (((unsigned long)entry) + sizeof(struct acpi_subtable_header) <
>  	       table_end) {
>  		if (entry->type == entry_id
> -		    && (!max_entries || count++ < max_entries))
> +		    && (!max_entries || count < max_entries)) {
>  			if (handler(entry, table_end))
>  				return -EINVAL;
>  
> +			count++;
> +		}
> +
>  		/*
>  		 * If entry->length is 0, break from this loop to avoid
>  		 * infinite loop.
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
