From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 2 Jun 2016 15:28:40 -0700
Subject: [Patch v5 6/8] firmware: qcom: scm: Add support for ARM64 SoCs
In-Reply-To: <1463111221-6963-7-git-send-email-andy.gross@linaro.org>
References: <1463111221-6963-1-git-send-email-andy.gross@linaro.org>
 <1463111221-6963-7-git-send-email-andy.gross@linaro.org>
Message-ID: <20160602222840.GP28218@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12, Andy Gross wrote:
> +
> +#define MAX_QCOM_SCM_ARGS 10
> +#define MAX_QCOM_SCM_RETS 3
> +
> +#define QCOM_SCM_ARGS_IMPL(num, a, b, c, d, e, f, g, h, i, j, ...) (\
> +			   (((a) & 0x3) << 4) | \
> +			   (((b) & 0x3) << 6) | \
> +			   (((c) & 0x3) << 8) | \
> +			   (((d) & 0x3) << 10) | \
> +			   (((e) & 0x3) << 12) | \
> +			   (((f) & 0x3) << 14) | \
> +			   (((g) & 0x3) << 16) | \
> +			   (((h) & 0x3) << 18) | \
> +			   (((i) & 0x3) << 20) | \
> +			   (((j) & 0x3) << 22) | \
> +			   (num & 0xf))

Parenthesis around num?

> +
> +#define QCOM_SCM_ARGS(...) QCOM_SCM_ARGS_IMPL(__VA_ARGS__, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
> +
> +/**
> + * struct qcom_scm_desc
> + * @arginfo:	Metadata describing the arguments in args[]
> + * @args:	The array of arguments for the secure syscall
> + * @res:	The values returned by the secure syscall
> + */
> +struct qcom_scm_desc {
> +	u32 arginfo;
> +	u64 args[MAX_QCOM_SCM_ARGS];
> +	struct arm_smccc_res res;
> +};

If we split the res from the descriptor structure we could make
the qcom_scm_desc const in qcom_scm_call(). We would have to add
another argument to the function though, not sure if this is a
big win idea, but just an idea to keep things "safer".

> +
> +static u64 qcom_smccc_convention = -1;
> +static DEFINE_MUTEX(qcom_scm_lock);
> +
> +#define QCOM_SCM_EBUSY_WAIT_MS 30
> +#define QCOM_SCM_EBUSY_MAX_RETRY 20
> +
> +#define N_EXT_QCOM_SCM_ARGS 7
> +#define FIRST_EXT_ARG_IDX 3
> +#define N_REGISTER_ARGS (MAX_QCOM_SCM_ARGS - N_EXT_QCOM_SCM_ARGS + 1)
> +
> +/**
> + * qcom_scm_call() - Invoke a syscall in the secure world
> + * @dev:	device
> + * @svc_id:	service identifier
> + * @cmd_id:	command identifier
> + * @desc:	Descriptor structure containing arguments and return values
> + *
> + * Sends a command to the SCM and waits for the command to finish processing.
> + * This should *only* be called in pre-emptible context.
> +*/
> +static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
> +			 struct qcom_scm_desc *desc)
> +{
> +	int arglen = desc->arginfo & 0xf;
> +	int retry_count = 0, i;
> +	u32 fn_id = QCOM_SCM_FNID(svc_id, cmd_id);
> +	u64 cmd, x5 = desc->args[FIRST_EXT_ARG_IDX];
> +	dma_addr_t args_phys = 0;
> +	void *args_virt = NULL;
> +	size_t alloc_len;
> +
> +	if (unlikely(arglen > N_REGISTER_ARGS)) {
> +		alloc_len = N_EXT_QCOM_SCM_ARGS * sizeof(u64);
> +		args_virt = kzalloc(PAGE_ALIGN(alloc_len), GFP_KERNEL);
> +
> +		if (!args_virt)
> +			return qcom_scm_remap_error(-ENOMEM);

Just return -ENOMEM here?

> +
> +		if (qcom_smccc_convention == ARM_SMCCC_SMC_32) {
> +			__le32 *args = args_virt;
> +
> +			for (i = 0; i < N_EXT_QCOM_SCM_ARGS; i++)
> +				args[i] = cpu_to_le32(desc->args[i +
> +						      FIRST_EXT_ARG_IDX]);
> +		} else {
> +			__le64 *args = args_virt;
> +
> +			for (i = 0; i < N_EXT_QCOM_SCM_ARGS; i++)
> +				args[i] = cpu_to_le64(desc->args[i +
> +						      FIRST_EXT_ARG_IDX]);
> +		}
> +
> +		args_phys = dma_map_single(dev, args_virt, alloc_len,
> +					   DMA_TO_DEVICE);
> +
> +		if (dma_mapping_error(dev, args_phys)) {
> +			kfree(args_virt);
> +			return qcom_scm_remap_error(-ENOMEM);

Just return -ENOMEM here?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
