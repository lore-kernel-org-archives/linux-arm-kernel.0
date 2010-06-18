From: eric.miao@canonical.com (Eric Miao)
Date: Fri, 18 Jun 2010 09:31:03 +0800
Subject: [PATCH 0/5] Makefile.boot cleanup
In-Reply-To: <alpine.LFD.2.00.1006171203030.13427@xanadu.home>
References: <1275550613-9553-1-git-send-email-eric.miao@canonical.com>
	<20100603075704.GB336@pengutronix.de>
	<alpine.LFD.2.00.1006171203030.13427@xanadu.home>
Message-ID: <AANLkTiloOzJk-TWDaFCLytjOWLEGSv-u_poJnC13tlD_@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/6/18 Nicolas Pitre <nico@fluxnic.net>:
> On Thu, 3 Jun 2010, Uwe Kleine-K?nig wrote:
>
>> Hello Eric,
>>
>> On Thu, Jun 03, 2010 at 03:36:48PM +0800, Eric Miao wrote:
>> > Several facts:
>> >
>> > 1. ZRELADDR in most cases can be auto detected by maksing PC with
>> > ? ?0xf000_0000 if the zImage is placed within the first 256MiB from
>> > ? ?the memory start, which is a sane assumption except for:
>> >
>> > ? ?- when ARCH_MX1 or ARCH_SHARK is defined
>> > ? ?- when ARCH_U300 is defined (U300 really is strange when defining
>> > ? ? ?PHYS_OFFSET and ZRELADDR)
>> > ? ?- or when ZBOOT_ROM is defined
>> If you guess ZRELADDR based on sp instead of pc it even should work if
>> ZBOOT_ROM is defined?!
>
> What is the relation between sp and ZRELADDR?
>
> While we're pushing forward the notion of a relation between phys offset
> and the location where zImage is loaded in memory, I think that making
> the association with sp is a bit too obscur. ?Knowing where you upload
> your kernel is clear, knowing where the stack is allocated in relation
> to that is not that clear. ?It is in the .bss section of course, but
> when ZBOOT_ROM is not defined then the .bss happens to be right after
> the zImage binary, while it must be explicitly specified otherwise.
>
> On Sun, 6 Jun 2010, Uwe Kleine-K?nig wrote:
>
>> On Thu, Jun 10, 2010 at 02:44:53PM -0400, Nicolas Pitre wrote:
>> > If you're using ZBOOT_ROM that means you want to execute zImage directly
>> > from ROM. ?This is therefore a highly customized configuration. ?In that
>> > context, having a variable phys-offset doesn't make much sense to start
>> > with.
>> Right, but then the kernel needs to know this fixed value for
>> phys-offset. ?In the patches presented by Eric the person configuring
>> the kernel needs to know that value. ?When guessing based on sp she
>> doesn't need to read addional docs when enabling ZBOOT_ROM.
>
> That's presuming phys offset would still be runtime determined. ?Again,
> if you care about ZBOOT_ROM, you probably want a fixed phys offset at
> compile time too. ?So that value has to be determined at kernel config
> time, not at run time from pc or sp. ?And when dealing with such
> customized expert config options, she better know what she's doing and
> be familiar with the memory layout so not to have to read the datasheet
> only for the physical RAM offset while she already must know what flash
> offset to use.
>
> If anything, you _could_ try doing something similar to:
>
> config PHYS_OFFSET
> ? ? ? ?[prompt]
> ? ? ? ?default (CONFIG_ZBOOT_ROM_BSS & 0xf0000000) if ZBOOT_ROM
>
> but I doubt Kconfig might accept such a syntax.
>

No, Kconfig doesn't. I tried to play this a bit with Kconfig, but failed.
