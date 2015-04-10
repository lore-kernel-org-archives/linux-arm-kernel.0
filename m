From: panand@redhat.com (Pratyush Anand)
Date: Fri, 10 Apr 2015 12:05:58 +0530
Subject: [PATCH 1/5] arm64: kdump: reserve memory for crash dump kernel
In-Reply-To: <5527663A.70402@linaro.org>
References: <1427358533-3754-1-git-send-email-takahiro.akashi@linaro.org>
 <1427358533-3754-2-git-send-email-takahiro.akashi@linaro.org>
 <55267A23.2040007@redhat.com> <5527663A.70402@linaro.org>
Message-ID: <55276F4E.3010103@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 10 April 2015 11:27 AM, AKASHI Takahiro wrote:
> Hi Pratyush,
>
> On 04/09/2015 10:09 PM, Pratyush Anand wrote:
>> Hi Takahiro,
>>
>> On Thursday 26 March 2015 01:58 PM, AKASHI Takahiro wrote:
>>> Crash dump kernel will access memory regions in system kernel via
>>> copy_oldmem_page(), which reads a page with ioremap'ing it assuming that
>>> such pages are not part of main memory of crash dump kernel.
>>> This is true under non-UEFI environment because kexec-tools modifies
>>> a device tree adding "usablemem" attributes to memory sections.
>>> Under UEFI, however, this is not true because UEFI remove memory
>>> sections
>>> in a device tree and export all the memory regions, even though they
>>> belong
>>> to system kernel.
>>>
>>> So we should add "mem=X[MG]" boot parameter to limit the meory size and
>>> avoid hitting the following assertion in ioremap():
>>>     if (WARN_ON(pfn_valid(__phys_to_pfn(phys_addr))))
>>>         return NULL;
>>
>> Well I am using your updated kexec-tool which has support of automatic
>> addition of "mem=" parameter. I found that this
>> warning is still appearing and therefore another error about "Kdump:
>> vmcore not initialized".
>>
>> Memory address for which ioremap failed was almost at the top of
>> crash_reserved_mem. So I modified kexec-tool [1] to
>> accept user specific mem= parameter with a value lesser than physical
>> location which was being remapped, however still
>> the warning was there.
>>
>> Further I noticed that there is no reserved memblock with nonzero
>> memblock_region->size when early_mem ->
>> memblock_enforce_memory_limit is called. Therefore this mem= param is
>> not limiting memory location in my case.
>
> On crash dump kernel? Sounds strange.
> Can you send me the followings for both 1st kernel and crash dump kernel?
> (add memblock_debug to cmd line for verbose messages)
>
> - boot log (dmesg)
> - cat /proc/iomem
>
> sending them in a private mail is fine.

OK.

>
>> I was just wondering, why do not we use ioremap_cache instead of
>> ioremap in copy_oldmem_page?
>
> Good point.
> My next version of kdump patch uses ioremap_cache() for another reason.

Thanks that you have already changed it. I am using ioremap_cache and I 
am able to get /proc/vmcore :)
ioremap allocates VAs with memory attribute DEVICE which might not be 
correct for RAM area.ioremap_cache is using memory attribute NORMAL 
which seems more logical for RAM areas.

> # As I'm discussing with Mark about kvm issue, I'm holding off
> submitting it.
>

I  am using one more modification on top of your patches for finding 
crashkernel address automatically. If that seems fine to you then may be 
I can send you that patch and you can add that in your next rev.

Author: Pratyush Anand <panand@redhat.com>
Date:   Tue Apr 7 08:14:55 2015 +0530

     arm64/kdump: Find free area for crash kernel memory

     If crashkernel=X at 0 is passed to the kernel then this patch will find
     free memory area of size X for crash kernel.

     Signed-off-by: Pratyush Anand <panand@redhat.com>

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 94694897beea..90b0b9d138f6 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -368,10 +368,18 @@ static void __init reserve_crashkernel(void)
         if (ret)
                 return;

-       ret = memblock_reserve(crash_base, crash_size);
-       if (ret < 0) {
+       /* 0 means: find the address automatically */
+       if (crash_base <= 0) {
+               crash_base = memblock_alloc(crash_size, 2 << 20);
+
+               if (!crash_base) {
+                       pr_warn("Could not find free memory for 
crashkernel\n");
+                       return;
+               }
+
+       } else if (memblock_reserve(crash_base, crash_size) < 0) {
                 pr_warn("crashkernel reservation failed - memory is in 
use (0x%lx)\n",
-                       (unsigned long)crash_base);
+                               (unsigned long)crash_base);
                 return;
         }

~Pratyush
