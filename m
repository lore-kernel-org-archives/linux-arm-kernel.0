From: saeed.bishara@gmail.com (saeed bishara)
Date: Wed, 13 Jan 2010 13:27:43 +0200
Subject: question about ARM11MP cpu architecture identification
In-Reply-To: <alpine.LFD.2.00.1001121453560.10143@xanadu.home>
References: <c70ff3ad1001120821u1f546480nd0229e560d84293@mail.gmail.com>
	<1263313572.29654.105.camel@pc1117.cambridge.arm.com>
	<20100112164220.GJ27771@n2100.arm.linux.org.uk>
	<1263315302.29654.110.camel@pc1117.cambridge.arm.com>
	<c70ff3ad1001120903i62b96731ld8c1820be00fb41b@mail.gmail.com>
	<20100112171733.GC5633@n2100.arm.linux.org.uk>
	<20100112172422.GD5633@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1001121453560.10143@xanadu.home>
Message-ID: <c70ff3ad1001130327n2816c42cj13ac97cf18cf4613@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

looks fine to me too.

On Tue, Jan 12, 2010 at 9:55 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Tue, 12 Jan 2010, Russell King - ARM Linux wrote:
>
>> On Tue, Jan 12, 2010 at 05:17:33PM +0000, Russell King - ARM Linux wrote:
>> > On Tue, Jan 12, 2010 at 07:03:35PM +0200, saeed bishara wrote:
>> > > On Tue, Jan 12, 2010 at 6:55 PM, Catalin Marinas
>> > > <catalin.marinas@arm.com> wrote:
>> > > > On Tue, 2010-01-12 at 16:42 +0000, Russell King - ARM Linux wrote:
>> > > >> On Tue, Jan 12, 2010 at 04:26:12PM +0000, Catalin Marinas wrote:
>> > > >> > On Tue, 2010-01-12 at 16:21 +0000, saeed bishara wrote:
>> > > >> > > ? ? The ARM11MP (rev r2p0) cpu architecture is ARMv6, and according to
>> > > >> > > the http://infocenter.arm.com, its Main ID register is 0x410FB024, and
>> > > >> > > the MMFR[3:0] is 3. but it looks to me that the cpu_architecture()
>> > > >> > > will identify it as ARMv7, and if the kernel was configured with
>> > > >> > > CPU_V7 only, then the lookup_processor_type() function also will
>> > > >> > > identify it as ARMv7. Am I missing something here?
>> > > >> >
>> > > >> > cpu_architecture() returns the architecture version of the supported MMU
>> > > >> > which on ARM11MPCore is the same as on ARMv7.
>> > > >> >
>> > > >> > Even if it is possible to configure both v6 and v7 in the same kernel, I
>> > > >> > don't think it is currently possible to successfully run such kernel.
>> > > >>
>> > > >> What makes you think that? ?I've been building v6+v7 kernels for Realview
>> > > >> (with a patch to provide the right build options for the ARMv7 arch/arm/mm
>> > > >> files) and ISTR it works fine on my Realview board.
>> > > >
>> > > > I don't remember exactly but it didn't work for me some time ago. I
>> > > > think it failed to build (though I could have worked around this with
>> > > > something like -march=all).
>> > > >
>> > > I think you need the attached patch from Lennert (it was planned to be
>> > > sent later by me)
>> >
>> > Using -Wa,-march= for assembler options is actually a better idea.
>> > I'll update my patch with that (which actually reflects what I did
>> > for Integrator/CP with ARM926 + v6).
>>
>> Ok, here's the combined patch. ?Ack?
>
> We need this as well so please consider adding it to your tree.
>
> Acked-by: Nicolas Pitre <nico@marvell.com>
>
>
>>
>> ?arch/arm/mm/Makefile | ? 12 ++++++++++++
>> ?1 files changed, 12 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
>> index 827e238..e8d34a8 100644
>> --- a/arch/arm/mm/Makefile
>> +++ b/arch/arm/mm/Makefile
>> @@ -27,6 +27,9 @@ obj-$(CONFIG_CPU_ABRT_EV5TJ) ? ? ? ?+= abort-ev5tj.o
>> ?obj-$(CONFIG_CPU_ABRT_EV6) ? += abort-ev6.o
>> ?obj-$(CONFIG_CPU_ABRT_EV7) ? += abort-ev7.o
>>
>> +AFLAGS_abort-ev6.o ? :=-Wa,-march=armv6k
>> +AFLAGS_abort-ev7.o ? :=-Wa,-march=armv7-a
>> +
>> ?obj-$(CONFIG_CPU_PABRT_LEGACY) ? ? ? += pabort-legacy.o
>> ?obj-$(CONFIG_CPU_PABRT_V6) ? += pabort-v6.o
>> ?obj-$(CONFIG_CPU_PABRT_V7) ? += pabort-v7.o
>> @@ -39,6 +42,9 @@ obj-$(CONFIG_CPU_CACHE_V6) ?+= cache-v6.o
>> ?obj-$(CONFIG_CPU_CACHE_V7) ? += cache-v7.o
>> ?obj-$(CONFIG_CPU_CACHE_FA) ? += cache-fa.o
>>
>> +AFLAGS_cache-v6.o ? ?:=-Wa,-march=armv6
>> +AFLAGS_cache-v7.o ? ?:=-Wa,-march=armv7-a
>> +
>> ?obj-$(CONFIG_CPU_COPY_V3) ? ?+= copypage-v3.o
>> ?obj-$(CONFIG_CPU_COPY_V4WT) ?+= copypage-v4wt.o
>> ?obj-$(CONFIG_CPU_COPY_V4WB) ?+= copypage-v4wb.o
>> @@ -58,6 +64,9 @@ obj-$(CONFIG_CPU_TLB_V6) ? ?+= tlb-v6.o
>> ?obj-$(CONFIG_CPU_TLB_V7) ? ? += tlb-v7.o
>> ?obj-$(CONFIG_CPU_TLB_FA) ? ? += tlb-fa.o
>>
>> +AFLAGS_tlb-v6.o ? ? ? ? ? ? ?:=-Wa,-march=armv6
>> +AFLAGS_tlb-v7.o ? ? ? ? ? ? ?:=-Wa,-march=armv7-a
>> +
>> ?obj-$(CONFIG_CPU_ARM610) ? ? += proc-arm6_7.o
>> ?obj-$(CONFIG_CPU_ARM710) ? ? += proc-arm6_7.o
>> ?obj-$(CONFIG_CPU_ARM7TDMI) ? += proc-arm7tdmi.o
>> @@ -84,6 +93,9 @@ obj-$(CONFIG_CPU_FEROCEON) ?+= proc-feroceon.o
>> ?obj-$(CONFIG_CPU_V6) ? ? ? ? += proc-v6.o
>> ?obj-$(CONFIG_CPU_V7) ? ? ? ? += proc-v7.o
>>
>> +AFLAGS_proc-v6.o ? ? :=-Wa,-march=armv6
>> +AFLAGS_proc-v7.o ? ? :=-Wa,-march=armv7-a
>> +
>> ?obj-$(CONFIG_CACHE_FEROCEON_L2) ? ? ?+= cache-feroceon-l2.o
>> ?obj-$(CONFIG_CACHE_L2X0) ? ? += cache-l2x0.o
>> ?obj-$(CONFIG_CACHE_XSC3L2) ? += cache-xsc3l2.o
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>
