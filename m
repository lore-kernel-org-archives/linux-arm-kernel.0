From: sricharan@codeaurora.org (Sricharan)
Date: Mon, 9 May 2016 10:48:49 +0530
Subject: [Patch v3 5/8] firmware: qcom: scm: Convert to streaming DMA APIS
In-Reply-To: <1462402245-18295-6-git-send-email-andy.gross@linaro.org>
References: <1462402245-18295-1-git-send-email-andy.gross@linaro.org>
 <1462402245-18295-6-git-send-email-andy.gross@linaro.org>
Message-ID: <000101d1a9b2$491fd1f0$db5f75d0$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
> This patch converts the Qualcomm SCM driver to use the streaming DMA
> APIs for communication buffers.
> 
> Signed-off-by: Andy Gross <andy.gross@linaro.org>
> ---

 Reviewed-by: sricharan at codeaurora.org

Regards,
 Sricharan

>  drivers/firmware/qcom_scm-32.c | 152
+++++++++++++------------------------
> ----
>  drivers/firmware/qcom_scm.c    |   6 +-
>  drivers/firmware/qcom_scm.h    |  10 +--
>  3 files changed, 58 insertions(+), 110 deletions(-)
> 
> diff --git a/drivers/firmware/qcom_scm-32.c b/drivers/firmware/qcom_scm-
> 32.c index 4388d13..3e71aec 100644
> --- a/drivers/firmware/qcom_scm-32.c
> +++ b/drivers/firmware/qcom_scm-32.c
> @@ -23,8 +23,7 @@
>  #include <linux/errno.h>
>  #include <linux/err.h>
>  #include <linux/qcom_scm.h>
> -
> -#include <asm/cacheflush.h>
> +#include <linux/dma-mapping.h>
> 
>  #include "qcom_scm.h"
> 
> @@ -97,44 +96,6 @@ struct qcom_scm_response {  };
> 
>  /**
> - * alloc_qcom_scm_command() - Allocate an SCM command
> - * @cmd_size: size of the command buffer
> - * @resp_size: size of the response buffer
> - *
> - * Allocate an SCM command, including enough room for the command
> - * and response headers as well as the command and response buffers.
> - *
> - * Returns a valid &qcom_scm_command on success or %NULL if the
> allocation fails.
> - */
> -static struct qcom_scm_command *alloc_qcom_scm_command(size_t
> cmd_size, size_t resp_size) -{
> -	struct qcom_scm_command *cmd;
> -	size_t len = sizeof(*cmd) + sizeof(struct qcom_scm_response) +
> cmd_size +
> -		resp_size;
> -	u32 offset;
> -
> -	cmd = kzalloc(PAGE_ALIGN(len), GFP_KERNEL);
> -	if (cmd) {
> -		cmd->len = cpu_to_le32(len);
> -		offset = offsetof(struct qcom_scm_command, buf);
> -		cmd->buf_offset = cpu_to_le32(offset);
> -		cmd->resp_hdr_offset = cpu_to_le32(offset + cmd_size);
> -	}
> -	return cmd;
> -}
> -
> -/**
> - * free_qcom_scm_command() - Free an SCM command
> - * @cmd: command to free
> - *
> - * Free an SCM command.
> - */
> -static inline void free_qcom_scm_command(struct qcom_scm_command
> *cmd) -{
> -	kfree(cmd);
> -}
> -
> -/**
>   * qcom_scm_command_to_response() - Get a pointer to a
> qcom_scm_response
>   * @cmd: command
>   *
> @@ -168,7 +129,7 @@ static inline void
> *qcom_scm_get_response_buffer(const struct qcom_scm_response
>  	return (void *)rsp + le32_to_cpu(rsp->buf_offset);  }
> 
> -static u32 smc(u32 cmd_addr)
> +static u32 smc(dma_addr_t cmd_addr)
>  {
>  	int context_id;
>  	register u32 r0 asm("r0") = 1;
> @@ -192,51 +153,15 @@ static u32 smc(u32 cmd_addr)
>  	return r0;
>  }
> 
> -static int __qcom_scm_call(const struct qcom_scm_command *cmd) -{
> -	int ret;
> -	u32 cmd_addr = virt_to_phys(cmd);
> -
> -	/*
> -	 * Flush the command buffer so that the secure world sees
> -	 * the correct data.
> -	 */
> -	secure_flush_area(cmd, cmd->len);
> -
> -	ret = smc(cmd_addr);
> -	if (ret < 0)
> -		ret = qcom_scm_remap_error(ret);
> -
> -	return ret;
> -}
> -
> -static void qcom_scm_inv_range(unsigned long start, unsigned long end) -{
> -	u32 cacheline_size, ctr;
> -
> -	asm volatile("mrc p15, 0, %0, c0, c0, 1" : "=r" (ctr));
> -	cacheline_size = 4 << ((ctr >> 16) & 0xf);
> -
> -	start = round_down(start, cacheline_size);
> -	end = round_up(end, cacheline_size);
> -	outer_inv_range(start, end);
> -	while (start < end) {
> -		asm ("mcr p15, 0, %0, c7, c6, 1" : : "r" (start)
> -		     : "memory");
> -		start += cacheline_size;
> -	}
> -	dsb();
> -	isb();
> -}
> -
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
>   *
>   * Sends a command to the SCM and waits for the command to finish
> processing.
>   *
> @@ -247,42 +172,60 @@ static void qcom_scm_inv_range(unsigned long
> start, unsigned long end)
>   * and response buffers is taken care of by qcom_scm_call; however,
callers
> are
>   * responsible for any other cached buffers passed over to the secure
world.
>   */
> -static int qcom_scm_call(u32 svc_id, u32 cmd_id, const void *cmd_buf,
> -			size_t cmd_len, void *resp_buf, size_t resp_len)
> +static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
> +			 const void *cmd_buf, size_t cmd_len, void
> *resp_buf,
> +			 size_t resp_len)
>  {
>  	int ret;
>  	struct qcom_scm_command *cmd;
>  	struct qcom_scm_response *rsp;
> -	unsigned long start, end;
> +	size_t alloc_len = sizeof(*cmd) + sizeof(struct qcom_scm_response) +
> +			   cmd_len + resp_len;
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
> +	cmd->resp_hdr_offset = cpu_to_le32(offset + cmd_len);
> +
>  	cmd->id = cpu_to_le32((svc_id << 10) | cmd_id);
>  	if (cmd_buf)
>  		memcpy(qcom_scm_get_command_buffer(cmd), cmd_buf,
> cmd_len);
> 
> +	cmd_phys = dma_map_single(dev, cmd, alloc_len,
> DMA_TO_DEVICE);
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
> +		dma_sync_single_for_cpu(dev, cmd_phys + cmd_len +
> offset,
> +					sizeof(*rsp), DMA_FROM_DEVICE);
>  	} while (!rsp->is_complete);
> 
> -	end = (unsigned long)qcom_scm_get_response_buffer(rsp) +
> resp_len;
> -	qcom_scm_inv_range(start, end);
> -
> -	if (resp_buf)
> +	if (resp_buf) {
> +		dma_sync_single_for_cpu(dev, cmd_phys + alloc_len -
> resp_len,
> +					resp_len, DMA_FROM_DEVICE);
>  		memcpy(resp_buf, qcom_scm_get_response_buffer(rsp),
> resp_len);
> +	}
>  out:
> -	free_qcom_scm_command(cmd);
> +	dma_unmap_single(dev, cmd_phys, alloc_len, DMA_TO_DEVICE);
> +	kfree(cmd);
>  	return ret;
>  }
> 
> @@ -437,7 +380,8 @@ int __qcom_scm_set_cold_boot_addr(void *entry,
> const cpumask_t *cpus)
>   * Set the Linux entry point for the SCM to transfer control to when
coming
>   * out of a power down. CPU power down may be executed on cpuidle or
> hotplug.
>   */
> -int __qcom_scm_set_warm_boot_addr(void *entry, const cpumask_t
> *cpus)
> +int __qcom_scm_set_warm_boot_addr(struct device *dev, void *entry,
> +				  const cpumask_t *cpus)
>  {
>  	int ret;
>  	int flags = 0;
> @@ -463,7 +407,7 @@ int __qcom_scm_set_warm_boot_addr(void *entry,
> const cpumask_t *cpus)
> 
>  	cmd.addr = cpu_to_le32(virt_to_phys(entry));
>  	cmd.flags = cpu_to_le32(flags);
> -	ret = qcom_scm_call(QCOM_SCM_SVC_BOOT,
> QCOM_SCM_BOOT_ADDR,
> +	ret = qcom_scm_call(dev, QCOM_SCM_SVC_BOOT,
> QCOM_SCM_BOOT_ADDR,
>  			    &cmd, sizeof(cmd), NULL, 0);
>  	if (!ret) {
>  		for_each_cpu(cpu, cpus)
> @@ -487,25 +431,27 @@ void __qcom_scm_cpu_power_down(u32 flags)
>  			flags & QCOM_SCM_FLUSH_FLAG_MASK);
>  }
> 
> -int __qcom_scm_is_call_available(u32 svc_id, u32 cmd_id)
> +int __qcom_scm_is_call_available(struct device *dev, u32 svc_id, u32
> +cmd_id)
>  {
>  	int ret;
>  	__le32 svc_cmd = cpu_to_le32((svc_id << 10) | cmd_id);
>  	__le32 ret_val = 0;
> 
> -	ret = qcom_scm_call(QCOM_SCM_SVC_INFO,
> QCOM_IS_CALL_AVAIL_CMD, &svc_cmd,
> -			sizeof(svc_cmd), &ret_val, sizeof(ret_val));
> +	ret = qcom_scm_call(dev, QCOM_SCM_SVC_INFO,
> QCOM_IS_CALL_AVAIL_CMD,
> +			    &svc_cmd, sizeof(svc_cmd), &ret_val,
> +			    sizeof(ret_val));
>  	if (ret)
>  		return ret;
> 
>  	return le32_to_cpu(ret_val);
>  }
> 
> -int __qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt,
> u32 *resp)
> +int __qcom_scm_hdcp_req(struct device *dev, struct qcom_scm_hdcp_req
> *req,
> +			u32 req_cnt, u32 *resp)
>  {
>  	if (req_cnt > QCOM_SCM_HDCP_MAX_REQ_CNT)
>  		return -ERANGE;
> 
> -	return qcom_scm_call(QCOM_SCM_SVC_HDCP,
> QCOM_SCM_CMD_HDCP,
> +	return qcom_scm_call(dev, QCOM_SCM_SVC_HDCP,
> QCOM_SCM_CMD_HDCP,
>  		req, req_cnt * sizeof(*req), resp, sizeof(*resp));  } diff
--git
> a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c index
> 63a2bfa..9166cbb 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -89,7 +89,7 @@ EXPORT_SYMBOL(qcom_scm_set_cold_boot_addr);
>   */
>  int qcom_scm_set_warm_boot_addr(void *entry, const cpumask_t *cpus)  {
> -	return __qcom_scm_set_warm_boot_addr(entry, cpus);
> +	return __qcom_scm_set_warm_boot_addr(__scm->dev, entry,
> cpus);
>  }
>  EXPORT_SYMBOL(qcom_scm_set_warm_boot_addr);
> 
> @@ -119,7 +119,7 @@ bool qcom_scm_hdcp_available(void)
>  	if (ret)
>  		return ret;
> 
> -	ret = __qcom_scm_is_call_available(QCOM_SCM_SVC_HDCP,
> +	ret = __qcom_scm_is_call_available(__scm->dev,
> QCOM_SCM_SVC_HDCP,
>  						QCOM_SCM_CMD_HDCP);
> 
>  	qcom_scm_clk_disable();
> @@ -143,7 +143,7 @@ int qcom_scm_hdcp_req(struct qcom_scm_hdcp_req
> *req, u32 req_cnt, u32 *resp)
>  	if (ret)
>  		return ret;
> 
> -	ret = __qcom_scm_hdcp_req(req, req_cnt, resp);
> +	ret = __qcom_scm_hdcp_req(__scm->dev, req, req_cnt, resp);
>  	qcom_scm_clk_disable();
>  	return ret;
>  }
> diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
> index 7dcc733..afe6676 100644
> --- a/drivers/firmware/qcom_scm.h
> +++ b/drivers/firmware/qcom_scm.h
> @@ -19,7 +19,8 @@
>  #define QCOM_SCM_FLAG_HLOS		0x01
>  #define QCOM_SCM_FLAG_COLDBOOT_MC	0x02
>  #define QCOM_SCM_FLAG_WARMBOOT_MC	0x04
> -extern int __qcom_scm_set_warm_boot_addr(void *entry, const
> cpumask_t *cpus);
> +extern int __qcom_scm_set_warm_boot_addr(struct device *dev, void
> *entry,
> +		const cpumask_t *cpus);
>  extern int __qcom_scm_set_cold_boot_addr(void *entry, const cpumask_t
> *cpus);
> 
>  #define QCOM_SCM_CMD_TERMINATE_PC	0x2
> @@ -29,12 +30,13 @@ extern void __qcom_scm_cpu_power_down(u32
> flags);
> 
>  #define QCOM_SCM_SVC_INFO		0x6
>  #define QCOM_IS_CALL_AVAIL_CMD		0x1
> -extern int __qcom_scm_is_call_available(u32 svc_id, u32 cmd_id);
> +extern int __qcom_scm_is_call_available(struct device *dev, u32 svc_id,
> +		u32 cmd_id);
> 
>  #define QCOM_SCM_SVC_HDCP		0x11
>  #define QCOM_SCM_CMD_HDCP		0x01
> -extern int __qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32
> req_cnt,
> -		u32 *resp);
> +extern int __qcom_scm_hdcp_req(struct device *dev,
> +		struct qcom_scm_hdcp_req *req, u32 req_cnt, u32 *resp);
> 
>  /* common error codes */
>  #define QCOM_SCM_ENOMEM		-5
> --
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
