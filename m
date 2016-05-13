From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri, 13 May 2016 16:48:52 -0700
Subject: [Patch v5 5/8] firmware: qcom: scm: Convert to streaming DMA APIS
In-Reply-To: <1463111221-6963-6-git-send-email-andy.gross@linaro.org>
References: <1463111221-6963-1-git-send-email-andy.gross@linaro.org>
 <1463111221-6963-6-git-send-email-andy.gross@linaro.org>
Message-ID: <20160513234852.GH1256@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 12 May 20:46 PDT 2016, Andy Gross wrote:

> This patch converts the Qualcomm SCM driver to use the streaming DMA APIs
> for communication buffers.
> 
> Signed-off-by: Andy Gross <andy.gross@linaro.org>
> ---
>  drivers/firmware/qcom_scm-32.c | 189 +++++++++++------------------------------
>  drivers/firmware/qcom_scm.c    |   6 +-
>  drivers/firmware/qcom_scm.h    |  10 ++-
>  3 files changed, 59 insertions(+), 146 deletions(-)
> 
> diff --git a/drivers/firmware/qcom_scm-32.c b/drivers/firmware/qcom_scm-32.c
[..]
> +static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
> +			 const void *cmd_buf, size_t cmd_len, void *resp_buf,
> +			 size_t resp_len)
>  {
>  	int ret;
>  	struct qcom_scm_command *cmd;
>  	struct qcom_scm_response *rsp;
> -	unsigned long start, end;
> +	size_t alloc_len = sizeof(*cmd) + cmd_len + sizeof(*rsp) + resp_len;
> +	dma_addr_t cmd_phys;
>  
> -	cmd = alloc_qcom_scm_command(cmd_len, resp_len);
> +	cmd = kzalloc(PAGE_ALIGN(alloc_len), GFP_KERNEL);
>  	if (!cmd)
>  		return -ENOMEM;
>  
> +	cmd->len = cpu_to_le32(alloc_len);
> +	cmd->buf_offset = cpu_to_le32(sizeof(*cmd));
> +	cmd->resp_hdr_offset = cpu_to_le32(sizeof(*cmd) + cmd_len);
> +
>  	cmd->id = cpu_to_le32((svc_id << 10) | cmd_id);
>  	if (cmd_buf)
> -		memcpy(qcom_scm_get_command_buffer(cmd), cmd_buf, cmd_len);
> +		memcpy(cmd->buf, cmd_buf, cmd_len);
> +
> +	rsp = (void *)cmd->buf + le32_to_cpu(cmd->resp_hdr_offset);

I believe resp_hdr_offset counts from the beginning of the buffer and
that this therefor is supposed to be:

	rsp = (void *)cmd + le32_to_cpu(cmd->resp_hdr_offset);

With that corrected, feel free to add:

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
