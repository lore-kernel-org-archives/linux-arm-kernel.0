From: mina86@mina86.com (Michal Nazarewicz)
Date: Wed, 07 Mar 2012 11:59:03 +0100
Subject: [PATCH v3] MM: CMA: add a simple kernel module as the helper to
 test CMA
In-Reply-To: <1331090098-25097-1-git-send-email-Barry.Song@csr.com>
References: <1331090098-25097-1-git-send-email-Barry.Song@csr.com>
Message-ID: <op.wasrgptm3l0zgt@mpn-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks!  Some minor comments, hopefully last ones:

On Wed, 07 Mar 2012 04:14:58 +0100, Barry Song <Barry.Song@csr.com> wrote:
> +static ssize_t
> +cma_test_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
> +{

[...]

> +	_dev_info(cma_dev, "free: CM virt: %p dma: %p size:%uK\n",

This should read: ?size: %zuK?.  ?z? is the proper modifier to use for size_t type.

> +		alloc->virt, (void *)alloc->dma, alloc->size / SZ_1K);
> +	kfree(alloc);
> +
> +	return 0;
> +}

> +static ssize_t
> +cma_test_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
> +{
> +	struct cma_allocation *alloc;
> +	size_t size;
> +	int ret;
> +
> +	ret = kstrtouint_from_user(buf, count, 0, &size);

kstrtouint_from_user() expects pointer to unsigned int, size_t is not always
unsigned int.  It may be unsigned long.  As such, size should be of type
unsigned long and this line should use kstrtoulong_from_user().

[...]

> +	if (alloc->virt) {
> +		_dev_info(cma_dev, "alloc: virt: %p dma: %p size: %uK\n",
> +			alloc->virt, (void *)alloc->dma, size);

Like previously, this should be ?size: %zuK?.

[...]

> +}

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
