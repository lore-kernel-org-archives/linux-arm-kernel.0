From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon, 12 Nov 2018 13:16:50 +0000
Subject: [RFC] arm64: Kconfig: Choose ARM64_64K_PAGES as default
In-Reply-To: <B7BFB069F158834E98A0C5702FB1F2460391A5C9@dggemm511-mbx.china.huawei.com>
References: <B7BFB069F158834E98A0C5702FB1F2460391A5C9@dggemm511-mbx.china.huawei.com>
Message-ID: <60e93387-ecfe-f3c5-5e2a-6fde45d49c06@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 12/11/2018 11:24, Zhangkehong wrote:
> Hi
>> On 05/11/18 12:33, Kehong Zhang wrote:
>>> For arm64 performance considerations, change default page size to 64K.
>>
>> defconfig never stands for performance. If that was the case, we must remove other options that could potentially slow down the performance.
>>
>> defconfig could be interpreted as more of a "standard" config which gives the best effort to make sure you get a usable system overall.
> 
> Ok, I got it.
> 
>> With this change, a rootfs with AArch32 applications without 64K aligned segments would fail, and that breaks the assumption about defconfig.
>>
>> So, NAK from my side.
> 
> I understand the mismatch AArch32 applications with AArch64 systems, but if AArch32 applications can run on AArch64 systems, how can 64K
> page affect it? Can you give me some examples?

The AArch32 applications must have 64K aligned sections in their
binaries, which was not the case by default ( I guess it was 16K or
32K). So, with that, we cannot reliably map different sections with
appropriate permissions as we will be mapping something that is not
within the "valid" sections (due to the alignment mismatch).

So if you have a toolchain which aligns the AArch32 binaries to 64K
sections, then you can definitely run those applications on a 64K
page sized kernel. This is why the 32bit EL0 support is an "EXPERT"
option unless you are using 4K page size (which works everywhere).
See arch/arm64/Kconfig : config COMPAT help section.

> 
>>
>> Btw, please could you share any performance numbers from the comparison with 4K kernel ?
>>
> Most of the examples are high TLB miss rate scenarios. And you may need to change this config in some MySQL scenarios.

Ok. But that doesn't justify breaking some of the existing users
with changes to the defconfig.

Cheers
Suzuki


> 
> Thanks
> Kehong Zhang
>> Suzuki
>>
> 
>>>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>;
>>> Cc: Will Deacon <will.deacon@arm.com>;
>>> Signed-off-by: Kehong Zhang <zhangkehong@hisilicon.com>
>>> ---
>>>    arch/arm64/Kconfig | 10 +++++-----
>>>    1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig index
>>> 787d785..56f651f 100644
>>> --- a/arch/arm64/Kconfig
>>> +++ b/arch/arm64/Kconfig
>>> @@ -620,7 +620,7 @@ endmenu
>>>    
>>>    choice
>>>    	prompt "Page size"
>>> -	default ARM64_4K_PAGES
>>> +	default ARM64_64K_PAGES
>>>    	help
>>>    	  Page size (translation granule) configuration.
>>>    
>>> @@ -639,10 +639,10 @@ config ARM64_16K_PAGES
>>>    config ARM64_64K_PAGES
>>>    	bool "64KB"
>>>    	help
>>> -	  This feature enables 64KB pages support (4KB by default)
>>> -	  allowing only two levels of page tables and faster TLB
>>> -	  look-up. AArch32 emulation requires applications compiled
>>> -	  with 64K aligned segments.
>>> +	  This feature enables 64KB pages support allowing only two
>>> +	  levels of page tables and faster TLB look-up. AArch32
>>> +	  emulation requires applications compiled with 64K aligned
>>> +	  segments.
>>>    
>>>    endchoice
>>>    
>>>
