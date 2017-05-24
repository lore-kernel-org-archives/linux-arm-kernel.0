From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 24 May 2017 10:40:16 -0700
Subject: User-space code aborts on some (but not all) misaligned accesses
In-Reply-To: <970d2f3a-7cb0-ad72-bff3-a66695d9e031@arm.com>
References: <e80ee08d-e8ab-9eeb-9555-a743f8681d7d@free.fr>
 <b9060068-5b9b-89b4-851e-430ec02f9fd8@arm.com>
 <382740a0-7d3b-7109-085a-d0ee2cc75638@free.fr>
 <CAKv+Gu83Q1bKa7PhXrSqf3jWj-SDWGcEYW1KdXuBAKbckN4Bvw@mail.gmail.com>
 <970d2f3a-7cb0-ad72-bff3-a66695d9e031@arm.com>
Message-ID: <CAKv+Gu8Ee+OiV+L727690=4UqnVPs5HD+jPKZxVo1iXCvM96Ww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 May 2017 at 10:36, Robin Murphy <robin.murphy@arm.com> wrote:
> On 24/05/17 18:27, Ard Biesheuvel wrote:
>> On 24 May 2017 at 09:56, Mason <slash.tmp@free.fr> wrote:
>>> On 24/05/2017 17:45, Robin Murphy wrote:
>>>
>>>> On 24/05/17 16:26, Mason wrote:
>>>>
>>>>> Consider the following user-space code, split over two files
>>>>> to defeat the optimizer.
>>>>>
>>>>> This test program maps a page of memory not managed by Linux,
>>>>> and writes 4 words to misaligned addresses within that page.
>>>>>
>>>>> $ cat store.c
>>>>> void store_at_addr_plus_0(void *addr, int val)
>>>>> {
>>>>>      __builtin_memcpy(addr + 0, &val, sizeof val);
>>>>> }
>>>>> void store_at_addr_plus_1(void *addr, int val)
>>>>> {
>>>>>      __builtin_memcpy(addr + 1, &val, sizeof val);
>>>>> }
>>>>>
>>>>> $ cat testcase.c
>>>>> #include <fcntl.h>
>>>>> #include <sys/mman.h>
>>>>> #include <stdio.h>
>>>>> void store_at_addr_plus_0(void *addr, int val);
>>>>> void store_at_addr_plus_1(void *addr, int val);
>>>>> int main(void)
>>>>> {
>>>>>      int fd = open("/dev/mem", O_RDWR | O_SYNC);
>>>>>      void *ptr = mmap(0, 4096, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0xc0000000);
>>>>>      store_at_addr_plus_0(ptr + 0, fd); puts("X");   // store at ptr + 0 => OK
>>>>>      store_at_addr_plus_0(ptr + 1, fd); puts("X");   // store at ptr + 1 => OK
>>>>>      store_at_addr_plus_1(ptr + 3, fd); puts("X");   // store at ptr + 4 => OK
>>>>>      store_at_addr_plus_1(ptr + 0, fd); puts("X");   // store at ptr + 1 => ABORT
>>>>>      return 0;
>>>>> }
>>>>>
>>>>> With optimizations turned off, the program works as expected.
>>>>>
>>>>> $ arm-linux-gnueabihf-gcc-6.3.1 -Wall -O0 testcase.c store.c -o misaligned_stores
>>>>> $ ./misaligned_stores
>>>>> X
>>>>> X
>>>>> X
>>>>> X
>>>>>
>>>>> But if optimizations are enabled, the program aborts on the last store.
>>>>>
>>>>> $ arm-linux-gnueabihf-gcc-6.3.1 -Wall -O1 testcase.c store.c -o misaligned_stores
>>>>> # ./misaligned_stores
>>>>> X
>>>>> X
>>>>> X
>>>>> Bus error
>>>>> [ 8736.457254] Alignment trap: not handling instruction f8c01001 at [<000104aa>]
>>>> ^^^
>>>>
>>>> Note where that message comes from: The alignment fault fixup code
>>>> doesn't recognise this instruction encoding, so it doesn't get fixed up.
>>>> It's that simple.
>>
>> Well spotted. I missed that bit, but it makes perfect sense. Mason,
>> care to propose a patch to the alignment fixup code that adds the
>> missing encoding?
>
> No need for that - anything that could be executing 32-bit Thumb
> encodings also supports (and will be using) the v6 unaligned access
> model by definition. I would assume that the "regular" loads/stores are
> deliberately unhandled for that reason (i.e. it would never be correct
> to fix up).
>

Fair enough. It causes some inconsistencies, as the example shows, but
the alignment fault handling is slightly inconsistent anyway, so I
suppose that doesn't really matter (given that the code is not
intended to deal with accesses to mappings with device attributes)
