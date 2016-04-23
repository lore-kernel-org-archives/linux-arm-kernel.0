From: andy.gross@linaro.org (Andy Gross)
Date: Fri, 22 Apr 2016 23:52:48 -0500
Subject: [PATCH 4/8] firmware: qcom: scm: Add support for ARM64 SoCs
In-Reply-To: <20160422234105.GH3202@tuxbot>
References: <1461363432-5730-1-git-send-email-andy.gross@linaro.org>
 <1461363432-5730-5-git-send-email-andy.gross@linaro.org>
 <20160422234105.GH3202@tuxbot>
Message-ID: <20160423045248.GD6968@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 22, 2016 at 04:41:05PM -0700, Bjorn Andersson wrote:
> On Fri 22 Apr 15:17 PDT 2016, Andy Gross wrote:
> 
> [..]
> > diff --git a/drivers/firmware/qcom_scm-64.c b/drivers/firmware/qcom_scm-64.c
> [..]
> > +
> > +/**
> > + * struct qcom_scm_desc
> > + * @arginfo: Metadata describing the arguments in args[]
> > + * @args: The array of arguments for the secure syscall
> > + * @res: The values returned by the secure syscall
> > + * @extra_args_virt: The buffer containing extra arguments
> > +		   (that don't fit in available registers)
> > + * @extra_args_phys: The physical address of the extra arguments
> 
> @alloc_size

Will add that.

> > + */
> > +struct qcom_scm_desc {
> > +	u32 arginfo;
> > +	u64 args[MAX_QCOM_SCM_ARGS];
> > +	struct arm_smccc_res res;
> > +
> > +	/* private */
> > +	void *extra_args_virt;
> > +	dma_addr_t extra_args_phys;
> > +	size_t alloc_size;
> > +};
> > +
> > +static u64 qcom_smccc_convention = -1;
> > +static DEFINE_MUTEX(qcom_scm_lock);
> > +
> > +#define QCOM_SCM_EBUSY_WAIT_MS 30
> > +#define QCOM_SCM_EBUSY_MAX_RETRY 20
> > +
> > +#define N_EXT_QCOM_SCM_ARGS 7
> > +#define FIRST_EXT_ARG_IDX 3
> > +#define N_REGISTER_ARGS (MAX_QCOM_SCM_ARGS - N_EXT_QCOM_SCM_ARGS + 1)
> > +
> > +/**
> > + * qcom_scm_call() - Invoke a syscall in the secure world
> > + * @svc_id: service identifier
> > + * @cmd_id: command identifier
> > + * @fn_id: The function ID for this syscall
> > + * @desc: Descriptor structure containing arguments and return values
> > + *
> > + * Sends a command to the SCM and waits for the command to finish processing.
> > + * This should *only* be called in pre-emptible context.
> > + *
> > +*/
> 
> Extra empty line in comment and odd indentation.

oops.  I'll fix that up.

> > +static int qcom_scm_call(u32 svc_id, u32 cmd_id, struct qcom_scm_desc *desc)
> > +{
> > +	int arglen = desc->arginfo & 0xf;
> > +	int ret, retry_count = 0, i;
> > +	u32 fn_id = QCOM_SCM_FNID(svc_id, cmd_id);
> > +	u64 cmd, x5 = desc->args[FIRST_EXT_ARG_IDX];
> > +
> > +	if (unlikely(arglen > N_REGISTER_ARGS)) {
> > +		desc->alloc_size = N_EXT_QCOM_SCM_ARGS * sizeof(u64);
> > +		desc->extra_args_virt =
> 
> alloc_size, extra_args_virt and extra_args_phys doesn't seem to outlive
> this function, can't they be made local variable?

That is a good point.  I'll make them local.

> > +			qcom_scm_alloc_buffer(desc->alloc_size,
> > +						 &desc->extra_args_phys,
> > +						 GFP_KERNEL);
> > +		if (!desc->extra_args_virt)
> > +			return qcom_scm_remap_error(-ENOMEM);
> > +
> > +		if (qcom_smccc_convention == ARM_SMCCC_SMC_32) {
> > +			u32 *args = desc->extra_args_virt;
> > +
> > +			for (i = 0; i < N_EXT_QCOM_SCM_ARGS; i++)
> > +				args[i] = desc->args[i + FIRST_EXT_ARG_IDX];
> > +		} else {
> > +			u64 *args = desc->extra_args_virt;
> > +
> > +			for (i = 0; i < N_EXT_QCOM_SCM_ARGS; i++)
> > +				args[i] = desc->args[i + FIRST_EXT_ARG_IDX];
> > +		}
> > +
> > +		x5 = desc->extra_args_phys;
> > +	}
> > +
> > +	do {
> > +		mutex_lock(&qcom_scm_lock);
> > +
> > +		cmd = ARM_SMCCC_CALL_VAL(ARM_SMCCC_STD_CALL,
> > +					 qcom_smccc_convention,
> > +					 ARM_SMCCC_OWNER_SIP, fn_id);
> > +
> > +		do {
> > +			arm_smccc_smc(cmd, arglen, desc->args[0], desc->args[1],
> > +				      desc->args[2], x5, 0, 0, &desc->res);
> > +		} while (desc->res.a0 == QCOM_SCM_INTERRUPTED);
> > +
> > +		mutex_unlock(&qcom_scm_lock);
> > +
> > +		if (desc->res.a0 == QCOM_SCM_V2_EBUSY) {
> > +			if (retry_count++ > QCOM_SCM_EBUSY_MAX_RETRY)
> > +				break;
> > +			msleep(QCOM_SCM_EBUSY_WAIT_MS);
> > +		}
> > +	}  while (desc->res.a0 == QCOM_SCM_V2_EBUSY);
> > +
> > +	if (desc->extra_args_virt)
> > +		qcom_scm_free_buffer(desc->alloc_size, desc->extra_args_virt,
> > +				     desc->extra_args_phys);
> > +
> > +	if (desc->res.a0 < 0)
> > +		return qcom_scm_remap_error(ret);
> > +
> > +	return 0;
> > +}
> >  
> >  /**
> >   * qcom_scm_set_cold_boot_addr() - Set the cold boot address for cpus
> > @@ -50,14 +186,68 @@ int __qcom_scm_set_warm_boot_addr(void *entry, const cpumask_t *cpus)
> >   */
> >  void __qcom_scm_cpu_power_down(u32 flags)
> >  {
> > +	return;
> 
> We can't have this empty?

OCD kicked in I think.  Yeah I'll make it empty.

> >  
> >  int __qcom_scm_is_call_available(u32 svc_id, u32 cmd_id)
> >  {
> > -	return -ENOTSUPP;
> > +	int ret;
> > +	struct qcom_scm_desc desc = {0};
> > +
> > +	desc.arginfo = QCOM_SCM_ARGS(1);
> > +	desc.args[0] = QCOM_SCM_FNID(svc_id, cmd_id) |
> 
> Are we not playing the endian game om arm64?

Actually yes.  This needs the le munging.

> > +			(ARM_SMCCC_OWNER_SIP << ARM_SMCCC_OWNER_SHIFT);
> > +
> > +	ret = qcom_scm_call(QCOM_SCM_SVC_INFO, QCOM_IS_CALL_AVAIL_CMD,
> > +			    &desc);
> > +
> > +	if (ret)
> > +		return ret;
> > +
> > +	return desc.res.a1;
> 
> We use the following construct elsewhere in scm:
> 
> 	return ret ? : desc.res.a1;

Will fix.

> 
> >  }
> >  
> [..]
> > diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> > index 8e1eeb8..7d7b12b 100644
> [..]
> >  
> > +static void qcom_scm_init(void)
> > +{
> > +	__qcom_scm_init();
> > +}
> > +
> >  static int qcom_scm_probe(struct platform_device *pdev)
> >  {
> >  	struct qcom_scm *scm;
> > @@ -208,6 +213,8 @@ static int qcom_scm_probe(struct platform_device *pdev)
> >  	__scm = scm;
> >  	__scm->dev = &pdev->dev;
> >  
> > +	qcom_scm_init();
> > +
> 
> Why don't you call __qcom_scm_init() directly here?

Yeah that would save some stack ops.

As a side note, what do you think about just making the first transaction on the
scm-64 side do this init to figure out 32/64 calling convention?

That would eliminate this mess.

> >  	return 0;
> >  }
> >  
> > diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
> [..]
> > +#define QCOM_SCM_V2_EBUSY	-12
> >  #define QCOM_SCM_ENOMEM		-5
> >  #define QCOM_SCM_EOPNOTSUPP	-4
> >  #define QCOM_SCM_EINVAL_ADDR	-3
> > @@ -56,6 +58,8 @@ static inline int qcom_scm_remap_error(int err)
> >  		return -EOPNOTSUPP;
> >  	case QCOM_SCM_ENOMEM:
> >  		return -ENOMEM;
> > +	case QCOM_SCM_V2_EBUSY:
> > +		return err;
> 
> I don't think return -ENOMEM is the right thing to do here.

-EBUSY?

> >  	return -EINVAL;
> >  }
