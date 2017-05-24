From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 24 May 2017 10:27:24 -0700
Subject: User-space code aborts on some (but not all) misaligned accesses
In-Reply-To: <382740a0-7d3b-7109-085a-d0ee2cc75638@free.fr>
References: <e80ee08d-e8ab-9eeb-9555-a743f8681d7d@free.fr>
 <b9060068-5b9b-89b4-851e-430ec02f9fd8@arm.com>
 <382740a0-7d3b-7109-085a-d0ee2cc75638@free.fr>
Message-ID: <CAKv+Gu83Q1bKa7PhXrSqf3jWj-SDWGcEYW1KdXuBAKbckN4Bvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 May 2017 at 09:56, Mason <slash.tmp@free.fr> wrote:
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
>>>      __builtin_memcpy(addr + 0, &val, sizeof val);
>>> }
>>> void store_at_addr_plus_1(void *addr, int val)
>>> {
>>>      __builtin_memcpy(addr + 1, &val, sizeof val);
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
>>>      int fd = open("/dev/mem", O_RDWR | O_SYNC);
>>>      void *ptr = mmap(0, 4096, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0xc0000000);
>>>      store_at_addr_plus_0(ptr + 0, fd); puts("X");   // store at ptr + 0 => OK
>>>      store_at_addr_plus_0(ptr + 1, fd); puts("X");   // store at ptr + 1 => OK
>>>      store_at_addr_plus_1(ptr + 3, fd); puts("X");   // store at ptr + 4 => OK
>>>      store_at_addr_plus_1(ptr + 0, fd); puts("X");   // store at ptr + 1 => ABORT
>>>      return 0;
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

Well spotted. I missed that bit, but it makes perfect sense. Mason,
care to propose a patch to the alignment fixup code that adds the
missing encoding?

>
> ARMv7 can handle misaligned accesses in hardware, right?
> But Linux sets up the MMU mapping to fault for misaligned
> accesses in "non-standard" areas, is that correct?
>

Please understand that device attributes simply imply that unaligned
accesses are not supportable. There is no policy here that you can
debate. If the underlying bus does not implement unaligned accesses,
the CPU needs to split them into several smaller ones, which is
impossible to do when side effects are taken into account (unless you
know the exact nature of the side effects of the particular location)

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
>
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

It is really quite simple
1. add the memory to the /memory DT node
2. add it as a no-map region to the /reserved-memory DT node

This should result in pgprot_writecombine() attributes on your O_SYNC
/dev/mem mapping, which should make the problem go away.
