From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 26 Oct 2018 09:33:18 +0100
Subject: [PATCH] arm64: Log the Fault Status Code (FSC) upon memory aborts
In-Reply-To: <1540512876-12011-1-git-send-email-sudaraja@codeaurora.org>
References: <1540512876-12011-1-git-send-email-sudaraja@codeaurora.org>
Message-ID: <20181026083318.xbeo3drinb5ptiba@blommer>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 25, 2018 at 05:14:36PM -0700, Sudarshan Rajagopalan wrote:
> When decoding the information from ESR on mem faults, log the
> FSC value, which is commonly shared for Data and Instruction aborts.

Given we extract the other fields, extracting the FSC makes sense to me.

> 
> Change-Id: If7d7f6027958864d99dfb7e79d368e82415dce97

Please drop any Change-Id tag when sending patches upstream.

> Signed-off-by: Sudarshan Rajagopalan <sudaraja@codeaurora.org>
> ---
>  arch/arm64/mm/fault.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index b8eecc7..e9d07ab 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -120,6 +120,7 @@ static void mem_abort_decode(unsigned int esr)
>  	pr_alert("  EA = %lu, S1PTW = %lu\n",
>  		 (esr & ESR_ELx_EA) >> ESR_ELx_EA_SHIFT,
>  		 (esr & ESR_ELx_S1PTW) >> ESR_ELx_S1PTW_SHIFT);
> +	pr_alert("  FSC = %lu\n", (esr & ESR_ELx_FSC));

I think it would make sense to log this immediately after the ESR and decoded
exception class, before the other fault fields.

It would be nice if we could factor out the strings from the fault_info table,
so that we can print a human-readable string as we do for the ESR, but I think
that can be a future addition.

FWIW, with this moved immediately after the dump of the ESR (and decoded ESR
string):

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

>  
>  	if (esr_is_data_abort(esr))
>  		data_abort_decode(esr);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
