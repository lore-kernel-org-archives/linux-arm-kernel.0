From: m.nazarewicz@samsung.com (=?utf-8?B?TWljaGHFgiBOYXphcmV3aWN6?=)
Date: Wed, 14 Oct 2009 11:37:39 +0200
Subject: Global Video Buffers Pool - PMM and UPBuffer reference drivers
	[RFC]
In-Reply-To: <000401ca4ca0$d668ef40$833acdc0$%szyprowski@samsung.com>
References: <000401ca4ca0$d668ef40$833acdc0$%szyprowski@samsung.com>
Message-ID: <op.u1sac1ji7p4s8u@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

[Code modified a bit to shorten it; removed some error reporting;
  irrelevant parts of the code removed.]
>> diff --git a/drivers/s3cmm/pmm-init.c b/drivers/s3cmm/pmm-init.c
>> new file mode 100644
>> index 0000000..f1e31a5
>> --- /dev/null
>> +++ b/drivers/s3cmm/pmm-init.c
>> @@ -0,0 +1,75 @@
>> +static unsigned long pmm_memory_start, pmm_memory_size;
>> +
>> +static int __init pmm_early_param(char *param)
>> +{
>> +       unsigned long long size = memparse(param, 0);
>> +       void *ptr;
>> +
>> +       if (size <= 0 || size > (1ull << 30))
>> +               return -EINVAL;
>> +
>> +       pmm_memory_size = PAGE_ALIGN((unsigned long)size);
>> +       ptr = alloc_bootmem_pages_nopanic(pmm_memory_size);

From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> How does this work?  When early params are parsed, the memory subsystem
> hasn't been initialized - not even bootmem.  So this will always fail.

 From my investigation into Linux kernel source code it seems as if
bootmem were initialised prior to parsing early params.  Lets look at
start_kernel():

#v+
init/main.c:
584        setup_arch(&command_line);
[...]
595        parse_early_param();
[...]
607        mm_init();
#v-

On ARM with MMU setup_arch() calls paging_init()
(arch/arm/kernel/setup.c:730) which calls bootmem_init()
(arch/arm/mm/mmu.c:989) which is the function that initialises
bootmem.

Early params are obviously handled by parse_early_param() function
which is invoked after the call to setup_arch().

What is also worth mentioning is that mm_init() initialises standard
allocators so after this function is called bootmem no longer works.


I've also tried to use various *_initcall()s (the ones defined in
include/linux/init.h) but neither of them seemed to work.


>> +       if (ptr)
>> +               pmm_memory_start = virt_to_phys(ptr);
>> +
>> +       return 0;
>> +}
>> +early_param("pmm", pmm_early_param);
>> +
>> +
>> +
>> +/** Called from pmm_module_init() when module is initialised. */
>> +void pmm_module_platform_init(pmm_add_region_func add_region)
>> +{
>> +       if (pmm_memory_start && pmm_memory_size)
>> +               add_region(pmm_memory_start, pmm_memory_size,
>> +                          PMM_MEM_GENERAL, 0);
>> +}
>> +EXPORT_SYMBOL(pmm_module_platform_init);


-- 
Best regards,                                           _     _
   .o. | Liege of Serenely Enlightened Majesty of       o' \,=./ `o
   ..o | Computer Science,  Micha? "mina86" Nazarewicz     (o o)
   ooo +---<mina86@mina86.com>---<mina86@jabber.org>---ooO--(_)--Ooo--
