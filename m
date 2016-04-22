From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri, 22 Apr 2016 16:50:05 -0700
Subject: [PATCH 5/8] firmware: qcom: scm: Use atomic SCM for cold boot
In-Reply-To: <1461363432-5730-6-git-send-email-andy.gross@linaro.org>
References: <1461363432-5730-1-git-send-email-andy.gross@linaro.org>
 <1461363432-5730-6-git-send-email-andy.gross@linaro.org>
Message-ID: <20160422235005.GI3202@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 22 Apr 15:17 PDT 2016, Andy Gross wrote:

> This patch changes the cold_set_boot_addr function to use atomic SCM
> calls.  This removes the need for memory allocation and instead places
> all arguments in registers.
> 
> Signed-off-by: Andy Gross <andy.gross@linaro.org>
> ---
>  drivers/firmware/qcom_scm-32.c | 40 ++++++++++++++++++++++++++--------------
>  1 file changed, 26 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/firmware/qcom_scm-32.c b/drivers/firmware/qcom_scm-32.c
[..]
>  /*
>   * Set the cold/warm boot address for one of the CPU cores.
>   */
> -static int qcom_scm_set_boot_addr(u32 addr, int flags)
> +static int qcom_scm_set_boot_addr(u32 addr, int flags, bool do_atomic)
>  {
>  	struct {
>  		__le32 flags;
>  		__le32 addr;
>  	} cmd;
>  
> -	cmd.addr = cpu_to_le32(addr);
> -	cmd.flags = cpu_to_le32(flags);
> -	return qcom_scm_call(QCOM_SCM_SVC_BOOT, QCOM_SCM_BOOT_ADDR,
> -			&cmd, sizeof(cmd), NULL, 0);
> +	if (do_atomic) {
> +		return qcom_scm_call_atomic(QCOM_SCM_SVC_BOOT,
> +					    QCOM_SCM_BOOT_ADDR, 2, flags, addr);
> +	} else {
> +
> +		cmd.addr = cpu_to_le32(addr);
> +		cmd.flags = cpu_to_le32(flags);
> +
> +		return qcom_scm_call(QCOM_SCM_SVC_BOOT, QCOM_SCM_BOOT_ADDR,
> +				     &cmd, sizeof(cmd), NULL, 0);
> +	}

I would prefer that you split this into two functions, rather than
hiding two functions bodies in one function.

Perhaps qcom_scm_set_boot_addr and qcom_scm_set_boot_addr_atomic?

>  }
>  

Regards,
Bjorn
