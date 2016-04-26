From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 25 Apr 2016 18:44:57 -0700
Subject: [Patch v2 6/8] firmware: qcom: scm: Use atomic SCM for cold boot
In-Reply-To: <1461625725-32425-7-git-send-email-andy.gross@linaro.org>
References: <1461625725-32425-1-git-send-email-andy.gross@linaro.org>
 <1461625725-32425-7-git-send-email-andy.gross@linaro.org>
Message-ID: <20160426014457.GG29990@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25, Andy Gross wrote:
> This patch changes the cold_set_boot_addr function to use atomic SCM
> calls.  This removes the need for memory allocation and instead places
> all arguments in registers.
> 
> Signed-off-by: Andy Gross <andy.gross@linaro.org>
> ---
>  drivers/firmware/qcom_scm-32.c | 47 ++++++++++++++++++++----------------------
>  1 file changed, 22 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/firmware/qcom_scm-32.c b/drivers/firmware/qcom_scm-32.c
> index 0d2a3f8..419df4d 100644
> --- a/drivers/firmware/qcom_scm-32.c
> +++ b/drivers/firmware/qcom_scm-32.c
> @@ -294,34 +294,39 @@ out:
>  				(n & 0xf))
>  
>  /**
> - * qcom_scm_call_atomic1() - Send an atomic SCM command with one argument
> + * qcom_scm_call_atomic() - Send an atomic SCM command with one argument

Update doc to say 1 or 2 arguments now? I guess we get slightly
worse code because we force a load into the second argument
register even if it isn't used.

Also, is there a patch to change scm-32 to use dma allocations
for the buffer, or did I miss it?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
