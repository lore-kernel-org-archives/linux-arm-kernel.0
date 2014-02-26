From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed, 26 Feb 2014 13:40:48 -0800
Subject: arm64 cache maintenance on read only address loops forever
In-Reply-To: <20140226135521.GF8961@mudshark.cambridge.arm.com>
References: <530D74C2.4000402@codeaurora.org>
 <20140226135521.GF8961@mudshark.cambridge.arm.com>
Message-ID: <530E5F60.4050701@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/26/2014 5:55 AM, Will Deacon wrote:
> On Wed, Feb 26, 2014 at 04:59:46AM +0000, Laura Abbott wrote:
>> Hi,
>
> Hi Laura,
>
>> On arm64, set_pte_at currently write protects user ptes that are not
>> dirty. The expected behavior is that the fault handler will fix this up
>> on a write to the address. do_page_fault will not mark the fault as a
>> write though if ESR has the CM (cache maintenance) bit set. This has the
>> unfortunate side effect that if cache maintenance is performed on a user
>> address that has not yet been marked as dirty, handle_mm_fault may
>> return without actually adjusting the pte or returning an error. This
>> means that the fault will be infinitely retried.
>>
>> Calling cache maintenance on an address that hasn't actually been
>> written to isn't all that useful but looping forever seems like a poor
>> result. It seems like the check in do_page_fault is too restrictive and
>> we need to be able to fault in pages via cache maintenance.
>
> My understanding is that the EL0 cache maintenance instructions only require
> read permission (note that DC ZVA is treated like a store and doesn't set
> ESR.CM), so I'm failing to appreciate the problem here.
>
> Do you have a small testcase I can play with?
>


You probably won't like the test case because it's breaking assumptions 
pretty badly. This uses 96f083d416c0d01687ed5b37074831f461838455 from
Catalin's devel branch to call __dma_inv_range on an mmaped user space
address. I see three possible outcomes:

1) The test while questionable may have some merit and we will be able 
to flush user space addresses using this API without causing a problem.

2) The test is bad. Instead of looping forever we will instead die with 
a fault.

3) The test is really really bad. Looping forever is your punishment.

Thanks,
Laura


Kernel Module
---

#include <linux/kernel.h>
#include <linux/debugfs.h>
#include <linux/fs.h>
#include <asm/cacheflush.h>
#include <linux/miscdevice.h>
#include <linux/slab.h>

#define PAGE_NUM	256

struct these_pages {
	struct page *pages[PAGE_NUM];
	unsigned long addr;
};

static int cache_debug_open(struct inode *inode, struct file *file)
{
         int ret = 0;
         struct these_pages *data;
	int i;

	data = kmalloc(sizeof(*data), GFP_KERNEL);

	if (!data) {
		return -ENOMEM;
	}

	for (i = 0; i < PAGE_NUM; i++) {
		data->pages[i] = alloc_pages(GFP_KERNEL, 0);
		if (!data->pages[i]) {
			return -ENOMEM;
		}
	}

         file->private_data = data;

         return ret;
}


static int cache_debug_mmap_internal(struct file *file, struct 
vm_area_struct *vma)
{
         struct these_pages *data;
	unsigned long addr = vma->vm_start;
	int i;
	int ret;

         data = file->private_data;
	vma->vm_flags |= VM_IO | VM_DONTEXPAND;

	for (i = 0; i < PAGE_NUM; i++, addr += PAGE_SIZE) {
		ret = vm_insert_page(vma, addr, data->pages[i]);
		if (ret) {
			pr_err(">>> fail %lx\n", addr);
		}
	}
	data->addr = vma->vm_start;

	return 0;
}

static long cache_debug_ioctl(struct file *filp, unsigned int cmd, 
unsigned long arg)
{
	struct these_pages *data = filp->private_data;

	pr_err(">>> start %lx\n", data->addr);
	__dma_inv_range((void *)data->addr, (void *)data->addr + 
PAGE_NUM*PAGE_SIZE);
	pr_err(">>> end");

	return 0;
}

static const struct file_operations cache_debug_fops = {
                 .owner = THIS_MODULE,
                 .open = cache_debug_open,
		.mmap = cache_debug_mmap_internal,
		.unlocked_ioctl = cache_debug_ioctl,
};

static struct miscdevice test_misc = {
	.minor = MISC_DYNAMIC_MINOR,
	.name = "test_dev",
	.fops = &cache_debug_fops,
};

static int cache_debug_init(void)
{
	int ret;

	ret = misc_register(&test_misc);
	if (ret < 0) {
		return -EINVAL;
	}

         return 0;
}
module_init(cache_debug_init);

----
Userspace test
----

void test_test(void)
{
         int fd;
         void *base;

         fd = open("/dev/test_dev", O_RDWR);

         if (fd < 0) {
                 printf("nope\n");
                 exit(1);
         }

         base = mmap(0, 1024*1024, PROT_READ|PROT_WRITE,
                     MAP_SHARED, fd, 0);


         ioctl(fd, 2345, 234566);

         return;
}

int main()
{
         printf("start\n");
         test_test();
         printf("done\n");

         return 0;
}

> Will
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
