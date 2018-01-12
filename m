From: james.morse@arm.com (James Morse)
Date: Fri, 12 Jan 2018 17:58:54 +0000
Subject: [PATCH][v2] arm64: Allocate elfcorehdr & crashkernel mem before
 any reservation
In-Reply-To: <DB5PR0401MB1733C9CB0DCDF94FCF3E4E1286130@DB5PR0401MB1733.eurprd04.prod.outlook.com>
References: <1515080048-9154-1-git-send-email-poonam.aggrwal@nxp.com>
 <5A4F5C45.3090006@arm.com>
 <DB5PR0401MB1733C9CB0DCDF94FCF3E4E1286130@DB5PR0401MB1733.eurprd04.prod.outlook.com>
Message-ID: <5A58F75E.8030106@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Poonam,

On 08/01/18 04:31, Poonam Aggrwal wrote:
> James Morse wrote:
>> On 04/01/18 15:34, Poonam Aggrwal wrote:
>>> Address for both crashkernel memory and elfcorehdr can be assigned
>>> statically. For crashkernel memory it is via crashkernel=SIZE at ADDRESS
>>> and elfcorehdr_addr via by kexec-utils in dump kernel device tree.
>>
>> There are some crashkernel=SIZE at ADDRESS values that the user can supply that
>> we must reject. The obvious one is if it overlaps with the kernel text. (this patch
>> won't spot this). We need to read the hardware's reserved regions from the DT
>> before we allocate the crashkernel region, for example if the bootloader
>> reserved a chunk of memory for a frame-buffer, I shouldn't be able to use that
>> as crashkernel memory.
>>
>> (you shouldn't need to specify an address, doing so prevents the kernel from
>> picking memory it can use)
>>
>>
>>> So memory should be reserved for both the above areas before any other
>>> memory reservations are done. Otherwise overlaps may happen and memory
>>> allocations will fail leading to failure in booting the dump capture
>>> kernel.

>>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c index
>>> 00e7b90..24ce15d 100644
>>> --- a/arch/arm64/mm/init.c
>>> +++ b/arch/arm64/mm/init.c
>>> @@ -453,6 +453,14 @@ void __init arm64_memblock_init(void)

>>> +	reserve_elfcorehdr();
>>
>> (Moving reserve_elfcorehdr() makes sense, but..)
>>
>>
>>> +	reserve_crashkernel();
>>
>> reserve_crashkernel() does the allocation for the crashkernels reserved memory.
>> I expect this to always fail in the kdump kernel because there isn't enough
>> memory. (fdt_enforce_memory_region() at the top of this function calls
>> memblock_cap_memory_range()).
>>
>> Moving this allocation above the early_init_fdt_scan_reserved_mem() below
>> means we may allocate memory for the crashdump that is in use by
>> firmware/hardware and described as reserved in the DT.

> Yeah, this is a good point. So ideally the address of the crash kernel should
> be diligently provided by the user based on the system.

Even better: the region to store the crash kernel in should be chosen by the kernel.
When using kdump I boot with 'crashkernel=1G', the kernel chooses where to place
the reserved region. Even if I specified a reasonable physical address, the
efistub may relocate the kernel over the top during boot as part of its KASLR work.

(Why does anyone ever need to specify an offset here?)


Thanks,

James
