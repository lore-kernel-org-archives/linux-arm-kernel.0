From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Tue, 7 Jun 2016 12:50:16 +0200
Subject: [PATCH v10 2/4] tee: generic TEE subsystem
In-Reply-To: <5755EECA.6040606@ti.com>
References: <1464784888-19854-1-git-send-email-jens.wiklander@linaro.org>
 <1464784888-19854-3-git-send-email-jens.wiklander@linaro.org>
 <5755EECA.6040606@ti.com>
Message-ID: <20160607105015.GA18132@ermac>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 06, 2016 at 04:44:42PM -0500, Nishanth Menon wrote:
> On 06/01/2016 07:41 AM, Jens Wiklander wrote:
> few minor comments below.
> 
> I see the patch generated (with --strict):
> > CHECK: Alignment should match open parenthesis
> > #512: FILE: drivers/tee/tee.c:375:
> > +static int tee_ioctl_close_session(struct tee_context *ctx,
> > +              struct tee_ioctl_close_session_arg __user *uarg)
> > CHECK: Alignment should match open parenthesis
> > #1607: FILE: drivers/tee/tee_shm_pool.c:103:
> > +struct tee_shm_pool *tee_shm_pool_alloc_res_mem(struct device *dev,
> > +                      struct tee_shm_pool_mem_info *priv_info,
> > CHECK: Alignment should match open parenthesis

The alternative is to format it as:
struct tee_shm_pool *tee_shm_pool_alloc_res_mem(struct device *dev,
                                                struct tee_shm_pool_mem_info
                                                        *priv_info,
                                                struct tee_shm_pool_mem_info
                                                        *dmabuf_info)
But that is a bit awkward. I'd like to keep it as it is if you don't mind.

> > #1789: FILE: include/linux/tee_drv.h:124:
> > +struct tee_device *tee_device_alloc(const struct tee_desc *teedesc,
> > +                      struct device *dev, struct tee_shm_pool *pool,
> > WARNING: line over 80 characters
> > #1814: FILE: include/linux/tee_drv.h:149:
> > + * struct tee_shm_pool_mem_info - holds information needed to create a shared memory pool  
> > WARNING: line over 80 characters
> > #1826: FILE: include/linux/tee_drv.h:161:
> > + * tee_shm_pool_alloc_res_mem() - Create a shared memory pool from reserved memory range  

I'll fix the long lines.

> > CHECK: Alignment should match open parenthesis
> > #1839: FILE: include/linux/tee_drv.h:174:
> > +struct tee_shm_pool *tee_shm_pool_alloc_res_mem(struct device *dev,                        
> > +                      struct tee_shm_pool_mem_info *priv_info,
> > CHECK: Prefer using the BIT macro
> > #1995: FILE: include/uapi/linux/tee.h:51:
> > +#define TEE_GEN_CAP_GP                (1 << 0)/* GlobalPlatform compliant TEE */ 
> > CHECK: Prefer using the BIT macro
> > #2005: FILE: include/uapi/linux/tee.h:61:
> > +#define TEE_OPTEE_CAP_TZ      (1 << 0)

This file is included from user space too and BIT is only defined if
__KERNEL__ is defined.

> > WARNING: line over 80 characters
> > #2205: FILE: include/uapi/linux/tee.h:261:
> > + * struct tee_ioctl_invoke_func_arg - Invokes a function in a Trusted Application 
> >       mechanically convert to the typical style using --fix or --fix-inplace.
> >       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> 
> Might be nice to fix them up.
> 
> [...]
> 
> > diff --git a/drivers/tee/Kconfig b/drivers/tee/Kconfig
> > new file mode 100644
> > index 0000000..f3ba154
> > --- /dev/null
> > +++ b/drivers/tee/Kconfig
> > @@ -0,0 +1,9 @@
> > +# Generic Trusted Execution Environment Configuration
> > +config TEE
> > +	bool "Trusted Execution Environment support"
> 
> Why could not this be tristate? we would like to enforce subsystem init?

In the past it wasn't possible, but it is now. I'll fix.

> 
> > +	default n
> 
> You should not need this. (default is n)

I'll fix.

> 
> > +	select DMA_SHARED_BUFFER
> > +	select GENERIC_ALLOCATOR
> 
> select or depends?

These are selected by all the other modules needing these.

> 
> > +	help
> > +	  This implements a generic interface towards a Trusted Execution
> > +	  Environment (TEE).
> > diff --git a/drivers/tee/Makefile b/drivers/tee/Makefile
> > new file mode 100644
> > index 0000000..60d2dab
> > --- /dev/null
> > +++ b/drivers/tee/Makefile
> > @@ -0,0 +1,3 @@
> > +obj-y += tee.o
> > +obj-y += tee_shm.o
> > +obj-y += tee_shm_pool.o
> > diff --git a/drivers/tee/tee.c b/drivers/tee/tee.c
> > new file mode 100644
> > index 0000000..119e18e
> > --- /dev/null
> > +++ b/drivers/tee/tee.c
> > @@ -0,0 +1,877 @@
> > +/*
> > + * Copyright (c) 2015-2016, Linaro Limited
> > + *
> > + * This software is licensed under the terms of the GNU General Public
> > + * License version 2, as published by the Free Software Foundation, and
> > + * may be copied, distributed, and modified under those terms.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + */
> Adding a
> #define pr_fmt(fmt) "%s: " fmt, __func__ might help
> might help give reasonable errors where pr_* is used.

I'll fix.

> 
> > +#include <linux/cdev.h>
> > +#include <linux/device.h>
> > +#include <linux/fs.h>
> > +#include <linux/idr.h>
> > +#include <linux/slab.h>
> > +#include <linux/tee_drv.h>
> > +#include <linux/uaccess.h>
> > +#include "tee_private.h"
> > +
> > +#define TEE_NUM_DEVICES	32
> 
> I have a personal allergy to MAX_* macros, so I wonder if idr can help
> us get rid of fixed size tables? I wonder if the use should be limited
> to tee_shm.c ?
> 
> static DEFINE_IDR(tee_id);
> ....
> 
> teedev->id =  idr_alloc(&tee_id, teedev, 0, 0, GFP_KERNEL);
> or something similar?

That would work, but the we'd need to do something with
alloc_chrdev_region() in tee_init() below also. As long as we're only
doing a single call to alloc_chrdev_region() we'll have an upper limit
of the number of devices and not much if any is gained by using IDR
instead of a fixed sized bit-field.

> 
> > +
> > +#define TEE_IOCTL_PARAM_SIZE(x) (sizeof(struct tee_param) * (x))
> > +
> > +/*
> > + * Unprivileged devices in the in the lower half range and privileged
> > + * devices in the upper half range.
> > + */
> > +static DECLARE_BITMAP(dev_mask, TEE_NUM_DEVICES);
> > +static DEFINE_SPINLOCK(driver_lock);
> 
> I think you might be able to get rid of the above two with idr usage.

Yes, but I'd need to add a mutex for synchronization for idr_alloc() and
idr_remove(). To make it easier in user space to tell the privileged
devices apart from the normal client devices I'm using /dev/teeprivX and
/dev/teeX, both are supposed to be numbered from 0 and upwards. Without
a fixed upper limit I would need two IDRs to keep track of the
numbering.

With these obstacles and the one above (alloc_chrdev_region()) in mind
I'd like to keep the fixed MAX number.

> 
> > +
> > +static struct class *tee_class;
> > +static dev_t tee_devt;
> > +
> > +static int tee_open(struct inode *inode, struct file *filp)
> > +{
> > +	int rc;
> > +	struct tee_device *teedev;
> > +	struct tee_context *ctx;
> > +
> > +	teedev = container_of(inode->i_cdev, struct tee_device, cdev);
> > +	if (!tee_device_get(teedev))
> > +		return -EINVAL;
> > +
> > +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> > +	if (!ctx) {
> > +		rc = -ENOMEM;
> > +		goto err;
> > +	}
> > +
> > +	ctx->teedev = teedev;
> > +	filp->private_data = ctx;
> 
> I wonder if the teedev was a module, could it be removed /
> unregistered after tee_open was invoked?

No, even if the shared memory routines was in another module we still
have the tee_class to keep track of.

> 
> > +static int tee_ioctl_invoke(struct tee_context *ctx,
> > +			    struct tee_ioctl_buf_data __user *ubuf)
> > +{
> > +	int rc;
> > +	size_t n;
> > +	struct tee_ioctl_buf_data buf;
> > +	struct tee_ioctl_invoke_arg __user *uarg;
> > +	struct tee_ioctl_invoke_arg arg;
> > +	struct tee_ioctl_param __user *uparams = NULL;
> > +	struct tee_param *params = NULL;
> > +
> > +	if (!ctx->teedev->desc->ops->invoke_func)
> > +		return -EINVAL;
> > +
> > +	rc = copy_from_user(&buf, ubuf, sizeof(buf));
> > +	if (rc)
> > +		return rc;
> > +
> > +	if (buf.buf_len > TEE_MAX_ARG_SIZE ||
> > +	    buf.buf_len < sizeof(struct tee_ioctl_invoke_arg))
> > +		return -EINVAL;
> > +
> > +	uarg = (struct tee_ioctl_invoke_arg __user *)(unsigned long)buf.buf_ptr;
> > +	if (copy_from_user(&arg, uarg, sizeof(arg)))
> > +		return -EFAULT;
> > +
> > +	if (sizeof(arg) + TEE_IOCTL_PARAM_SIZE(arg.num_params) != buf.buf_len)
> > +		return -EINVAL;
> > +
> > +	if (arg.num_params) {
> > +		params = kcalloc(arg.num_params, sizeof(struct tee_param),
> > +				 GFP_KERNEL);
> > +		if (!params)
> > +			return -ENOMEM;
> > +		uparams = (struct tee_ioctl_param __user *)(uarg + 1);
> > +		rc = params_from_user(ctx, params, arg.num_params, uparams);
> > +		if (rc)
> > +			goto out;
> > +	}
> > +
> > +	rc = ctx->teedev->desc->ops->invoke_func(ctx, &arg, params);
> > +	if (rc)
> > +		goto out;
> 
> Hmm.. I wonder if the teedev drivers should get subsystem level lock
> protection for ops invocation or should they implement locking themselves?

At least for OP-TEE we need to be able to make several ops invocations
in parallel so it locking has to be dealt with in the ops invocations
themselves.

Thanks for taking the time to review this.

--
Regards,
Jens
