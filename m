From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 6 Jul 2016 16:41:30 +0200
Subject: [PATCH] arm64:mm Remove the redundant initrd memblock codes
In-Reply-To: <20160706100725.GA14647@arm.com>
References: <1467607994-14368-1-git-send-email-dennis.chen@arm.com>
 <4ABE8B9C-8027-40AA-A303-A82CF014A287@linaro.org>
 <20160705022217.GA27637@arm.com>
 <B1CA6829-851E-4E56-BA48-58EE72272B49@linaro.org>
 <20160705041834.GA28823@arm.com>
 <CAKv+Gu8Zygx8jiYvDN69NuAEHWFOg2eCh+xM7m6FveBw2Qo7-Q@mail.gmail.com>
 <20160706100725.GA14647@arm.com>
Message-ID: <CAKv+Gu95sV0Et4rFGBG2vYFXdV-GC3CV=npD2uAvAsE=hqfJ=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 July 2016 at 12:07, Dennis Chen <dennis.chen@arm.com> wrote:
> On Wed, Jul 06, 2016 at 10:47:57AM +0200, Ard Biesheuvel wrote:
>> On 5 July 2016 at 06:18, Dennis Chen <dennis.chen@arm.com> wrote:
>> > On Tue, Jul 05, 2016 at 11:41:02AM +0800, Ard Biesheuvel wrote:
>> >>
>> >> > On 5 jul. 2016, at 10:22, Dennis Chen <dennis.chen@arm.com> wrote:
>> >> >
>> >> >> On Mon, Jul 04, 2016 at 12:33:05PM +0200, Ard Biesheuvel wrote:
>> >> >>
>> >> >>> On 4 jul. 2016, at 06:53, Dennis Chen <dennis.chen@arm.com> wrote:
>> >> >>>
>> >> >>> The memory range between initrd_start and initrd_end was added to the memblock
>> >> >>> twice unnecessarily in the same function before initrd memory range can be freed.
>> >> >>> This patch merge those codes into one piece of block and add the initrd memory
>> >> >>> range only once, also it makes the code clean and simple.
>> >> >>
>> >> >> This is likely to break under KASLR (and I would recommend that you test with kaslr enabled when you propose changes to this code)
>> >> > Hello Ard, I've tested it under KASLR on Juno board before proposing the changes,where the firmware provides the RNG protocol, it works well.
>> >>
>> >> Ok, thanks for confirming that (and apologies for assuming you did not test it)
>> >>
>> >> >>
>> >> >> The randomization of memstart_addr needs to execute /after/ adding back the initrd, otherwise the chosen value of memstart_addr may push the initrd beyond the end of the linear area into the userland range.
>> >> > Yes, I know the 'range' is depends on memblock_end_of_DRAM() and memblock_start_of_DRAM(), but I can't see that the order of initrd added to the memblock will affect
>> >> > those two values returned from memblock_ fucntions, IMHO the initrd will be loaded to somewhere within the DRAM by firmware, is that correct?
>> >>
>> >> memblock_add/_remove may affect the return values of memblock_start/_end_of_DRAM, so the reordering will affect the range of the randomized memstart_addr, afaict
>> >>
>> > Hello Ard, since the efi stub will load the initrd block to the DRAM, and all the memory descriptions passed in by the firmware will be added to the memblock by efi
>> > stub, so in this case adding the initrd to the memblock will not change the return value of memblock_start/_end_of_DRAM, else it's a bug from efi stub, isn't it?
>> >
>>
>> First of all, every memblock_add/_remove call is likely to affect
>> either memblock_start_of_DRAM or memblock_end_of_DRAM. The EFI stub
>> does not manipulate the memblock table, it simply retrieves the UEFI
>> memory map from the firmware and hands the address to the kernel
>> proper.
>>
>> But more importantly, the initrd could be loaded not only by the EFI
>> stub, but also by GRUB, and so we should be able to gracefully handle
>> the case where the initrd ends up in a place where it is outside of
>> the linear mapping, either due to a mem= kernel command line argument,
>> or due to an insufficient VA size (e.g., the Freescale platform that
>> puts 2 GB at 0x8000_0000 and the remaining memory at 0x80_0000_0000
>> cannot run an ordinary 39-bit VA kernel without losing access to a
>> substantial chunk of its memory)
>>
> Hello Ard, Freescale platform is a good example. In this case, with 39-bit
> VA, the linear map area is only 256GB, while the upper memory block on that
> platform is 0x80_0000_0000 exceeding the linear size, so current code will not
> put the [0x80_0000_0000, size] into the memblock, if kernel is loaded into the
> lower address memblock [0x8000_0000, size] while initrd block is loaded into
> the higher memblock, so the memblock_end_of_DRAM() will be changed after adding
> back the initrd.
> OK, so please modulo my prior comments/questions. Maybe we can have:
>
> -------->8--------
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 2ade7a6..2dede3b 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -279,15 +279,11 @@ void __init arm64_memblock_init(void)
>          * pagetables with memblock.
>          */
>         memblock_reserve(__pa(_text), _end - _text);
> -#ifdef CONFIG_BLK_DEV_INITRD
> -       if (initrd_start) {
> -               memblock_reserve(initrd_start, initrd_end - initrd_start);
> -
> -#ifdef CONFIG_BLK_DEV_INITRD
> -       if (initrd_start) {
> +       if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && initrd_start) {
>                 /* the generic initrd code expects virtual addresses */
>                 initrd_start = __phys_to_virt(initrd_start);
>                 initrd_end = __phys_to_virt(initrd_end);
>         }
> -#endif
> -------->8--------
>
> But I really have no keen on this kind of cleanup. So let's ignore this changes,
> and thanks for the clarification!
>

No problem.
