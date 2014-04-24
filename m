From: julien.grall@linaro.org (Julien Grall)
Date: Thu, 24 Apr 2014 13:49:09 +0100
Subject: [PATCH] arm/xen: Remove definiition of virt_to_pfn in
 asm/xen/page.h
In-Reply-To: <535901F0.3010908@citrix.com>
References: <1397836474-10478-1-git-send-email-julien.grall@linaro.org>
 <535901F0.3010908@citrix.com>
Message-ID: <53590845.1090405@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On 04/24/2014 01:22 PM, David Vrabel wrote:
> On 18/04/14 16:54, Julien Grall wrote:
>> virt_to_pfn has been defined in asm/memory.h by the commit e26a9e0 "ARM: Better
>> virt_to_page() handling"
>>
>> This will result of a compilation warning when CONFIG_XEN is enabled.
>>
>> arch/arm/include/asm/xen/page.h:80:0: warning: "virt_to_pfn" redefined [enabled by default]
>>  #define virt_to_pfn(v)          (PFN_DOWN(__pa(v)))
>>  ^
>> In file included from arch/arm/include/asm/page.h:163:0,
>>                  from arch/arm/include/asm/xen/page.h:4,
>>                  from include/xen/page.h:4,
>>                  from arch/arm/xen/grant-table.c:33:
>>
>> The definition in memory.h is nearly the same (it directly expand PFN_DOWN),
>> so we can safely drop virt_to_pfn in xen include.
> 
> 
> This breaks the arm build for me.
> 
> /local/davidvr/work/k.org/tip/drivers/block/xen-blkfront.c: In function
> ?setup_blkring?:
> /local/davidvr/work/k.org/tip/drivers/block/xen-blkfront.c:1236:2:
> error: implicit declaration of function ?virt_to_pfn?
> [-Werror=implicit-function-declaration]
>   err = xenbus_grant_ring(dev, virt_to_mfn(info->ring.sring));
>   ^

I don't have any issue to build the following branch with this patch on:
	- v3.15-rc2
	- xentip master
	- xentip for-linus-3.16

Regards,

-- 
Julien Grall
