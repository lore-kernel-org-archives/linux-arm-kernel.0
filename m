From: pj0585@gmail.com (P J)
Date: Tue, 26 Jul 2011 16:38:48 +0530
Subject: at91sam9g45: Issues while working with RAM that is separated on
	physical address space
In-Reply-To: <CAA2DH4u9GANxUTnTqRzUR=GihNLS8EEDAKm8u8SFZ_Yq48qXOg@mail.gmail.com>
References: <CAA2DH4u1kcky3xzxpepS=gtDK1Xas17zDxcRkDR7qRNLHQyoxw@mail.gmail.com>
	<20110722135505.GB25947@n2100.arm.linux.org.uk>
	<CAA2DH4u9GANxUTnTqRzUR=GihNLS8EEDAKm8u8SFZ_Yq48qXOg@mail.gmail.com>
Message-ID: <CAA2DH4sviHkHEHZTR+0AHP3pToC7fEgTc+irw0vk_WU5q0XEQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 25, 2011 at 7:36 PM, P J <pj0585@gmail.com> wrote:
> Hi Russell,
>
> On Fri, Jul 22, 2011 at 7:25 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Fri, Jul 22, 2011 at 07:06:40PM +0530, P J wrote:
>>> The memory map (required) is as follows:
>>> ? ? phys ? ? ? ? ? => ? ? ? ? ?virt
>>> 0x70000000 ? ?=> ? ?0xC0000000 ?(128 MB)
>>> 0x20000000 ? ?=> ? ?0xC8000000 ?(128 MB)
>>
>> There is no way that the kernel will support this kind of hair-brained
>> memory layout. ?This is even more true than it once was since we've moved
>> to using memblock to manage the physical memory layout in later kernels.
>>
>> What the kernel will support is using 0x20000000 as the first bank and
>> 0x70000000 as the second bank of memory. ?I suggest trying with it mapped
>> that way around, and failing that then using highmem support without
>> sparse.
>>
>
> I do not completely understand why this layout is not possible.
>
> Anyways, my one memory bank (128 MB DDR2) is located at physical
> address 0x70000000 to 0x77FFFFFF and is virtually mapped to 0xC0000000
> to 0xC7FFFFFF.
>
> If I have to continue to use this bank as per the above mapping then
> how can I use the other memory bank (128MB DDR2) which is located at
> physical address 0x20000000 to 0x27FFFFFF ?
>
>
> -Prasant J
>


I think that if I change my memory banks (like I use the memory bank
at 0x20000000 as the first one and the memory bank at 0x70000000 as
the second one) then also I will have issues.

The issue is because the memory banks are not getting correctly mapped
because the __virt_to_phys() and __phys_to_virt() are defined as
linear:

#define __virt_to_phys(x)	((x) - PAGE_OFFSET + PHYS_OFFSET)
#define __phys_to_virt(x)	((x) - PHYS_OFFSET + PAGE_OFFSET)

where PHYS_OFFSET is 0x70000000 and PAGE_OFFSET is 0xC0000000


Now the first bank which is at 0x70000000 gets correctly mapped
virtually but the second bank which is at 0x20000000 gets mapped
incorrectly. Even if I change the order of banks, (also I change the
PHYS_OFFSET to 0x20000000) then, always, only one bank gets mapped
correctly and the other one gets incorrectly mapped.

If I change the above defines to map both my memories correctly then
Linux does not boot.


Any suggestions, as to how I can get the mappings correct.

-Prasant J
