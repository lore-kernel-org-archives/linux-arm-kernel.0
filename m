From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Mon, 20 Apr 2015 08:20:44 +0200
Subject: [RFC PATCH 1/2] tee: generic TEE subsystem
In-Reply-To: <2102140.2VHBUJBHNB@wuerfel>
References: <1429257057-7935-1-git-send-email-jens.wiklander@linaro.org>
 <1429257057-7935-2-git-send-email-jens.wiklander@linaro.org>
 <2102140.2VHBUJBHNB@wuerfel>
Message-ID: <20150420062044.GA7767@ermac>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Fri, Apr 17, 2015 at 10:07:02PM +0200, Arnd Bergmann wrote:
> On Friday 17 April 2015 09:50:56 Jens Wiklander wrote:
> >  Documentation/ioctl/ioctl-number.txt |   1 +
> >  drivers/Kconfig                      |   2 +
> >  drivers/Makefile                     |   1 +
> >  drivers/tee/Kconfig                  |   8 +
> >  drivers/tee/Makefile                 |   3 +
> >  drivers/tee/tee.c                    | 253 +++++++++++++++++++++++++++
> >  drivers/tee/tee_private.h            |  64 +++++++
> >  drivers/tee/tee_shm.c                | 330 +++++++++++++++++++++++++++++++++++
> >  drivers/tee/tee_shm_pool.c           | 246 ++++++++++++++++++++++++++
> >  include/linux/tee/tee.h              | 180 +++++++++++++++++++
> >  include/linux/tee/tee_drv.h          | 271 ++++++++++++++++++++++++++++
> 
> Hi Jens,
> 
> The driver looks very well implemented, but as you are introducing a new user
> space API, we have to very carefully consider every aspect of that interface,
> so I'm commenting mainly on user-visible parts.
>  
> > diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
> > index 8136e1f..6e9bd04 100644
> > --- a/Documentation/ioctl/ioctl-number.txt
> > +++ b/Documentation/ioctl/ioctl-number.txt
> > @@ -301,6 +301,7 @@ Code  Seq#(hex)	Include File		Comments
> >  0xA3	80-8F	Port ACL		in development:
> >  					<mailto:tlewis@mindspring.com>
> >  0xA3	90-9F	linux/dtlk.h
> > +0xA4	00-1F	linux/sec-hw/tee.h	Generic TEE subsystem
> 
> File name does not match.
Sorry, I'll fix.

> 
> > +static long tee_ioctl_cmd(struct tee_context *ctx,
> > +		struct tee_ioctl_cmd_data __user *ucmd)
> > +{
> > +	long ret;
> > +	struct tee_ioctl_cmd_data cmd;
> > +	void __user *buf_ptr;
> > +
> > +	ret = copy_from_user(&cmd, ucmd, sizeof(cmd));
> > +	if (ret)
> > +		return ret;
> > +
> > +	buf_ptr = (void __user *)(uintptr_t)cmd.buf_ptr;
> > +	return ctx->teedev->desc->ops->cmd(ctx, buf_ptr, cmd.buf_len);
> > +}
> 
> What is that double indirection for? Normally each command gets its
> own data structure, and then you can handle each command in the common
> abstraction.
I'm not sure I understand what you mean. This function is a building
block for the TEE driver to supply whatever interface is needed for user
space. For a Global Platform like TEE it will typically have support for
TEEC_OpenSession(), TEEC_InvokeCommand(), TEEC_RequestCancellation() and
TEEC_CloseSession(). But how that's done is depending on how the
interface towards the TEE (in secure world) looks like. From what I've
heard so far those interfaces diverges a lot so we've compromised with
this function.

> 
> > +static long tee_ioctl_mem_share(struct tee_context *ctx,
> > +		struct tee_ioctl_mem_share_data __user *udata)
> > +{
> > +	/* Not supported yet */
> > +	return -ENOSYS;
> > +}
> > +
> > +static long tee_ioctl_mem_unshare(struct tee_context *ctx,
> > +		struct tee_ioctl_mem_share_data __user *udata)
> > +{
> > +	/* Not supported yet */
> > +	return -ENOSYS;
> > +}
> 
> Why -ENOSYS? ioctl does exist ;-)
You're right :-), is -EINVAL OK?

> 
> > +static const struct file_operations tee_fops = {
> > +	.owner = THIS_MODULE,
> > +	.open = tee_open,
> > +	.release = tee_release,
> > +	.unlocked_ioctl = tee_ioctl
> > +};
> 
> Add a .compat_ioctl function, to make it work on arm64 as well.
> If you got all the data structures right, you can use the same
> tee_ioctl function.
To handle the combination of kernel as arm64 and user space arm32?
Thanks, I'll fix.

> 
> Minor nit: put a comma behind the last line in each struct initialization
> to make it easier to add another callback.
OK

> 
> > +
> > +static void tee_shm_release(struct tee_shm *shm);
> 
> Try to avoid forward declarations by reordering the code.
OK, will fix.

> 
> > +static struct sg_table *tee_shm_op_map_dma_buf(struct dma_buf_attachment
> > +			*attach, enum dma_data_direction dir)
> > +{
> > +	return NULL;
> > +}
> > +
> > +static void tee_shm_op_unmap_dma_buf(struct dma_buf_attachment *attach,
> > +			struct sg_table *table, enum dma_data_direction dir)
> > +{
> > +}
> 
> Since a lot of callbacks are empty here, I'd probably change the
> caller to check for NULL pointer before calling these, and remove
> the empty implementations, unless your next patch fills them with
> content.
You mean I should update various functions in dma-buf.c? Dma-buf allows
having some functions as NULL but not these we had to provide here, I
don't know if there was a good reason for that or not.

> 
> > +struct tee_shm *tee_shm_get_from_fd(int fd)
> > +{
> > +	struct dma_buf *dmabuf = dma_buf_get(fd);
> > +
> > +	if (IS_ERR(dmabuf))
> > +		return ERR_CAST(dmabuf);
> > +
> > +	if (!is_shm_dma_buf(dmabuf)) {
> > +		dma_buf_put(dmabuf);
> > +		return ERR_PTR(-EINVAL);
> > +	}
> > +	return dmabuf->priv;
> > +}
> > +EXPORT_SYMBOL_GPL(tee_shm_get_from_fd);
> > +
> > +void tee_shm_put(struct tee_shm *shm)
> > +{
> > +	if (shm->flags & TEE_SHM_DMA_BUF)
> > +		dma_buf_put(shm->dmabuf);
> > +}
> > +EXPORT_SYMBOL_GPL(tee_shm_put);
> 
> Can you explain why you picked dmabuf as the interface here? Normally this
> is used when you have multiple DMA master devices access the same memory,
> while my understanding of your use case is that you just have one other
> piece of code running on the same CPU accessing this.
It could be any of the available CPUs in the system that will be
accessing this, both in secure and normal world. When we're doing a
secure video path use case some of the buffers will not be mapped in
normal world, but normal world will still keep track of the physical
addresses.

> 
> Do you need more than one such buffer per device? Could you perhaps just
> implement mmap on the chardev as a lot of other drivers do?
Each buffer allocation corresponds to TEEC_AllocateSharedMemory() in Global
Platforms TEE Client API which we implement in user space. The number of
needed buffer depends on how the user space application is designed.


> 
> > +struct tee_shm_pool *tee_shm_pool_alloc_cma(struct device *dev, u_long *vaddr,
> > +			phys_addr_t *paddr, size_t *size)
> 
> I think it would be better not to have 'cma' as part of the function
> name -- the driver really should not care at all.
OK, I'll drop the _cma suffix.

> 
> What is the typical and maximum allocation size here?
It depends on the design of the Trusted Application in secure world and
the client in user space.  A few KiB could be the typical allocation
size, with a maximum at perhaps 512 KiB (for instance when loading a
very large Trusted Application).

> 
> > +++ b/include/linux/tee/tee.h
> 
> This belongs into include/uapi/linux/, because you are defining ioctl values
> for user space.
Thanks, I'll fix.

> 
> > +#define TEE_IOC_MAGIC	0xa4
> > +#define TEE_IOC_BASE	0
> > +#define _TEE_IOR(nr, size)	_IOR(TEE_IOC_MAGIC, TEE_IOC_BASE + (nr), size)
> > +#define _TEE_IOWR(nr, size)	_IOWR(TEE_IOC_MAGIC, TEE_IOC_BASE + (nr), size)
> > +#define _TEE_IOW(nr, size)	_IOW(TEE_IOC_MAGIC, TEE_IOC_BASE + (nr), size)
> 
> I would remove these macros and open-code the users of this as:
> 
> #define TEE_IOC_VERSION		_IOR(TEE_IOC_MAGIC, TEE_IOC_BASE, struct tee_ioctl_version)
> 
> The reason is that a number of scripts try to scan the header files for
> ioctl commands, which will fail if you add another indirection.
Thanks, I'll fix.

> 
> > +/*
> > + * Version of the generic TEE subsystem, if it doesn't match what's
> > + * returned by TEE_IOC_VERSION this header is not in sync with the kernel.
> > + */
> > +#define TEE_SUBSYS_VERSION	1
> 
> That does not work. When you introduce commands, you have to keep them working.
> If you get an interface wrong, you can add another ioctl, but you can never
> become incompatible. If a user applications wants to see if an interface is
> supported, they can use a compile-time check. Building against a version 4.xyz
> kernel header means that the code will not run on older kernels.
> 
> You can also copy the definition to user space and then do runtime checks
> by trying out commands and falling back to something else.
OK, I'll drop this.

> 
> > +
> > +/* Flags relating to shared memory */
> > +#define TEE_IOCTL_SHM_MAPPED	0x1	/* memory mapped in normal world */
> > +#define TEE_IOCTL_SHM_DMA_BUF	0x2	/* dma-buf handle on shared memory */
> > +
> > +/**
> > + * struct tee_version - TEE versions
> > + * @gen_version:	[out] Generic TEE driver version
> > + * @spec_version:	[out] Specific TEE driver version
> > + * @uuid:		[out] Specific TEE driver uuid, zero if not used
> > + *
> > + * Identifies the generic TEE driver, and the specific TEE driver.
> > + * Used as argument for TEE_IOC_VERSION below.
> > + */
> > +struct tee_ioctl_version {
> > +	uint32_t gen_version;
> > +	uint32_t spec_version;
> > +	uint8_t uuid[16];
> > +};
> > +/**
> > + * TEE_IOC_VERSION - query version of drivers
> > + *
> > + * Takes a tee_version struct and returns with the version numbers filled in.
> > + */
> > +#define TEE_IOC_VERSION		_TEE_IOR(0, struct tee_ioctl_version)
> 
> Don't use uuids. You can probably just remove this entire command for
> the reasons explained above.
I agree that we can drop least one of the _version fields probably both,
but something is needed for user space to be able to know which TEE (in
secure world) it's communicating with. The uuid will let the client know
how how to format the commands passed to TEE_IOC_CMD below.

> 
> > +/**
> > + * struct tee_cmd_data - Opaque command argument
> > + * @buf_ptr:	[in] A __user pointer to a command buffer
> > + * @buf_len:	[in] Length of the buffer above
> > + *
> > + * Opaque command data which is passed on to the specific driver. The command
> > + * buffer doesn't have to reside in shared memory.
> > + * Used as argument for TEE_IOC_CMD below.
> > + */
> > +struct tee_ioctl_cmd_data {
> > +	uint64_t buf_ptr;
> > +	uint64_t buf_len;
> > +};
> 
> Drop this one too. If someone wants commands that are not implemented
> by the core, let them ask you to add them to the core, provided they are
> useful and well-designed.
I've touched on this above, this function the essential when
communicating with the driver and secure world. Different TEEs (running
in some secure environment) provides different interfaces. By providing
an opaque channel we don't have to force something on the TEE.  The
problem is moved to the user space library which is used when talking to
the TEE. The assumption here is that the interface provided the TEE is
stable or something that the specific TEE driver can handle with a glue
layer.

When the client opens /dev/teeX it will check that if it's a known TEE,
or it will close the device and try next and fail when there's no more
to try.


> 
> > + * struct tee_shm_alloc_data - Shared memory allocate argument
> > + * @size:	[in/out] Size of shared memory to allocate
> > + * @flags:	[in/out] Flags to/from allocation.
> > + * @fd:		[out] dma_buf file descriptor of the shared memory
> > + *
> > + * The flags field should currently be zero as input. Updated by the call
> > + * with actual flags as defined by TEE_IOCTL_SHM_* above.
> > + * This structure is used as argument for TEE_IOC_SHM_ALLOC below.
> > + */
> > +struct tee_ioctl_shm_alloc_data {
> > +	uint64_t size;
> > +	uint32_t flags;
> > +	int32_t fd;
> > +};
> > +/**
> > + * TEE_IOC_SHM_ALLOC - allocate shared memory
> > + *
> > + * Allocates shared memory between the user space process and secure OS.
> > + * The returned file descriptor is used to map the shared memory into user
> > + * space. The shared memory is freed when the descriptor is closed and the
> > + * memory is unmapped.
> > + */
> > +#define TEE_IOC_SHM_ALLOC	_TEE_IOWR(2, struct tee_ioctl_shm_alloc_data)
> 
> See my questions above. Ideally we should be able to just use mmap here.
We're are using mmap, but on the file descriptor returned here. If we
had only one file descriptor it would be hard for the subsystem or the
driver to tell if user space is allowed to map this particular memory
range.

> 
> > +/**
> > + * struct tee_mem_buf - share user space memory with Secure OS
> > + * @ptr:	A __user pointer to memory to share
> > + * @size:	Size of the memory to share
> > + * Used in 'struct tee_mem_share_data' below.
> > + */
> > +struct tee_ioctl_mem_buf {
> > +	uint64_t ptr;
> > +	uint64_t size;
> > +};
> 
> Why do you want both directions, exporting a kernel buffer to user
> space, as well as using a user space buffer to give to the firmware?
> 
> If you can get by with just one of them, drop the other one.
We need to be able to export kernel buffers to user space as some secure
worlds has restrictions on which memory ranges can be used for shared
memory. The other way around (exporting user memory to secure world) is
an optimization (which we haven't implemented) to be able to avoid
double buffering when implementing TEEC_RegisterSharedMemory() in Global
Platforms TEE Client API in user space.

> 
> > +/**
> > + * struct tee_mem_dma_buf - share foreign dma_buf memory
> > + * @fd:		dma_buf file descriptor
> > + * @pad:	padding, set to zero by caller
> > + * Used in 'struct tee_mem_share_data' below.
> > + */
> > +struct tee_ioctl_mem_dma_buf {
> > +	int32_t fd;
> > +	uint32_t pad;
> > +};
> 
> What other driver do you have in mind that would provide the
> file descriptor?
This is primary to support secure video path. The file descriptor would
come from some driver handling hardware for decoding or rendering from
one secure buffer to another.

I'll drop this until we have code that need it.

> 
> > +/**
> > + * struct tee_mem_share_data - share memory with Secure OS
> > + * @buf:	[in] share user space memory
> > + * @dma_buf:	[in] share foreign dma_buf memory
> > + * @flags:	[in/out] Flags to/from sharing.
> > + * @pad:	[in/out] Padding, set to zero by caller
> > + *
> > + * The bits in @flags are defined by TEE_IOCTL_SHM_* above, undefined bits
> > + * should be seto to zero as input. If TEE_IOCTL_SHM_DMA_BUF is set in the
> > + * flags field use the dma_buf field, else the buf field in the union.
> > + *
> > + * Used as argument for TEE_IOC_MEM_SHARE and TEE_IOC_MEM_UNSHARE below.
> > + */
> > +struct tee_ioctl_mem_share_data {
> > +	union {
> > +		struct tee_ioctl_mem_buf buf;
> > +		struct tee_ioctl_mem_dma_buf dma_buf;
> > +	};
> > +	uint32_t flags;
> > +	uint32_t pad;
> > +};
> 
> Better make that two distinct commands to avoid the union and the flags.
OK, makes sense. This is currently not used by OP-TEE. As was suggested
elsewhere I'll drop the parts of the API which aren't currently needed
by OP-TEE.

Regards,
Jens
