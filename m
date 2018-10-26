From: miles.chen@mediatek.com (Miles Chen)
Date: Fri, 26 Oct 2018 16:50:34 +0800
Subject: [PATCH] mm/page_owner: use vmalloc instead of kmalloc
In-Reply-To: <20181025192701.GK25444@bombadil.infradead.org>
References: <1540492481-4144-1-git-send-email-miles.chen@mediatek.com>
 <20181025192701.GK25444@bombadil.infradead.org>
Message-ID: <1540543834.21297.14.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-10-25 at 12:27 -0700, Matthew Wilcox wrote:
> On Fri, Oct 26, 2018 at 02:34:41AM +0800, miles.chen at mediatek.com wrote:
> > The kbuf used by page owner is allocated by kmalloc(),
> > which means it can use only normal memory and there might
> > be a "out of memory" issue when we're out of normal memory.
> > 
> > Use vmalloc() so we can also allocate kbuf from highmem
> > on 32bit kernel.
> 
> ... hang on, there's a bigger problem here.
> 
> static const struct file_operations proc_page_owner_operations = {
>         .read           = read_page_owner,
> };
> 
> read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
> {
> ...
>                 return print_page_owner(buf, count, pfn, page,
>                                 page_owner, handle);
> }
> 
> static ssize_t
> print_page_owner(char __user *buf, size_t count, unsigned long pfn,
>                 struct page *page, struct page_owner *page_owner,
>                 depot_stack_handle_t handle)
> {mount -t debugfs none /sys/kernel/debug/
> ...
>       kbuf = kmalloc(count, GFP_KERNEL);
> 
> So I can force the kernel to make an arbitrary size allocation, triggering
> OOMs and forcing swapping if I can get a file handle to this file.
> The only saving grace is that (a) this is a debugfs file and (b) it's
> root-only (mode 0400).  Nevertheless, I feel some clamping is called
> for here.  Do we really need to output more than 4kB worth of text here?
> 
I did a test on my device, the allocation count is 4096 and around 6xx
bytes are used each print_page_owner() is called. It looks like that
clamping the reading count to PAGE_SIZE is ok.

The following output from print_page_owner() is 660 bytes long, I think
PAGE_SIZE should be enough to print the information we need.

Page allocated via order 0, mask 0x6200ca(GFP_HIGHUSER_MOVABLE)
PFN 262199 type Movable Block 512 type Movable Flags 0x4003c(referenced|
uptodate|dirty|lru|swapbacked)
 get_page_from_freelist+0x1580/0x1650
 __alloc_pages_nodemask+0xcc/0xfa4
 shmem_alloc_page+0xa4/0xc8
 shmem_alloc_and_acct_page+0x138/0x2b8
 shmem_getpage_gfp.isra.54+0x164/0xfc8
 shmem_write_begin+0x84/0xcc
 generic_perform_write+0xe8/0x210
 __generic_file_write_iter+0x1d4/0x230
 generic_file_write_iter+0x184/0x2e8
 new_sync_write+0x144/0x1c4
 vfs_write+0x194/0x278
 ksys_write+0x64/0xd4
 xwrite+0x34/0x84
 do_copy+0xf4/0x168
 flush_buffer+0x68/0xec
 __gunzip+0x370/0x448
