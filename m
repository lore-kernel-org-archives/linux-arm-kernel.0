From: robh@kernel.org (Rob Herring)
Date: Fri, 9 Jun 2017 11:13:59 -0500
Subject: DMA-safety for edac_atomic_scrub on ARM
In-Reply-To: <1497016569.3536.84.camel@pengutronix.de>
References: <20170608041124.4624-1-chris.packham@alliedtelesis.co.nz>
 <20170608041124.4624-2-chris.packham@alliedtelesis.co.nz>
 <1497014062.3536.52.camel@pengutronix.de>
 <1497016569.3536.84.camel@pengutronix.de>
Message-ID: <CAL_JsqLX0kbMBM3JOqvOTAUsWdGmjyT-xP+nVJtEpKZH-5oYOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 9, 2017 at 8:56 AM, Jan L?bbe <jlu@pengutronix.de> wrote:
> Hi,
>
> I've CCed Rob as the original author of the ARM EDAC scrub function.
>
> On Fr, 2017-06-09 at 15:14 +0200, Jan L?bbe wrote:
>> [...]
>> > +     mci->scrub_mode = SCRUB_SW_SRC;
>> I'm not sure if this works as expected ARM as it is currently
>> implemented, but that's a topic for a different mail.
>
> Some more background as I understand it so far:
>
> Configuring a EDAC MC to scrub_mode = SCRUB_SW_SRC causes the common
> handler code to run a per-arch software scrub function. It is used by
> several EADC drivers on ARM.
>
> drivers/edac/edac_mc.c:
>>         if (mci->scrub_mode == SCRUB_SW_SRC) {
>>                 /*
>>                         * Some memory controllers (called MCs below) can remap
>>                         * memory so that it is still available at a different
>>                         * address when PCI devices map into memory.
>>                         * MC's that can't do this, lose the memory where PCI
>>                         * devices are mapped. This mapping is MC-dependent
>>                         * and so we call back into the MC driver for it to
>>                         * map the MC page to a physical (CPU) page which can
>>                         * then be mapped to a virtual page - which can then
>>                         * be scrubbed.
>>                         */
>>                 remapped_page = mci->ctl_page_to_phys ?
>>                         mci->ctl_page_to_phys(mci, page_frame_number) :
>>                         page_frame_number;
>>
>>                 edac_mc_scrub_block(remapped_page,
>>                                         offset_in_page, grain);
>>         }
>
> edac_mc_scrub_block() then basically checks if it actually hit a valid
> PFN, maps the page with kmap_atomic and runs edac_atomic_scrub().
> For ARM this is implemented in arch/arm/include/asm/edac.h:
>> /*
>>  * ECC atomic, DMA, SMP and interrupt safe scrub function.
>>  * Implements the per arch edac_atomic_scrub() that EDAC use for software
>>  * ECC scrubbing.  It reads memory and then writes back the original
>>  * value, allowing the hardware to detect and correct memory errors.
>>  */
>>
>> static inline void edac_atomic_scrub(void *va, u32 size)
>> {
>> #if __LINUX_ARM_ARCH__ >= 6
>>         unsigned int *virt_addr = va;
>>         unsigned int temp, temp2;
>>         unsigned int i;
>>
>>         for (i = 0; i < size / sizeof(*virt_addr); i++, virt_addr++) {
>>                 /* Very carefully read and write to memory atomically
>>                  * so we are interrupt, DMA and SMP safe.
>>                  */
>>                 __asm__ __volatile__("\n"
>>                         "1:     ldrex   %0, [%2]\n"
>>                         "       strex   %1, %0, [%2]\n"
>>                         "       teq     %1, #0\n"
>>                         "       bne     1b\n"
>>                         : "=&r"(temp), "=&r"(temp2)
>>                         : "r"(virt_addr)
>>                         : "cc");
>>         }
>> #endif
>> }
>
> The comment "ECC atomic, DMA, SMP and interrupt safe scrub function"
> seems to be copied from the initial implementation on x86, first to
> powerpc, to mips and later to arm.

Yes.

> On ARM, other bus masters are usually not coherent to the CPUs. This
> means that exclusive loads/stores only affect (at most) the sharable
> domain, which is usually a subset of the SoC.

Maybe usually, but that's entirely system dependent. For the system
that needed this (and maybe still the only 32-bit one), it was
coherent i/o. Good luck doing 10G networking with a non-coherent
master.

> Consequently, when a bus master outside of the shareable domain (such as
> a ethernet controller) writes to the same memory after the ldrex, the
> strex will simply succeed and write stale data to the CPU cache, which
> can later overwrite the data written by the ethernet controller.
>
> I'm not sure if it is actually possible to implement this in a DMA-safe
> way on ARM without stopping all other bus masters.

Generically, probably not. And stopping bus masters is probably not
going to work. Bottom line is systems have to be designed for this or
bus masters and drivers audited that they could deal with this. Many
bus masters are not going to both repeatedly read the same location
and write to it. It's a rare problem on an already rare occurrence.

Rob
