From: damjan.marion@gmail.com (Damjan Marion)
Date: Tue, 21 Dec 2010 13:38:16 +0100
Subject: Help with cleaning CNS21xx code
In-Reply-To: <20101221113912.GQ28157@n2100.arm.linux.org.uk>
References: <EDE16191-967E-4BBA-A398-EDCBEC4A7A2B@gmail.com>
	<20101221113912.GQ28157@n2100.arm.linux.org.uk>
Message-ID: <EB30BAE8-4A04-42CD-8F2D-E99DEA44D71D@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Dec 21, 2010, at 12:39 PM, Russell King - ARM Linux wrote:
> On Tue, Dec 21, 2010 at 12:26:39PM +0100, Damjan Marion wrote:
>> Cavium Networks provided SDK for CNS21XX SoCs which is actually patched
>> 2.6.24 kernel. It is Faraday FA526 based platform with some embedded
>> peripherals (http://www.caviumnetworks.com/ECONA_CNS2XXX.html).
>> I'm trying to clean up the code and submit this as a new architecture,
>> and I have few issues. Seems that they patched some common code, and
>> this doesn't look to me like something what I should do.
>> 
>> I will appreciate any comments/hints how to address it. Diffs are below
>> and here is summary:
>> 
>> 1. modification of irq_handler when VIC is enabled [arch/arm/kernel/entry-armv.S] 
> 
> That looks like someone's been lazy when writing their get_irqnr_and_base
> implementation.  Without seeing the implementation of that macro, it's
> not really possible to make much more comments than that.

Please see below.

> 
>> 2. redefinition of PROCINFO_INITFUNC=12 in [arch/arm/kernel/head.S]
> 
> This should not be necessary - this symbol is generated from the C
> structure, which must match the layout of the structures in the
> proc-*.S files.
> 
> My guess is that the record in proc-fa526.S that's in your 2.6.24 was not
> updated, and the above is a bodge to make it sort-of work, rather than
> fixing it properly.  My guess is that this is actually causing some subtle
> breakage in 2.6.24 (such as screwed ELF hwcaps.)
> 

fa526 was not supported at all in 2.6.24 so they made own implementation.
I removed code which was obvious to be related to their fa526 implementation
as (i asume) it is not needed anymore.

This is my main concern, will you be able to take a look into their files?
I put all diffs and full files to http://web.me.com/dmarion/.


Thanks,

Damjan




	.macro	disable_fiq
	.endm

	.macro	get_irqnr_preamble, base, tmp
	.endm

	.macro	arch_ret_to_user, tmp1, tmp2
	.endm


#ifdef CONFIG_VIC_INTERRUPT
	.macro	get_fiqnr_and_base, irqnr, irqstat, base, tmp
	ldr	\base, =(SYSVA_VIC_BASE_ADDR + 0x140)
	ldr	\irqnr, [\base]
	.endm

	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
	ldr	\base, =(SYSVA_VIC_BASE_ADDR + 0x140)
	ldr	\irqnr, [\base]
	.endm
#else
	.macro	get_fiqnr_and_base, irqnr, irqstat, base, tmp
	ldr	\base, =(SYSVA_VIC_BASE_ADDR + 0x20)
	ldr	\irqstat, [\base]
	mov	\irqnr, #0
9001:
	tst	\irqstat, #1
	bne	9002f
	add	\irqnr, \irqnr, #1
	mov	\irqstat, \irqstat, lsr #1
	cmp	\irqnr, #32
	bcc	9001b
9002:
	.endm

	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
	ldr	\base, =(SYSVA_VIC_BASE_ADDR + 0x1C)
	ldr	\irqstat, [\base]
	mov	\irqnr, #0
9003:
	tst	\irqstat, #1
	bne	9004f
	add	\irqnr, \irqnr, #1
	mov	\irqstat, \irqstat, lsr #1
	cmp	\irqnr, #32
	bcc	9003b
9004:
	.endm
#endif

	.macro	irq_prio_table
	.endm
