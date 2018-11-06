From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 6 Nov 2018 12:39:22 +0000
Subject: [RFC] arm64: Kconfig: Choose ARM64_64K_PAGES as default
In-Reply-To: <db60f42f-c83d-7a9b-b6ba-450fb7970563@arm.com>
References: <1541421211-17561-1-git-send-email-zhangkehong@hisilicon.com>
 <db60f42f-c83d-7a9b-b6ba-450fb7970563@arm.com>
Message-ID: <82025f91-b2b3-f831-4a28-45914f339d5c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/11/2018 14:08, Suzuki K Poulose wrote:
> Hi,
> 
> On 05/11/18 12:33, Kehong Zhang wrote:
>> For arm64 performance considerations, change default page size to 64K.
> 
> defconfig never stands for performance. If that was the case, we must
> remove other options that could potentially slow down the performance.
> 
> defconfig could be interpreted as more of a "standard" config which
> gives the best effort to make sure you get a usable system overall.
> With this change, a rootfs with AArch32 applications without 64K aligned
> segments would fail, and that breaks the assumption about defconfig.

Plus I think it's still the case that various drivers and filesystems 
just don't work properly with PAGE_SIZE != 4K, and reducing defconfig's 
development/testing coverage is exactly what we don't want.

If you're building a distro or running production workloads with an 
unmodified defconfig, you're probably doing it wrong.

Robin.

> So, NAK from my side.
> 
> Btw, please could you share any performance numbers from the comparison
> with 4K kernel ?
> 
> Suzuki
> 
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>;
>> Cc: Will Deacon <will.deacon@arm.com>;
>> Signed-off-by: Kehong Zhang <zhangkehong@hisilicon.com>
>> ---
>> ? arch/arm64/Kconfig | 10 +++++-----
>> ? 1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 787d785..56f651f 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -620,7 +620,7 @@ endmenu
>> ? choice
>> ????? prompt "Page size"
>> -??? default ARM64_4K_PAGES
>> +??? default ARM64_64K_PAGES
>> ????? help
>> ??????? Page size (translation granule) configuration.
>> @@ -639,10 +639,10 @@ config ARM64_16K_PAGES
>> ? config ARM64_64K_PAGES
>> ????? bool "64KB"
>> ????? help
>> -????? This feature enables 64KB pages support (4KB by default)
>> -????? allowing only two levels of page tables and faster TLB
>> -????? look-up. AArch32 emulation requires applications compiled
>> -????? with 64K aligned segments.
>> +????? This feature enables 64KB pages support allowing only two
>> +????? levels of page tables and faster TLB look-up. AArch32
>> +????? emulation requires applications compiled with 64K aligned
>> +????? segments.
>> ? endchoice
>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
