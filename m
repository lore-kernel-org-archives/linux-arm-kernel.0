From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 11 May 2016 14:21:23 -0700
Subject: [Patch v4 6/8] firmware: qcom: scm: Add support for ARM64 SoCs
In-Reply-To: <1462976158-26016-7-git-send-email-andy.gross@linaro.org>
References: <1462976158-26016-1-git-send-email-andy.gross@linaro.org>
 <1462976158-26016-7-git-send-email-andy.gross@linaro.org>
Message-ID: <20160511212123.GY1256@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 11 May 07:15 PDT 2016, Andy Gross wrote:

[..]
> diff --git a/drivers/firmware/qcom_scm-64.c b/drivers/firmware/qcom_scm-64.c
[..]
> +
> +#define QCOM_SCM_ARGS_IMPL(num, a, b, c, d, e, f, g, h, i, j, ...) (\
> +			   (((a) & 0xff) << 4) | \
> +			   (((b) & 0xff) << 6) | \
> +			   (((c) & 0xff) << 8) | \
> +			   (((d) & 0xff) << 10) | \
> +			   (((e) & 0xff) << 12) | \
> +			   (((f) & 0xff) << 14) | \
> +			   (((g) & 0xff) << 16) | \
> +			   (((h) & 0xff) << 18) | \
> +			   (((i) & 0xff) << 20) | \
> +			   (((j) & 0xff) << 22) | \
> +			   (num & 0xffff))

Sorry, haven't payed attention to the body of this macro before; but
it's "wrong".

num is 4 bits all other entries are 2 bits each. So it should be:

#define QCOM_SCM_ARGS_IMPL(num, a, b, c, d, e, f, g, h, i, j, ...) (\
			   (((a) & 0x3) << 4) | \
			   (((b) & 0x3) << 6) | \
			   (((c) & 0x3) << 8) | \
			   (((d) & 0x3) << 10) | \
			   (((e) & 0x3) << 12) | \
			   (((f) & 0x3) << 14) | \
			   (((g) & 0x3) << 16) | \
			   (((h) & 0x3) << 18) | \
			   (((i) & 0x3) << 20) | \
			   (((j) & 0x3) << 22) | \
			   (num & 0xf))

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
> + * @fn_id:	The function ID for this syscall

You don't have a fn_id parameter anymore.

> + * @desc:	Descriptor structure containing arguments and return values
> + *
> + * Sends a command to the SCM and waits for the command to finish processing.
> + * This should *only* be called in pre-emptible context.
> +*/
> +static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
> +			 struct qcom_scm_desc *desc)
> +{
> +	int arglen = desc->arginfo & 0xf;
> +	int ret, retry_count = 0, i;
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
> +		}
> +
> +		x5 = args_phys;
> +	}
> +
> +	do {
> +		mutex_lock(&qcom_scm_lock);
> +
> +		cmd = ARM_SMCCC_CALL_VAL(ARM_SMCCC_STD_CALL,
> +					 qcom_smccc_convention,
> +					 ARM_SMCCC_OWNER_SIP, fn_id);
> +
> +		do {
> +			arm_smccc_smc(cmd, arglen, desc->args[0], desc->args[1],
> +				      desc->args[2], x5, 0, 0, &desc->res);

Looking at downstream you should pass the entirety of arginfo as the
second parameter. Currently you only set the num bits, but there are a
few cases when these bits should be set.

> +		} while (desc->res.a0 == QCOM_SCM_INTERRUPTED);
> +
> +		mutex_unlock(&qcom_scm_lock);
> +
> +		if (desc->res.a0 == QCOM_SCM_V2_EBUSY) {
> +			if (retry_count++ > QCOM_SCM_EBUSY_MAX_RETRY)
> +				break;
> +			msleep(QCOM_SCM_EBUSY_WAIT_MS);
> +		}
> +	}  while (desc->res.a0 == QCOM_SCM_V2_EBUSY);
> +
> +	if (args_virt) {
> +		dma_unmap_single(dev, args_phys, alloc_len, DMA_TO_DEVICE);
> +		kfree(args_virt);
> +	}
> +
> +	if (desc->res.a0 < 0)
> +		return qcom_scm_remap_error(ret);

Probably not ret, as this is unused.

> +
> +	return 0;
> +}
>  
>  /**
>   * qcom_scm_set_cold_boot_addr() - Set the cold boot address for cpus
> - * @entry: Entry point function for the cpus
> - * @cpus: The cpumask of cpus that will use the entry point
> + * @entry:	Entry point function for the cpus
> + * @cpus:	The cpumask of cpus that will use the entry point

Unnecessary indentation change.

>   *
>   * Set the cold boot address of the cpus. Any cpu outside the supported
>   * range would be removed from the cpu present mask.
> @@ -29,20 +165,21 @@ int __qcom_scm_set_cold_boot_addr(void *entry, const cpumask_t *cpus)
>  
>  /**
>   * qcom_scm_set_warm_boot_addr() - Set the warm boot address for cpus
> - * @entry: Entry point function for the cpus
> - * @cpus: The cpumask of cpus that will use the entry point
> + * @entry:	Entry point function for the cpus
> + * @cpus:	The cpumask of cpus that will use the entry point

Unnecessary indentation change, and you missed adding "dev".

>   *
>   * Set the Linux entry point for the SCM to transfer control to when coming
>   * out of a power down. CPU power down may be executed on cpuidle or hotplug.
>   */
> -int __qcom_scm_set_warm_boot_addr(void *entry, const cpumask_t *cpus)
> +int __qcom_scm_set_warm_boot_addr(struct device *dev, void *entry,
> +				  const cpumask_t *cpus)
>  {
>  	return -ENOTSUPP;
>  }
>  
>  /**
>   * qcom_scm_cpu_power_down() - Power down the cpu
> - * @flags - Flags to flush cache
> + * @flags:	Flags to flush cache

I presume this one is ok...

>   *
>   * This is an end point to power down cpu. If there was a pending interrupt,
>   * the control would return from this function, otherwise, the cpu jumps to the
> @@ -52,12 +189,63 @@ void __qcom_scm_cpu_power_down(u32 flags)
>  {
>  }
>  

Regards,
Bjorn
