From: james.morse@arm.com (James Morse)
Date: Mon, 9 Jul 2018 12:03:13 +0100
Subject: [PATCH v10 03/14] powerpc, kexec_file: factor out memblock-based
 arch_kexec_walk_mem()
In-Reply-To: <20180709054953.GR28220@linaro.org>
References: <20180623022058.10935-1-takahiro.akashi@linaro.org>
 <20180623022058.10935-4-takahiro.akashi@linaro.org>
 <8a59db79-6379-550b-b20e-01036626904e@arm.com>
 <20180709054953.GR28220@linaro.org>
Message-ID: <68e7d558-91bf-a6f4-3e59-b93d5db0d77b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akashi,

On 09/07/18 06:49, AKASHI Takahiro wrote:
> On Tue, Jul 03, 2018 at 05:36:24PM +0100, James Morse wrote:
>> On 23/06/18 03:20, AKASHI Takahiro wrote:
>>> Memblock list is another source for usable system memory layout.
>>> A merged new arch_kexec_walk_mem() will walk through either io resource
>>> list or memblock list depending on CONFIG_ARCH_DISCARD_MEMBLOCK so that
>>> arm64, in addition to powerpc, will be able to utilize this generic
>>> function for kexec_file.
>>
>>> diff --git a/arch/powerpc/kernel/machine_kexec_file_64.c b/arch/powerpc/kernel/machine_kexec_file_64.c
>>> index 0bd23dc789a4..3d4be91786ce 100644
>>> --- a/arch/powerpc/kernel/machine_kexec_file_64.c
>>> +++ b/arch/powerpc/kernel/machine_kexec_file_64.c

>>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>>> index 63c7ce1c0c3e..563acd1c9a61 100644
>>> --- a/kernel/kexec_file.c
>>> +++ b/kernel/kexec_file.c
>>> @@ -16,6 +16,7 @@
>>>  #include <linux/file.h>
>>>  #include <linux/slab.h>
>>>  #include <linux/kexec.h>
>>> +#include <linux/memblock.h>
>>>  #include <linux/mutex.h>
>>>  #include <linux/list.h>
>>>  #include <linux/fs.h>
>>> @@ -501,6 +502,53 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
>>>  	return locate_mem_hole_bottom_up(start, end, kbuf);
>>>  }
>>>  
>>> +#if defined(CONFIG_HAVE_MEMBLOCK) && !defined(CONFIG_ARCH_DISCARD_MEMBLOCK)
>>
>> The only caller is also guarded by these same ifdefs. Can't we remove this and
>> rely on the compilers dead-code elimination to remove this function when its not
>> needed?
> 
> I don't think we can remove this #ifdef.
> "for_each_free_mem_range[_reverse]()" is defined under CONFIG_HAVE_MEMBLOCK
> in memblock.h. If some architecture wants to support KEXEC_FILE but
> doesn't have HAVE_MEMBLOCK, compiling kexec_file.c will fail.

Ah, I'd missed this, turns out memblock isn't ubiquitous!


Thanks,

James
