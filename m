From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Aug 2012 13:44:55 +0000
Subject: [PATCH 0/6] Integrator devicetree support
In-Reply-To: <1345119317-22600-1-git-send-email-linus.walleij@linaro.org>
References: <1345119317-22600-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <201208161344.55723.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 August 2012, Linus Walleij wrote:
> This patch set moves all the non-DT platform code into
> #ifndef CONFIG_OF sections for clarity. The plan is to
> delete them after deprecation.

I'm fine with your playing around with this in any way you
like, but I think in general we should have a new CONFIG_ATAG
symbol, so you can build a kernel that supports booting
both with and without DT for the same platform, depending
on what the boot loader supports.

Then you can enclose all the non-DT sections in #ifdef
CONFIG_ATAG and we can remove them at some later stage.

> - The special PCI adapter in the Integrator has to be DT:ed,
>   but AFAICT there is still a problem with how to represent
>   these things in DT. Any hints/examples, Arnd, Rob?
>   arch/arm/mach-integrator/pci_v3.c

PCI bindings are a bit tricky but they are well-defined,
see www.openfirmware.org/ofwg/bindings/pci/pci2_1.pdf

The main thing to understand is the use of 3-cell address
spaces and the interrupt map. Each PCI host must have

         #interrupt-cells = <1>;
         #size-cells = <2>;
         #address-cells = <3>;

The "ranges" property is used to transform the PCI
address space into the host address space.

The first cell identifies the device and address space
using a bit-masked notation. The important part to
know here is 

0x00000000 config space
0x01000000 I/O space
0x02000000 memory space
0x03000000 64 bit memory space
0x42000000 memory space, prefetchable
0x43000000 64 bit memory space, prefetchable

Each entry in the ranges property consists of 3 cells
for the PCI address start, one cell for a 32 bit parent
but start address where this is mapped, and two cells for
the size.
For your bus, the ranges then would be defined as 

ranges = <0x00000000 0x00000000 0x00000000 /* configuration space: */
	  0x61000000 0x00000000 0x00100000 /* 16 MB at 61000000    */
	  0x01000000 0x00000000 0x00000000 /* I/O space:	   */
	  0x60000000 0x00000000 0x00010000 /* 64KB@0x60000000   */
	  0x02000000 0x00000000 0x40000000 /* non-prefetchable mem */
	  0x40000000 0x00000000 0x10000000 /* identity-mapped      */
	  0x42000000 0x00000000 0x50000000 /* prefetchable mem     */
	  0x50000000 0x00000000 0x10000000> /* identity-mapped     */

I'm not quite sure if I understood the comments about LB_BASE0 etc
correctly, so it might actually be different.

You also need an interrupt-map, which maps the slots to the
connected irq lines in a board-specific way:

interrupt-map = <
	/* IDSEL 9 */
	0x4800 0 0 1 &pic 14 /* INT A on slot 9 is irq 14 */
	0x4800 0 0 2 &pic 15 /* INT B on slot 9 is irq 15 */
	0x4800 0 0 3 &pic 16 /* INT C on slot 9 is irq 16 */
	0x4800 0 0 4 &pic 17 /* INT D on slot 9 is irq 17 */

	/* IDSEL 10 */
	0x5000 0 0 1 &pic 15 /* INT A on slot 10 is irq 15 */
	0x5000 0 0 2 &pic 16 /* INT B on slot 10 is irq 16 */
	0x5000 0 0 3 &pic 17 /* INT C on slot 10 is irq 17 */
	0x5000 0 0 4 &pic 14 /* INT D on slot 10 is irq 18 */

	/* IDSEL 11 */
	0x5800 0 0 1 &pic 16 /* INT A on slot 11 is irq 16 */
	0x5800 0 0 2 &pic 17 /* INT B on slot 11 is irq 17 */
	0x5800 0 0 3 &pic 14 /* INT C on slot 11 is irq 18 */
	0x5800 0 0 4 &pic 15 /* INT D on slot 11 is irq 14 */

	/* IDSEL 12 */
	0x6000 0 0 1 &pic 17 /* INT A on slot 12 is irq 17 */
	0x6000 0 0 2 &pic 14 /* INT B on slot 12 is irq 14 */
	0x6000 0 0 3 &pic 15 /* INT C on slot 12 is irq 15 */
	0x6000 0 0 4 &pic 16 /* INT D on slot 12 is irq 16 */
	>;

	Arnd
