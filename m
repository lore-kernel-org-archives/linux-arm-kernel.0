From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 29 Sep 2017 11:53:11 +0100
Subject: [PATCH v1 02/14] tee: add register user memory
In-Reply-To: <1506621851-6929-3-git-send-email-volodymyr_babchuk@epam.com>
References: <1506621851-6929-1-git-send-email-volodymyr_babchuk@epam.com>
 <1506621851-6929-3-git-send-email-volodymyr_babchuk@epam.com>
Message-ID: <20170929105311.GC5781@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 28, 2017 at 09:03:59PM +0300, Volodymyr Babchuk wrote:
> +static int
> +tee_ioctl_shm_register(struct tee_context *ctx,
> +		       struct tee_ioctl_shm_register_data __user *udata)
> +{
> +	long ret;
> +	struct tee_ioctl_shm_register_data data;
> +	struct tee_shm *shm;
> +
> +	if (copy_from_user(&data, udata, sizeof(data)))
> +		return -EFAULT;
> +
> +	/* Currently no input flags are supported */
> +	if (data.flags)
> +		return -EINVAL;
> +
> +	shm = tee_shm_register(ctx, data.addr, data.length,
> +			       TEE_SHM_DMA_BUF | TEE_SHM_USER_MAPPED);
> +	if (IS_ERR(shm))
> +		return PTR_ERR(shm);
> +
> +	data.id = shm->id;
> +	data.flags = shm->flags;
> +	data.length = shm->size;
> +
> +	if (copy_to_user(udata, &data, sizeof(data)))
> +		ret = -EFAULT;
> +	else
> +		ret = tee_shm_get_fd(shm);

Why do you need both the fd and an id? That seems redundant.

[...]

> +struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
> +				 size_t length, u32 flags)
> +{
> +	struct tee_device *teedev = ctx->teedev;
> +	const u32 req_flags = TEE_SHM_DMA_BUF | TEE_SHM_USER_MAPPED;
> +	struct tee_shm *shm;
> +	void *ret;
> +	int rc;
> +	int num_pages;
> +	unsigned long start;
> +
> +	if (flags != req_flags) {
> +		dev_err(teedev->dev.parent, "invliad shm flags %#x", flags);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (!tee_device_get(teedev))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (!teedev->desc->ops->shm_register ||
> +	    !teedev->desc->ops->shm_unregister) {
> +		dev_err(teedev->dev.parent,
> +			"register shared memory unspported by device");

I don't think this should be a dev_err. The user requested something
that the device did not support, but that's not a device-side error.

A user may legitmiately do this to probe whether the TEE supports
registering memory.

> +		tee_device_put(teedev);
> +		return ERR_PTR(-EINVAL);

Perhaps EOPNOTSUPP?

> +	}
> +
> +	shm = kzalloc(sizeof(*shm), GFP_KERNEL);
> +	if (!shm) {
> +		ret = ERR_PTR(-ENOMEM);
> +		goto err;
> +	}
> +
> +	shm->flags = flags | TEE_SHM_REGISTER;
> +	shm->teedev = teedev;
> +	shm->ctx = ctx;
> +	shm->id = -1;
> +	start = rounddown(addr, PAGE_SIZE);
> +	shm->offset = addr - start;
> +	shm->size = length;
> +	num_pages = (roundup(addr + length, PAGE_SIZE) - start) / PAGE_SIZE;

Why not mandate that the user passes a buffer which has a start and end
aligned to PAGE_SIZE?

Otherwise, the buffer is size is silently upgraded without the user's
knowledge, which seems likely to result in bugs.

> +	shm->pages = kcalloc(num_pages, sizeof(struct page), GFP_KERNEL);

I think you mean sizeof(struct page *) here.

Generally, for:

  lhs = some_alloc(sizeof(x))

... it's preferred that x is *lhs, so as to keep the types in sync. e.g.

  shm->pages = kcalloc(num_pages, sizeof(*shm->pages), GFP_KERNEL);

> +	if (!shm->pages) {
> +		ret = ERR_PTR(-ENOMEM);
> +		goto err;
> +	}
> +
> +	rc = get_user_pages_fast(start, num_pages, 1, shm->pages);
> +	if (rc > 0)
> +		shm->num_pages = rc;
> +	if (rc != num_pages) {
> +		if (rc > 0)
> +			rc = -ENOMEM;
> +		ret = ERR_PTR(rc);
> +		goto err;
> +	}
> +
> +	mutex_lock(&teedev->mutex);
> +	shm->id = idr_alloc(&teedev->idr, shm, 1, 0, GFP_KERNEL);
> +	mutex_unlock(&teedev->mutex);

AFAICT, idr_alloc() can fail, so I beleive you're missing a sanity check
on the return value here.

THanks,
Mark.
