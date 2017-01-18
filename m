From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Jan 2017 21:19:25 +0100
Subject: [PATCH v13 2/5] tee: generic TEE subsystem
In-Reply-To: <1479480700-554-3-git-send-email-jens.wiklander@linaro.org>
References: <1479480700-554-1-git-send-email-jens.wiklander@linaro.org>
 <1479480700-554-3-git-send-email-jens.wiklander@linaro.org>
Message-ID: <5825882.vZRDMrBMkW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, November 18, 2016 3:51:37 PM CET Jens Wiklander wrote:
> Initial patch for generic TEE subsystem.
> This subsystem provides:
> * Registration/un-registration of TEE drivers.
> * Shared memory between normal world and secure world.
> * Ioctl interface for interaction with user space.
> * Sysfs implementation_id of TEE driver
> 
> A TEE (Trusted Execution Environment) driver is a driver that interfaces
> with a trusted OS running in some secure environment, for example,
> TrustZone on ARM cpus, or a separate secure co-processor etc.
> 
> The TEE subsystem can serve a TEE driver for a Global Platform compliant
> TEE, but it's not limited to only Global Platform TEEs.
> 
> This patch builds on other similar implementations trying to solve
> the same problem:
> * "optee_linuxdriver" by among others
>   Jean-michel DELORME<jean-michel.delorme@st.com> and
>   Emmanuel MICHEL <emmanuel.michel@st.com>
> * "Generic TrustZone Driver" by Javier Gonz?lez <javier@javigon.com>

Can you give an example for a system that would contain more than one
TEE? I see that you support dynamic registration, and it's clear that
there can be more than one type of TEE, but why would one have more
than one at a time, and why not more than 32?

> +static int tee_ioctl_invoke(struct tee_context *ctx,
> +			    struct tee_ioctl_buf_data __user *ubuf)
> +{
> +	int rc;
> +	size_t n;
> +	struct tee_ioctl_buf_data buf;
> +	struct tee_ioctl_invoke_arg __user *uarg;
> +	struct tee_ioctl_invoke_arg arg;
> +	struct tee_ioctl_param __user *uparams = NULL;
> +	struct tee_param *params = NULL;
> +
> +	if (!ctx->teedev->desc->ops->invoke_func)
> +		return -EINVAL;
> +
> +	if (copy_from_user(&buf, ubuf, sizeof(buf)))
> +		return -EFAULT;
> +
> +	if (buf.buf_len > TEE_MAX_ARG_SIZE ||
> +	    buf.buf_len < sizeof(struct tee_ioctl_invoke_arg))
> +		return -EINVAL;
> +
> +	uarg = (struct tee_ioctl_invoke_arg __user *)(unsigned long)buf.buf_ptr;

u64_to_user_ptr()

> +	if (copy_from_user(&arg, uarg, sizeof(arg)))
> +		return -EFAULT;
> +
> +	if (sizeof(arg) + TEE_IOCTL_PARAM_SIZE(arg.num_params) != buf.buf_len)
> +		return -EINVAL;
> +
> +	if (arg.num_params) {
> +		params = kcalloc(arg.num_params, sizeof(struct tee_param),
> +				 GFP_KERNEL);
> +		if (!params)
> +			return -ENOMEM;

It would be good to have an upper bound on the number of parameters
to limit the size of the memory allocation here.

> +int tee_device_register(struct tee_device *teedev)
> +{
> +	int rc;
> +
> +	/*
> +	 * If the teedev already is registered, don't do it again. It's
> +	 * obviously an error to try to register twice, but if we return
> +	 * an error we'll force the driver to remove the teedev.
> +	 */
> +	if (teedev->flags & TEE_DEVICE_FLAG_REGISTERED) {
> +		dev_err(&teedev->dev, "attempt to register twice\n");
> +		return 0;
> +	}

I don't understand what you are protecting against here.
How would we get to this function twice for the same device?

Could you change the caller so it doesn't happen?

> +/**
> + * struct tee_ioctl_param - parameter
> + * @attr: attributes
> + * @memref: a memory reference
> + * @value: a value
> + *
> + * @attr & TEE_PARAM_ATTR_TYPE_MASK indicates if memref or value is used in
> + * the union. TEE_PARAM_ATTR_TYPE_VALUE_* indicates value and
> + * TEE_PARAM_ATTR_TYPE_MEMREF_* indicates memref. TEE_PARAM_ATTR_TYPE_NONE
> + * indicates that none of the members are used.
> + */
> +struct tee_ioctl_param {
> +	__u64 attr;
> +	union {
> +		struct tee_ioctl_param_memref memref;
> +		struct tee_ioctl_param_value value;
> +	} u;
> +};
> +
> +#define TEE_IOCTL_UUID_LEN		16
> +

Having a union in an ioctl argument seems odd. Have you considered
using two different ioctl command numbers depending on the type?

> +/**
> + * struct tee_iocl_supp_send_arg - Send a response to a received request
> + * @ret:	[out] return value
> + * @num_params	[in] number of parameters following this struct
> + */
> +struct tee_iocl_supp_send_arg {
> +	__u32 ret;
> +	__u32 num_params;
> +	/*
> +	 * this struct is 8 byte aligned since the 'struct tee_ioctl_param'
> +	 * which follows requires 8 byte alignment.
> +	 *
> +	 * Commented out element used to visualize the layout dynamic part
> +	 * of the struct. This field is not available at all if
> +	 * num_params == 0.
> +	 *
> +	 * struct tee_ioctl_param params[num_params];
> +	 */
> +} __aligned(8);

I'd make that 

	struct tee_ioctl_param params[0];

as wel here, as I also commented in patch 3 that has a similar structure.

	Arnd
