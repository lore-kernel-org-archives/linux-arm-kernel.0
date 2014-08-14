From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Thu, 14 Aug 2014 17:12:12 +0530
Subject: [PATCH v7 07/11] arm64: mm: Implement 4 levels of translation
 tables
In-Reply-To: <9DF712F2-52EB-412B-9E6F-41FC8212AE1F@gmail.com>
References: <CAGoO6fLT6B_vx+Wtm6bKHD6YkjQcM8f=deD7SDP3BR_uC+1c5w@mail.gmail.com>
 <ACF42928-55EE-4466-B217-982839BB98C4@gmail.com>
 <53D7AD7A.8050706@amd.com>
 <9DF712F2-52EB-412B-9E6F-41FC8212AE1F@gmail.com>
Message-ID: <CAFpQJXU_8HTaL5s+gyZKA7F6HS_jeAfOrEwahEe0P-EKo1FaHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

IMHO, the Macro MAX_PHYSMEM_BITS needs to be set to 48 in file
arch/arm64/include/asm/sparsemem.h

with 40 bit set, for RAM address beyond 40 bit,  seeeing below warning message.
WARNING: CPU: 0 PID: 0 at mm/sparse.c:164
mminit_validate_memmodel_limits+0xf8/0x118()

thanks
Ganapat

On Wed, Jul 30, 2014 at 8:27 PM, Jungseok Lee <jungseoklee85@gmail.com> wrote:
> On Jul 29, 2014, at 11:19 PM, Joel Schopp wrote:
>>
>>>> Here's a good example of where we run into trouble equating page table
>>>> addressable bits with hardware addressable bits.  If VA_BITS is 48 due
>>>> to 4K 4 level page tables but is running on a 42 bit system this will
>>>> end up being out of range.
>>> Is your concern that CPU issues 48-bit address to MMU on 42-bit hardware?
>>> Have you tested this patch series on your hardware?
>>>
>>> - Jungseok Lee
>>
>> That is my concern.  I did test the patch on my hardware with the
>> following results:
>> 64k pages, 2 levels 42 bit VA - worked (no regression)
>> 64k pages, 3 levels 48 bit VA- didn't boot
>> 4k pages, 4 levels 42 bit VA - didn't boot
>> 4k pages, 4 levels 48 bit VA - didn't boot
>
>
> Let me break the concern down into two small parts.
>
> The first one is a relation between VA and PA. Let me visualize the above
> description in the following way. I assume that Cortex-A57 is used and
> connected to bus with 42-bit address line.
>
> SoC Boundary
> |---------------------------------------------
> | Cortex-A57 Boundary                        |
> | ---------------                            |
> | | CPU --> MMU | --> BUS --> Memory Controller --> RAM
> | ------48------- 42      42                 |  42
> |---------------------------------------------
>
> In this configuration, there is no problem since 48-bit VA is handled in
> Cortex-A57 boundary. Cortex-A57 can support up to 48-bit VA and 44-bit PA.
>
> The second part is the test result. It's bad actually. So, I've done booting
> test on for-next/core branch of arm64 linux git, [1], quickly using Model. All
> combinations, 4KB + 3Level (39-bit VA), 4KB + 4Level (48-bit VA), 64KB + 2Level
> (42-bit VA) and 64KB + 3Level(48bit VA), boot up successfully.
>
> I hesitate to say anything since I don't have any real hardware. I think people
> who have real platform, such as Juno, can help to figure it out.
>
> [1]: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
>
> I add Will in Cc since [1] looks updated by Will now.
>
> - Jungseok Lee
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
