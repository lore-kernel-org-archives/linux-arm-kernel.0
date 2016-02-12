From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Fri, 12 Feb 2016 12:30:07 +0100
Subject: [PATCH v8 2/4] tee: generic TEE subsystem
In-Reply-To: <20160212045159.GQ17997@ZenIV.linux.org.uk>
References: <1455210877-15748-1-git-send-email-jens.wiklander@linaro.org>
 <1455210877-15748-3-git-send-email-jens.wiklander@linaro.org>
 <20160212045159.GQ17997@ZenIV.linux.org.uk>
Message-ID: <20160212113006.GA30447@ermac>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 12, 2016 at 04:51:59AM +0000, Al Viro wrote:
> On Thu, Feb 11, 2016 at 06:14:35PM +0100, Jens Wiklander wrote:
> 
> > +static int tee_ioctl_shm_alloc(struct tee_context *ctx,
> > +		struct tee_ioctl_shm_alloc_data __user *udata)
> > +{
> > +	long ret;
> > +	struct tee_ioctl_shm_alloc_data data;
> > +	struct tee_shm *shm;
> > +
> > +	if (copy_from_user(&data, udata, sizeof(data)))
> > +		return -EFAULT;
> > +
> > +	/* Currently no input flags are supported */
> > +	if (data.flags)
> > +		return -EINVAL;
> > +
> > +	data.fd = -1;
> > +
> > +	shm = tee_shm_alloc(ctx->teedev, data.size,
> > +			    TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
> > +	if (IS_ERR(shm))
> > +		return PTR_ERR(shm);
> > +
> > +	data.flags = shm->flags;
> > +	data.size = shm->size;
> > +	data.fd = tee_shm_get_fd(shm);
> > +	if (data.fd < 0) {
> > +		ret = data.fd;
> > +		goto err;
> > +	}
> > +
> > +	if (copy_to_user(udata, &data, sizeof(data))) {
> > +		ret = -EFAULT;
> > +		goto err;
> > +	}
> > +	/*
> > +	 * When user space closes the file descriptor the shared memory
> > +	 * should be freed
> > +	 */
> > +	tee_shm_put(shm);
> > +	return 0;
> > +err:
> > +	if (data.fd >= 0)
> > +		tee_shm_put_fd(data.fd);
> 
> This is completely broken.  Don't ever use that pattern.  Once something
> is in descriptor table, that's _it_.  You are already past the point of
> no return and there is no way to clean up.
> 
> In ABIs like that (and struct containing descriptor *is* a bad ABI design)
> solution is
> 	* allocate a descriptor
> 	* do everything that might fail, including copy_to_user()/put_user(),
> etc.
> 	* if failed, release unused descriptor and do fput(), if you already
> have a struct file reference that needs to be released.
> 	* FINALLY, when nothing no failures are possible, fd_install() the
> sucker in place.
> 
> And yes, dma_buf_fd() encourages that kind of braindamage.  It's tolerable
> only in one case - when we are about to return descriptor number directly
> as return value of syscall and really can't fail anymore.  Not the case
> here.

Thanks for the feedback, I'll change to return the descriptor in the
return value instead.

--
Jens
