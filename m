From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 2 Jun 2016 16:26:02 -0700
Subject: [Patch v5 5/8] firmware: qcom: scm: Convert to streaming DMA APIS
In-Reply-To: <1463111221-6963-6-git-send-email-andy.gross@linaro.org>
References: <1463111221-6963-1-git-send-email-andy.gross@linaro.org>
 <1463111221-6963-6-git-send-email-andy.gross@linaro.org>
Message-ID: <20160602232602.GS28218@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12, Andy Gross wrote:
> This patch converts the Qualcomm SCM driver to use the streaming DMA APIs
> for communication buffers.

Yes, but why?

> 
> Signed-off-by: Andy Gross <andy.gross@linaro.org>
> ---
>  drivers/firmware/qcom_scm-32.c | 189 +++++++++++------------------------------
>  drivers/firmware/qcom_scm.c    |   6 +-
>  drivers/firmware/qcom_scm.h    |  10 ++-
>  3 files changed, 59 insertions(+), 146 deletions(-)
> 
> diff --git a/drivers/firmware/qcom_scm-32.c b/drivers/firmware/qcom_scm-32.c
> index 4388d13..e92bf7a 100644
> --- a/drivers/firmware/qcom_scm-32.c
> +++ b/drivers/firmware/qcom_scm-32.c
> @@ -64,11 +63,11 @@ static DEFINE_MUTEX(qcom_scm_lock);
>   *
>   *	------------------- <--- struct qcom_scm_command
>   *	| command header  |
> - *	------------------- <--- qcom_scm_get_command_buffer()
> + *	------------------- <--- buf[0]
>   *	| command buffer  |
> - *	------------------- <--- struct qcom_scm_response and
> - *	| response header |      qcom_scm_command_to_response()
> - *	------------------- <--- qcom_scm_get_response_buffer()
> + *	------------------- <--- struct qcom_scm_response
> + *	| response header |
> + *	-------------------

You don't like my convenience functions? :) I always thought
qcom_scm_get_response_buffer() read better than

(void *)cmd->buf + le32_to_cpu(cmd->resp_hdr_offset);

>   *	| response buffer |
>   *	-------------------
>   *
> @@ -96,79 +95,7 @@ struct qcom_scm_response {
>  	__le32 is_complete;
>  };
>  
> -
> -/**
> - * free_qcom_scm_command() - Free an SCM command
> - * @cmd: command to free
> - *
> - * Free an SCM command.
> - */
> -static inline void free_qcom_scm_command(struct qcom_scm_command *cmd)
> -{
> -	kfree(cmd);
> -}
> -
> -/**
> - * qcom_scm_command_to_response() - Get a pointer to a qcom_scm_response
> - * @cmd: command
> - *
> - * Returns a pointer to a response for a command.
> - */
> -static inline struct qcom_scm_response *qcom_scm_command_to_response(
> -		const struct qcom_scm_command *cmd)
> -{
> -	return (void *)cmd + le32_to_cpu(cmd->resp_hdr_offset);
> -}
> -
> -/**
> - * qcom_scm_get_command_buffer() - Get a pointer to a command buffer
> - * @cmd: command
> - *
> - * Returns a pointer to the command buffer of a command.
> - */
> -static inline void *qcom_scm_get_command_buffer(const struct qcom_scm_command *cmd)
> -{
> -	return (void *)cmd->buf;
> -}
> -
> -/**
> - * qcom_scm_get_response_buffer() - Get a pointer to a response buffer
> - * @rsp: response
> - *
> - * Returns a pointer to a response buffer of a response.
> - */
> -static inline void *qcom_scm_get_response_buffer(const struct qcom_scm_response *rsp)
> -{
> -	return (void *)rsp + le32_to_cpu(rsp->buf_offset);
> -}

At the least the diff would be more concentrated on what really
is happening in this patch if we left these functions as is.

> -
> -static u32 smc(u32 cmd_addr)
> +static u32 smc(dma_addr_t cmd_addr)

Please leave this as u32, the interface doesn't support anything
wider here so we shouldn't let this change on LPAE.

>  {
>  	int context_id;
>  	register u32 r0 asm("r0") = 1;
> @@ -192,45 +119,9 @@ static u32 smc(u32 cmd_addr)
>  	return r0;
>  }
>  
> -static int __qcom_scm_call(const struct qcom_scm_command *cmd)
> -{
> -	int ret;
> -	u32 cmd_addr = virt_to_phys(cmd);
> -
> -	/*
> -	 * Flush the command buffer so that the secure world sees
> -	 * the correct data.
> -	 */
> -	secure_flush_area(cmd, cmd->len);

Yay we should delete secure_flush_area() too.

> -
> -	ret = smc(cmd_addr);
> -	if (ret < 0)
> -		ret = qcom_scm_remap_error(ret);
> -
> -	return ret;
> -}
> -
> -
> @@ -143,7 +143,7 @@ int qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt, u32 *resp)
>  	if (ret)
>  		return ret;
>  
> -	ret = __qcom_scm_hdcp_req(req, req_cnt, resp);
> +	ret = __qcom_scm_hdcp_req(__scm->dev, req, req_cnt, resp);

Hmm maybe we should pass __scm instead of dev? Is there any
advantage to that?

>  	qcom_scm_clk_disable();
>  	return ret;
>  }

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
