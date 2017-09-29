From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 29 Sep 2017 14:06:43 +0100
Subject: [PATCH v1 07/14] tee: optee: add shared buffer registration
 functions
In-Reply-To: <1506621851-6929-8-git-send-email-volodymyr_babchuk@epam.com>
References: <1506621851-6929-1-git-send-email-volodymyr_babchuk@epam.com>
 <1506621851-6929-8-git-send-email-volodymyr_babchuk@epam.com>
Message-ID: <20170929130643.GE5781@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 28, 2017 at 09:04:04PM +0300, Volodymyr Babchuk wrote:
> From: Volodymyr Babchuk <vlad.babchuk@gmail.com>
> 
> This change adds ops for shm_(un)register functions in tee interface.
> Client application can use these functions to (un)register an own shared
> buffer in OP-TEE address space. This allows zero copy data sharing between
> Normal and Secure Worlds.
> 
> Please note that while those functions were added to optee code,
> it does not report to userspace that those functions are available.
> OP-TEE code does not set TEE_GEN_CAP_REG_MEM flag. This flag will be
> enabled only after all other features of dynamic shared memory will be
> implemented in subsequent patches.

While it's not adveritsed to the user, AFAICT the user could still
invoke these via ioctls, right?

Is there a problem if the user were to do so, or is it simply not useful
without the other features?

[...]

> +int optee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
> +		       struct page **pages, size_t num_pages)
> +{

> +	pages_array = optee_allocate_pages_array(num_pages);
> +	if (!pages_array)
> +		return -ENOMEM;

> +	msg_arg->params->u.tmem.buf_ptr = virt_to_phys(pages_array) |
> +					  tee_shm_get_page_offset(shm);

This doesn't look right. Why is the shm page offset being orred-in to
the pages_array physical address? They're completely separate objects.

Thanks,
Mark.
