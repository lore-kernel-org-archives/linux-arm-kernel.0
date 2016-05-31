From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 31 May 2016 14:46:17 +0100
Subject: [PATCH] drivers: char: mem: Check {read,write}_kmem() addresses
In-Reply-To: <5e293c103f0a86f512d71f17091a55e9746e711f.1464698496.git.robin.murphy@arm.com>
References: <5e293c103f0a86f512d71f17091a55e9746e711f.1464698496.git.robin.murphy@arm.com>
Message-ID: <20160531134617.GA11321@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2016 at 01:52:45PM +0100, Robin Murphy wrote:
> Arriving at read_kmem() with an offset representing a bogus kernel
> address (e.g. 0 from a simple "cat /dev/kmem") leads to copy_to_user
> faulting on the kernel-space read.
> 
> x86_64 happens to get away with this since the optimised implementation
> uses "rep movs*", thus the user write (which is allowed to fault) and
> the kernel read are the same instruction, the kernel-side fault falls
> into the userspace fixup handler and a chain of events transpires
> leading to returning the expected -EFAULT. On other architectures,
> though, the read is not covered by the fixup entry for the write, and we
> get a straightforward "Unable to hande kernel paging request..." dump.
> 
> The more typical use-case of mmap_kmem() already validates the address
> with pfn_valid() as one might expect, so let's make that consistent
> across {read,write}_kem() too.
> 
> Reported-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> I'm not sure if this warrants going to stable or not, as it's really
> just making an existing failure case more graceful and less confusing.
> 
>  drivers/char/mem.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> index 71025c2f6bbb..64c766023b15 100644
> --- a/drivers/char/mem.c
> +++ b/drivers/char/mem.c
> @@ -384,6 +384,9 @@ static ssize_t read_kmem(struct file *file, char __user *buf,
>  	char *kbuf; /* k-addr because vread() takes vmlist_lock rwlock */
>  	int err = 0;
>  
> +	if (!pfn_valid(PFN_DOWN(p)))
> +		return -EFAULT;
> +
>  	read = 0;
>  	if (p < (unsigned long) high_memory) {
>  		low_count = count;
> @@ -512,6 +515,9 @@ static ssize_t write_kmem(struct file *file, const char __user *buf,
>  	char *kbuf; /* k-addr because vwrite() takes vmlist_lock rwlock */
>  	int err = 0;
>  
> +	if (!pfn_valid(PFN_DOWN(p)))
> +		return -EFAULT;

Since the /dev/kmem interface is about kernel virtual address rather
than physical (like /dev/mem), the pfn may not always be mapped. I think
a better check would be to use kern_addr_valid(kaddr) just before
copy_(to|from)_user (a similar approach is taken by read_kcore()). The
downside is that it breaks a couple of configurations where
kern_addr_valid() is 0:

- x86_32 with !CONFIG_FLATMEM
- alpha with CONFIG_DISCONTIGMEM

-- 
Catalin
