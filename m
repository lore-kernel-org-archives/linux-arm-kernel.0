From: rostedt@goodmis.org (Steven Rostedt)
Date: Wed, 15 Feb 2017 12:47:43 -0500
Subject: [PATCH V9 09/10] trace, ras: add ARM processor error trace event
In-Reply-To: <1487180692-16732-10-git-send-email-tbaicar@codeaurora.org>
References: <1487180692-16732-1-git-send-email-tbaicar@codeaurora.org>
 <1487180692-16732-10-git-send-email-tbaicar@codeaurora.org>
Message-ID: <20170215124743.68343176@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 15 Feb 2017 10:44:51 -0700
Tyler Baicar <tbaicar@codeaurora.org> wrote:

> Currently there are trace events for the various RAS
> errors with the exception of ARM processor type errors.
> Add a new trace event for such errors so that the user
> will know when they occur. These trace events are
> consistent with the ARM processor error section type
> defined in UEFI 2.6 spec section N.2.4.4.
> 
> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
> Acked-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  drivers/acpi/apei/ghes.c    |  8 +++++++-
>  drivers/firmware/efi/cper.c |  1 +
>  drivers/ras/ras.c           |  1 +
>  include/ras/ras_event.h     | 34 ++++++++++++++++++++++++++++++++++
>  4 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index be365e2..560a172 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -514,7 +514,13 @@ static void ghes_do_proc(struct ghes *ghes,
>  		}
>  #endif
>  #ifdef CONFIG_RAS
> -		else if(trace_unknown_sec_event_enabled()) {
> +		else if (!uuid_le_cmp(sec_type, CPER_SEC_PROC_ARM) &&
> +			 trace_arm_event_enabled()) {
> +			struct cper_sec_proc_arm *arm_err;
> +
> +			arm_err = acpi_hest_generic_data_payload(gdata);
> +			trace_arm_event(arm_err);
> +		} else if(trace_unknown_sec_event_enabled()) {

I think you want a space between "if" and "("

-- Steve

>  			void *unknown_err = acpi_hest_generic_data_payload(gdata);
>  			trace_unknown_sec_event(&sec_type,
>  					fru_id, fru_text, sec_sev,
