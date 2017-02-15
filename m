From: rostedt@goodmis.org (Steven Rostedt)
Date: Wed, 15 Feb 2017 10:52:34 -0500
Subject: [PATCH V8 08/10] ras: acpi / apei: generate trace event for
 unrecognized CPER section
In-Reply-To: <1485969413-23577-9-git-send-email-tbaicar@codeaurora.org>
References: <1485969413-23577-1-git-send-email-tbaicar@codeaurora.org>
 <1485969413-23577-9-git-send-email-tbaicar@codeaurora.org>
Message-ID: <20170215105234.4921db1f@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed,  1 Feb 2017 10:16:51 -0700
Tyler Baicar <tbaicar@codeaurora.org> wrote:

> @@ -452,11 +454,21 @@ static void ghes_do_proc(struct ghes *ghes,
>  {
>  	int sev, sec_sev;
>  	struct acpi_hest_generic_data *gdata;
> +	uuid_le sec_type;
> +	uuid_le *fru_id = &NULL_UUID_LE;
> +	char *fru_text = "";
>  
>  	sev = ghes_severity(estatus->error_severity);
>  	apei_estatus_for_each_section(estatus, gdata) {
>  		sec_sev = ghes_severity(gdata->error_severity);
> -		if (!uuid_le_cmp(*(uuid_le *)gdata->section_type,
> +		sec_type = *(uuid_le *)gdata->section_type;
> +
> +		if (gdata->validation_bits & CPER_SEC_VALID_FRU_ID)
> +			fru_id = (uuid_le *)gdata->fru_id;
> +		if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
> +			fru_text = gdata->fru_text;
> +
> +		if (!uuid_le_cmp(sec_type,
>  				 CPER_SEC_PLATFORM_MEM)) {
>  			struct cper_sec_mem_err *mem_err;
>  
> @@ -467,7 +479,7 @@ static void ghes_do_proc(struct ghes *ghes,
>  			ghes_handle_memory_failure(gdata, sev);
>  		}
>  #ifdef CONFIG_ACPI_APEI_PCIEAER
> -		else if (!uuid_le_cmp(*(uuid_le *)gdata->section_type,
> +		else if (!uuid_le_cmp(sec_type,
>  				      CPER_SEC_PCIE)) {
>  			struct cper_sec_pcie *pcie_err;
>  
> @@ -500,6 +512,12 @@ static void ghes_do_proc(struct ghes *ghes,
>  
>  		}
>  #endif
> +		else {

As an optimization, you can add:

		else if (trace_unknown_sec_event_enabled()) {

instead, as then this wont be called unless the tracepoint is
activated. Will keep the logic from doing anything with
acpi_hest_generic_data_payload().

Note, that trace_*_enabled() is activated via a jump_label, thus
there's no branches involved.

-- Steve

> +			void *unknown_err = acpi_hest_generic_data_payload(gdata);
> +			trace_unknown_sec_event(&sec_type,
> +					fru_id, fru_text, sec_sev,
> +					unknown_err, gdata->error_data_length);
> +		}
>  	}
>  }
>  
>
