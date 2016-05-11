From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 11 May 2016 13:34:44 -0700
Subject: [Patch v4 5/8] firmware: qcom: scm: Convert to streaming DMA APIS
In-Reply-To: <1462976158-26016-6-git-send-email-andy.gross@linaro.org>
References: <1462976158-26016-1-git-send-email-andy.gross@linaro.org>
 <1462976158-26016-6-git-send-email-andy.gross@linaro.org>
Message-ID: <20160511203444.GX1256@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 11 May 07:15 PDT 2016, Andy Gross wrote:

> This patch converts the Qualcomm SCM driver to use the streaming DMA APIs
> for communication buffers.
> 

Some style issues in qcom_scm_call(), but functionality wise I think
this looks good (with the open question on packing of rsp and rps->buf).

> Signed-off-by: Andy Gross <andy.gross@linaro.org>
> ---
>  drivers/firmware/qcom_scm-32.c | 152 +++++++++++++----------------------------
>  drivers/firmware/qcom_scm.c    |   6 +-
>  drivers/firmware/qcom_scm.h    |  10 +--
>  3 files changed, 58 insertions(+), 110 deletions(-)
> 
> diff --git a/drivers/firmware/qcom_scm-32.c b/drivers/firmware/qcom_scm-32.c
[..]
>  /**
>   * qcom_scm_call() - Send an SCM command
> - * @svc_id: service identifier
> - * @cmd_id: command identifier
> - * @cmd_buf: command buffer
> - * @cmd_len: length of the command buffer
> - * @resp_buf: response buffer
> - * @resp_len: length of the response buffer
> + * @dev:	struct device
> + * @svc_id:	service identifier
> + * @cmd_id:	command identifier
> + * @cmd_buf:	command buffer
> + * @cmd_len:	length of the command buffer
> + * @resp_buf:	response buffer
> + * @resp_len:	length of the response buffer

Leaving the indentation alone clarifies that your changes is just the
addition of "dev".

>   *
>   * Sends a command to the SCM and waits for the command to finish processing.
>   *
> @@ -247,42 +172,60 @@ static void qcom_scm_inv_range(unsigned long start, unsigned long end)
>   * and response buffers is taken care of by qcom_scm_call; however, callers are
>   * responsible for any other cached buffers passed over to the secure world.
>   */
> -static int qcom_scm_call(u32 svc_id, u32 cmd_id, const void *cmd_buf,
> -			size_t cmd_len, void *resp_buf, size_t resp_len)
> +static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
> +			 const void *cmd_buf, size_t cmd_len, void *resp_buf,
> +			 size_t resp_len)
>  {
>  	int ret;
>  	struct qcom_scm_command *cmd;
>  	struct qcom_scm_response *rsp;
> -	unsigned long start, end;
> +	size_t alloc_len = sizeof(*cmd) + sizeof(struct qcom_scm_response) +
> +			   cmd_len + resp_len;

This would be cleaner if written:

size_t alloc_len = sizeof(*cmd) + cmd_len + sizeof(*rsp) + resp_len;

> +	dma_addr_t cmd_phys;
> +	u32 offset;
>  
> -	cmd = alloc_qcom_scm_command(cmd_len, resp_len);
> +	cmd = kzalloc(PAGE_ALIGN(alloc_len), GFP_KERNEL);
>  	if (!cmd)
>  		return -ENOMEM;
>  
> +	cmd->len = cpu_to_le32(alloc_len);
> +	offset = offsetof(struct qcom_scm_command, buf);
> +	cmd->buf_offset = cpu_to_le32(offset);

Sure this is the offset of the buf in *cmd, but based on the rest of my
comments below I would have dropped the offset variable and just used
sizeof(*cmd).

> +	cmd->resp_hdr_offset = cpu_to_le32(offset + cmd_len);

But this would be more intuitive as sizeof(*cmd) + cmd_len;

> +
>  	cmd->id = cpu_to_le32((svc_id << 10) | cmd_id);
>  	if (cmd_buf)
>  		memcpy(qcom_scm_get_command_buffer(cmd), cmd_buf, cmd_len);

Somewhat unrelated, but we should probably just inline this helper in
favour of writing "cmd->buf".

>  
> +	cmd_phys = dma_map_single(dev, cmd, alloc_len, DMA_TO_DEVICE);

Unless there's a guarantee that the resp buffer is packed onto the
response we should probably map the entire page(s).

> +	if (dma_mapping_error(dev, cmd_phys)) {
> +		kfree(cmd);
> +		return -ENOMEM;
> +	}
> +
>  	mutex_lock(&qcom_scm_lock);
> -	ret = __qcom_scm_call(cmd);
> +	ret = smc(cmd_phys);
> +	if (ret < 0)
> +		ret = qcom_scm_remap_error(ret);
>  	mutex_unlock(&qcom_scm_lock);
>  	if (ret)
>  		goto out;
>  
>  	rsp = qcom_scm_command_to_response(cmd);
> -	start = (unsigned long)rsp;
>  
>  	do {
> -		qcom_scm_inv_range(start, start + sizeof(*rsp));
> +		dma_sync_single_for_cpu(dev, cmd_phys + cmd_len + offset,

Same here, would be easier to read if it was
  cmd_phys + sizeof(*cmd) + cmd_len;

Or even:
  cmd_phys + le32_to_cpu(cmd->resp_hdr_offset);

> +					sizeof(*rsp), DMA_FROM_DEVICE);
>  	} while (!rsp->is_complete);
>  
> -	end = (unsigned long)qcom_scm_get_response_buffer(rsp) + resp_len;
> -	qcom_scm_inv_range(start, end);
> -
> -	if (resp_buf)
> +	if (resp_buf) {
> +		dma_sync_single_for_cpu(dev, cmd_phys + alloc_len - resp_len,

Do we know that the firmware always set
  rsp->buf_offset = sizeof(*rsp)

Would be clearer (and safe from this assumption) if you have it as:
  cmd_phys + le32_to_cpu(cmd->resp_hdr_offset) + le32_to_cpu(rsp->buf_offset);

> +					resp_len, DMA_FROM_DEVICE);
>  		memcpy(resp_buf, qcom_scm_get_response_buffer(rsp), resp_len);

And as we just calculated that offset, we can drop the
qcom_scm_get_response_buffer() single use helper.

> +	}
>  out:
> -	free_qcom_scm_command(cmd);
> +	dma_unmap_single(dev, cmd_phys, alloc_len, DMA_TO_DEVICE);
> +	kfree(cmd);
>  	return ret;
>  }
>  

The rest looks good.

Regards,
Bjorn
