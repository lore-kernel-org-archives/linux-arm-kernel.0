From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Thu, 26 Mar 2015 18:19:09 +0300
Subject: [PATCH] arm: fix integer overflow in ELF_ET_DYN_BASE
In-Reply-To: <20150326150558.GK8656@n2100.arm.linux.org.uk>
References: <1426849972-19606-1-git-send-email-a.ryabinin@samsung.com>
 <20150326150558.GK8656@n2100.arm.linux.org.uk>
Message-ID: <5514236D.50808@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/26/2015 06:05 PM, Russell King - ARM Linux wrote:
> On Fri, Mar 20, 2015 at 02:12:52PM +0300, Andrey Ryabinin wrote:
>> Usually ELF_ET_DYN_BASE is 2/3 of TASK_SIZE. With 3G/1G user/kernel
>> split this is not so, because 2*TASK_SIZE overflows 32 bits,
>> so the actual value of ELF_ET_DYN_BASE is:
>> 	(2 * TASK_SIZE / 3) = 0x2a000000
>>
>> When ASLR is disabled PIE binaries will load at ELF_ET_DYN_BASE address.
>> On 32bit platforms AddressSanitzer uses addresses [0x20000000 - 0x40000000]
>> for shadow memory [1]. So ASan doesn't work for PIE binaries when ASLR disabled
>> as it fails to map shadow memory.
>> Also after Kees's 'split ET_DYN ASLR from mmap ASLR' patchset PIE binaries
>> has a high chance of loading somewhere in between [0x2a000000 - 0x40000000]
>> even if ASLR enabled. This makes ASan with PIE absolutely incompatible.
>>
>> Fix overflow by dividing TASK_SIZE prior to multiplying.
>> After this patch ELF_ET_DYN_BASE equals to (for CONFIG_VMSPLIT_3G=y):
>> 	(TASK_SIZE / 3 * 2) = 0x7f555554
>>
>> [1] https://code.google.com/p/address-sanitizer/wiki/AddressSanitizerAlgorithm#Mapping
>>
>> Signed-off-by: Andrey Ryabinin <a.ryabinin@samsung.com>
>> Reported-by: Maria Guseva <m.guseva@samsung.com>
>> Cc: stable at vger.kernel.org
> 
> Who's handling this patch?  I'm guessing it should be me, so if it could
> find its way into my patch system for when I next apply a bunch of patches,
> that'd be good.
> 

It's already there. Patch number - 8320/1.
