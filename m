From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Dec 2010 11:39:12 +0000
Subject: Help with cleaning CNS21xx code
In-Reply-To: <EDE16191-967E-4BBA-A398-EDCBEC4A7A2B@gmail.com>
References: <EDE16191-967E-4BBA-A398-EDCBEC4A7A2B@gmail.com>
Message-ID: <20101221113912.GQ28157@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 21, 2010 at 12:26:39PM +0100, Damjan Marion wrote:
> Cavium Networks provided SDK for CNS21XX SoCs which is actually patched
> 2.6.24 kernel. It is Faraday FA526 based platform with some embedded
> peripherals (http://www.caviumnetworks.com/ECONA_CNS2XXX.html).
> I'm trying to clean up the code and submit this as a new architecture,
> and I have few issues. Seems that they patched some common code, and
> this doesn't look to me like something what I should do.
> 
> I will appreciate any comments/hints how to address it. Diffs are below
> and here is summary:
> 
> 1. modification of irq_handler when VIC is enabled [arch/arm/kernel/entry-armv.S] 

That looks like someone's been lazy when writing their get_irqnr_and_base
implementation.  Without seeing the implementation of that macro, it's
not really possible to make much more comments than that.

> 2. redefinition of PROCINFO_INITFUNC=12 in [arch/arm/kernel/head.S]

This should not be necessary - this symbol is generated from the C
structure, which must match the layout of the structures in the
proc-*.S files.

My guess is that the record in proc-fa526.S that's in your 2.6.24 was not
updated, and the above is a bodge to make it sort-of work, rather than
fixing it properly.  My guess is that this is actually causing some subtle
breakage in 2.6.24 (such as screwed ELF hwcaps.)

> 3. 4 extra nops in __turn_mmu_on in [arch/arm/kernel/head.S]

Again, not necessary, as we have setup a 1:1 mapping.

> 4. excluded code [drivers/usb/core/buffer.c]
> 5. 250ms delay in ehci_run [drivers/usb/host/ehci-hcd.c]

I can't answer these.
