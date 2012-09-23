From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 23 Sep 2012 12:35:24 +0000
Subject: vt8500: multiplatform for 3.8
In-Reply-To: <1348372670.28422.6.camel@gitbox>
References: <1348372670.28422.6.camel@gitbox>
Message-ID: <201209231235.24679.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 23 September 2012, Tony Prisk wrote:
> I just took a cursory look over the work required for enabling
> multiplatform support for v3.8 for arch-vt8500.
> 
> There are 2 files I don't know what to do with in
> arch-vt8500/include/mach:
> 
> 1) entry-macro.S
> Contains some low-level irq macro's.

The solution is to enable CONFIG_MULTI_IRQ_HANDLER (implied in
CONFIG_MULTIPLATFORM), and implement the same code in C, and then
set the .handle_irq callback in the your machine descriptor
to this function.
 
> 2) irqs.h
> Only contains '#define NR_IRQS 128' so I thought it would be easy enough
> to get rid of, but it looks like I need to enable SPARSE_IRQ to drop it,
> which will require some coding - what exactly is SPARSE_IRQ and what's
> required to make it work?

SPARSE_IRQ (in combination with IRQDOMAIN) removes the direct mapping
between hardware IRQ numbers and Linux IRQ numbers. You already have
IRQ domain support in the irq driver. If all IRQ numbers are parsed
from the device tree, you can convert this from legacy to linear domain
to cut the last ties (the local irq_cnt variable) and just set SPARSE_IRQ
without reserving any legacy interrupts. Some platforms put an nr_irqs
variable into the machine descriptor as an intermediate step, but I think
you don't even need that.

	Arnd
