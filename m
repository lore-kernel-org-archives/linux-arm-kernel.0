From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 13 Feb 2015 11:00:50 +0100
Subject: [PATCH 02/14] ARM: ARMv7M: Enlarge vector table to 256 entries
In-Reply-To: <CALszF6BDa9pUb534YN2z9DbYA+hPCnG8XYy5YbjJwSiseKz4xg@mail.gmail.com>
References: <1423763164-5606-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1423763164-5606-3-git-send-email-mcoquelin.stm32@gmail.com>
 <CAMuHMdWESyPktOSBfVoZCb35stUbhNpbbpzSW4JfORdObgg5jw@mail.gmail.com>
 <CALszF6BDa9pUb534YN2z9DbYA+hPCnG8XYy5YbjJwSiseKz4xg@mail.gmail.com>
Message-ID: <20150213100050.GM10842@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 13, 2015 at 09:42:46AM +0100, Maxime Coquelin wrote:
> Hi Geert,
> 
> 2015-02-12 21:34 GMT+01:00 Geert Uytterhoeven <geert@linux-m68k.org>:
> > On Thu, Feb 12, 2015 at 6:45 PM, Maxime Coquelin
> > <mcoquelin.stm32@gmail.com> wrote:
> >> From Cortex-M4 and M7 reference manuals, the nvic supports up to 240
> >> interrupts. So the number of entries in vectors table is 256.
> >>
> >> This patch adds the missing entries, and change the alignement, so that
> >> vector_table remains naturally aligned.
> >
> > Shouldn't this depend on ARCH_STM32, or some other M4 or M7 specific
> > Kconfig option, to avoid wasting the space on other CPUs?
> 
> Actually, the STM32F429 has 90 interrupts, so it would need 106
> entries in the vector table.
> The maximum of supported interrupts is not only for Cortex-M4 and M7,
> this is also true for Cortex-M3.
> 
> I see two possibilities:
>  1 - We declare the vector table for the maximum supported number of
> IRQs, as this patch does.
>         - Pro: it will be functionnal with all Cortex-M MCUs
>         - Con: Waste of less than 1KB for memory
>  2 - We introduce a config flag that provides the number of interrupts
>         - Pro: No more memory waste
>         - Con: Need to declare a per MCU model config flag.
I'd vote for 2, something like:

	config CPUV7M_NUM_IRQ
		int
		default 90 if STM32F429
		default 38 if EFM32GG
		default 240

then there is a working default and platforms being short on memory can
configure as appropriate. (The only down side is that if we create
multi-platfrom images at some time in the future either all or none of
the supported platforms must provide a value here.)
 
> Then, regarding the natural alignment, is there a way to ensure it
> depending on the value of a config flag?
The exact wording in ARMARMv7-M is:

	The Vector table must be naturally aligned to a power of two
	whose alignment value is greater than or equal
	to (Number of Exceptions supported x 4), with a minimum
	alignment of 128 bytes.

> Or we should keep it at the maximum value possible?
So we need:

	.align x

with x being max(7, ceil(log((CPUV7M_NUM_IRQ + 16) * 4, 2))). So the
alignment needed is between 7 and 10.

If the assembler supports an expression here I'd use that. But before
adding strange hacks to generate the right value there better go for a
static value like:

	/* The vector table must be naturally aligned */
	#if CONFIG_CPUV7M_NUM_IRQ <= 112
	.align 9 /* log2((112 + 16) * 4) */
	#else
	.align 10
	#endif

Further steps would be:

	CONFIG_CPUV7M_NUM_IRQ <= 48 -> .align 8
	CONFIG_CPUV7M_NUM_IRQ <= 16 -> .align 7

Probably it's not worth to add the respective #ifdefs here.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
