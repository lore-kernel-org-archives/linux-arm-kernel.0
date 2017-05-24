From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 24 May 2017 18:25:46 +0100
Subject: User-space code aborts on some (but not all) misaligned accesses
In-Reply-To: <382740a0-7d3b-7109-085a-d0ee2cc75638@free.fr>
References: <e80ee08d-e8ab-9eeb-9555-a743f8681d7d@free.fr>
 <b9060068-5b9b-89b4-851e-430ec02f9fd8@arm.com>
 <382740a0-7d3b-7109-085a-d0ee2cc75638@free.fr>
Message-ID: <43fd0ea8-8403-2122-365c-070984accd0f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/05/17 17:56, Mason wrote:
> On 24/05/2017 17:45, Robin Murphy wrote:
> 
>> On 24/05/17 16:26, Mason wrote:
>>
>>> Consider the following user-space code, split over two files
>>> to defeat the optimizer.
>>>
>>> This test program maps a page of memory not managed by Linux,
>>> and writes 4 words to misaligned addresses within that page.
>>>
>>> $ cat store.c 
>>> void store_at_addr_plus_0(void *addr, int val)
>>> {
>>> 	__builtin_memcpy(addr + 0, &val, sizeof val);
>>> }
>>> void store_at_addr_plus_1(void *addr, int val)
>>> {
>>> 	__builtin_memcpy(addr + 1, &val, sizeof val);
>>> }
>>>
>>> $ cat testcase.c 
>>> #include <fcntl.h>
>>> #include <sys/mman.h>
>>> #include <stdio.h>
>>> void store_at_addr_plus_0(void *addr, int val);
>>> void store_at_addr_plus_1(void *addr, int val);
>>> int main(void)
>>> {
>>> 	int fd = open("/dev/mem", O_RDWR | O_SYNC);
>>> 	void *ptr = mmap(0, 4096, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0xc0000000);
>>> 	store_at_addr_plus_0(ptr + 0, fd); puts("X");	// store at ptr + 0 => OK
>>> 	store_at_addr_plus_0(ptr + 1, fd); puts("X");	// store at ptr + 1 => OK
>>> 	store_at_addr_plus_1(ptr + 3, fd); puts("X");	// store at ptr + 4 => OK
>>> 	store_at_addr_plus_1(ptr + 0, fd); puts("X");	// store at ptr + 1 => ABORT
>>> 	return 0;
>>> }
>>>
>>> With optimizations turned off, the program works as expected.
>>>
>>> $ arm-linux-gnueabihf-gcc-6.3.1 -Wall -O0 testcase.c store.c -o misaligned_stores
>>> $ ./misaligned_stores 
>>> X
>>> X
>>> X
>>> X
>>>
>>> But if optimizations are enabled, the program aborts on the last store.
>>>
>>> $ arm-linux-gnueabihf-gcc-6.3.1 -Wall -O1 testcase.c store.c -o misaligned_stores
>>> # ./misaligned_stores 
>>> X
>>> X
>>> X
>>> Bus error
>>> [ 8736.457254] Alignment trap: not handling instruction f8c01001 at [<000104aa>]
>> ^^^
>>
>> Note where that message comes from: The alignment fault fixup code
>> doesn't recognise this instruction encoding, so it doesn't get fixed up.
>> It's that simple.
> 
> ARMv7 can handle misaligned accesses in hardware, right?
> But Linux sets up the MMU mapping to fault for misaligned
> accesses in "non-standard" areas, is that correct?

Unaligned accesses are only supported to Normal memory - anything mapped
as Device or Strongly Ordered will always make one fault at the MMU
before it even gets a chance to go out onto the interconnect and wreak
havoc.

> I will study arch/arm/mm/alignment.c
> 
>> Try "echo 5 > /proc/cpu/alignment" then run it again, and it should
>> become clearer what the kernel's doing (or not) behind your back - see
>> Documentation/arm/mem_alignment
> 
> # echo 5 > /proc/cpu/alignment
> # ./misaligned_stores 
> X
> Bus error
> [  241.813350] Alignment trap: misaligned_stor (1015) PC=0x000104b8 Instr=0x6001 Address=0xb6f16001 FSR 0x811
> 
>> The other thing to say, of course, is "don't make unaligned accesses to
>> Strongly-Ordered memory in the first place".
> 
> How would you fix my test case?

"rm store.c testcase.c"?

The point being that what you are doing looks fairly nonsensical to
begin with, since it's not like many peripherals support unaligned reads
or writes anyway. /dev/mem gives you pgprot_noncached, which translates
to Strongly Ordered, because as far as the kernel's concerned you're
mapping random bits of physical address space which could be home to
anything at all, and using a weaker memory type could be a Very Bad
Thing. You don't want to waste (significant) time debugging the
side-effects of the CPU speculatively filling cachelines from some
read-sensitive register, that's for sure.

> Ard mentioned something similar on IRC:
>> doesn't the issue go away when you stop using device attributes for the userland mapping?
>> iiuc you are mapping memory from userland that is not mapped by the kernel, right?
>> which is why it gets pgprot_noncached() attributes
>> so if you do add this memory to memblock but with the MEMBLOCK_NOMAP attribute
>> and use O_SYNC to open /dev/mem from userland
>> you will get writecombine attributes instead
>> it is perfectly legal for gcc to generate unaligned accesses to something that is presented
>> to it as being memory so you should focus on getting the attributes correct on this region
> 
> 
> I will study the different properties (cached vs noncached, write-combined).
> 
> 
> 
>>> [ 8736.464496] Unhandled fault: alignment exception (0x811) at 0xb6f4b001
>>> [ 8736.471106] pgd = de2d4000
>>> [ 8736.473839] [b6f4b001] *pgd=9f56b831, *pte=c0000743, *ppte=c0000c33
>>>
>>> (gdb) disassemble store_at_addr_plus_0
>>>    0x000104a6 <+0>:     str     r1, [r0, #0]
>>>    0x000104a8 <+2>:     bx      lr
>>>
>>> (gdb) disassemble store_at_addr_plus_1
>>>    0x000104aa <+0>:     str.w   r1, [r0, #1]
>>>    0x000104ae <+4>:     bx      lr
>>>
>>>
>>> So the 4th store (a misaligned store) aborts.
>>> But why doesn't the 2nd store abort as well?
>>> It targets the *same* address.
>>> They're using different versions of the str instruction.
>>>
>>> The compiler generates
>>> str	r1, [r0]	@ unaligned
>>> str	r1, [r0, #1]	@ unaligned
>>>
>>> According to objdump
>>>
>>> 00000000 <store_at_addr_plus_0>:
>>>    0:	6001      	str	r1, [r0, #0]
>>>    2:	4770      	bx	lr
>>>
>>> 00000004 <store_at_addr_plus_1>:
>>>    4:	f8c0 1001 	str.w	r1, [r0, #1]
>>>    8:	4770      	bx	lr
>>>
>>> Side issue, the T2 encoding for the STR instruction states
>>> 1 1 1 1 1 0 0 0 0 1 0 0 Rn
>>> which comes out as f840, not f8c0; I don't understand.
> 
> Ard said:
>> btw the str.w encodings are listed as T3/T4 in my copy of the v8 ARM ARM
> 
> I'm on a Cortex A9, so ARMv7-A
> But my copy of the ARM ARM is revB.
> I found rev C.b but that doesn't explain f8c0 vs f840

Its an immediate-offset STR, not a register-offset one.

Robin.
