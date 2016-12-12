From: v.narang@samsung.com (=?UTF-8?B?VmFuZWV0IE5hcmFuZw==?=)
Date: Mon, 12 Dec 2016 10:08:36 +0000
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzFdIGFybS9tb2R1bGU6IG1heGltdW0g?=
 =?UTF-8?B?dXRpbGl6YXRpb24gb2YgbW9kdWxlIGFyZWEu?=
References: <1481012975-44478-1-git-send-email-maninder1.s@samsung.com>
 <CGME20161206091317epcas3p3702de092ecce4ac079b27180dd48c744@epcas3p3.samsung.com>
Message-ID: <20161212100836epcms5p2679e36dab1af137e07ecb33970362463@epcms5p2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

>> +#ifndef CONFIG_THUMB2_KERNEL
>> +#define MODULES_START  ALIGN((unsigned long)_etext - SZ_32M, PAGE_SIZE)
>
>On a multi_v7_defconfig kernel, the text size is >8 MB, which means
>you are only adding ~7 MB to the module area, while consuming 16 MB of
>additional address space.

I am not sure if 16MB virtual address space will make any difference on embedded 
systems where physical memory is already less than virtual address space.
if required address space wastage can be reduced by keeping TASK_SIZE as 
PAGE_OFFSET - 24MB like below

#define MODULES_VADDR          (PAGE_OFFSET - SZ_24M)
#define TASK_SIZE              (UL(CONFIG_PAGE_OFFSET) - UL(SZ_24M))


> Given that 20 MB modules are very uncommon,

Size of all modules can be 20MB, this seems to be normal scenario.

>I think it is better to enable CONFIG_ARM_MODULE_PLTS instead. That

CONFIG_ARM_MODULE_PLTS has function call overhead as it refers PLT table
while calling kernel functions. Also size of modules will also gets increased a bit.
So using short calls from modules to kernel will be faster. 
These changes trying to utilize best available space for kernel modules for
making short calls. 
So CONFIG_ARM_MODULE_PLTS is not required when modules
can be accomdated within 20MB.

>way, there is no need to update these defaults for everyone.
>

>> +#else
>> +#define MODULES_START MODULES_VADDR

Thanks & Regards,
Vaneet Narang
