From: kirill@shutemov.name (Kirill A. Shutemov)
Date: Tue, 19 Jan 2016 00:55:50 +0200
Subject: [PATCH v4] kernel: add kcov code coverage
In-Reply-To: <1453145117-92868-1-git-send-email-dvyukov@google.com>
References: <1453145117-92868-1-git-send-email-dvyukov@google.com>
Message-ID: <20160118225550.GE14531@node.shutemov.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 18, 2016 at 08:25:16PM +0100, Dmitry Vyukov wrote:
> +enum kcov_mode {
> +	/*
> +	 * Tracing coverage collection mode.
> +	 * Covered PCs are collected in a per-task buffer.
> +	 */
> +	kcov_mode_trace = 1,

We usually use upper case for items in enum.

> +};
> +
> +/*
> + * kcov descriptor (one per opened debugfs file).
> + * State transitions of the descriptor:
> + *  - initial state after open()
> + *  - then there must be a single ioctl(KCOV_INIT_TRACE) call
> + *  - then, mmap() call (several calls are allowed but not useful)
> + *  - then, repeated enable/disable for a task (only one task a time allowed)
> + */
> +struct kcov {
> +	/*
> +	 * Reference counter. We keep one for:
> +	 *  - opened file descriptor
> +	 *  - mmapped region (including copies after fork)

Outdated.

> +	 *  - task with enabled coverage (we can't unwire it from another task)
> +	 */
> +	atomic_t		rc;
> +	/* The lock protects mode, size, area and t. */
> +	spinlock_t		lock;
> +	enum kcov_mode		mode;
> +	unsigned		size;
> +	void			*area;
> +	struct task_struct	*t;
> +};

...l

> +static int kcov_mmap(struct file *filep, struct vm_area_struct *vma)
> +{
> +	int res = 0;
> +	void *area;
> +	struct kcov *kcov = vma->vm_file->private_data;
> +	unsigned long size, off;
> +	struct page *page;
> +
> +	area = vmalloc_user(vma->vm_end - vma->vm_start);
> +	if (!area)
> +		return -ENOMEM;
> +
> +	spin_lock(&kcov->lock);
> +	size = kcov->size * sizeof(u32);
> +	if (kcov->mode == 0 || vma->vm_pgoff != 0 ||
> +	    vma->vm_end - vma->vm_start != size) {
> +		res = -EINVAL;
> +		goto exit;
> +	}
> +	if (!kcov->area) {
> +		kcov->area = area;
> +		vma->vm_flags |= VM_DONTEXPAND;
> +		spin_unlock(&kcov->lock);
> +		for (off = 0; off < size; off += PAGE_SIZE) {
> +			page = vmalloc_to_page(kcov->area + off);
> +			vm_insert_page(vma, vma->vm_start + off, page);

At least WARN_ONCE() for non-zero return code, meaning something is
horribly wrong.

> +		}
> +		return 0;
> +	}
> +exit:
> +	spin_unlock(&kcov->lock);
> +	vfree(area);
> +	return res;
> +}

....

> +static long kcov_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
> +{
> +	struct kcov *kcov = filep->private_data;
> +	struct task_struct *t;
> +	struct kcov_init_trace init;
> +
> +	switch (cmd) {
> +	case KCOV_INIT_TRACE:
> +		if (copy_from_user(&init, (void __user *)arg, sizeof(init)))
> +			return -EFAULT;
> +		/*
> +		 * Size must be at least 2 to hold current position and one PC.
> +		 */
> +		if (init.flags != 0 || init.size < 2 || init.size > INT_MAX)
> +			return -EINVAL;
> +		/*
> +		 * Enable kcov in trace mode and setup buffer size.
> +		 * Must happen before anything else.
> +		 */
> +		spin_lock(&kcov->lock);
> +		if (kcov->mode != 0) {
> +			spin_unlock(&kcov->lock);
> +			return -EBUSY;
> +		}
> +		kcov->mode = kcov_mode_trace;
> +		kcov->size = init.size;
> +		init.version = 1;
> +		init.pc_size = sizeof(u32);
> +		init.pc_base = ((1ull << 32) - 1) << 32;
> +		spin_unlock(&kcov->lock);
> +		if (copy_to_user((void __user *)arg, &init, sizeof(init)))
> +			return -EFAULT;
> +		return 0;
> +	case KCOV_ENABLE:

Looks like you've ignored my comment on arg validation for enable/disable.
Why?

....

> +static int __init kcov_init(void)
> +{
> +	if (!debugfs_create_file("kcov", 0666, NULL, NULL, &kcov_fops)) {

Why 0666? May be 0600?.

> +		pr_err("init failed\n");

Again, you've ignored the comment.

> +		return 1;
> +	}
> +	return 0;
> +}
> +
> +device_initcall(kcov_init);
-- 
 Kirill A. Shutemov
