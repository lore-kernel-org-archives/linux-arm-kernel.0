From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 17 Apr 2015 22:07:02 +0200
Subject: [RFC PATCH 1/2] tee: generic TEE subsystem
In-Reply-To: <1429257057-7935-2-git-send-email-jens.wiklander@linaro.org>
References: <1429257057-7935-1-git-send-email-jens.wiklander@linaro.org>
 <1429257057-7935-2-git-send-email-jens.wiklander@linaro.org>
Message-ID: <2102140.2VHBUJBHNB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 17 April 2015 09:50:56 Jens Wiklander wrote:
>  Documentation/ioctl/ioctl-number.txt |   1 +
>  drivers/Kconfig                      |   2 +
>  drivers/Makefile                     |   1 +
>  drivers/tee/Kconfig                  |   8 +
>  drivers/tee/Makefile                 |   3 +
>  drivers/tee/tee.c                    | 253 +++++++++++++++++++++++++++
>  drivers/tee/tee_private.h            |  64 +++++++
>  drivers/tee/tee_shm.c                | 330 +++++++++++++++++++++++++++++++++++
>  drivers/tee/tee_shm_pool.c           | 246 ++++++++++++++++++++++++++
>  include/linux/tee/tee.h              | 180 +++++++++++++++++++
>  include/linux/tee/tee_drv.h          | 271 ++++++++++++++++++++++++++++

Hi Jens,

The driver looks very well implemented, but as you are introducing a new user
space API, we have to very carefully consider every aspect of that interface,
so I'm commenting mainly on user-visible parts.
 
> diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
> index 8136e1f..6e9bd04 100644
> --- a/Documentation/ioctl/ioctl-number.txt
> +++ b/Documentation/ioctl/ioctl-number.txt
> @@ -301,6 +301,7 @@ Code  Seq#(hex)	Include File		Comments
>  0xA3	80-8F	Port ACL		in development:
>  					<mailto:tlewis@mindspring.com>
>  0xA3	90-9F	linux/dtlk.h
> +0xA4	00-1F	linux/sec-hw/tee.h	Generic TEE subsystem

File name does not match.

> +static long tee_ioctl_cmd(struct tee_context *ctx,
> +		struct tee_ioctl_cmd_data __user *ucmd)
> +{
> +	long ret;
> +	struct tee_ioctl_cmd_data cmd;
> +	void __user *buf_ptr;
> +
> +	ret = copy_from_user(&cmd, ucmd, sizeof(cmd));
> +	if (ret)
> +		return ret;
> +
> +	buf_ptr = (void __user *)(uintptr_t)cmd.buf_ptr;
> +	return ctx->teedev->desc->ops->cmd(ctx, buf_ptr, cmd.buf_len);
> +}

What is that double indirection for? Normally each command gets its
own data structure, and then you can handle each command in the common
abstraction.

> +static long tee_ioctl_mem_share(struct tee_context *ctx,
> +		struct tee_ioctl_mem_share_data __user *udata)
> +{
> +	/* Not supported yet */
> +	return -ENOSYS;
> +}
> +
> +static long tee_ioctl_mem_unshare(struct tee_context *ctx,
> +		struct tee_ioctl_mem_share_data __user *udata)
> +{
> +	/* Not supported yet */
> +	return -ENOSYS;
> +}

Why -ENOSYS? ioctl does exist ;-)

> +static const struct file_operations tee_fops = {
> +	.owner = THIS_MODULE,
> +	.open = tee_open,
> +	.release = tee_release,
> +	.unlocked_ioctl = tee_ioctl
> +};

Add a .compat_ioctl function, to make it work on arm64 as well.
If you got all the data structures right, you can use the same
tee_ioctl function.

Minor nit: put a comma behind the last line in each struct initialization
to make it easier to add another callback.

> +
> +static void tee_shm_release(struct tee_shm *shm);

Try to avoid forward declarations by reordering the code.

> +static struct sg_table *tee_shm_op_map_dma_buf(struct dma_buf_attachment
> +			*attach, enum dma_data_direction dir)
> +{
> +	return NULL;
> +}
> +
> +static void tee_shm_op_unmap_dma_buf(struct dma_buf_attachment *attach,
> +			struct sg_table *table, enum dma_data_direction dir)
> +{
> +}

Since a lot of callbacks are empty here, I'd probably change the
caller to check for NULL pointer before calling these, and remove
the empty implementations, unless your next patch fills them with
content.

> +struct tee_shm *tee_shm_get_from_fd(int fd)
> +{
> +	struct dma_buf *dmabuf = dma_buf_get(fd);
> +
> +	if (IS_ERR(dmabuf))
> +		return ERR_CAST(dmabuf);
> +
> +	if (!is_shm_dma_buf(dmabuf)) {
> +		dma_buf_put(dmabuf);
> +		return ERR_PTR(-EINVAL);
> +	}
> +	return dmabuf->priv;
> +}
> +EXPORT_SYMBOL_GPL(tee_shm_get_from_fd);
> +
> +void tee_shm_put(struct tee_shm *shm)
> +{
> +	if (shm->flags & TEE_SHM_DMA_BUF)
> +		dma_buf_put(shm->dmabuf);
> +}
> +EXPORT_SYMBOL_GPL(tee_shm_put);

Can you explain why you picked dmabuf as the interface here? Normally this
is used when you have multiple DMA master devices access the same memory,
while my understanding of your use case is that you just have one other
piece of code running on the same CPU accessing this.

Do you need more than one such buffer per device? Could you perhaps just
implement mmap on the chardev as a lot of other drivers do?

> +struct tee_shm_pool *tee_shm_pool_alloc_cma(struct device *dev, u_long *vaddr,
> +			phys_addr_t *paddr, size_t *size)

I think it would be better not to have 'cma' as part of the function
name -- the driver really should not care at all.

What is the typical and maximum allocation size here?

> +++ b/include/linux/tee/tee.h

This belongs into include/uapi/linux/, because you are defining ioctl values
for user space.

> +#define TEE_IOC_MAGIC	0xa4
> +#define TEE_IOC_BASE	0
> +#define _TEE_IOR(nr, size)	_IOR(TEE_IOC_MAGIC, TEE_IOC_BASE + (nr), size)
> +#define _TEE_IOWR(nr, size)	_IOWR(TEE_IOC_MAGIC, TEE_IOC_BASE + (nr), size)
> +#define _TEE_IOW(nr, size)	_IOW(TEE_IOC_MAGIC, TEE_IOC_BASE + (nr), size)

I would remove these macros and open-code the users of this as:

#define TEE_IOC_VERSION		_IOR(TEE_IOC_MAGIC, TEE_IOC_BASE, struct tee_ioctl_version)

The reason is that a number of scripts try to scan the header files for
ioctl commands, which will fail if you add another indirection.

> +/*
> + * Version of the generic TEE subsystem, if it doesn't match what's
> + * returned by TEE_IOC_VERSION this header is not in sync with the kernel.
> + */
> +#define TEE_SUBSYS_VERSION	1

That does not work. When you introduce commands, you have to keep them working.
If you get an interface wrong, you can add another ioctl, but you can never
become incompatible. If a user applications wants to see if an interface is
supported, they can use a compile-time check. Building against a version 4.xyz
kernel header means that the code will not run on older kernels.

You can also copy the definition to user space and then do runtime checks
by trying out commands and falling back to something else.

> +
> +/* Flags relating to shared memory */
> +#define TEE_IOCTL_SHM_MAPPED	0x1	/* memory mapped in normal world */
> +#define TEE_IOCTL_SHM_DMA_BUF	0x2	/* dma-buf handle on shared memory */
> +
> +/**
> + * struct tee_version - TEE versions
> + * @gen_version:	[out] Generic TEE driver version
> + * @spec_version:	[out] Specific TEE driver version
> + * @uuid:		[out] Specific TEE driver uuid, zero if not used
> + *
> + * Identifies the generic TEE driver, and the specific TEE driver.
> + * Used as argument for TEE_IOC_VERSION below.
> + */
> +struct tee_ioctl_version {
> +	uint32_t gen_version;
> +	uint32_t spec_version;
> +	uint8_t uuid[16];
> +};
> +/**
> + * TEE_IOC_VERSION - query version of drivers
> + *
> + * Takes a tee_version struct and returns with the version numbers filled in.
> + */
> +#define TEE_IOC_VERSION		_TEE_IOR(0, struct tee_ioctl_version)

Don't use uuids. You can probably just remove this entire command for
the reasons explained above.

> +/**
> + * struct tee_cmd_data - Opaque command argument
> + * @buf_ptr:	[in] A __user pointer to a command buffer
> + * @buf_len:	[in] Length of the buffer above
> + *
> + * Opaque command data which is passed on to the specific driver. The command
> + * buffer doesn't have to reside in shared memory.
> + * Used as argument for TEE_IOC_CMD below.
> + */
> +struct tee_ioctl_cmd_data {
> +	uint64_t buf_ptr;
> +	uint64_t buf_len;
> +};

Drop this one too. If someone wants commands that are not implemented
by the core, let them ask you to add them to the core, provided they are
useful and well-designed.

> + * struct tee_shm_alloc_data - Shared memory allocate argument
> + * @size:	[in/out] Size of shared memory to allocate
> + * @flags:	[in/out] Flags to/from allocation.
> + * @fd:		[out] dma_buf file descriptor of the shared memory
> + *
> + * The flags field should currently be zero as input. Updated by the call
> + * with actual flags as defined by TEE_IOCTL_SHM_* above.
> + * This structure is used as argument for TEE_IOC_SHM_ALLOC below.
> + */
> +struct tee_ioctl_shm_alloc_data {
> +	uint64_t size;
> +	uint32_t flags;
> +	int32_t fd;
> +};
> +/**
> + * TEE_IOC_SHM_ALLOC - allocate shared memory
> + *
> + * Allocates shared memory between the user space process and secure OS.
> + * The returned file descriptor is used to map the shared memory into user
> + * space. The shared memory is freed when the descriptor is closed and the
> + * memory is unmapped.
> + */
> +#define TEE_IOC_SHM_ALLOC	_TEE_IOWR(2, struct tee_ioctl_shm_alloc_data)

See my questions above. Ideally we should be able to just use mmap here.

> +/**
> + * struct tee_mem_buf - share user space memory with Secure OS
> + * @ptr:	A __user pointer to memory to share
> + * @size:	Size of the memory to share
> + * Used in 'struct tee_mem_share_data' below.
> + */
> +struct tee_ioctl_mem_buf {
> +	uint64_t ptr;
> +	uint64_t size;
> +};

Why do you want both directions, exporting a kernel buffer to user
space, as well as using a user space buffer to give to the firmware?

If you can get by with just one of them, drop the other one.

> +/**
> + * struct tee_mem_dma_buf - share foreign dma_buf memory
> + * @fd:		dma_buf file descriptor
> + * @pad:	padding, set to zero by caller
> + * Used in 'struct tee_mem_share_data' below.
> + */
> +struct tee_ioctl_mem_dma_buf {
> +	int32_t fd;
> +	uint32_t pad;
> +};

What other driver do you have in mind that would provide the
file descriptor?

> +/**
> + * struct tee_mem_share_data - share memory with Secure OS
> + * @buf:	[in] share user space memory
> + * @dma_buf:	[in] share foreign dma_buf memory
> + * @flags:	[in/out] Flags to/from sharing.
> + * @pad:	[in/out] Padding, set to zero by caller
> + *
> + * The bits in @flags are defined by TEE_IOCTL_SHM_* above, undefined bits
> + * should be seto to zero as input. If TEE_IOCTL_SHM_DMA_BUF is set in the
> + * flags field use the dma_buf field, else the buf field in the union.
> + *
> + * Used as argument for TEE_IOC_MEM_SHARE and TEE_IOC_MEM_UNSHARE below.
> + */
> +struct tee_ioctl_mem_share_data {
> +	union {
> +		struct tee_ioctl_mem_buf buf;
> +		struct tee_ioctl_mem_dma_buf dma_buf;
> +	};
> +	uint32_t flags;
> +	uint32_t pad;
> +};

Better make that two distinct commands to avoid the union and the flags.

	Arnd
