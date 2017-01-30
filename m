From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Mon, 30 Jan 2017 14:43:26 +0100
Subject: [PATCH v15 2/5] tee: generic TEE subsystem
In-Reply-To: <324467e6-807e-34e1-e411-e4ef95c8c76c@st.com>
References: <1485605984-30064-1-git-send-email-jens.wiklander@linaro.org>
 <1485605984-30064-3-git-send-email-jens.wiklander@linaro.org>
 <324467e6-807e-34e1-e411-e4ef95c8c76c@st.com>
Message-ID: <20170130134325.GA4888@jax>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2017 at 09:02:49AM +0000, Benjamin GAIGNARD wrote:
> 
> 
> On 01/28/2017 01:19 PM, Jens Wiklander wrote:
[...]
> > +/**
> > + * tee_shm_alloc() - Allocate shared memory
> > + * @ctx:	Context that allocates the shared memory
> > + * @size:	Requested size of shared memory
> > + * @flags:	Flags setting properties for the requested shared memory.
> > + *
> > + * Memory allocated as global shared memory is automatically freed when the
> > + * TEE file pointer is closed. The @flags field uses the bits defined by
> > + * TEE_SHM_* in <linux/tee_drv.h>. TEE_SHM_MAPPED must currently always be
> > + * set. If TEE_SHM_DMA_BUF global shared memory will be allocated and
> > + * associated with a dma-buf handle, else driver private memory.
> > + */
> > +struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
> > +{
> > +	struct tee_device *teedev = ctx->teedev;
> > +	struct tee_shm_pool_mgr *poolm = NULL;
> > +	struct tee_shm *shm;
> > +	void *ret;
> > +	int rc;
> > +
> > +	if (!(flags & TEE_SHM_MAPPED)) {
> > +		dev_err(teedev->dev.parent,
> > +			"only mapped allocations supported\n");
> > +		return ERR_PTR(-EINVAL);
> > +	}
> > +
> > +	if ((flags & ~(TEE_SHM_MAPPED | TEE_SHM_DMA_BUF))) {
> > +		dev_err(teedev->dev.parent, "invalid shm flags 0x%x", flags);
> > +		return ERR_PTR(-EINVAL);
> > +	}
> > +
> > +	if (!tee_device_get(teedev))
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	if (!teedev->pool) {
> > +		/* teedev has been detached from driver */
> > +		ret = ERR_PTR(-EINVAL);
> > +		goto err_dev_put;
> > +	}
> > +
> > +	shm = kzalloc(sizeof(*shm), GFP_KERNEL);
> > +	if (!shm) {
> > +		ret = ERR_PTR(-ENOMEM);
> > +		goto err_dev_put;
> > +	}
> > +
> > +	shm->flags = flags;
> > +	shm->teedev = teedev;
> > +	shm->ctx = ctx;
> > +	if (flags & TEE_SHM_DMA_BUF)
> > +		poolm = &teedev->pool->dma_buf_mgr;
> > +	else
> > +		poolm = &teedev->pool->private_mgr;
> > +
> > +	rc = poolm->ops->alloc(poolm, shm, size);
> > +	if (rc) {
> > +		ret = ERR_PTR(rc);
> > +		goto err_kfree;
> > +	}
> > +
> > +	mutex_lock(&teedev->mutex);
> > +	shm->id = idr_alloc(&teedev->idr, shm, 1, 0, GFP_KERNEL);
> > +	mutex_unlock(&teedev->mutex);
> > +	if (shm->id < 0) {
> > +		ret = ERR_PTR(shm->id);
> > +		goto err_pool_free;
> > +	}
> > +
> > +	if (flags & TEE_SHM_DMA_BUF) {
> > +		DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> > +
> > +		exp_info.ops = &tee_shm_dma_buf_ops;
> > +		exp_info.size = shm->size;
> > +		exp_info.flags = O_RDWR;
> > +		exp_info.priv = shm;
> > +
> > +		shm->dmabuf = dma_buf_export(&exp_info);
> > +		if (IS_ERR(shm->dmabuf)) {
> > +			ret = ERR_CAST(shm->dmabuf);
> > +			goto err_rem;
> > +		}
> > +	}
> why not always use dmabuf ? with dma_buf_fd() you have a file descriptor
> which is also an integer.
> Like this you may can remove shm->id and TEE_SHM_DMA_BUF

In the early patch sets (v8 and earlier) it was a bit like you propose
(except that we only used dmabuf on the same object as today). Then I
got https://lkml.org/lkml/2016/2/11/861 where Al Viro says (among other
things) "struct containing descriptor *is* a bad ABI design". Al also
mentioned the problem with cleaning up allocated file descriptors on
errors. I choose the safe path to only allocate and return a file
descriptor when no error cleanup is needed because the descriptor is in
the return value.

Another reason is that there are shared memory objects which never are
supposed to be mapped in user space. They are only a thing between the
kernel and secure world, when carrying the struct optee_msg_arg for
instance.

> > +	mutex_lock(&teedev->mutex);
> > +	list_add_tail(&shm->link, &ctx->list_shm);
> > +	mutex_unlock(&teedev->mutex);
> > +
> > +	return shm;
> > +err_rem:
> > +	mutex_lock(&teedev->mutex);
> > +	idr_remove(&teedev->idr, shm->id);
> > +	mutex_unlock(&teedev->mutex);
> > +err_pool_free:
> > +	poolm->ops->free(poolm, shm);
> > +err_kfree:
> > +	kfree(shm);
> > +err_dev_put:
> > +	tee_device_put(teedev);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(tee_shm_alloc);
[...]

> > +/**
> > + * tee_shm_get_from_id() - Find shared memory object and increase referece count
> referece -> reference

I'll fix.

> > + * @ctx:	Context owning the shared memory
> > + * @id:		Id of shared memory object
> > + * @returns a pointer to 'struct tee_shm' on success or an ERR_PTR on failure
> > + */
> > +struct tee_shm *tee_shm_get_from_id(struct tee_context *ctx, int id)
> > +{
> > +	struct tee_device *teedev;
> > +	struct tee_shm *shm;
> > +
> > +	if (!ctx)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	teedev = ctx->teedev;
> > +	mutex_lock(&teedev->mutex);
> > +	shm = idr_find(&teedev->idr, id);
> > +	if (!shm || shm->ctx != ctx)
> > +		shm = ERR_PTR(-EINVAL);
> > +	else if (shm->flags & TEE_SHM_DMA_BUF)
> > +		get_dma_buf(shm->dmabuf);
> > +	mutex_unlock(&teedev->mutex);
> > +	return shm;
> > +}
> > +EXPORT_SYMBOL_GPL(tee_shm_get_from_id);

[...]

> > +/**
> > + * tee_shm_get_from_id() - Find shared memory object and increase referece count
> referece -> reference

I'll fix.

> > + * @ctx:	Context owning the shared memory
> > + * @id:		Id of shared memory object
> > + * @returns a pointer to 'struct tee_shm' on success or an ERR_PTR on failure
> > + */
> > +struct tee_shm *tee_shm_get_from_id(struct tee_context *ctx, int id);
> > +
> > +#endif /*__TEE_DRV_H*/

Thanks,
Jens
