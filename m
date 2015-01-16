From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 16 Jan 2015 11:30:04 +0000
Subject: Issue on reserving memory with no-map flag  in  DT
Message-ID: <54B8F63C.1060300@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

I am hitting boot failures when I did try to reserve memory with no-map 
flag using DT. Basically kernel just hangs with no indication of whats 
going on. Added some debug to find out the location, it was some where 
while dma mapping at kmap_atomic() in __dma_clear_buffer().
reserving.

The issue is very much identical to 
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/294773.html 
but the memory reserve in my case is at start of the memory. I tried the 
same fixes on this thread but it did not help.

Platform: IFC6410 with APQ8064 which is a v7 platform with 2GB of memory 
starting at 0x80000000 and kernel is always loaded at 0x80200000
And am using multi_v7_defconfig.

Meminfo without memory reserve:
80000000-88dfffff : System RAM
   80208000-80e5d307 : Kernel code
   80f64000-810be397 : Kernel data
8a000000-8d9fffff : System RAM
8ec00000-8effffff : System RAM
8f700000-8fdfffff : System RAM
90000000-af7fffff : System RAM

DT entry:
        reserved-memory {
                #address-cells = <1>;
                #size-cells = <1>;
                ranges;
                smem at 80000000 {
                        reg = <0x80000000 0x200000>;
                        no-map;
                };
        };

If I remove the no-map flag, then I can boot the board. But I don?t want 
kernel to map this memory at all, as this a IPC memory.

I just wanted to understand whats going on here, Am guessing that kernel 
would never touch that 2MB memory.

Does arm-kernel has limitation on unmapping/memblock_remove() such 
memory locations?
Or
Is this a known issue?

Any pointers to debug this issue?

Before the kernel hangs it reports 2 errors like:

BUG: Bad page state in process swapper  pfn:fffa8
page:ef7fb500 count:0 mapcount:0 mapping:  (null) index:0x0
flags: 0x96640253(locked|error|dirty|active|arch_1|reclaim|mlocked)
page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
bad because of flags:
flags: 0x200041(locked|active|mlocked)
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 3.19.0-rc3-00007-g412f9ba-dirty #816
Hardware name: Qualcomm (Flattened Device Tree)
[<c0218280>] (unwind_backtrace) from [<c0212be8>] (show_stack+0x20/0x24)
[<c0212be8>] (show_stack) from [<c0af7124>] (dump_stack+0x80/0x9c)
[<c0af7124>] (dump_stack) from [<c0301570>] (bad_page+0xc8/0x128)
[<c0301570>] (bad_page) from [<c03018a8>] (free_pages_prepare+0x168/0x1e0)
[<c03018a8>] (free_pages_prepare) from [<c030369c>] 
(free_hot_cold_page+0x3c/0x174)
[<c030369c>] (free_hot_cold_page) from [<c0303828>] (__free_pages+0x54/0x58)
[<c0303828>] (__free_pages) from [<c030395c>] (free_highmem_page+0x38/0x88)
[<c030395c>] (free_highmem_page) from [<c0f62d5c>] (mem_init+0x240/0x430)
[<c0f62d5c>] (mem_init) from [<c0f5db3c>] (start_kernel+0x1e4/0x3c8)
[<c0f5db3c>] (start_kernel) from [<80208074>] (0x80208074)
Disabling lock debugging due to kernel taint


Full kernel log with memblock debug at http://paste.ubuntu.com/9761000/

Thanks,
srini
