From: kmpark@infradead.org (Kyungmin Park)
Date: Wed, 7 Jul 2010 13:40:39 +0900
Subject: [PATCH] ARM: S5PV210: Fix on SECTION_SIZE_BITS on
	S5PV210/S5PC110.
In-Reply-To: <013001cb1d62$de72ff30$9b58fd90$%kim@samsung.com>
References: <1278391007-11144-1-git-send-email-kgene.kim@samsung.com>
	<20100706071245.GA5058@n2100.arm.linux.org.uk>
	<013001cb1d62$de72ff30$9b58fd90$%kim@samsung.com>
Message-ID: <AANLkTinwGaBt-vOVThBb1yoevkHZtxQTQzZ2b5Nyt3dY@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 7, 2010 at 8:27 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Russell King wrote:
>>
> Hi Russell :-)
>
>> On Tue, Jul 06, 2010 at 01:36:47PM +0900, Kukjin Kim wrote:
>> > This patch fixes on SECTION_SIZE_BITS for Sparsemem on S5PV210/S5PC110.
>> > Because smallest size of a bank on S5PV210/S5PC110 is aligned by 16MB.
>> > So each section's maximum size should be 16MB.
>>
>> What is the spacing of chunks of memory, and minimum alignment of those
>> chunks in physical address space?
>
> Some S5PC110(MCP D-type) has only available 80MiB in a bank.
> So the space accounts for 432MiB in a DMC0, but larger memory(256MiB +
> 128MiB) exists in a DMC1.

It's OneDRAM consists of 80MiB for AP, 16MiB for shared between AP and
CP, and last 32MiB for CP.
Even though we use the dedicated 80MiB for AP. we also use the shared
16MiB at AP side.
Then can we access the last 32MiB? the answer is no. But it's
connected physically. so we can't  use the last 32MiB area for other
case.

Additionally it's almost difficult to 16MiB align by Spec.

Memory Chip0 Configuration Register (MemConfig0, R/W,
Address=0xF000_0008, 0xF140_0008)

chip_mask [23:16] AXI Base Address Mask
Upper address bit mask to determine AXI offset address of memory chip0.
0 = Corresponding address bit is not to be used for comparison
1 = Corresponding address bit is to be used for comparison
For example, if chip_mask = 0xF8, then AXI offset address
becomes 0x0000_0000 ~ 0x07FF_FFFF. If AXI base address
of memory chip0 is 0x2000_0000, then memory chip0 has an
address range of 0x2000_0000 ~ 0x27FF_FFFF.

Thank you,
Kyungmin Park

>
> As you know, the size of a section should be a power of 2 and a physical
> address space of a section should be contiguous.
> If a section size is greater than 16MiB, a section have a hole. So the
> SECTION_SIZE_BITS should be 16MiB.
>
>>
>> Also, what is the maximum physical address which memory can be located?
>
> Following is memory map of S5PV210/S5PC110.
>
> 0x80000000 ?-------------------
> ? ? ? ? ? ?| ? ? ? ? ?|
> 0x70000000 ?| ? ? ? ? ?|
> ? ? ? ? ? ?| ? ? ? ? ?|
> 0x60000000 ?| ?DMC 1 ?| ?up to 1GiB
> ? ? ? ? ? ?| ? ? ? ? ?|
> 0x50000000 ?| ? ? ? ? ?|
> ? ? ? ? ? ?| ? ? ? ? ?|
> 0x40000000 ?-----------------
> ? ? ? ? ? ?| ? ? ? ? ?|
> 0x30000000 ?| ?DMC 0 ?| ?up to 512MiB
> ? ? ? ? ? ?| ? ? ? ? ?|
> 0x20000000 ?-------------------
>
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
